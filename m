From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Mon, 16 Mar 2009 17:01:33 +0100
Message-ID: <49BE77DD.5020407@drmicha.warpmail.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net> <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com> <49BA6606.1070403@fastmail.fm> <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org> <49BB920A.20301@drmicha.warpmail.net> <7viqmcaqov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:03:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjFHq-000875-0j
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 17:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbZCPQBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 12:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbZCPQBv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 12:01:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33280 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754990AbZCPQBu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 12:01:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F1D992F0C33;
	Mon, 16 Mar 2009 12:01:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 16 Mar 2009 12:01:48 -0400
X-Sasl-enc: jh2d2fLnDh7js3g3vfMqhN49/pZXlI7BPX2MouUqzGpP 1237219307
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 809553BAA9;
	Mon, 16 Mar 2009 12:01:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090316 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7viqmcaqov.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113340>

Junio C Hamano venit, vidit, dixit 14.03.2009 19:45:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Since both the cleaned and the smudged version are supposed to be
>> "authoritative" (as opposed to the textconv'ed one) one may argue either
>> way what's the right approach.
> 
> Smudged one can never be authoritative.  That is the whole point of smudge
> filter and in general the whole convert_to_working_tree() infrastructure.
> It changes depending on who you are (e.g. on what platform you are on).
> So running comparison between two clean versions is the only sane thing to
> do.

Yes. I guess I'm being too much of a mathematician here: if clean is a
well-defined function, then clean(x) is well defined by specifying x. In
that sense x is equally authoritative.
Again, if smudge is the inverse of clean, i.e. smudge and clean are
bijective, then x differs from y iff clean(x) differs from clean(y).

> You could argue textconv should work on smudged contents or on clean
> contents before smudging.  As long as it is done consistently, I do not
> care either way too deeply, as its output is not supposed to be used for
> anything but human consumption.  Two equally sane arrangement would be:
> 
>  (1) Start from two clean contents (run convert_to_git() if contents were
>      obtained from the work tree), run textconv, run diff, and output the
>      result literally; or
> 
>  (2) Start from two smudged contents (run convert_to_working_tree() for
>      contents taken from the repository), run textconv, run diff, and
>      run clean before sending the result to the output.
> 
> The former assumes a textconv filter that wants to work on clean
> contents, the latter for a one that expects smudged input.  I probably
> would suggest going the former approach, as it is consistent with the
> general principle in other parts of the system (the internal processing
> happens on clean contents).
> 
> Both of the above two assumes that the output should come in clean form;
> it is consistent with the way normal diff is generated for consumption by
> git-apply. You can certainly argue that the final output should be in
> smudged form when textconv is used, as it is purely for human consumption,
> and is not even supposed to be fed to apply.

Also, I don't expect clean to be necessarily meaningful when applied to
the result of textconv, and even less so to the output of diff.

Now, a simple test shows that git diff obviously does this when diffing
HEAD to worktree:

diff between HEAD and clean(worktree)

Which is the right thing. It just seems so that textconv is not even
called "in the wrong place of the chain", but messes the diff up in this
way:

diff between textconv(HEAD) and textconv(worktree)

(I expected clean(textconv(worktree)) first, which would be wrong, too).
I.e., the clean filter is ignored completely in the presence of textconv.

OK, I'll stop bugging you, until I checked the existing tests and the
code...

Michael
