From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Fri, 09 Nov 2007 11:22:37 +0100
Message-ID: <473434ED.50002@op5.se>
References: <4733AEA0.1060602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 11:23:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqR0t-0001Y0-RB
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 11:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXKIKWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 05:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXKIKWn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 05:22:43 -0500
Received: from mail.op5.se ([193.201.96.20]:48609 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbXKIKWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 05:22:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 63A4A1F0871E;
	Fri,  9 Nov 2007 11:22:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOd3cm33zFst; Fri,  9 Nov 2007 11:22:39 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B80311F08715;
	Fri,  9 Nov 2007 11:22:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4733AEA0.1060602@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64151>

Ren=E9 Scharfe wrote:
> As suggested by Pierre Habouzit, add strchrnul().  It's a useful GNU
> extension and can simplify string parser code.  There are several
> places in git that can be converted to strchrnul(); as a trivial
> example, this patch introduces its usage to builtin-fetch--tool.c.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>=20
>  Makefile              |   13 +++++++++++++
>  builtin-fetch--tool.c |    8 ++------
>  compat/strchrnul.c    |    8 ++++++++
>  git-compat-util.h     |    5 +++++
>  4 files changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 0d5590f..578c999 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -30,6 +30,8 @@ all::
>  #
>  # Define NO_MEMMEM if you don't have memmem.
>  #
> +# Define NO_STRCHRNUL if you don't have strchrnul.
> +#


This seems overly complicated. How about this instead?

=46rom: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Add strchrnul()

As suggested by Pierre Habouzit, add strchrnul().  It's a useful GNU
extension and can simplify string parser code.  There are several
places in git that can be converted to strchrnul(); as a trivial
example, this patch introduces its usage to builtin-fetch--tool.c.

strchrnul() was introduced in glibc in April 1999 and included in
glibc-2.1. Checking for that version means the majority of all git
users would get to use the optimized version in glibc. Of the
remaining few some might get to use a slightly slower version
than necessary but probably not slower than what we have today.

Original patch by Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

I'm fairly much against forcing people to know what library
functions they have in order to get software to compile
properly. This is, imo, a neater solution, and also inlines
the function as suggested by Dscho.

diff --git a/git-compat-util.h b/git-compat-util.h
index 7b29d1b..9fedf33 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -105,6 +105,18 @@ extern void set_die_routine(void (*routine)(const =
char *err
 extern void set_error_routine(void (*routine)(const char *err, va_list=
 params))
 extern void set_warn_routine(void (*routine)(const char *warn, va_list=
 params))
=20
+
+#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
+# define strchrnul(s, c) gitstrchrnul(s, c)
+static inline char *gitstrchrnul(const char *s, int c)
+{
+       while (*s && *s !=3D c)
+               s++;
+
+       return (char *)s;
+}
+#endif
+
 #ifdef NO_MMAP
=20
 #ifndef PROT_READ
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 6a78517..ed60847 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -435,9 +435,7 @@ static int pick_rref(int sha1_only, const char *rre=
f, const char *ls_remote_resu
 				cp++;
 			if (!*cp)
 				break;
-			np =3D strchr(cp, '\n');
-			if (!np)
-				np =3D cp + strlen(cp);
+			np =3D strchrnul(cp, '\n');
 			if (pass) {
 				lrr_list[i].line =3D cp;
 				lrr_list[i].name =3D cp + 41;
@@ -461,9 +459,7 @@ static int pick_rref(int sha1_only, const char *rre=
f, const char *ls_remote_resu
 			rref++;
 		if (!*rref)
 			break;
-		next =3D strchr(rref, '\n');
-		if (!next)
-			next =3D rref + strlen(rref);
+		next =3D strchrnul(rref, '\n');
 		rreflen =3D next - rref;
=20
 		for (i =3D 0; i < lrr_count; i++) {
--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
