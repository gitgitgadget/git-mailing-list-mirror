From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 16:41:10 -0500
Message-ID: <1235684470-6184-1-git-send-email-jaysoffian@gmail.com>
References: <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 22:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lco0D-0007rt-UW
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 22:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbZBZVlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 16:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZBZVlR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 16:41:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:51082 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZBZVlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 16:41:16 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1308212qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FkjYyiNUXQhdwSliq3O96qWTOv2Y4LFzmiRidAjiTIk=;
        b=jb/5Ok2RsXgWRUkNOdZHTJe+80xvNfxdfy1dxI3yE6C0CxHlZ4F3gzU2iwvltWT+LY
         BiCFhn1jVVJsBwYwkSLWVnXMXJR0xneYDL39/kN5JX+Yh9MAC14lehYydRv0eOklYEva
         cCP9UEfNDnEOi8uBiVWgLGrBjgOaBp0LOxw7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KLxValjaT6FScm4iZCtBppX1deM+w19r9Y2UjVg6ena2wG4z+pHSxudAx977RvKdr2
         rkHF7qmkfay/jV+NzZYVE5lr0ZRQX39CLu6YiFfL6Hsb/Qw2i1sBtIkLINAz2kqXpKLB
         ivhU1cM1NLm+jDCiMif2Rz8S3orU3A+M44vJw=
Received: by 10.224.74.68 with SMTP id t4mr3030706qaj.59.1235684473324;
        Thu, 26 Feb 2009 13:41:13 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm392436qwg.54.2009.02.26.13.41.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 13:41:12 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111600>

OS X's GNU grep does not support -P/--perl-regexp; use basic REs instead.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t5540-http-push.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..a2e9384 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,10 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 '
 
-test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+x1="[0-9a-z]"
+x2="$x1$x1"
+x5="$x1$x1$x1$x1$x1"
+x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
+x40="$x38$x2"
 
-	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
-		< "$HTTPD_ROOT_PATH"/access.log
+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+	sed -e "s/PUT/OP/" -e "s/MOVE/OP/" < "$HTTPD_ROOT_PATH"/access.log \
+	| grep "\"OP .\{1,\}objects/$x2/${x38}_$x40 HTTP/[0-9.]\{1,\}\" 20[0-9]"
 
 '
 
-- 
1.6.2.rc1.309.g5f417
