From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix preprocessor logic that determines the availablity of
 strchrnul().
Date: Mon, 12 Nov 2007 11:09:05 +0100
Message-ID: <47382641.3080109@viscovery.net>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org>	 <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>	 <473818FA.1060400@viscovery.net>	 <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com>	 <473821CE.8050907@viscovery.net> <ee77f5c20711120152i4955ed3bh484c9ac76a7f1f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWEP-0006tj-6t
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbXKLKJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbXKLKJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:09:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65381 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836AbXKLKJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:09:08 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrWDb-0003rz-54; Mon, 12 Nov 2007 11:08:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B6F9C54D; Mon, 12 Nov 2007 11:09:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ee77f5c20711120152i4955ed3bh484c9ac76a7f1f5c@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64591>

Apart from the error in the condition (&& should actually be ||), the
construct

    #if !defined(A) || !A

leads to a syntax error in the C preprocessor if A is indeed not defined.

Tested-by: David Symonds <dsymonds@gmail.com>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  git-compat-util.h |    8 +++++++-
  1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3d147b6..276a437 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -184,7 +184,13 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                  const void *needle, size_t needlelen);
  #endif

-#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
+#ifdef __GLIBC_PREREQ
+#if __GLIBC_PREREQ(2, 1)
+#define HAVE_STRCHRNUL
+#endif
+#endif
+
+#ifndef HAVE_STRCHRNUL
  #define strchrnul gitstrchrnul
  static inline char *gitstrchrnul(const char *s, int c)
  {
-- 
1.5.3.5.578.g1f8ec
