From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Mon, 4 Apr 2011 12:29:29 +0200
Message-ID: <BANLkTi=dF7p9K5c8SYFJjZ7uognwizuuaQ@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com> <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 12:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6h2m-00087e-7L
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 12:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab1DDK3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 06:29:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38422 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab1DDK3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 06:29:50 -0400
Received: by bwz15 with SMTP id 15so3895214bwz.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Wtmntc8sSVpYBQsWgAVzU0QoiRIeBYAzLo4m/ZTX3x0=;
        b=YeifyJ2TNKIKLQH/4uZqKGVMVMdJhUbGLCgSGZIz+xRkVQIm5bXPsNTAJRb42XZJ3z
         1ymjRxDOgWT24ak6KQ0f8rOsEV9+FwJ4p2H0fzxqnvzqANt5U3kDRxGDA0vhq6/wH/N8
         Fyp+sx0yEH9TnNB64AAI7Rlqz01htSYDLAXEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=r87jrzeEI4fpujq4gaxs88pzp7YbgVqdeIggKK8j42JxGFrl2PrZnRA46k8sMe4XVR
         nP6+CTFQU4aDu8+g4nF9gPmZeKQrj0VuvDvFa4PDvMjY16Jqyqsyy9v0qNOMm0eRE81g
         u5ToMDUTpEF0E3Ws5ePwfU50EMkVKLOUaYcr4=
Received: by 10.204.144.194 with SMTP id a2mr5689231bkv.93.1301912989094; Mon,
 04 Apr 2011 03:29:49 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Mon, 4 Apr 2011 03:29:29 -0700 (PDT)
In-Reply-To: <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170801>

On Thu, Mar 31, 2011 at 3:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> We know our mode entry in our tree objects should be 5 or 6 character=
s
> long. This change both enforces this fact and also unrolls the parsin=
g
> of the information giving the compiler more room for optimization of =
the
> operations.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
> =A0tree-walk.c | =A0 41 ++++++++++++++++++++++++++++++++++-------
> =A01 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index f386151..41383b0 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -9,16 +9,43 @@ static const char *get_mode(const char *str, unsign=
ed int *modep)
> =A0 =A0 =A0 =A0unsigned char c;
> =A0 =A0 =A0 =A0unsigned int mode =3D 0;
>
> - =A0 =A0 =A0 if (*str =3D=3D ' ')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> -
> - =A0 =A0 =A0 while ((c =3D *str++) !=3D ' ') {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c < '0' || c > '7')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Unroll what looks like a loop since the bounds are
> + =A0 =A0 =A0 =A0* well-known. There should be at least 5 and at most=
 6
> + =A0 =A0 =A0 =A0* characters available in any valid mode, as '40000'=
 is the
> + =A0 =A0 =A0 =A0* shortest while '160000' (S_IFGITLINK) is the longe=
st.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 /* char 1 */
> + =A0 =A0 =A0 c =3D *str++;
> + =A0 =A0 =A0 if (c < '0' || c > '7') return NULL;

We perfer this style:

if (c < '0' || c > '7')
	return NULL;

i.e a line-break and a tab between the if-statement and the conditional=
 code.

> + =A0 =A0 =A0 mode =3D (mode << 3) + (c - '0');
> + =A0 =A0 =A0 /* char 2 */
> + =A0 =A0 =A0 c =3D *str++;
> + =A0 =A0 =A0 if (c < '0' || c > '7') return NULL;
> + =A0 =A0 =A0 mode =3D (mode << 3) + (c - '0');
> + =A0 =A0 =A0 /* char 3 */
> + =A0 =A0 =A0 c =3D *str++;
> + =A0 =A0 =A0 if (c < '0' || c > '7') return NULL;
> + =A0 =A0 =A0 mode =3D (mode << 3) + (c - '0');
> + =A0 =A0 =A0 /* char 4 */
> + =A0 =A0 =A0 c =3D *str++;
> + =A0 =A0 =A0 if (c < '0' || c > '7') return NULL;
> + =A0 =A0 =A0 mode =3D (mode << 3) + (c - '0');
> + =A0 =A0 =A0 /* char 5 */
> + =A0 =A0 =A0 c =3D *str++;
> + =A0 =A0 =A0 if (c < '0' || c > '7') return NULL;
> + =A0 =A0 =A0 mode =3D (mode << 3) + (c - '0');

Wouldn't this part be cleaner as a constant-length loop? Any
optimizing compiler should end up unrolling this, and we don't get as
much code-duplication...

Oddly enough, this change gave me a drastic (> 20%) performance
increase in my test (isolating get_mode in a separate compilation
unit, and calling it in a loop):

diff --git a/tree-walk.c b/tree-walk.c
index b8d504b..114ad63 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -7,42 +7,30 @@
 static const char *get_mode(const char *str, unsigned int *modep)
 {
 	unsigned char c;
-	unsigned int mode =3D 0;
+	unsigned int mode =3D 0, i;

 	/*
-	 * Unroll what looks like a loop since the bounds are
+	 * Allow the compiler to unroll the loop since the bounds are
 	 * well-known. There should be at least 5 and at most 6
 	 * characters available in any valid mode, as '40000' is the
 	 * shortest while '160000' (S_IFGITLINK) is the longest.
 	 */
-	/* char 1 */
-	c =3D *str++;
-	if (c < '0' || c > '7') return NULL;
-	mode =3D (mode << 3) + (c - '0');
-	/* char 2 */
-	c =3D *str++;
-	if (c < '0' || c > '7') return NULL;
-	mode =3D (mode << 3) + (c - '0');
-	/* char 3 */
-	c =3D *str++;
-	if (c < '0' || c > '7') return NULL;
-	mode =3D (mode << 3) + (c - '0');
-	/* char 4 */
-	c =3D *str++;
-	if (c < '0' || c > '7') return NULL;
-	mode =3D (mode << 3) + (c - '0');
-	/* char 5 */
-	c =3D *str++;
-	if (c < '0' || c > '7') return NULL;
-	mode =3D (mode << 3) + (c - '0');
+	for (i =3D 0; i < 5; ++i) {
+		c =3D *str++;
+		if (c < '0' || c > '7')
+			return NULL;
+		mode =3D (mode << 3) + (c - '0');
+	}
 	/* char 6, optional */
 	if (*str !=3D ' ') {
 		c =3D *str++;
-		if (c < '0' || c > '7') return NULL;
+		if (c < '0' || c > '7')
+			return NULL;
 		mode =3D (mode << 3) + (c - '0');
 	}

-	if (*str !=3D ' ') return NULL;
+	if (*str !=3D ' ')
+		return NULL;

 	*modep =3D mode;
 	return str + 1;
