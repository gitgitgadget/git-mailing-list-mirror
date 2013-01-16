From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Wed, 16 Jan 2013 02:08:16 +0100
Message-ID: <50F5FD80.1000808@lsrfire.ath.cx>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org> <50F57BDF.1050400@lsrfire.ath.cx> <m2libunqdj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvHUl-0004Zn-CR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 02:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab3APBIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 20:08:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:37666 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147Ab3APBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 20:08:24 -0500
Received: from [192.168.2.105] (p4FFDA529.dip.t-dialin.net [79.253.165.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 3B0971D4;
	Wed, 16 Jan 2013 02:08:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <m2libunqdj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213699>

Am 15.01.2013 21:27, schrieb Andreas Schwab:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> +	return '\0' - ent->name[key->len];
>=20
> You need to cast to unsigned char first to make it consistent with
> memcmp and strcmp.

Thanks for catching this!

-- >8 --
Subject: [PATCH] refs: use strncmp() instead of strlen() and memcmp()

Simplify ref_entry_cmp_sslice() by using strncmp() to compare the
length-limited key and a NUL-terminated entry.  While we're at it,
retain the const attribute of the input pointers.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 refs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 541fec2..5129da0 100644
--- a/refs.c
+++ b/refs.c
@@ -333,14 +333,12 @@ struct string_slice {
=20
 static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
 {
-	struct string_slice *key =3D (struct string_slice *)key_;
-	struct ref_entry *ent =3D *(struct ref_entry **)ent_;
-	int entlen =3D strlen(ent->name);
-	int cmplen =3D key->len < entlen ? key->len : entlen;
-	int cmp =3D memcmp(key->str, ent->name, cmplen);
+	const struct string_slice *key =3D key_;
+	const struct ref_entry *ent =3D *(const struct ref_entry * const *)en=
t_;
+	int cmp =3D strncmp(key->str, ent->name, key->len);
 	if (cmp)
 		return cmp;
-	return key->len - entlen;
+	return '\0' - (unsigned char)ent->name[key->len];
 }
=20
 /*
--=20
1.8.0
