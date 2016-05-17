From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 7/9] connect: change the --diag-url output to separate user and host
Date: Tue, 17 May 2016 10:35:52 +0900
Message-ID: <20160517013554.22578-8-mh@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2TwA-00076Q-D2
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbcEQBgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35474 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932986AbcEQBgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvP-0005tD-3y; Tue, 17 May 2016 10:35:55 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
In-Reply-To: <20160517013554.22578-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294833>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c             |  6 ++----
 t/t5500-fetch-pack.sh | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 2659b40..dcaf32f 100644
--- a/connect.c
+++ b/connect.c
@@ -720,10 +720,8 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.8.2.411.ga570dec.dirty
