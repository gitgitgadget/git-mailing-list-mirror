From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 18:35:50 +0200
Message-ID: <53B191E6.7010509@web.de>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com> <53AFA775.1090900@web.de> <53AFAA89.6050200@web.de> <20140630134317.GB14799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:36:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1eYv-00088f-AQ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbaF3QgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:36:08 -0400
Received: from mout.web.de ([212.227.17.12]:63415 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbaF3QgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:36:07 -0400
Received: from [192.168.178.27] ([79.253.187.118]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MA5qv-1WuovF1Brl-00BLr1; Mon, 30 Jun 2014 18:35:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140630134317.GB14799@sigill.intra.peff.net>
X-Provags-ID: V03:K0:hrNLE4QQptGZulEh163sSZ/jgfvUdOdyz+drAa/knJsHNizAWNg
 Ab6OEvDhk/Qmn71rrwudEaXdtjH4LxOTYSfFCoga8xLtONvY83VyewhjWutTroh8TRaQw5O
 Tis8Vvr/8jfcI0PhXp5vMSmeHmVftcsnSSAlrg+J4vyovsnRJwh1ecYxCcpC6pJ8TIs5pfB
 Sch0K3RAVWuBEl+B/kjkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252678>

Am 30.06.2014 15:43, schrieb Jeff King:
> On Sun, Jun 29, 2014 at 07:56:25AM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Avoid overrunning the existing pack name (p->pack_name, a C string) =
in
>> the case that the new path is longer by using strncmp instead of mem=
cmp
>> for comparing.  While at it, replace the magic constant 4 with a
>> strlen call to document its meaning.
>=20
> An unwritten assumption with this code is that we have "foo.idx" and =
we
> want to make sure that we are matching "foo.pack" from the existing p=
ack
> list. Both before and after your patch, I think we would match
> "foobar.pack".

Yes, indeed.

> It's probably not a big deal, as we don't expect random
> junk in the pack directory, but I wonder if it would be better to be
> explicit, like:

<snip>

Here's a simpler approach:

-- >8 --
Subject: [PATCH v2 3/2] sha1_file: more precise packname matching

Consider the full length of the already loaded pack names when checking
for duplicates.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b7ad6c1..a13fbbd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1206,10 +1206,12 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 		strbuf_addstr(&path, de->d_name);
=20
 		if (has_extension(de->d_name, ".idx")) {
+			size_t len =3D path.len - strlen(".idx");
+
 			/* Don't reopen a pack we already have. */
 			for (p =3D packed_git; p; p =3D p->next) {
-				if (!strncmp(path.buf, p->pack_name,
-					     path.len - strlen(".idx")))
+				if (!strncmp(p->pack_name, path.buf, len) &&
+				    !strcmp(p->pack_name + len, ".pack"))
 					break;
 			}
 			if (p =3D=3D NULL &&
--=20
2.0.0
