From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 22:32:10 -0700
Message-ID: <7vabge30dh.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 07:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK54c-0004Vt-St
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 07:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYGSFck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2008 01:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbYGSFck
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 01:32:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYGSFcj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2008 01:32:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DAFE2AFEB;
	Sat, 19 Jul 2008 01:32:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 594C62AFE5; Sat, 19 Jul 2008 01:32:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 175A1992-5554-11DD-A721-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89100>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 18 Jul 2008, Junio C Hamano wrote:
>
>> +The 'recursive' strategy can take the following options:
>> +
>> +ours;;
>
> You still have not addressed the issue that you can specify multiple=20
> strategies,...

Even though multiple -s parameters are supported, I know you have been
here long enough in git scene to remember how it came about.  I've seen
some third-party documents that talk about our ability to "try multiple
strategies and pick the best one" as one of the unique features, but
anybody who was there knows that it was just a failed experiment that w=
e
did not bother removing.

The thing is, trying multiple strategies was a cute idea and it was qui=
te
straightforward to implement.  But picking the best one is the much mor=
e
important part, and judging whose result is the best shouldn't be done
with just a na=C3=AFve "how many conflicting paths remain there?" metri=
c
(c.f. $gmane/87297 which talks about "stupid" but the argument is exact=
ly
the same --- smaller number of conflicts may not necessarily be the
easiest to resolve nor the right resolution).  I would be surprised if
anybody uses multiple -s options in their daily workflow, even though I
would not be surprised if people tried to use it just as an experiment =
and
for its entertainment value once or maybe twice.  After all, I invented
the multiple strategy support for amusement, not from any practical rea=
l
world needs ;-)

So I do not consider that a convincing argument at all.

> ... or even a single _wrong_ one.  So:
>
> 	$ git merge -s stupid -Xours
>
> would not fail at all, but definitely not do the right thing either (=
it=20
> disobeys a direct command of the user).

It does fail gracefully, though.

    $ git merge -s resolve -Xours next
    Trying really trivial in-index merge...
    error: Untracked working tree file '.gitattributes' would be overwr=
itten by merge.
    Nope.
    fatal: Not a valid object name --ours
    Merge with strategy resolve failed.

I consider this falls into "You say it hurts?  Don't do that, then"
category.

The error message will naturally improve, once we teach the merge strat=
egy
backends that they can be given --<option> in front of the usual
<base>... -- <ents>... parameters, and there is no risk of ambiguity
because no object names begin with a dash.

Having said all that, I do not have any reason to push for -Xours/their=
s
myself.  I've made myself very clear from the beginning that what these
options do is a bad idea, just as "-s theirs" is a bad idea.  These
encourage a broken workflow and I do not see a clear upside, however
narrow, and you and Pasky seem to agree with me (heh, isn't it a rare
occasion that all three of us agree on something these days? ;-)

I won't shed tears to see them go.

However, I do think it is wrong to deny that it will eventually be
necessary for us to be able to pass strategy specific options via the
git-merge frontend driver to the strategy backend.  The primary reason =
why
I wrote "subtree" strategy to _guess_ how to shift trees was because th=
ere
was no way to pass "how the end user wants to shift them" to the strate=
gy
backend over "pull -- merge -- merge-subtree" callchain.  Coming up wit=
h
the algorithm was fun, but that was secondary.

If we allow users to say -Xsubtree=3D<path>, it would be a true improve=
ment
to a tool that is used in real life.  Unlike "multiple -s strategy"
support that I think nobody ever uses in practice (on which part of you=
r
objection is based), "-s subtree" has been useful in real life, and you
can verify that claim easily by counting how many times I've used that =
in
git.git history yourself.

Even though I do not care deeply about the syntax (and if you do not li=
ke
the "-X" as the external option introducer, you are welcome to pick a
different notation and send in a patch), it would help for example the
vanilla "recursive" strategy to allow the user, when dealing with reall=
y
tricky merge, to influence the rename threshold score it uses by passin=
g
it as a strategy-specific option.

As a conclusion of this discussion, I'll discard xx/merge-in-c-into-nex=
t
branch from "next", at the beginning of post-1.6.0 cycle.  We might in =
the
future need to resurrect only the -X<option> part to allow us to pass
strategy specific options (that are not "ours/theirs"), but there is no
immediate need for it, other than -Xsubtree=3D<path>.  If somebody want=
s to
step up and give the custom rename threshold to the recursive strategy,
keeping that code to do -X<option> might help that too, though.
