From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: [MinGW PATCH] 'git clone git://...' was failing inside git-read-tree with 'fatal: Not a valid object name HEAD'
Date: Sat, 4 Aug 2007 04:38:13 -0700
Message-ID: <F7C35F51E58245FDA1EE1C2F2B4EB204@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <johannes.sixt@telecom.at>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHxb-00023N-8w
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbXHDLiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbXHDLiQ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:38:16 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:54634 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbXHDLiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:38:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so857591rvb
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 04:38:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=buzT6+zAcJc5v1GLd26qVsUFeFMQ1lK1XSClDCPb1A5V2vqe21abZJEeSv8O3gKBlJtV2ccyoS5DNMBzVcbHYX92vF9ir9yrLjwitAEC+y64FekKOBhkNGTAMQ0vaoHKxPnTvERrigkPJcahU9c1a68lWKZWCdyr7DKdDvDqq4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=aIOyNSY1z+1124OAkF4uqjgpXT0QIkfMBqvQkSApk2Rj2MDXAeJ8cGuUrGYMJSANO5F5cC5/pqGKQ6Z2X2272uVWpUUHgmZqEV9QrF1gIDRe3v4lnzNFvMmlvRGIxBChpu4CFQYhES/dwrwaRGFZPIFn3ASuDeSXeegIR12L8M4=
Received: by 10.141.3.10 with SMTP id f10mr1411644rvi.1186227495184;
        Sat, 04 Aug 2007 04:38:15 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id g39sm7342906rvb.2007.08.04.04.38.13
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 04:38:14 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54825>

NOTE: This fix uses is_absolute_path from msysGit-0.3.exe that is not in mingw.git yet.

Correctly test for absolute path

This fix (while correct) actually avoids another nasty bug that must be fixed later:
environment.c caches results of many getenv calls.
Under MinGW setenv(X) invalidates all previous values returned by getenv(X) 
so cached values become dangling pointers.

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index e921013..47cd790 100644
--- a/setup.c
+++ b/setup.c
@@ -332,7 +332,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
   * In case there is a work tree we may change the directory,
   * therefore make GIT_DIR an absolute path.
   */
- if (gitdirenv[0] != '/') {
+ if ( !is_absolute_path( gitdirenv ) ) {
   setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
   gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
   if (!gitdirenv)
-- 
mingw.v1.5.2.4.884.gad85-dirty
