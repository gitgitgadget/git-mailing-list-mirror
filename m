From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: fix colouring of matches with zero length
Date: Mon, 01 Jun 2009 23:53:05 +0200
Message-ID: <4A244DC1.1090801@lsrfire.ath.cx>
References: <4A2405DA.7010801@lsrfire.ath.cx> <7voct7k61r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 23:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBFRi-0005Tz-30
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbZFAVxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757421AbZFAVxT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 17:53:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:47307 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757336AbZFAVxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 17:53:16 -0400
Received: from [10.0.1.101] (p57B7CDAE.dip.t-dialin.net [87.183.205.174])
	by india601.server4you.de (Postfix) with ESMTPSA id DE84B2F8042;
	Mon,  1 Jun 2009 23:53:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7voct7k61r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120484>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> The first hunk fixes match colouring if the patterns is the empty st=
ring.
>> Such a pattern matches the whole line,...
>=20
> Hmmm...
>=20
> An empty pattern may have to produce a match with any line, but I do =
not
> think it should match the whole line.  GNU seems to agree with me.
>=20
> 	echo foo | grep --color -e ''
>         echo foo | grep --color -F -e ''
>         echo foo | grep --color -e '.*'
>         echo foo | grep --color -F -e 'foo'
>=20
> The first two are uncoloured (but still show matches).

You're right, and matching the zero-length string at the beginning of t=
he
line actually makes sense.  Corrected patch below.


If a zero-length match is encountered, break out of loop and show the r=
est
of the line uncoloured.  Otherwise we'd be looping forever, trying to m=
ake
progress by advancing the pointer by zero characters.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/grep.c b/grep.c
index cc6d5b0..7bf4a60 100644
--- a/grep.c
+++ b/grep.c
@@ -500,6 +500,8 @@ static void show_line(struct grep_opt *opt, char *b=
ol, char *eol,
=20
 		*eol =3D '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+			if (match.rm_so =3D=3D match.rm_eo)
+				break;
 			printf("%.*s%s%.*s%s",
 			       (int)match.rm_so, bol,
 			       opt->color_match,
--=20
1.6.3.1
