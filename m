From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 08/11] connect: change the --diag-url output to separate user and host
Date: Tue,  3 May 2016 17:50:49 +0900
Message-ID: <1462265452-32360-9-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:52:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW4W-0005So-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbcECIvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51948 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813AbcECIvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:51:04 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008R3-Jb; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293345>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c             |  6 ++----
 t/t5500-fetch-pack.sh | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index e95e385..2c5b722 100644
--- a/connect.c
+++ b/connect.c
@@ -703,10 +703,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
-		if (user)
-			printf("Diag: userandhost=%s@%s\n", user, host);
-		else
-			printf("Diag: userandhost=%s\n", host ? host : "NULL");
+		printf("Diag: user=%s\n", user ? user : "NULL");
+		printf("Diag: host=%s\n", host ? host : "NULL");
 		printf("Diag: port=%s\n", port ? port : "NONE");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 09d46c3..0c2f79f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -537,7 +537,7 @@ check_prot_path () {
 	Diag: protocol=$2
 	Diag: path=$3
 	EOF
-	git fetch-pack --diag-url "$1" | grep -v host= | grep -v port= >actual &&
+	git fetch-pack --diag-url "$1" | grep -v user= | grep -v host= | grep -v port= >actual &&
 	test_cmp expected actual
 }
 
@@ -552,10 +552,20 @@ check_prot_host_port_path () {
 		;;
 	esac
 	ehost=$(echo $3 | tr -d "[]")
+	case "$ehost" in
+		*@*)
+		user=${ehost%@*}
+		ehost=${ehost#$user@}
+		;;
+		*)
+		user=NULL
+		;;
+	esac
 	cat >exp <<-EOF &&
 	Diag: url=$1
 	Diag: protocol=$pp
-	Diag: userandhost=$ehost
+	Diag: user=$user
+	Diag: host=$ehost
 	Diag: port=$4
 	Diag: path=$5
 	EOF
-- 
2.8.1.16.gaa70619.dirty
