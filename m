From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] repo-config: give value_ a sane default so regexec won't segfault
Date: Mon, 6 Mar 2006 06:23:30 +0100
Message-ID: <20060306052330.GB6487@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 06:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8CB-0001Gv-5R
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 06:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCFFXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 00:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWCFFXd
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 00:23:33 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:38118 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750799AbWCFFXd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 00:23:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 16F7F770068;
	Mon,  6 Mar 2006 06:23:32 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04949-04; Mon,  6 Mar 2006 06:23:30 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 68BA7770069;
	Mon,  6 Mar 2006 06:23:30 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AE6516DF894; Mon,  6 Mar 2006 06:22:11 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3D9A961D58; Mon,  6 Mar 2006 06:23:30 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17270>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 repo-config.c          |    5 ++++-
 t/t1300-repo-config.sh |    8 ++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

7fcdb6b9c8c75a0c84076b4a0ebc46b4c7383906
diff --git a/repo-config.c b/repo-config.c
index 9cf6519..c5ebb76 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -14,6 +14,9 @@ static enum { T_RAW, T_INT, T_BOOL } typ
 
 static int show_config(const char* key_, const char* value_)
 {
+	if (value_ == NULL)
+		value_ = "";
+
 	if (!strcmp(key_, key) &&
 			(regexp == NULL ||
 			 (do_not_match ^
@@ -35,7 +38,7 @@ static int show_config(const char* key_,
 			sprintf(value, "%s", git_config_bool(key_, value_)
 					     ? "true" : "false");
 		} else {
-			value = strdup(value_ ? value_ : "");
+			value = strdup(value_);
 		}
 		seen++;
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 207dd3d..ab4dd5c 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -247,5 +247,13 @@ EOF
 
 test_expect_success 'hierarchical section value' 'cmp .git/config expect'
 
+cat > .git/config << EOF
+[novalue]
+	variable
+EOF
+
+test_expect_success 'get variable with no value' \
+	'git-repo-config --get novalue.variable ^$'
+
 test_done
 
-- 
1.2.4.g9201

-- 
Jonas Fonseca
