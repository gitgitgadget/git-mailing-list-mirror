From: Danny Lin <danny0838@gmail.com>
Subject: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri,  8 May 2015 08:51:39 +0800
Message-ID: <1431046299-5984-1-git-send-email-danny0838@gmail.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
Cc: git develop <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Danny Lin <danny0838@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 02:52:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqWWQ-00030Y-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 02:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbbEHAwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 20:52:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35810 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbEHAwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 20:52:04 -0400
Received: by pabtp1 with SMTP id tp1so54377812pab.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1MGX3dWmFZt+rSFf51bgJMHWD1rhuqDGLORKBdkOKsc=;
        b=mR9JBPtm22kF2agch93MRfsmJ6iDzBf2YIJ56t+OSwG8NFsGXd9njwXVmWUGEnyns4
         7J1UCjfeHCWFAM4lu2Maru2sxeetpbANzPEKgNZCEM+WwsFFGvUUylDQQO2iLyRDLZ2P
         MP+bE5pexjbqEfESmol2WznDB5+THWGac5XFReqlcg957TGC34GOikfmfdmz0IFnuo1p
         Z5qsNZs5G/5PQTojgvajpa7aayVgYobcCs/Q+I/pxORTzRtAQEunRXNG1dFk83DZjuhE
         t3RESPOmjCcFXc25a6qgXhxdz89dVW7mkz6CGs7Q2eRI/oE+kMQtjwjyXJa7FC/5OpSs
         ZDHQ==
X-Received: by 10.66.185.168 with SMTP id fd8mr2116424pac.27.1431046323783;
        Thu, 07 May 2015 17:52:03 -0700 (PDT)
Received: from localhost.localdomain (1-164-201-189.dynamic.hinet.net. [1.164.201.189])
        by mx.google.com with ESMTPSA id yv6sm3318948pac.29.2015.05.07.17.52.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 17:52:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.7.windows.1
In-Reply-To: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268594>

Replace echo using printf in debug() and say() for
better portability.

Also re-wrap previous 'say -n "$str<CR>"' using a new
function progress() to prevent CR chars included in the
source code, which could be mal-processed in some shells.
For example, MsysGit trims CR before executing a shell
script file in order to make it work right on Windows
even if it uses CRLF as linefeeds.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index fa1a583..6f6ddbe 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -51,14 +51,21 @@ prefix=
 debug()
 {
 	if [ -n "$debug" ]; then
-		echo "$@" >&2
+		printf "%s\n" "$*" >&2
 	fi
 }
 
 say()
 {
 	if [ -z "$quiet" ]; then
-		echo "$@" >&2
+		printf "%s\n" "$*" >&2
+	fi
+}
+
+progress()
+{
+	if [ -z "$quiet" ]; then
+		printf "%s\r" "$*" >&2
 	fi
 }
 
@@ -247,7 +254,7 @@ find_latest_squash()
 						sq="$sub"
 					fi
 					debug "Squash found: $sq $sub"
-					echo "$sq" "$sub"
+					log "$sq" "$sub"
 					break
 				fi
 				sq=
@@ -599,7 +606,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		progress "$revcount/$revmax ($createcount)"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
2.3.7.windows.1
