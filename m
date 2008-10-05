From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2] check-attr: add an internal check_attr() function
Date: Sun,  5 Oct 2008 06:30:54 +0400
Message-ID: <1223173855-6173-1-git-send-email-dpotapov@gmail.com>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 04:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmJPr-0008UG-Fr
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 04:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYJECbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 22:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYJECbD
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 22:31:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:5970 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYJECbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 22:31:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1663772fkq.5
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jBJlvrz7hi0yEU3UIE/KbLK2FRdNAOdwCBkCg7aywBs=;
        b=kuFDziBvKa1H2xLLbnusllQITHauRvwUgj2t7n2l8FYxHe03f6A/nfr8DotI2W3V0o
         aQHMQQFTDGnJ6KkA9Ci8Ob2d7W2J+HCgGgTOuVdZTxDl6Y8dlCoDa008TbZoGRWNFl6C
         MHJhUUTWjDmJivoksfGeq0d6pb3KoTbQFs8Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OTXqNWJHPd/ZGYfdl8kB96furve8QuYQ6D6kBbnU9xwBepdYJ46SfAmkKFyr2XvQkk
         qM8oI2a6ERQMZOoLUDfa4x6bhnylkOG/OCfim6Fzo+p/GehRL3bwCMHG+rPIjotBTDCK
         RKNxZ99DqpJQFIRO2KEK5LSZdqLnj06XbGl+Q=
Received: by 10.103.212.2 with SMTP id o2mr1825229muq.1.1223173859387;
        Sat, 04 Oct 2008 19:30:59 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id t10sm8098179muh.16.2008.10.04.19.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 19:30:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97493>

This step is preparation to introducing --stdin-paths option

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
On Mon, Sep 22, 2008 at 02:12:33PM +0400, Alexander Gavrilov wrote:
> 
> Core git does not provide any interface for reading attributes from
> older commits, so they are loaded from the working copy. And caching
> is necessary for performance when lookup involves calling an external
> application at least once per 30 files. This may change if
> git-check-attr is modified to support --stdin-paths.

 builtin-check-attr.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index cb783fc..5a2e329 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -6,6 +6,27 @@
 static const char check_attr_usage[] =
 "git check-attr attr... [--] pathname...";
 
+static void check_attr(int cnt, struct git_attr_check *check,
+	const char** name, const char *file)
+{
+	int j;
+	if (git_checkattr(file, cnt, check))
+		die("git_checkattr died");
+	for (j = 0; j < cnt; j++) {
+		const char *value = check[j].value;
+
+		if (ATTR_TRUE(value))
+			value = "set";
+		else if (ATTR_FALSE(value))
+			value = "unset";
+		else if (ATTR_UNSET(value))
+			value = "unspecified";
+
+		quote_c_style(file, NULL, stdout, 0);
+		printf(": %s: %s\n", name[j], value);
+	}
+}
+
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
@@ -42,23 +63,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		check[i].attr = a;
 	}
 
-	for (i = doubledash; i < argc; i++) {
-		int j;
-		if (git_checkattr(argv[i], cnt, check))
-			die("git_checkattr died");
-		for (j = 0; j < cnt; j++) {
-			const char *value = check[j].value;
-
-			if (ATTR_TRUE(value))
-				value = "set";
-			else if (ATTR_FALSE(value))
-				value = "unset";
-			else if (ATTR_UNSET(value))
-				value = "unspecified";
-
-			quote_c_style(argv[i], NULL, stdout, 0);
-			printf(": %s: %s\n", argv[j+1], value);
-		}
-	}
+	for (i = doubledash; i < argc; i++)
+		check_attr(cnt, check, argv+1, argv[i]);
 	return 0;
 }
-- 
1.6.0.2.447.g3befd
