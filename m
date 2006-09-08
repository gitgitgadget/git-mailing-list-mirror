From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 19:15:53 +1200
Message-ID: <46a038f90609080015u56daae78u9d78584edae7fb72@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
	 <7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 09:16:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLaak-0008QH-Cx
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 09:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWIHHPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 03:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIHHPz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 03:15:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:5140 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751897AbWIHHPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 03:15:54 -0400
Received: by nf-out-0910.google.com with SMTP id o25so605799nfa
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 00:15:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2IgLj4Cebl6BrpFeaJae/wUA0zBLlskVWI5JIlBCWAbLnbLL2ofmY4Y+y47ctt3fWaAq6p9N+ErVCEEan8JURD1vfUaBX80Gpclk/iYJ/6O+M7D0yxdvnLcjumltQW4WloFEOQG5nM1t723Dd2R2Lls/Jh3X1lUJaG6g5NOYEk=
Received: by 10.48.210.20 with SMTP id i20mr3729336nfg;
        Fri, 08 Sep 2006 00:15:53 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Fri, 8 Sep 2006 00:15:53 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26679>

On 9/8/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> > People who want shallow clones are actually asking for a "light"
> > clone, in terms of "how much do I need to download". If everyone has
> > the whole commit chain (but may be missing olden blobs, and even
> > trees), the problem becomes a lot easier.
>
> No, I do not think so.  You are just pushing the same problem to
> another layer.
>
> Reachability through commit ancestry chain is no more special
> than reachability through commit-tree or tree-containment
> relationships.  The grafts mechanism happen to treat commit

Agreed that it is no more special. OTOH, if we focus on the fact that
people want to avoid high-cost data transfers, transferring commit
chains is cheap and allows the client to ask good questions when
talking to the server.

So as far as tradeoffs go, it allows you to keep the protocol simple,
and minimise complex guessing at either end of the wire.

> But let's touch a slightly different but related topic first.
> People do not ask for shallow clones.  They just want faster
> transfer of "everything they care about".  Shallow and lazy

I'd disagree a bit here. They care about the whole project, and in
time they'll find that out and end up pulling it all if they use git
much at all ;-)

They want fast, cheap initial checkouts.

...
> So they are all not that different.

Earlier you were pointing out how hard it was for the client to even
know what to ask for because it can't see the whole picture. Having
the ancestry  complete means you always know what to ask for.

> Now, first and foremost, while I would love to have a system
> that gracefully operates with a "sparse" repository that lacks
> objects that should exist from tag/commit/tree/blob reachability
> point of view, it is an absolute requirement that I can tell why
> objects are missing from a repository when I find some are
> missing by running fsck-objects [*3*].

I agree -- and you can keep those objects you know are expected to be
missing listed in an "packless" idx file somewhere.

> If repository is a
> shallow clone, not having some object may be expected, but I
> want to be able to tell repository corruption locally even in
> that case,

+1

> I talked about the need of upload-pack protocol extension

As far as I can see, this would not need any change to the upload-pack
protocol.

There are some hard problems in dealing with a sparse repo that need
thinking through. My thinking is that by having the whole commit chain
around the protocol can be kept sane, by virtue of the local repo
always having a clear "overall" picture, including knowing what it's
missing.

> [*4*] In git, there is no inherent server vs client or upstream
> vs downstream relationship between repositories.

Here an importaant distiction must be made. A "publishing" repo cannot
be sparse. A sparse repo probably cannot be cloned from.

>  You may be
> even fetching from many people and do not have a set upstream at
> all.  Or you are _the_ upstream, and your notebook has the
> latest devevelopment history, and after pushing that latest
> history to your mothership repository, you may decide you do not
> want ancient development history on a puny notebook, and locally
> cauterize the history on your notebook repository and prune
> ancient stuff.

Well, that's easy again: "prune old blobs and list them in an idx"
should work well.

cheers,



martin
