From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2 v2] check-attr: add an internal check_attr() function
Date: Tue, 7 Oct 2008 04:14:18 +0400
Message-ID: <20081007001418.GQ21650@dpotapov.dyndns.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 02:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0Ep-0001oj-LB
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYJGAOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbYJGAOc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:14:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42266 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYJGAOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:14:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2127567fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 17:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZXH2rYu/NHD/M/w6LOBEeI46gr5228iAZng+mvatDJk=;
        b=AvzIMb7xFsfxQ9hdBkIxg/URhoM9tbgp2fUj5ihN4grRhnIJM4WUTDZGwFStF4T8Bp
         be+cc74BnOUJDyg2e6Pp/nI4ZYVG/KWUPlkVZ7qCxylQnYhaWCfF66CL8vyM3HsFFuZY
         suvIAZkH9lW2b/sI8e4C1kfWUafkV3gdwXl9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nf17nXmKmWxLGbFEEXMRdX8d/TKRzITYk74aL7AiwrunrxhePACbi0e3od6r1I6YpU
         bEMiDVACyM6Asm6aQRHCypniXHEjyFS/k6G1jCPOxOMLvkF3CLFXOzz+MhpbZwpzxvOh
         A+1PRpx4FU/zKvViS7JkLltIOmeGptPRsr64Y=
Received: by 10.86.4.14 with SMTP id 14mr5174140fgd.20.1223338469472;
        Mon, 06 Oct 2008 17:14:29 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id d6sm12339589fga.2.2008.10.06.17.14.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 17:14:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48E9B997.1010006@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97644>

This step is preparation to introducing --stdin-paths option.

I have also added maybe_flush_or_die() at the end of main() to ensure that
we exit with the zero code only when we flushed the output successfully.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
maybe_flush_or_die() is added in this version of patch.

 builtin-check-attr.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index cb783fc..786256e 100644
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
@@ -42,23 +63,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
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
+	maybe_flush_or_die(stdout, "attribute to stdout");
 	return 0;
 }
-- 
1.6.0.2.447.g3befd
