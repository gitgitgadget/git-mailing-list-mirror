From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:33:07 +0200
Message-ID: <20110428093307.GA15349@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNeJ-0006Ya-5U
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab1D1Jgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:36:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45182 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab1D1Jgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:36:31 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFNax-0006s4-1j
	from <mingo@elte.hu>; Thu, 28 Apr 2011 11:33:16 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id DC3743E236B; Thu, 28 Apr 2011 11:33:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172334>


* Erik Faye-Lund <kusmabite@gmail.com> wrote:

> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
> >
> > * Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Ingo Molnar <mingo@elte.hu> writes:
> >>
> >> > +static inline int hashcmp(const unsigned char *sha1, const unsi=
gned char *sha2)
> >> > =A0{
> >> > - =A0 return !memcmp(sha1, null_sha1, 20);
> >> > + =A0 int i;
> >> > +
> >> > + =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
> >> > + =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 < *sha2)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return +1;
> >> > + =A0 =A0 =A0 =A0 =A0 }
>=20
> Why not just:
>=20
> if (*sha1 !=3D *sha2)
>         return *sha2 - *sha1;

You mean "*sha1 - *sha2", right?

> memcmp isn't guaranteed to return onlt the values -1, 0, +1, it can
> return any value, just as long as it's sign of a non-zero return
> express the relationship between the first mis-matching byte.

Yeah, agreed, updated patch below. Seems to work fine here.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/cache.h b/cache.h
index 2674f4c..574c948 100644
--- a/cache.h
+++ b/cache.h
@@ -675,14 +675,30 @@ extern char *sha1_pack_name(const unsigned char *=
sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
-static inline int is_null_sha1(const unsigned char *sha1)
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
 {
-	return !memcmp(sha1, null_sha1, 20);
+	int i;
+
+	for (i =3D 0; i < 20; i++, sha1++, sha2++) {
+		if (*sha1 !=3D *sha2)
+			return *sha1 - *sha2;
+	}
+
+	return 0;
 }
-static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
+
+static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return memcmp(sha1, sha2, 20);
+	const unsigned long long *sha1_64 =3D (void *)sha1;
+	const unsigned int *sha1_32 =3D (void *)sha1;
+
+	if (sha1_64[0] || sha1_64[1] || sha1_32[4])
+		return 0;
+
+	return 1;
 }
+
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char=
 *sha_src)
 {
 	memcpy(sha_dst, sha_src, 20);
