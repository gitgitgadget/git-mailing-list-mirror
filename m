From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] grep: support newline separated pattern list
Date: Mon, 21 May 2012 18:10:09 +0200
Message-ID: <4FBA68E1.60908@lsrfire.ath.cx>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com> <4FB6426C.7040202@lsrfire.ath.cx> <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com> <4FB900A3.9050309@lsrfire.ath.cx> <7vobpia3l3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Torne (Richard Coles)" <torne@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 18:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWVBg-0003rg-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 18:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab2EUQKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 May 2012 12:10:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:32999 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab2EUQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 12:10:17 -0400
Received: from [192.168.2.105] (p4FFDA0CF.dip.t-dialin.net [79.253.160.207])
	by india601.server4you.de (Postfix) with ESMTPSA id 06BD32F8058;
	Mon, 21 May 2012 18:10:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vobpia3l3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198116>

Am 21.05.2012 00:29, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>=20
>> Currently, patterns that contain newline characters don't match anyt=
hing
>> when given to git grep.  Regular grep(1) interprets patterns as list=
s of
>> newline separated search strings instead.
>>
>> Implement this functionality by creating and inserting extra grep_pa=
t
>> structures for patterns consisting of multiple lines when appending =
to
>> the pattern lists.  For simplicity, all pattern strings are duplicat=
ed.
>> The original pattern is truncated in place to make it contain only t=
he
>> first line.
>=20
> Thanks for a fix; I am assuming that the duplication for simplicity i=
s not
> for simplified allocation but primarily for a simpler freeing?

When we split a search string into multiple parts, we could allocate on=
ly
the new parts and remember which strings were allocated, so that we cou=
ld
later free them (and only them).  Or we could allocate and leak them, a=
s
there aren't that many and we keep them during the whole run of the pro=
gram
anyway.  Or we could do without any allocations if all match backends
respected length limited strings like kwset does.  Or only allocate
non-fixed pattern.

Allocating any and all pattern strings and freeing them at the end, thu=
s
disregarding these considerations, is simpler, cleaner and still doesn'=
t
cause excessive memory usage.

That reminds me that we can now have this bonus patch:

-- >8 --
Subject: [PATCH 4/3] grep: stop leaking line strings with -f

When reading patterns from a file, we pass the lines as allocated strin=
g
buffers to append_grep_pat() and never free them.  That's not a problem
because they are needed until the program ends anyway.

However, now that the function duplicates the pattern string, we can
reuse the strbuf after calling that function.  This simplifies the code
a bit and plugs a minor memory leak.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/grep.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 643938d..fe1726f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -600,15 +600,12 @@ static int file_callback(const struct option *opt=
, const char *arg, int unset)
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
 	while (strbuf_getline(&sb, patterns, '\n') =3D=3D 0) {
-		char *s;
-		size_t len;
-
 		/* ignore empty line like grep does */
 		if (sb.len =3D=3D 0)
 			continue;
=20
-		s =3D strbuf_detach(&sb, &len);
-		append_grep_pat(grep_opt, s, len, arg, ++lno, GREP_PATTERN);
+		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
+				GREP_PATTERN);
 	}
 	if (!from_stdin)
 		fclose(patterns);
--=20
1.7.10.2
