From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 10:50:06 +0100
Message-ID: <473821CE.8050907@viscovery.net>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org>	 <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>	 <473818FA.1060400@viscovery.net> <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVw5-0001zx-6v
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbXKLJuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756084AbXKLJuN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:50:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63801 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXKLJuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:50:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrVvE-00030l-5a; Mon, 12 Nov 2007 10:49:36 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D8A8F54D; Mon, 12 Nov 2007 10:50:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64584>

David Symonds schrieb:
> On Nov 12, 2007 8:12 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> David Symonds schrieb:
>>> I don't think I have __GLIBC_PREREQ defined anywhere I can find.
>> Turn the && in that line into || and it should work.
> 
> Nope, no dice. Plus, that'd change the logic. I also tried turning the
> (!X && !Y) into (X || Y) to no avail.

Ok, then how about this?

---
diff --git a/git-compat-util.h b/git-compat-util.h
index 3d147b6..276a437 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -184,7 +184,13 @@ void *gitmemmem(const void *haystack,
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
