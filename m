From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 17:09:58 -0800
Message-ID: <7v3afkqcnt.fsf@gitster.siamese.dyndns.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org> <20090115153529.GA13961@neumann>
 <7vvdsgql17.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com>
 <20090115225912.GL9794@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdFO-0001NF-VK
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762547AbZAPBKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 20:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934766AbZAPBKP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:10:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450AbZAPBKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 20:10:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CB9411CA13;
	Thu, 15 Jan 2009 20:10:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 74E101CA03; Thu,
 15 Jan 2009 20:10:00 -0500 (EST)
In-Reply-To: <20090115225912.GL9794@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Thu, 15 Jan 2009 23:59:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A2AAD18-E36A-11DD-BC72-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105898>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> But the current behaviour of the 'edit' rebase command gives you the
> possibility of adding further commits on top of the selected one
> (after you have edited that or left intact, doesn't matter).  To do
> that with this automatic 'reset --soft HEAD^' modification you would
> first need to 'git commit -c @{1}' to keep the selected commit before
> going on with adding further commits, which is not quite nice.

Yeah, I agree.

I think my confusion mostly came from perception, and the way the "edit=
"
action is (not) explained.

What "edit" means is "pick this commit and then stop to give control ba=
ck
to the user.  The user is free to muck with the history starting from t=
he
state after picking the named commit in any way, and --continue will ca=
rry
on the rest of the insns from the state" [*1*].  Once I realize that,
it becomes clear what it means to do any of the following when "edit"
gives the control back to me:

 (1) commit --amend (with or without changing the tree and message); th=
is
     is the originally intended usage.  Edit the commit the machinery j=
ust
     picked and let it continue.  The end result is as if you edited on=
e
     commit in the sequence.

 (2) making completely unrelated commits on top of the state "edit" gav=
e
     you; this inserts a new commit in the sequence.

 (3) first "reset HEAD^", commit selected parts of the difference in on=
e
     commit, commit the reaminder in another commit; this splits the
     commit the machinery just picked into two.

By the way, "rebase --continue" codepath has extra code that does
something magical when the index does not match the HEAD commit.  I
suspect what it does makes sense only in the originally intended usage
sequence (i.e. "edit" stops, you want to do "commit --amend" and then
"rebase --continue" but somehow you forgot to commit everything).

How well does that logic work when the user wanted to do (2) or (3) abo=
ve,
and happened to have the index unclean when s/he said "rebase --continu=
e"?
Does it do something nonsensical?

[Footnote]

*1* Explained the same way, "pick" is "cherry-pick the named commit to
replay its effect and then continue".
