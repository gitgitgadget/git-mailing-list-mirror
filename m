From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git show loop
Date: Sat, 24 Mar 2012 16:18:46 +0100
Message-ID: <4F6DE5D6.4010408@lsrfire.ath.cx>
References: <alpine.DEB.2.02.1203241101390.2046@localhost6.localdomain6> <4F6DB4E9.3090402@in.waw.pl> <4F6DC151.9040707@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Julia Lawall <julia.lawall@lip6.fr>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 16:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBSkj-0007yx-M2
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 16:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab2CXPS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 11:18:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:33252 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab2CXPS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 11:18:58 -0400
Received: from [192.168.2.105] (p4FFD9E33.dip.t-dialin.net [79.253.158.51])
	by india601.server4you.de (Postfix) with ESMTPSA id 276C02F805D;
	Sat, 24 Mar 2012 16:18:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <4F6DC151.9040707@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193828>

Am 24.03.2012 13:42, schrieb Zbigniew J=C4=99drzejewski-Szmek:
> On 03/24/2012 12:50 PM, Zbigniew J=C4=99drzejewski-Szmek wrote:
>> On 03/24/2012 11:05 AM, Julia Lawall wrote:
>>> In linux, git show 60d9aa7 -U0 goes into an infinite loop.
>=20
> Bisect points to
> commit b810cbbde9232cbe9a3841edccc5b606bbd3a82e (refs/bisect/bad)
> Author: Junio C Hamano<gitster@pobox.com>
> Date:   Wed Jul 22 14:48:29 2009 -0700
>=20
>       diff --cc: a lost line at the beginning of the file is shown
> incorrectly

That's what I found as well, but I don't understand how this relates to
the patch below, which should fix the issue.  Valgrind told me where to
look instead.

-- >8 --
Subject: [PATCH] combine-diff: fix loop index underflow

If both la and context are zero at the start of the loop, la wraps arou=
nd
and we end up reading from memory far away.  Skip the loop in that case
instead.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 combine-diff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index a2e8dcf..9786680 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -423,7 +423,7 @@ static int make_hunks(struct sline *sline, unsigned=
 long cnt,
 						     hunk_begin, j);
 				la =3D (la + context < cnt + 1) ?
 					(la + context) : cnt + 1;
-				while (j <=3D --la) {
+				while (la && j <=3D --la) {
 					if (sline[la].flag & mark) {
 						contin =3D 1;
 						break;
--=20
1.7.9.2
