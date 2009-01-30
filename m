From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] fsck: HEAD is part of refs
Date: Fri, 30 Jan 2009 01:12:48 -0800
Message-ID: <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
 <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
 <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu>
 <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 10:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSpSC-0006rw-Qm
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 10:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbZA3JNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 04:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbZA3JM7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 04:12:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZA3JM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 04:12:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D7D0A95FCC;
	Fri, 30 Jan 2009 04:12:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1595495FCB; Fri,
 30 Jan 2009 04:12:49 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
 (Linus Torvalds's message of "Thu, 29 Jan 2009 15:21:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E40FB0A-EEAE-11DD-9960-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107781>

By default we looked at all refs but not HEAD.  The only thing that
made fsck not lose sight of comments that are only reachable from a
detached HEAD was the reflog for the HEAD.

This fixes it, with a new test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is unrelated to Peter's "missing blob", but should be an obviously
   right thing to do. 

 builtin-fsck.c  |   13 ++++++++-----
 t/t1450-fsck.sh |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100755 t/t1450-fsck.sh

diff --git a/builtin-fsck.c b/builtin-fsck.c
index aecc828..2cfff43 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -23,6 +23,7 @@ static int check_full;
 static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
+static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -473,6 +474,8 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 
 static void get_default_heads(void)
 {
+	if (head_points_at && !is_null_sha1(head_sha1))
+		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
 	for_each_ref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
@@ -512,14 +515,13 @@ static void fsck_object_dir(const char *path)
 
 static int fsck_head_link(void)
 {
-	unsigned char sha1[20];
 	int flag;
 	int null_is_error = 0;
-	const char *head_points_at = resolve_ref("HEAD", sha1, 0, &flag);
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
+	head_points_at = resolve_ref("HEAD", head_sha1, 0, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
@@ -528,7 +530,7 @@ static int fsck_head_link(void)
 	else if (prefixcmp(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
-	if (is_null_sha1(sha1)) {
+	if (is_null_sha1(head_sha1)) {
 		if (null_is_error)
 			return error("HEAD: detached HEAD points at nothing");
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
@@ -624,8 +626,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	heads = 0;
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!get_sha1(arg, head_sha1)) {
-			struct object *obj = lookup_object(head_sha1);
+		unsigned char sha1[20];
+		if (!get_sha1(arg, sha1)) {
+			struct object *obj = lookup_object(sha1);
 
 			/* Error is printed by lookup_object(). */
 			if (!obj)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
new file mode 100755
index 0000000..5166566
--- /dev/null
+++ b/t/t1450-fsck.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='git fsck random collection of tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	git checkout HEAD^0 &&
+	test_commit B &&
+	git reflog expire --expire=now --all
+'
+
+test_expect_success 'HEAD is part of refs' '
+	test 0 = $(git fsck | wc -l)
+'
+
+test_done
-- 
1.6.1.2.312.g5be3c
