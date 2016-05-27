From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 7/9] connect: change the --diag-url output to separate user and host
Date: Fri, 27 May 2016 11:27:54 +0900
Message-ID: <20160527022756.22904-8-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Ve-0005Gz-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbcE0C2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:04 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40416 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yT-Ta; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295712>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c             |  6 ++----
 t/t5500-fetch-pack.sh | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 0819c25..0c4d23b 100644
--- a/connect.c
+++ b/connect.c
@@ -714,10 +714,8 @@ struct child_process *git_connect(int fd[2], const char *url,
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
index 739c6b1..2d9c4be 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -553,7 +553,7 @@ check_prot_path () {
 	Diag: protocol=$2
 	Diag: path=$3
 	EOF
-	git fetch-pack --diag-url "$1" | egrep -v '(host|port)=' >actual &&
+	git fetch-pack --diag-url "$1" | egrep -v "(user|host|port)=" >actual &&
 	test_cmp expected actual
 }
 
@@ -568,10 +568,20 @@ check_prot_host_port_path () {
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
2.8.3
