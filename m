From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] send-pack: do not send unknown object name from ".have"
 to pack-objects
Date: Tue, 27 Jan 2009 23:51:46 -0800
Message-ID: <7vocxrvpf1.fsf_-_@gitster.siamese.dyndns.org>
References: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
 <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5Eh-0002m6-W3
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbZA1Hv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbZA1Hv6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:51:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZA1Hv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:51:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ED9EE94F3C;
	Wed, 28 Jan 2009 02:51:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 815B894F39; Wed,
 28 Jan 2009 02:51:48 -0500 (EST)
In-Reply-To: <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Jan 2009 23:41:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 88B1DD06-ED10-11DD-A7E1-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107500>

v1.6.1 introduced ".have" extension to the protocol to allow the receiving
side to advertise objects that are reachable from refs in the repositories
it borrows from.  This was meant to be used by the sending side to avoid
sending such objects; they are already available through the alternates
mechanism.

The client side implementation in v1.6.1, which was introduced with
40c155f (push: prepare sender to receive extended ref information from the
receiver, 2008-09-09) aka v1.6.1-rc1~203^2~1, were faulty in that it did
not consider the possiblity that the repository receiver borrows from
might have objects it does not know about.

This fixes it by refraining from passing missing commits to underlying
pack-objects.  Revision machinery may need to be tightened further to
treat missing uninteresting objects as non-error events, but this is an
obvious and safe fix for a maintenance release that is almost good enough.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This lost the "NEEDSWORK" comment, as it turns out that revision
   traversal machinery mostly ignores missing uninteresting objects as
   non-error events except for a few corner cases, which we can tighten
   separately.

 builtin-send-pack.c        |   43 +++++++++---------
 t/t5519-push-alternates.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 22 deletions(-)
 create mode 100755 t/t5519-push-alternates.sh

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index a9fdbf9..d65d019 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -15,6 +15,20 @@ static struct send_pack_args args = {
 	/* .receivepack = */ "git-receive-pack",
 };
 
+static int feed_object(const unsigned char *sha1, int fd, int negative)
+{
+	char buf[42];
+
+	if (negative && !has_sha1_file(sha1))
+		return 1;
+
+	memcpy(buf + negative, sha1_to_hex(sha1), 40);
+	if (negative)
+		buf[0] = '^';
+	buf[40 + negative] = '\n';
+	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs");
+}
+
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -35,7 +49,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	};
 	struct child_process po;
 	int i;
-	char buf[42];
 
 	if (args.use_thin_pack)
 		argv[4] = "--thin";
@@ -51,31 +64,17 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
-	for (i = 0; i < extra->nr; i++) {
-		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
-		buf[0] = '^';
-		buf[41] = '\n';
-		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
+	for (i = 0; i < extra->nr; i++)
+		if (!feed_object(extra->array[i], po.in, 1))
 			break;
-	}
 
 	while (refs) {
 		if (!is_null_sha1(refs->old_sha1) &&
-		    has_sha1_file(refs->old_sha1)) {
-			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
-			buf[0] = '^';
-			buf[41] = '\n';
-			if (!write_or_whine(po.in, buf, 42,
-						"send-pack: send refs"))
-				break;
-		}
-		if (!is_null_sha1(refs->new_sha1)) {
-			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
-			buf[40] = '\n';
-			if (!write_or_whine(po.in, buf, 41,
-						"send-pack: send refs"))
-				break;
-		}
+		    !feed_object(refs->old_sha1, po.in, 1))
+			break;
+		if (!is_null_sha1(refs->new_sha1) &&
+		    !feed_object(refs->new_sha1, po.in, 0))
+			break;
 		refs = refs->next;
 	}
 
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
new file mode 100755
index 0000000..6dfc55a
--- /dev/null
+++ b/t/t5519-push-alternates.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='push to a repository that borrows from elsewhere'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir alice-pub &&
+	(
+		cd alice-pub &&
+		GIT_DIR=. git init
+	) &&
+	mkdir alice-work &&
+	(
+		cd alice-work &&
+		git init &&
+		>file &&
+		git add . &&
+		git commit -m initial &&
+		git push ../alice-pub master
+	) &&
+
+	# Project Bob is a fork of project Alice
+	mkdir bob-pub &&
+	(
+		cd bob-pub &&
+		GIT_DIR=. git init &&
+		mkdir -p objects/info &&
+		echo ../../alice-pub/objects >objects/info/alternates
+	) &&
+	git clone alice-pub bob-work &&
+	(
+		cd bob-work &&
+		git push ../bob-pub master
+	)
+'
+
+test_expect_success 'alice works and pushes' '
+	(
+		cd alice-work &&
+		echo more >file &&
+		git commit -a -m second &&
+		git push ../alice-pub
+	)
+'
+
+test_expect_success 'bob fetches from alice, works and pushes' '
+	(
+		# Bob acquires what Alice did in his work tree first.
+		# Even though these objects are not directly in
+		# the public repository of Bob, this push does not
+		# need to send the commit Bob received from Alice
+		# to his public repository, as all the object Alice
+		# has at her public repository are available to it
+		# via its alternates.
+		cd bob-work &&
+		git pull ../alice-pub master &&
+		echo more bob >file &&
+		git commit -a -m third &&
+		git push ../bob-pub
+	) &&
+
+	# Check that the second commit by Alice is not sent
+	# to ../bob-pub
+	(
+		cd bob-pub &&
+		second=$(git rev-parse HEAD^) &&
+		rm -f objects/info/alternates &&
+		test_must_fail git cat-file -t $second &&
+		echo ../../alice-pub/objects >objects/info/alternates
+	)
+'
+
+test_expect_success 'clean-up in case the previous failed' '
+	(
+		cd bob-pub &&
+		echo ../../alice-pub/objects >objects/info/alternates
+	)
+'
+
+test_expect_success 'alice works and pushes again' '
+	(
+		# Alice does not care what Bob does.  She does not
+		# even have to be aware of his existence.  She just
+		# keeps working and pushing
+		cd alice-work &&
+		echo more alice >file &&
+		git commit -a -m fourth &&
+		git push ../alice-pub
+	)
+'
+
+test_expect_success 'bob works and pushes' '
+	(
+		# This time Bob does not pull from Alice, and
+		# the master branch at her public repository points
+		# at a commit Bob does not know about.  This should
+		# not prevent the push by Bob from succeeding.
+		cd bob-work &&
+		echo yet more bob >file &&
+		git commit -a -m fifth &&
+		git push ../bob-pub
+	)
+'
+
+test_done
-- 
1.6.1.1.273.g0e555
