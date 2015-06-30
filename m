From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 19:02:04 +0200 (CEST)
Message-ID: <70428267.93232.1435683724659.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr> <1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqq7fql8949.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:59:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9ysx-0005Qd-BI
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbbF3Q7j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 12:59:39 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:41360 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753684AbbF3Q7e convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:59:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DC862292F;
	Tue, 30 Jun 2015 18:59:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p1iL3mZcppRV; Tue, 30 Jun 2015 18:59:31 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BCF2C28AD;
	Tue, 30 Jun 2015 18:59:31 +0200 (CEST)
In-Reply-To: <xmqq7fql8949.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: rebase -i: drop, missing commits and static checks
Thread-Index: j7QMkmUUAjkcqB8jb+C5Un8TOWsMCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273082>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> write=
s:
>=20
> > Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes=
:
> >> Shouldn't all the checking also be called in a 'rebase --continue'=
,
> >> considering that it can be called after a 'rebase --edit-todo' ?
> >> (Right now it is only called after closing the editor in 'rebase -=
i')
> >
> > What's your opinion on it?
>=20
> It would probably be better to run the check when running "git rebase
> --continue". This way, we would have a guarantee that the todo-list i=
s
> syntactically correct when going through it.
>=20
> Just checking after --edit-todo would not guarantee that:

That's actually what I had in mind, my message wasn't clear enough, my
bad.

> But in any case, the most important is the initial edition. It covers
> 99.9% of use-cases. So, I'd say: if you have time to add the checks a=
t
> the other relevant places, good, but not doing it shouldn't block the
> inclusion of the series.

Agreed, that's something that can be done in a future patch without
interfering with this one.

Junio C Hamano <gitster@pobox.com> writes:
> The place where an error can be introduced is (assuming that what
> "rebase -i" writes out itself is perfect ;-) where we allow the user
> to edit, so instead of checking before "--continue", I would expect
> a sane design would check immediately after the editor we spawned
> returns.

Makes sense but we would have the problem mentioned by Matthieu:
> Warning: the command isn't recognized ...
>  =20
> # Hmm, let's ignore that warning
> $ git rebase --continue

While in most cases it would be irrelevant (it would be the user that=20
ignored the error on purpose), I can imagine the following situation:
 - 'git rebase --edit-todo'
 - get an error
 - go do something else, forgot where I was when I come back
 - 'git status', "you are in the middle of a rebasing"
 - 'git rebase --continue'

> The codepath that allows the insn sheet getting edited and the
> codepath that handles --edit-todo have to do many things the same
> way (i.e. use collapse_todo_ids to prepare the file for editing,
> spawn the editor, receive the result and use expand_todo_ids to
> prepare the file to be used by us), and I would have expected for
> these two to be using a single helper---and a sanity check like the
> above can and should be done when we receive the result from the
> editor, immediately before running expand_todo_ids perhaps.
>=20
> If they are not using such a single helper right now, perhaps that
> is the preliminary restructuring of the code that is needed?

Good point, maybe I'll try doing that at a later date, however as
Matthieu said, I think it doesn't hurt to add this patch (if there is
no further corrections to do) and do additional things in a later
patch.

Thanks,
R=C3=A9mi
