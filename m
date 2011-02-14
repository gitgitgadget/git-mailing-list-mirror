From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 13 Feb 2011 23:35:21 -0800
Message-ID: <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102080159.02153.johan@herland.net> <m3mxm28v3i.fsf@localhost.localdomain>
 <201102140036.42197.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 08:36:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Posyl-0006gD-Ed
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 08:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab1BNHfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 02:35:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1BNHfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 02:35:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6893E265E;
	Mon, 14 Feb 2011 02:36:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTt+CsYzI37xsJTE9DNBIxsItIo=; b=j5E0Kg
	qBE7f1ILIKKbffiMww364b1jPsyujyB/C3ZnAyh8RDzqbeaNe6xcRJVBi1Is4TTE
	3rv3P4KyP89GScNMh3m3DuB2zjtibRxx93xh5Ac5DZydCF7qT3fxmifPIR2cNxIF
	29sghE9D4UzbOxVF50by6ilaYmmEGYdY+5IdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N2eIyfpEC9bsQUaqDKEQeYx1LKHuXfxx
	8dPa8MNJFdSjSsnyfY/Sms6zJXUqr4xDSUBj5ceW5JALXvocwIrHCl2DVAAIbcBG
	zMOuo9tGFS+QEWDodGraeTDbynpblyiEGimNJRocZEQrGWfuMdd+ssfWbFIjVYh5
	+dDhgf0P4Gs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEB7C265C;
	Mon, 14 Feb 2011 02:36:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 59AF42640; Mon, 14 Feb 2011
 02:36:32 -0500 (EST)
In-Reply-To: <201102140036.42197.johan@herland.net> (Johan Herland's message
 of "Mon\, 14 Feb 2011 00\:36\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B960198-380D-11E0-AF5F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166694>

Johan Herland <johan@herland.net> writes:

> Yes, replicating existing behavior w/explicit refspecs would look like this:
>
>   [remote "origin"]
>         url = git://git.example.com/repo.git
>         fetch = +HEAD:refs/remotes/origin/HEAD
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = ~refs/tags/*:refs/tags/*

While this is fine, I am not sure about the "HEAD" part.  Most of the
protocol do not convey which branch HEAD points at (instead "clone" has to
guess), which eventually needs to be fixed.  Incremental updates via
"fetch" does not touch "HEAD" at all by design; unlike the real branch
heads "remotes/origin/$branch" that are used to keep copies of what are at
the remote, "remotes/origin/HEAD" is meant to be used by the local
repository to designate which of the remote branch is considered the
primary branch from local repository owner's point of view, primarily so
that you can say "origin" locally to mean "origin/next" by setting the
symref origin/HEAD to point at it.  In that sense, the guess made by
"clone" is only used to give an initial value.

> FTR, my new/proposed refspecs would look like this:
>
>   [remote "origin"]
>         url = git://git.example.com/repo.git
>         fetch = +HEAD:refs/remotes/origin/HEAD
>         fetch = +refs/heads/*:refs/remotes/origin/heads*
>         fetch = ~+refs/tags/*:refs/remotes/origin/tags/*
>       ( fetch = +refs/notes/*:refs/remotes/origin/notes/* )
>       ( fetch = +refs/replace/*:refs/remotes/origin/replace/* )

I think you meant "refs/remotes/origin/heads/*" (note the slash) on the
RHS of the branch refspecs.

How's that different from refs/*:refs/remotes/origin/* by the way?  Also
if you give tags a totally separate namespace, I don't see much reason to
still give it the "auto-follow" semantics.  It is far simpler to explain
if you just fetch all of them and be done with it, no?

> Yes, to me it seems intuitive that when you specify <URL> (even if <URL> 
> corresponds to an existing remote) you do NOT update remote-tracking refs, 
> but if you use <remote>, you should ALWAYS update remote-tracking refs.
> Others may disagree.

One argument for disagreement used to be that an explicit fetch of a
single branch was a deliberate way to avoid updating the tracking branch
before examining what has been changed (i.e. "git fetch origin master"
followed by "git log origin/master..FETCH_HEAD" and hopefully followed by
"git pull origin" or somesuch).  But that was before reflog was adopted as
a reliable safety measure, and I don't think people should rely on that
behaviour anymore.

I would actually make an even stronger point that people should not base
their workflow on keeping remote tracking refs deliberately stale, which
is exactly the "feature" was meant to be used for.  What has happened on
the other end has already happened whether you like it or not, and there
is no point in your locally pretending that it didn't happen.  If you
don't like the latest update there, you go talk to the party that control
the remote and rectify the situation with them.  It may involve pushing a
reverting or correcting commit over there, or in the worst case you simply
stop pulling from them, forking the project in effect at that point.

> It may seem so, but in my experience it doesn't really work perfectly: Even 
> if I fully control the repo I push to, I still want precise control over 
> what I push there. Sometimes I may working on 'next' and 'master' in 
> parallel, and I might have finished and tested some bugfixes on 'master', 
> while I still have unfinished/untested stuff on 'next'.

Yes, I do this all the time and I often say "git push ko maint master" (ko
is my name for the k.org repo).  I however don't feel inconvenienced by it
precisely because when I make such a push, I _know_ that I want to push
only these two branches.  Saying "only these two branches" explicitly from
the command line, and seeing only these two branches go out, are very
assuring to me.  I usually try to be much more organized to make sure all
four integration branches satisfy certain preconditions before pushing,
and I say "git push ko" only after I make sure they do.

I consider it is a good UI design to force myself to type more when I am
doing something un(der)disciplined and to let me type less when I am
following a good project hygiene.
