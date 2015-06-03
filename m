From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv4 1/2] git-rebase -i: add command "drop" to remove a
 commit
Date: Wed, 3 Jun 2015 21:23:47 +0200 (CEST)
Message-ID: <739894117.78611.1433359427863.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqq8uc0y8jw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0EGR-0004It-QH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbbFCTXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 15:23:43 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:58735 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756310AbbFCTXm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 15:23:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 00BF7360B;
	Wed,  3 Jun 2015 21:23:39 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKNEW9VTS+36; Wed,  3 Jun 2015 21:23:38 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D7E753609;
	Wed,  3 Jun 2015 21:23:38 +0200 (CEST)
In-Reply-To: <xmqq8uc0y8jw.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: MRKmZZQkP4B6NT36zoryxBItMY1r0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270726>

Junio C Hamano <gitster@pobox.com> writes:
> But what if you got this back after the user edits?
>=20
>     drop
>     pick 2c9c1c5 gostak: distim doshes
>     drop e3b601d pull: use git-rev-parse...
>     edit eb2a8d9 pull: handle git-fetch'...
>=20
> [...]
> Did the user tried to drop something else but the
> object name has gone missing by mistake?

If the user tried to drop something but the SHA-1 has gone missing, it
would be picked up by 2/2 if rebase.missingCommitsCheck is set to warn
or error.

> Did the user wanted to drop the first one but made mistake while
> editing 'pick' away into 'drop'?

I see your point here.

> Noticing and flagging malformed 'drop' lines (or line with any
> command, for that matter) as such is part of that process to make
> sure you collected the object names from the "after" image
> correctly, which is the job of 2/2 in your series (if I am reading
> the description of your series right).

I agree on the fact that noticing and flagging malformed lines for the
various commands is a part of the process to make sure the collected
object names are correct.
However, the original job of 2/2 was to avoid the silent loss of
information caused by deleting a line by mistake, not to check the
correctness of the whole todo-file (though I think that it is a good
idea, to develop in another commit of this patch/in another patch).
On the opposite, in some way it could be seen as some loss of informati=
on, as your previous example suggests:
> Did the user wanted to drop the first one but made mistake while
> editing 'pick' away into 'drop'?
We lose the information that the user wanted to drop the line and not
pick it.

Aside from that, checking specifically the 'drop' command beforehand
(that's what happens in 2/2) while not doing any checking on the other
commands (or checking on the fly) doesn't really makes sense, I think
the commands should be treated equally on the matter of checking.
In doing so, checking that the various commands exist, that they are
followed by the correct argument and that their argument is of the
right type (SHA-1 representing a commit for example), in top of
checking that no commit is removed, without forgetting tests to make
sure everything has the right behaviour, I am afraid that it would
make this part of the patch far too long thus why I think it should be
in another commit/patch.

By the way
> In the new world order to punish those who simply remove lines to
> signal that they want the commits omitted from replaying

Aside from liking the wording here, I don't think it can really be
considered as a punishment since it is the user that chooses if he
wants to be "punished" or not; I guess it can be considered BDSM
though.

Junio C Hamano <gitster@pobox.com> writes:
> > +        drop|d)
> > +                if test -z $sha1
> > +                then
> > +                        warn "Missing SHA-1 in 'drop' command."
> > +                        die "Please fix this using 'git rebase --e=
dit-todo'."
>=20
> Is this a sensible piece of advice, though?  The user edited the
> line away and it does not have the commit object name anymore.
> How does she "fix" it in the editor?  The same puzzlement applies
> to the other message.

=46or a missing SHA-1, if it is a 'drop' that he forgot to remove after
changing his mind, then it can be fixed.
=46or an incorrect SHA-1, maybe he can find it back using git log or
others commands of the kind, though I don't think this way of fixing
things is user-friendly at all.
However, as you point out, in most cases it will be a line edited
away, I agree that the "fix it" doesn't really help.

The only alternative I see right now (in 1/2) is aborting the rebase
(die_abort) though it seems overkill, as the user I wouldn't want to
lose all of the modifications I have done on the todo-list.

Through this I see your point about checking in 2/2 since we would
have more information (for example if he has an error because a drop
has no SHA-1 or the SHA-1 is incorrect and at the same time an error
because a SHA-1 has disappeared, it would make more sense to give him
"fix it" since he would have most of the informations he needs to do
so). However, right now, I think that my previous points about 2/2
still stand.

Thanks,
R=C3=A9mi
