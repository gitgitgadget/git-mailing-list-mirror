From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Tue, 06 Nov 2007 23:31:42 +0100
Message-ID: <4730EB4E.4080903@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>	<Pine.LNX.4.64.0711041915290.4362@racer.site>	<7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>	<472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 23:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWy3-0006U0-2S
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbXKFWcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbXKFWcE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:32:04 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37698
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754573AbXKFWcB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 17:32:01 -0500
Received: from [10.0.1.201] (p57B7F84D.dip.t-dialin.net [87.183.248.77])
	by neapel230.server4you.de (Postfix) with ESMTP id 4D3AF873BA;
	Tue,  6 Nov 2007 23:31:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63740>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Junio C Hamano schrieb: ...
>>> Instead of allocating a separate array and freeing at the end,=20
>>> wouldn't it make more sense to have a bitfield that records what=20
>>> is used by the format string inside the array elements?
>> How about (ab)using the value field?  Let interp_find_active() mark
>>  unneeded entries with NULL, and the rest with some cookie.  All
>> table entries with non-NULL values need to be initialized.
>> interp_set_entry() needs to be aware of this cookie, as it mustn't
>> free() it.  The cookie could be the address of a static char* in
>> interpolate.c.
>=20
> Sorry, where is this aversion to making the struct a bit larger=20
> coming from?

Not from the rational part of my brain, for sure.  The following on
top of Dscho's second patch?  (A char would be smaller, but a bitfield
documents the intent better.)


diff --git a/interpolate.c b/interpolate.c
index 80eeb36..1e4ccaf 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -103,22 +103,21 @@ unsigned long interpolate(char *result, unsigned =
long reslen,
 	return newlen;
 }
=20
-char *interp_find_active(const char *orig,
-		const struct interp *interps, int ninterps)
+void interp_find_active(const char *orig, struct interp *interps, int =
ninterps)
 {
-	char *result =3D xcalloc(1, ninterps);
 	char c;
 	int i;
=20
+	for (i =3D 0; i < ninterps; i++)
+		interps[i].active =3D 0;
+
 	while ((c =3D *(orig++)))
 		if (c =3D=3D '%')
 			/* Try to match an interpolation string. */
 			for (i =3D 0; i < ninterps; i++)
 				if (!prefixcmp(orig, interps[i].name + 1)) {
-					result[i] =3D 1;
+					interps[i].active =3D 1;
 					orig +=3D strlen(interps[i].name + 1);
 					break;
 				}
-
-	return result;
 }
diff --git a/interpolate.h b/interpolate.h
index 2d197c5..a8ee6b9 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -14,6 +14,7 @@
 struct interp {
 	const char *name;
 	char *value;
+	unsigned active:1;
 };
=20
 extern void interp_set_entry(struct interp *table, int slot, const cha=
r *value);
@@ -22,7 +23,6 @@ extern void interp_clear_table(struct interp *table, =
int ninterps);
 extern unsigned long interpolate(char *result, unsigned long reslen,
 				 const char *orig,
 				 const struct interp *interps, int ninterps);
-extern char *interp_find_active(const char *orig,
-				const struct interp *interps, int ninterps);
+extern void interp_find_active(const char *orig, struct interp *interp=
s, int ninterps);
=20
 #endif /* INTERPOLATE_H */
