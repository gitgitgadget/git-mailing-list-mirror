From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] builtin-bundle.c - use stream buffered input for rev-list
Date: Fri, 10 Aug 2007 18:29:49 -0400
Message-ID: <11867849893486-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJczj-0000EZ-3O
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 00:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761402AbXHJWaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 18:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760353AbXHJWaG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 18:30:06 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:41439 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762580AbXHJWaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 18:30:04 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMK005ZVX5RTH8B@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 10 Aug 2007 17:29:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.53.g9fc90
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55574>

git-bundle create on cygwin was nearly unusable due to 1 character
at a time (unbuffered) reading from an exec'ed process. Fix by using
fdopen to get a buffered stream.

Results for "time git bundle create test.bdl v1.0.3..v1.5.2" are:

before this patch:
         cygwin         linux
real    1m38.828s      0m3.578s
user    0m12.122s      0m2.896s
sys     1m28.215s      0m0.692s

after this patch:
real    0m3.688s       0m2.835s
user    0m3.075s       0m2.731s
sys     0m1.075s       0m0.149s

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 builtin-bundle.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 2d0e106..b954213 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -207,6 +207,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	char buffer[1024];
 	struct rev_info revs;
 	struct child_process rls;
+	FILE *rls_fout;
 
 	/*
 	 * NEEDSWORK: this should use something like lock-file
@@ -236,10 +237,11 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	rls.git_cmd = 1;
 	if (start_command(&rls))
 		return -1;
-	while ((i = read_string(rls.out, buffer, sizeof(buffer))) > 0) {
+	rls_fout = fdopen(rls.out, "r");
+	while (fgets(buffer, sizeof(buffer), rls_fout)) {
 		unsigned char sha1[20];
 		if (buffer[0] == '-') {
-			write_or_die(bundle_fd, buffer, i);
+			write_or_die(bundle_fd, buffer, strlen(buffer));
 			if (!get_sha1_hex(buffer + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
@@ -250,6 +252,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			object->flags |= SHOWN;
 		}
 	}
+	fclose(rls_fout);
 	if (finish_command(&rls))
 		return error("rev-list died");
 
-- 
1.5.3.rc4.53.g9fc90
