From: Danny Lin <danny0838@gmail.com>
Subject: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri,  8 May 2015 08:56:59 +0800
Message-ID: <1431046619-2340-1-git-send-email-danny0838@gmail.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
Cc: git develop <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Danny Lin <danny0838@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 02:57:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqWbP-0004zX-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 02:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbEHA5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 20:57:15 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34213 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbEHA5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 20:57:14 -0400
Received: by pdbqa5 with SMTP id qa5so55876123pdb.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NXBH3A/JgrfGfcCWznkuODsvsdsrScViL7Q0WXk90ew=;
        b=Bie7TpsuZVLEKgcJZlrKghJokUHHIb0kepWmjpLcDlqbMYzNU8OYSqBZTTAVJJaH1H
         /6usruKq6chNPbQ29CWOBYHnkjUFcVAbPoyvHI6kVJV+a/9+oA6SAs0dShjvqccE16Fz
         Q/IpxF67jeoukPamHaPp23uJZid5B2nzwmOZ5HxcVuYD4jAITfNOhSm4RxeZYRD6Sg5+
         RPFcuM6L1BRgk+KR/ORCeSSE9rRZ7QVcb+ogoH0qgX+xZlxAC7SujNOrGRpfWuWvAM2m
         h97MJDraUnAi7fOCVnrqmnwuY+wFd3qlzh4bzruTZcU4TJrhktaWX6xKNekLVfY/3VJx
         vQMg==
X-Received: by 10.66.101.9 with SMTP id fc9mr2112209pab.37.1431046634284;
        Thu, 07 May 2015 17:57:14 -0700 (PDT)
Received: from localhost.localdomain (1-164-201-189.dynamic.hinet.net. [1.164.201.189])
        by mx.google.com with ESMTPSA id u8sm3305959pdi.90.2015.05.07.17.57.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 17:57:13 -0700 (PDT)
X-Mailer: git-send-email 2.3.7.windows.1
In-Reply-To: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268595>

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
 contrib/subtree/git-subtree.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index fa1a583..d4dae7a 100755
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

Previous patch had a flaw, revised.
