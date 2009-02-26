From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 17:45:07 -0500
Message-ID: <1235688307-8464-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 23:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcp06-0000Gy-U0
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902AbZBZWpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZBZWpO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:45:14 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:60860 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758885AbZBZWpN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:45:13 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1355274qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vV942+wKsoV8FVaEPN6Qx5AJMJQI/6ZRFcX+2zkPZgA=;
        b=npZCDinV9Ft0n1fPboVAKUUS5E0EXrQXZRKkDiImZsvdkBfSc+2hsf5gVegii4L6L7
         jJHQwIVfYd4QdtxAoPszVydkMfHzHTbrfso9h3ozsssQQHPDxN6Op6HMBWQOu7KzVzjD
         Cm4KmTQN+jebVSREa6/y7/qEGpvG55Hfhlr8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Kh94zrxfG/igd6z17hj69hnHLerWIhgzMcmJZjla5BC8gc776PX8N7PcJoJpeshFfp
         iqeJq1ZdW5DNUCCXmUKZogZBrO0os8rF6ychFUBPlIj12CTn+EMtXJ3cy8B0KVIEtkZs
         abGYpl84XTQvm8xwNILOvx4squqFGhxO/yycY=
Received: by 10.224.67.82 with SMTP id q18mr3074748qai.312.1235688310302;
        Thu, 26 Feb 2009 14:45:10 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm308946qwh.59.2009.02.26.14.45.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 14:45:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111607>

OS X's GNU grep does not support -P/--perl-regexp.

We use a basic RE instead, and simplify the pattern slightly by
replacing '+' with '*' so it can be more easily expressed using a basic
RE. The important part of pattern, checking for a SHA-1 has suffix in
the successful PUT/MOVE operations, remains the same. Here are samples
of what we want to match:

127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "PUT /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277
127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "MOVE /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Junio,

This is the best I can do. If it's not good enough, and you'd rather
have the existing non-portable grep -P, so be it.

 t/t5540-http-push.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..470bca3 100755
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
+	| grep "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9]"
 
 '
 
-- 
1.6.2.rc1.309.g5f417
