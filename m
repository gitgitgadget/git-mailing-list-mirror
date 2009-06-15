From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 10:02:00 +0200
Message-ID: <87fxe2lybr.fsf@meyering.net>
References: <87bpoqoavp.fsf@meyering.net>
	<81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG790-0006E0-Dh
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 10:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbZFOICI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 04:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZFOICH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 04:02:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:59143 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbZFOICG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 04:02:06 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id C8A6F4B007E
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 10:02:03 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp2-g21.free.fr (Postfix) with ESMTP id ACD824B00BB
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 10:02:00 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 29BB4364FE; Mon, 15 Jun 2009 10:02:00 +0200 (CEST)
In-Reply-To: <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	(Alex Riesen's message of "Mon, 15 Jun 2009 00:03:27 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121590>

Alex Riesen wrote:
> 2009/6/14 Jim Meyering <jim@meyering.net>:
>> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var, co=
nst char *value, void *cb)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D strdup(value);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D xstrdup(value);
>
> read_merge_config has a failure mode (where it returns -1), why not u=
se it?

I didn't even consider it, because it would be inconsistent with
the other heap-allocation functions used there (xcalloc, xmemdupz).

However, now that I do, it looks like that would mean adding four times
the same code (including conditionals and code to generate a diagnostic=
 via
a call to error -- or a goto). Why bother, when all of that is already
encapsulated in xmalloc?
Maybe because you want to be able to continue after an allocation failu=
re?
If a small strdup allocation fails, odds are good that the code won't
be able to do anything useful, so when not in library code, cleanest is
simply to exit.

In addition, if you insist on using strdup, you'll probably want to
be consistent and use calloc and memdupz, too.  Adding all of the code
required to recover from those failures and to avoid leaks would be mes=
sy.
