From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] git-am foreign patch support: StGIT
Date: Mon, 25 May 2009 21:14:06 +0200
Message-ID: <1243278846-14120-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243278846-14120-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 21:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fcy-0002ls-Ap
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZEYTOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbZEYTOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:14:16 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:47103 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZEYTOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:14:14 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so1539209fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oet2Glu42gFxme0jsphjOGiEzen+l0e1wcnmV2hOOAQ=;
        b=PG9HhVIx8kGQAl401MYQMPxo9crN83yHpahUUtgOOJtCfnDYhLPw6AV6Li3wXPKTTY
         aSqfN0OWs2RjrLMD+NSFjKM62DUNdLcrZdec2NLz1fdHlypZ/kyXeno6coeHNhP0z//D
         ZTkrielB1KjR2e9w45CkzAdY4kpLcXI1LkSow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gf0DTWhE4ia5WNbdJosEAiFEYF1ZtX9Zl2QkPqgfVt8A1+7CizlB/DKBGFG+7+dpX4
         rxCVuwo33FMHB8buZPZgNIG7XtNV0ELCJj6+nSw5TG008ioOSMBKSHKTpNc4PFR6Zjf0
         gh8mizc6ncQ+uLEMngso4Aa/sr66iMgBbL3Eo=
Received: by 10.103.197.14 with SMTP id z14mr3893890mup.1.1243278856292;
        Mon, 25 May 2009 12:14:16 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id j10sm9350706muh.15.2009.05.25.12.14.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 12:14:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.245.g4529.dirty
In-Reply-To: <1243278846-14120-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119954>

Convert StGIT patches to mbox format so that they can be imported.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3508b7e..5199354 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -375,6 +375,38 @@ else
 			exit 1
 		}
 		;;
+	stgit)
+		this=0
+		for stgit in "$@"
+		do
+			this=`expr "$this" + 1`
+			msgnum=`printf "%0${prec}d" $this`
+			touch "$dotest/$msgnum"
+			# Awk version of StGIT parse_patch
+			awk 'BEGIN { subject=0 }
+			{
+				if (subject > 1)
+					print ;
+				else if (/^$/) next ;
+				else if (/^Author:/) print sub("Author", "From"), $ORS ;
+				else if (/^(From|Date)/) print ;
+				else if (subject) {
+					subject = 2 ;
+					print "" ;
+					print ;
+				} else {
+					print "Subject:", $0 ;
+					subject = 1;
+				}
+			}' "$stgit" > "$dotest/$msgnum" || {
+				echo "Failed to import $patch_format patch $stgit"
+				exit 1
+			}
+		done
+		echo "$this" > "$dotest/last"
+		this=
+		msgnum=
+		;;
 	*)
 		echo "Patch format $patch_format is not currently handled, sorry"
 		exit 1
-- 
1.6.3.1.245.g4529.dirty
