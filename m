From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Wed, 24 Dec 2008 16:20:15 +0100
Message-ID: <4952532F.5050704@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org> <20081223102127.GA21485@artemis.corp> <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain> <20081224101146.GA10008@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 16:21:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFVYH-0005QC-VZ
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 16:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbYLXPUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Dec 2008 10:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbYLXPUS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 10:20:18 -0500
Received: from india601.server4you.de ([85.25.151.105]:46461 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYLXPUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 10:20:17 -0500
Received: from [10.0.1.101] (p57B7D767.dip.t-dialin.net [87.183.215.103])
	by india601.server4you.de (Postfix) with ESMTPSA id 8B3C92F8003;
	Wed, 24 Dec 2008 16:20:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081224101146.GA10008@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103860>

Pierre Habouzit schrieb:
> On Tue, Dec 23, 2008 at 06:16:01PM +0000, Linus Torvalds wrote:
>>
>> On Tue, 23 Dec 2008, Pierre Habouzit wrote:
>>> when readlink fails, the strbuf shall not be destroyed. It's not ho=
w
>>> read_file_or_gitlink works for example.
>> I disagree.
>>
>> This patch just makes things worse. Just leave the "strbuf_release()=
" in=20
>> _one_ place.
>=20
> The "problem" is that the strbuf API usually works that way: function=
s
> append things to a buffer, or do nothing, but always keep the buffer =
in
> a state where you can append more stuff to it.
>=20
> If read_file_or_gitlink or strbuf_readlink destroy the buffer, then y=
ou
> break the second expectation people (should) have about the strbuf AP=
I.

The "append or do nothing" rule is broken by strbuf_getline(), but I ag=
ree
to your reasoning.  How about refining this rule a bit to "do your thin=
g
and roll back changes if an error occurs"?  I think it's not worth to u=
ndo
allocation extensions, but making reverting first time allocations seem=
s
like a good idea.  Something like this?

Ren=E9


PS: only nine lines! ;-)


 strbuf.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bdf4954..6ed0684 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -256,18 +256,21 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, c=
onst char *placeholder,
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
+	size_t oldalloc =3D sb->alloc;
=20
 	strbuf_grow(sb, size);
 	res =3D fread(sb->buf + sb->len, 1, size, f);
-	if (res > 0) {
+	if (res > 0)
 		strbuf_setlen(sb, sb->len + res);
-	}
+	else if (res < 0 && oldalloc =3D=3D 0)
+		strbuf_release(sb);
 	return res;
 }
=20
 ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 {
 	size_t oldlen =3D sb->len;
+	size_t oldalloc =3D sb->alloc;
=20
 	strbuf_grow(sb, hint ? hint : 8192);
 	for (;;) {
@@ -275,7 +278,10 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, siz=
e_t hint)
=20
 		cnt =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 		if (cnt < 0) {
-			strbuf_setlen(sb, oldlen);
+			if (oldalloc =3D=3D 0)
+				strbuf_release(sb);
+			else
+				strbuf_setlen(sb, oldlen);
 			return -1;
 		}
 		if (!cnt)
@@ -292,6 +298,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size=
_t hint)
=20
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 {
+	size_t oldalloc =3D sb->alloc;
+
 	if (hint < 32)
 		hint =3D 32;
=20
@@ -311,7 +319,8 @@ int strbuf_readlink(struct strbuf *sb, const char *=
path, size_t hint)
 		/* .. the buffer was too small - try again */
 		hint *=3D 2;
 	}
-	strbuf_release(sb);
+	if (oldalloc =3D=3D 0)
+		strbuf_release(sb);
 	return -1;
 }
=20
