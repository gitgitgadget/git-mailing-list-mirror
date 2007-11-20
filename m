From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc
Date: Tue, 20 Nov 2007 12:08:06 -0800
Message-ID: <7vzlx8k7dl.fsf@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
	<7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
	<mj+md-20071120.182204.515.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Martin Mares <mj@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuZOg-00033U-Op
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 21:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702AbXKTUIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 15:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759547AbXKTUIQ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 15:08:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50121 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759514AbXKTUIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 15:08:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B2C822FC;
	Tue, 20 Nov 2007 15:08:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0594E97E1C;
	Tue, 20 Nov 2007 15:08:29 -0500 (EST)
In-Reply-To: <mj+md-20071120.182204.515.nikam@ucw.cz> (Martin Mares's message
	of "Tue, 20 Nov 2007 19:26:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65573>

Martin Mares <mj@ucw.cz> writes:

> Do we really want to use empty FLEX_ARRAY only for a new gcc? Shouldn't
> we test for C99 instead (__STDC_VERSION__ >= 199901L) and only if it
> isn't C99, choose between 0 and 1 depending on gccness of the compiler?

How about doing it this way?

-- >8 --
[PATCH] git-compat-util.h: auto-adjust to compiler support of FLEX_ARRAY a bit better

When declaring a structure with a flexible array member, instead
of defaulting to the c99 syntax for non-gnu compilers (which
burned people with older compilers), default to the traditional
and more portable "member[1]; /* more */" syntax.

At the same time, other c99 compilers should be able to take
advantage of the modern syntax to flexible array members without
being gcc.  Check __STDC_VERSION__ for that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 276a437..454d25e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -4,10 +4,24 @@
 #define _FILE_OFFSET_BITS 64
 
 #ifndef FLEX_ARRAY
-#if defined(__GNUC__) && (__GNUC__ < 3)
-#define FLEX_ARRAY 0
-#else
-#define FLEX_ARRAY /* empty */
+/*
+ * See if our compiler is known to support flexible array members.
+ */
+#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
+# define FLEX_ARRAY /* empty */
+#elif defined(__GNUC__)
+# if (__GNUC__ >= 3)
+#  define FLEX_ARRAY /* empty */
+# else
+#  define FLEX_ARRAY 0 /* older GNU extension */
+# endif
+#endif
+
+/*
+ * Otherwise, default to safer but a bit wasteful traditional style
+ */
+#ifndef FLEX_ARRAY
+# define FLEX_ARRAY 1
 #endif
 #endif
 
-- 
1.5.3.6.1797.g67f5d
