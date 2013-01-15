From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 16:55:11 +0100
Message-ID: <50F57BDF.1050400@lsrfire.ath.cx>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Carlos?= =?ISO-8859-1?Q?_Mart=EDn_Nieto?= 
	<cmn@elego.de>, Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 16:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv8rY-00010Z-Me
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 16:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab3AOPzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 10:55:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:37628 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3AOPzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 10:55:23 -0500
Received: from [192.168.2.105] (p579BE2B3.dip.t-dialin.net [87.155.226.179])
	by india601.server4you.de (Postfix) with ESMTPSA id 91C18138;
	Tue, 15 Jan 2013 16:55:21 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213641>

Am 15.01.2013 00:36, schrieb Junio C Hamano:
> It appears that memcmp() uses the usual "one word at a time"
> comparison and triggers valgrind in a callback of bsearch() used in
> the refname search.  I can easily trigger problems in any script
> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
> without this suppression.

I can't reproduce it on Debian, but can we perhaps do without the
suppression with a patch like this instead?  I would expect it to
be slightly faster because we lose the strlen() call, but didn't
check.  It's also simpler, perhaps with the exception of the last
line.  Does it help in your case?

Ren=E9

---
 refs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 541fec2..1a0e049 100644
--- a/refs.c
+++ b/refs.c
@@ -335,12 +335,10 @@ static int ref_entry_cmp_sslice(const void *key_,=
 const void *ent_)
 {
 	struct string_slice *key =3D (struct string_slice *)key_;
 	struct ref_entry *ent =3D *(struct ref_entry **)ent_;
-	int entlen =3D strlen(ent->name);
-	int cmplen =3D key->len < entlen ? key->len : entlen;
-	int cmp =3D memcmp(key->str, ent->name, cmplen);
+	int cmp =3D strncmp(key->str, ent->name, key->len);
 	if (cmp)
 		return cmp;
-	return key->len - entlen;
+	return '\0' - ent->name[key->len];
 }
=20
 /*
