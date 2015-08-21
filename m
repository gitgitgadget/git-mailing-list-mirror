From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Sat, 22 Aug 2015 00:29:59 +0300
Message-ID: <5570041440192599@web21j.yandex.ru>
References: <349031438778845@web22j.yandex.ru>
	<CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com> <xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:30:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZStte-0004b0-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 23:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbbHUVaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 17:30:06 -0400
Received: from forward20j.cmail.yandex.net ([5.255.227.239]:35548 "EHLO
	forward20j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934AbbHUVaF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 17:30:05 -0400
Received: from web21j.yandex.ru (web21j.yandex.ru [5.45.198.62])
	by forward20j.cmail.yandex.net (Yandex) with ESMTP id A8472217AE;
	Sat, 22 Aug 2015 00:30:00 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web21j.yandex.ru (Yandex) with ESMTP id DE425454002C;
	Sat, 22 Aug 2015 00:29:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1440192600; bh=Lth9JmQDI4wq29/UKQsJNhPnNXvz927efRasEZaIbWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=utq4NXh5hKb6RAHSfnNMhjpLxRpQ/MR4Zcf/P6t3aETenwYXHtZpQBt9HyS/gn+fE
	 0Abm9Jm0/sxRewgAq2UnpG3CCz79M5za5NAaEqLJdyJBTb2gF+GoL7jKeAgPDxesuX
	 ZU0yApfuApo7KONEQ8Voxz7n2SdGB/BaYFsLlsmo=
Received: by web21j.yandex.ru with HTTP;
	Sat, 22 Aug 2015 00:29:59 +0300
In-Reply-To: <xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276335>



17.08.2015, 20:49, "Junio C Hamano" <gitster@pobox.com>:
> =9ADuy Nguyen <pclouds@gmail.com> writes:
>
>> =9A=9AOn Wed, Aug 5, 2015 at 7:47 PM, Ivan Chernyavsky <camposer@yan=
dex.ru> wrote:
>
> =9AThat is a dangeous thought. I'd understand if it were internally
> =9Atwo step process, i.e. (1) the first pass finds commits that hits
> =9Athe --grep criteria and then (2) the second pass does "--contains"
> =9Afor all the hits found in the first pass using existing code, but
> =9Astill, this operation is bound to dig all the way through the root
> =9Aof the history when asked to find something that does not exist.

My intention was to use existing git-branch filters such as -a or -r an=
d pattern to limit the scope, then apply --grep machinery.

But now I had a look on the source and I can see that builtin/branch.c =
builds the list of references and prints them in a single place (print_=
ref_list()) so I will have to split that function into two in order to =
reuse existing functionality.

Another problem is that builtin/branch.c currently does not use setup_r=
evisions(), so I'll have to hook it there as well.

Then, I assume, I'll need to use the initial ref_list (filled the same =
as for the current "list" case) to configure the rev_info structure aft=
er setup_revisions(), and start revision traversal.

I'm not sure I've got it all right from the source in those few days, s=
o I apologize in advance if it's stupid in some part or as a whole.

That said, do you think the goal is worth such changes? Seems like git-=
branch currently has it's own way of doing things and I'm trying to tea=
ch it to use git-rev-list's.

Maybe it is more reasonable to add an option to "git log --all --source=
 --grep=3D..." to print *all* branch tips which are reachable from the =
found commits, not only the first one encountered? E.g. --decorate-all =
or --source-all?

> =9AYou should at least feed all --contains to a single invocation of
> =9A"git branch". They are designed to be OR'ed together.


Yep thanks I overlooked that. In my repository, this takes 40 seconds i=
nstead of 2 minutes 30 seconds for my construct.

--=20
=9A=9AIvan
