From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow git-bundle to create bottomless bundle
Date: Wed, 08 Aug 2007 22:04:06 -0700
Message-ID: <7v643pz4c9.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
	<20070808035946.GP9527@spearce.org>
	<Pine.LNX.4.64.0708081012110.14781@racer.site>
	<7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
	<7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
	<46BA8065.6010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 07:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ0C8-0006Mw-PW
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 07:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbXHIFEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbXHIFEK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 01:04:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:32841 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXHIFEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 01:04:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809050408.XMMO7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 9 Aug 2007 01:04:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zh461X00M1kojtg0000000; Thu, 09 Aug 2007 01:04:07 -0400
In-Reply-To: <46BA8065.6010005@gmail.com> (Mark Levedahl's message of "Wed, 08
	Aug 2007 22:48:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55407>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> While "git bundle" was a useful way to sneakernet incremental
>> changes, we did not allow:
>>
> Thanks - I've been thinking for months I could fix this bug, never
> figured it out and didn't want to nag Dscho one more time. I confirm
> that this allows creation of bundles with arbitrary refs, not just
> those under refs/heads. Yahoo!

Actually, there is another bug nearby.

If you do:

	git bundle create v2.6-20-v2.6.22.bndl v2.6.20..v2.6.22

the bundle records that it requires v2.6.20^0 commit (correct)
and gives you tag v2.6.22 (incorrect); the bug is that the
object it lists in fact is the commit v2.6.22^0, not the tag.

This is because the revision range operation .. is always about
set of commits, but the code near where my patch touches does
not validate that the sha1 value obtained from dwim_ref()
against the commit object name e->item->sha1 before placing the
head information in the commit.

The attached patch attempts to fix this problem.

---

 builtin-bundle.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 t/t5510-fetch.sh |    8 ++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 6ae5ab0..2d0e106 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -208,6 +208,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct rev_info revs;
 	struct child_process rls;
 
+	/*
+	 * NEEDSWORK: this should use something like lock-file
+	 * to create temporary that is cleaned up upon error.
+	 */
 	bundle_fd = (!strcmp(path, "-") ? 1 :
 			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
 	if (bundle_fd < 0)
@@ -267,12 +271,49 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * Make sure the refs we wrote out is correct; --max-count and
 		 * other limiting options could have prevented all the tips
 		 * from getting output.
+		 *
+		 * Non commit objects such as tags and blobs do not have
+		 * this issue as they are not affected by those extra
+		 * constraints.
 		 */
-		if (!(e->item->flags & SHOWN)) {
+		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
 			warning("ref '%s' is excluded by the rev-list options",
 				e->name);
+			free(ref);
+			continue;
+		}
+		/*
+		 * If you run "git bundle create bndl v1.0..v2.0", the
+		 * name of the positive ref is "v2.0" but that is the
+		 * commit that is referenced by the tag, and not the tag
+		 * itself.
+		 */
+		if (hashcmp(sha1, e->item->sha1)) {
+			/*
+			 * Is this the positive end of a range expressed
+			 * in terms of a tag (e.g. v2.0 from the range
+			 * "v1.0..v2.0")?
+			 */
+			struct commit *one = lookup_commit_reference(sha1);
+			struct object *obj;
+
+			if (e->item == &(one->object)) {
+				/*
+				 * Need to include e->name as an
+				 * independent ref to the pack-objects
+				 * input, so that the tag is included
+				 * in the output; otherwise we would
+				 * end up triggering "empty bundle"
+				 * error.
+				 */
+				obj = parse_object(sha1);
+				obj->flags |= SHOWN;
+				add_pending_object(&revs, obj, e->name);
+			}
+			free(ref);
 			continue;
 		}
+
 		ref_count++;
 		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
 		write_or_die(bundle_fd, " ", 1);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 426017e..439430f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -145,4 +145,12 @@ test_expect_success 'bundle does not prerequisite objects' '
 	test 4 = $(git verify-pack -v bundle.pack | wc -l)
 '
 
+test_expect_success 'bundle should be able to create a full history' '
+
+	cd "$D" &&
+	git tag -a -m '1.0' v1.0 master &&
+	git bundle create bundle4 v1.0
+
+'
+
 test_done
