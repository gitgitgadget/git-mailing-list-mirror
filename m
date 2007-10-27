From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sat, 27 Oct 2007 18:50:04 +0200
Message-ID: <11935038084055-git-send-email-prohaska@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de>
 <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de>
 <11935038083369-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 18:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilori-0004UC-Dj
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 18:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbXJ0QuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbXJ0QuM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 12:50:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:49611 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbXJ0QuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 12:50:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9RGo8FJ023479
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 18:50:08 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9RGo7oL028374;
	Sat, 27 Oct 2007 18:50:08 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935038083369-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62496>

This teaches "push <remote> HEAD" to resolve HEAD on the local
side to its real ref name, e.g. refs/heads/master, and then
use the real ref name on the remote side to search a matching
remote ref.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 remote.c              |   13 ++++++++++---
 t/t5516-fetch-push.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 8908a19..1c96659 100644
--- a/remote.c
+++ b/remote.c
@@ -575,6 +575,8 @@ static struct ref *try_explicit_object_name(const char *name)
 	unsigned char sha1[20];
 	struct ref *ref;
 	int len;
+	char *real_name = 0;
+	const char *best_name;
 
 	if (!*name) {
 		ref = alloc_ref(20);
@@ -582,12 +584,17 @@ static struct ref *try_explicit_object_name(const char *name)
 		hashclr(ref->new_sha1);
 		return ref;
 	}
-	if (get_sha1(name, sha1))
+	if (get_sha1_with_real_ref(name, sha1, &real_name))
 		return NULL;
-	len = strlen(name) + 1;
+	best_name = real_name ? real_name : name;
+	len = strlen(best_name) + 1;
 	ref = alloc_ref(len);
-	memcpy(ref->name, name, len);
+	memcpy(ref->name, best_name, len);
 	hashcpy(ref->new_sha1, sha1);
+
+	if (real_name) {
+		free(real_name);
+	}
 	return ref;
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 42ca0ff..0ff791a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -282,6 +282,35 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push with HEAD' '
+
+	mk_test heads/master &&
+	git push testrepo HEAD &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with HEAD (--create)' '
+
+	mk_test &&
+	git push --create testrepo HEAD &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with HEAD nonexisting at remote' '
+
+	mk_test heads/master &&
+	git checkout -b local master &&
+	if git push testrepo HEAD
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		check_push_result $the_first_commit heads/master
+	fi
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.5.3.4.1261.g626eb
