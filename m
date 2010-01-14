From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Test t5560: Fix test when run with dash
Date: Wed, 13 Jan 2010 23:01:17 -0800
Message-ID: <1263452477-15250-1-git-send-email-tarmigan+git@gmail.com>
References: <4B4EAB58.6040901@alum.mit.edu>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVJTT-0001ke-QG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 07:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0ANGq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 01:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664Ab0ANGq1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 01:46:27 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:62279 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0ANGq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 01:46:27 -0500
Received: by qyk32 with SMTP id 32so3657115qyk.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 22:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=bBoJIa6q7HDsK51kwhMu9zBU+g11sB5tdpaIwd4Vwts=;
        b=PQ0d8a0xt/t00MVgKvVKF53fs0RNHpB1+I8tKu70voe7EmPyh99hWNspKLrFvn5G2E
         dSi/NsHNBt3/lVYLYVKLuZTH+I06HJu83Db5PVLmV88+OkNvRjO1/v2qRq9piafM1zh+
         JKdvO81Jo9LzzouPr76TMKdwrGPyTvAImmIEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=WnhrAsAbqW+pBP59LdQWOzqbue98V4mkPRvGc+GRgW/BR/S6v1NSA/SHbPwrM4TqWz
         FM+JWhHN1169VsufV69kJtHI4pOVd2g8DdMKHWZCl0g6vOJuLTBP7K3lrfox5g2jrkN8
         lntIyV7b5ErR0TNy2A7e8qC9Kp6b+TUXCijUU=
Received: by 10.220.124.38 with SMTP id s38mr155639vcr.36.1263451586013;
        Wed, 13 Jan 2010 22:46:26 -0800 (PST)
Received: from localhost (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 23sm155269yxe.0.2010.01.13.22.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 22:46:24 -0800 (PST)
X-Mailer: git-send-email 1.6.6.376.gabe8e
In-Reply-To: <4B4EAB58.6040901@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136955>

dash is more finicky than some shells and this change seems to make it
happier.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

---
Michael, thanks for the report.

Ubuntu's /bin/sh is dash, which I had not tested with.  Installing
dash on my machine, I was able to reproduce and this patch fixes the
problem for me.

Could you please see if this works for you?

Thanks,
Tarmigan
---
 t/t5560-http-backend-noserver.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 5f8c88e..f2e413d 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -10,12 +10,13 @@ run_backend() {
 	QUERY_STRING="${1#*\?}" \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
 	PATH_INFO="${1%%\?*}" \
+	REQUEST_METHOD="$3" \
+	CONTENT_TYPE="$4" \
 	git http-backend >act.out 2>act.err
 }
 
 GET() {
-	REQUEST_METHOD="GET" \
-	run_backend "/repo.git/$1" &&
+	run_backend "/repo.git/$1" "" "GET" &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
@@ -25,9 +26,7 @@ GET() {
 }
 
 POST() {
-	REQUEST_METHOD="POST" \
-	CONTENT_TYPE="application/x-$1-request" \
-	run_backend "/repo.git/$1" "$2" &&
+	run_backend "/repo.git/$1" "$2" "POST" "application/x-$1-request" &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
-- 
1.6.6.376.gabe8e
