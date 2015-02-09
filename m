From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] sha1_file: fix iterating loose alternate objects
Date: Sun, 8 Feb 2015 20:15:39 -0500
Message-ID: <20150209011538.GB21123@peff.net>
References: <20150209011159.GA21072@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@jonathonmah.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:15:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKcwz-0001cZ-Im
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 02:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177AbbBIBPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 20:15:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:46612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759107AbbBIBPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 20:15:41 -0500
Received: (qmail 16386 invoked by uid 102); 9 Feb 2015 01:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 19:15:41 -0600
Received: (qmail 26863 invoked by uid 107); 9 Feb 2015 01:15:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 20:15:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:15:39 -0500
Content-Disposition: inline
In-Reply-To: <20150209011159.GA21072@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263540>

From: Jonathon Mah <me@jonathonmah.com>

The string in 'base' contains a path suffix to a specific object;
when its value is used, the suffix must either be filled (as in
stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or
cleared (as in prepare_packed_git) to avoid junk at the end.

660c889e (sha1_file: add for_each iterators for loose and packed
objects, 2014-10-15) introduced loose_from_alt_odb(), but this did
neither and treated 'base' as a complete path to the "base" object
directory, instead of a pointer to the "base" of the full path
string.

The trailing path after 'base' is still initialized to NUL, hiding
the bug in some common cases.  Additionally the descendent
for_each_file_in_obj_subdir() function swallows ENOENT, so an error
only shows if the alternate's path was last filled with a valid
object (where statting /path/to/existing/00/0bjectfile/00 fails).

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
Helped-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I think the S-O-B should still stand, as the code is now a mix of our
work, and the tests are still Jonathon's. But let me know if you do not
want your name attached to this. ;)

I am also happy to build it as a patch on top of the original if that is
simpler.

 sha1_file.c      | 13 ++++++++++---
 t/t5304-prune.sh |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 725de7f..a41cc4f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3406,9 +3406,16 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 			      void *vdata)
 {
 	struct loose_alt_odb_data *data = vdata;
-	return for_each_loose_file_in_objdir(alt->base,
-					     data->cb, NULL, NULL,
-					     data->data);
+	struct strbuf buf = STRBUF_INIT;
+	int r;
+
+	/* copy base not including trailing '/' */
+	strbuf_add(&buf, alt->base, alt->name - alt->base - 1);
+	r = for_each_loose_file_in_objdir_buf(&buf,
+					      data->cb, NULL, NULL,
+					      data->data);
+	strbuf_release(&buf);
+	return r;
 }
 
 int for_each_loose_object(each_loose_object_fn cb, void *data)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e32e46d..0794d33 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -253,4 +253,12 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune: handle alternate object database' '
+	test_create_repo A &&
+	git -C A commit --allow-empty -m "initial commit" &&
+	git clone --shared A B &&
+	git -C B commit --allow-empty -m "next commit" &&
+	git -C B prune
+'
+
 test_done
-- 
2.3.0.rc1.287.g761fd19
