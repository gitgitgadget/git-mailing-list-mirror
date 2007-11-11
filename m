From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Sun, 11 Nov 2007 02:44:06 -0800
Message-ID: <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
	<47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:44:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrAJ1-0005c8-IR
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 11:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbXKKKoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 05:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbXKKKoV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 05:44:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40904 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbXKKKoU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 05:44:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A0B4A2F2;
	Sun, 11 Nov 2007 05:44:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FA1A93A43;
	Sun, 11 Nov 2007 05:44:32 -0500 (EST)
In-Reply-To: <4735BA79.5020102@op5.se> (Andreas Ericsson's message of "Sat, 10
	Nov 2007 15:04:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64443>

Andreas Ericsson <ae@op5.se> writes:

> Ren=C3=A9 Scharfe wrote:
>>  -#ifdef NO_STRCHRNUL
>> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
>
> This will break things for users of glibc-2.1.1 (the first release st=
ill
> available from ftp://sources.redhat.com/pub/glibc/old-releases that
> includes the strchrnul() function), since __GLIBC_PREREQ() was invent=
ed
> after strchrnul() was introduced.
>
> Replacing __GLIBC__ with __GLIBC_PREREQ (as in the original patch) wi=
ll
> solve it nicely. Users of glibc-2.1.1 will be the odd minority where
> strchrnul() is available in their libc but not used.

Do you mean this on top of Ren=C3=A9's patch?  Although I do not
think I saw "the original patch" that did it this way, I think
it makes sense.

diff --git a/git-compat-util.h b/git-compat-util.h
index 11e6df6..dd96f7a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -183,7 +183,7 @@ void *gitmemmem(const void *haystack, size_t haysta=
cklen,
                 const void *needle, size_t needlelen);
 #endif
=20
-#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
+#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
 #define strchrnul gitstrchrnul
 static inline char *gitstrchrnul(const char *s, int c)
 {
