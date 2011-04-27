From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Wed, 27 Apr 2011 19:24:50 +0200
Message-ID: <4DB85162.6000204@lsrfire.ath.cx>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com> <7vaafdexsp.fsf@alter.siamese.dyndns.org> <4DB738A1.8020706@lsrfire.ath.cx> <7vhb9kd6kp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:25:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Um-0007qa-7i
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab1D0RZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 13:25:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:41228 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab1D0RZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:25:42 -0400
Received: from [192.168.2.106] (p4FFDB579.dip.t-dialin.net [79.253.181.121])
	by india601.server4you.de (Postfix) with ESMTPSA id 905212F8050;
	Wed, 27 Apr 2011 19:25:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vhb9kd6kp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172249>

Am 26.04.2011 23:51, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>=20
>> How about something like this instead?  The call to strbuf_grow() wa=
s
>> introduced in a8f3e2219 when there was no strbuf_slopbuf buffer that
>> nowadays makes sure we always have a place to write an initial NUL.
>> We can take it out again now, simplifying the code and hopefully
>> avoiding future confusion.
>=20
> Thanks; I think that makes sense.
>=20
> It further may make sense to turn the assert into BUG() though, to cl=
arify
> what kind of programming error we are trying to catch.  Perhaps like:
>=20
>>   static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>> +	assert(len<  (sb->alloc ? sb->alloc : 1));
>=20
> 	if (len<  (sb->alloc ? sb->alloc : 1))
> 		die("programming error: using strbuf_setlen() to extend a strbuf");
>=20
>>   	sb->len =3D len;
>>   	sb->buf[len] =3D '\0';
>>   }

I like the idea, except the comparison needs to be inverted.

Compiled, but not tested.  The test suite takes too long and skips too
many tests on my Windows box and I don't have any other machine
available right now. :-/

-- >8 --
Subject: strbuf: clarify assertion in strbuf_setlen()

Commit a8f3e2219 introduced the strbuf_grow() call to strbuf_setlen() t=
o
make ensure that there was at least one byte available to write the
mandatory trailing NUL, even for previously unallocated strbufs.

Then b315c5c0 added strbuf_slopbuf for the same reason, only globally f=
or
all uses of strbufs.

Thus the strbuf_grow() call can be removed now.  This avoids readers of
strbuf.h from mistakenly thinking that strbuf_setlen() can be used to
extend a strbuf.

The following assert() needs to be changed to cope with the fact that
sb->alloc can now be zero, which is OK as long as len is also zero.  As
suggested by Junio, use the chance to convert it to a die() with a shor=
t
explanatory message.  The pattern of 'die("BUG: ...")' is already used =
in
strbuf.c.

This was the only assert() in strbuf.[ch], so assert.h doesn't have to =
be
included anymore either.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 strbuf.h |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 07060ce..9e6d9fa 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -3,8 +3,6 @@
=20
 /* See Documentation/technical/api-strbuf.txt */
=20
-#include <assert.h>
-
 extern char strbuf_slopbuf[];
 struct strbuf {
 	size_t alloc;
@@ -33,9 +31,8 @@ static inline size_t strbuf_avail(const struct strbuf=
 *sb) {
 extern void strbuf_grow(struct strbuf *, size_t);
=20
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
-	if (!sb->alloc)
-		strbuf_grow(sb, 0);
-	assert(len < sb->alloc);
+	if (len > (sb->alloc ? sb->alloc - 1 : 0))
+		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len =3D len;
 	sb->buf[len] =3D '\0';
 }
--=20
1.7.5
