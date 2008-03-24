From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
 merges
Date: Mon, 24 Mar 2008 11:35:53 -0700
Message-ID: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
 <alpine.LSU.1.00.0803232334130.4353@racer.site>
 <20080324111413.GA18488@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, B.Steinbrink@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrXP-0000Zx-Mz
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760866AbYCXSgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758785AbYCXSgG
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:36:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbYCXSgF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 14:36:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 222531F74;
	Mon, 24 Mar 2008 14:36:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E38AB1F6E; Mon, 24 Mar 2008 14:35:55 -0400 (EDT)
In-Reply-To: <20080324111413.GA18488@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of "Mon, 24 Mar 2008 12:14:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78074>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> Me too, but I think it's not possible to do what I want with -p. -p
> misses a definition of the (new) parent of a commit. It tries to pres=
erve
> all commits from all branches. But going through the _list_ of comman=
ds
> couldn't preserve this structure.
>
> o--A--B
>  \     \
>   C--D--M--E
>
> How should the graph look like after these commands:
>
> pick A
> pick C
> squash E
> # pick D
> pick B
> pick M

I am beginning to suspect that the root cause of this is that the todo
language is not expressive enough to reproduce a merge _and_ allow end
user editing.

Let's step back a bit.

If you have this history:

      o---o---o---o---o---Z
     /
    X---Y---A---B
         \       \
          C---D---M---E

and you want to transplant the history  between X..E on top of Z, from =
the
command line you would say:

	$ git rebase --interactive -p --onto Z X E

=46irst let's think what you would do if you want to do this by hand.  =
The
sequence would be:

	$ git checkout Z^0 ;# detach at Z

        $ git cherry-pick Y
        $ git tag new-Y ;# remember it
        $ git cherry-pick A
        $ git cherry-pick B
        $ git tag new-B ;# remember it
        $ git checkout new-Y
        $ git cherry-pick C
        $ git cherry-pick D
        $ git merge new-B ;# this reproduces M
        $ git cherry-pick E

	$ git branch -f $the_branch && git checkout $the_branch


Now how does the todo file before you edit look like?

	pick Y
        pick A
        pick B
        pick C
        pick D
        pick M
        pick E

The todo file expects the initial detaching and the final switching bac=
k
outside of its control, so it is Ok that the first "checkout Z^0" and t=
he
last "branch && checkout" do not appear, but it should be able to expre=
ss
the remainder and let you tweak.  Is it expressive enough to do so? =20

Most of the "pick" from the above list literally translate to the
"cherry-pick", and if you change any of them to "edit", that is
"cherry-pick --no-edit" followed by a return of control to you with ins=
n
to "rebase --continue" to resume.  There appears nothing magical.

Not really.  There already are two gotchas even without talking about
end-user editing.

=46irst, "pick M" is not "cherry-pick M".  You do not want to end up wi=
th
merging an old parent before rewriting.  It has to be something like
"merge rewritten-Y".

Second, before you start picking C, if you want to preserve merges, you
have to switch to rewritten Y.  The original sequence left in todo does
not have that information to begin with.  We need, before the "pick C",=
 to
say the equivalent of "git checkout new-Y" in the manual sequence
illustrated above.  The lack of "checkout new-Y" is perfectly fine if
rebase is meant to linearlize the history, but if you want to preserve =
the
shape of the history, you would need to give a clue that the sequence t=
hat
begins with the "pick C" starts from somewhere else.

You also need to make sure that "pick M" moved elsewhere still merges t=
he
tips of two forked histories.  Moving "pick M" before "pick C" or "pick=
 A"
would not make much sense.  So you would need some kind of "barrier" th=
at
says "do not move this 'pick M' beyond this point".

Perhaps we can make it clearer by introducing a few more primitives to =
the
todo language: mark, reset and merge.  The above illustrated history wo=
uld
then become:

	pick Y
        mark #0
	pick A
        pick B
        mark #1
        reset #0
        pick C
        pick D
	mark #2
        merge #1 #2
        pick E

You can change any of the "pick" to "edit, or drop it, and you can reor=
der
"pick" in a sequence of "pick", but you cannot change "mark", "reset",
"merge", or move "pick" across insn that was not originally "pick".
