From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Solve continuous integration (pending head / commit queue) 
	problem using git
Date: Fri, 12 Feb 2010 12:42:44 -0500
Message-ID: <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
References: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jan Koprowski <jan.koprowski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:43:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfzXz-0000fw-K4
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab0BLRnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:43:14 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:32911 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0BLRnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:43:13 -0500
Received: by gxk24 with SMTP id 24so2629776gxk.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=YYg3+eXnvImf2DFWnl4BDhv5IoakHncS1laH/eS58J4=;
        b=NMCKGADeedheLAqcZmcki61tFaKnTt2tduVJgxPkr/TPaD5Z+ziV5PlLz9iT1EJrfX
         ZGnH+dRIy8CtsyPYhit3Lp/SNs7kdZcJCx+Go1rhRzygx92NT7HsCx60tRddINZ7VdeA
         247J+pbvWMAbhDDCfN0EusivdRgvr5SkHv+i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LcLkyhdi/VqCBPLyOoF7+I0AgXB2IhS7hTG/iIa+F30qIRccl12urZwciLw3MEjk+r
         7zcFRKwXvR4dvSkpAfqhDnro90UaASLRPVkEAKP6HreioWcPQ5TVTzl47SpwcfvXRhMz
         cnrBsuo1JPj/WyAwjAlLpfbOi/Jgluyy5iRfg=
Received: by 10.150.120.42 with SMTP id s42mr2784129ybc.91.1265996592332; Fri, 
	12 Feb 2010 09:43:12 -0800 (PST)
In-Reply-To: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139731>

On Fri, Feb 12, 2010 at 11:37 AM, Jan Koprowski <jan.koprowski@gmail.com> wrote:
> Now. My idea. There is some revision tagged as "stable". *Clone* and
> *pull* operations is somehow "overloaded" from server side and always!
> return last revision tagged as stable. After compiling external tool
> just move tag to another revision which pass all tests. Of course
> there is some additional parameter (for example --last or --unstable)
> which can clone fine way of repository.
>
> Two questions.
> 1) Maybe I try to invent the wheel again. Is there any way to take the
> effect without overloading standard git behaviours.
> 2) If not how overload git behaviors on git "server side" repo?

In general, code that lies to you about what's the most revision is
evil.  Sometimes you *do* want to fetch that revision it's lying to
you and saying doesn't exist, precisely because you'd like to help fix
it before integration.

What you really want is:

- nobody can push to the "integration branch" except the "integration manager"

- the "integration manager" should be a computer program, so that you
can have "continuous integration"

This isn't actually that hard.  Give each user their own repository;
no user can write to any other user's repository.  (This is the
default setup on github.com, for example.)  Alternatively, just tell
people to never, ever push to the master branch by themselves.  People
are easily capable of following rules like that unless they're
actively trying to screw you.

Then set up something like gitbuilder
(http://github.com/apenwarr/gitbuilder) (Full disclosure: I wrote it)
to build *all* the branches from *all* the users.  This sounds like it
would create exponential work for the build machine, but it doesn't,
since most users will have mostly the same commits anyway.

When gitbuilder tags a particular commit as having built and passed
all tests, then it becomes a candidate for merging into the
integration branch.  Write a little script that goes through candidate
branches, checks their gitbuilder status, and if they've passed,
pushes them into the integration branch.  The push will only succeed
if the integration branch can be fast-forwarded to match the branch
you're trying to push; if you can't, it'll be rejected, which is what
you want, since merging (even conflict-free merging) might break
tests.

That mechanism works pretty well at my company, with one exception: we
didn't bother with an automatic tool that merges into master.  We
prefer to have a release manager do that.

Have fun,

Avery
