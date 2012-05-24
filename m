From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Thu, 24 May 2012 22:32:07 +0200
Message-ID: <4FBE9AC7.3010506@kdbg.org>
References: <4FBAA33D.1080703@kdbg.org> <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com> <7vzk8yzq35.fsf@alter.siamese.dyndns.org> <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com> <7vehq9xz7a.fsf@alter.siamese.dyndns.org> <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXehl-0001Ln-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab2EXUcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:32:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:39279 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889Ab2EXUcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:32:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 90ABE13004C;
	Thu, 24 May 2012 22:32:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BEF1F19F6ED;
	Thu, 24 May 2012 22:32:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198418>

Am 24.05.2012 19:47, schrieb Martin von Zweigbergk:
> On Thu, May 24, 2012 at 10:31 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>
>>> Yes, I've had the same idea myself. Anyway, as Johannes said, that'=
s
>>> probably something to consider for the sequencer.
>>
>> Are you saying that "rebase -any-variant" and the sequencer should b=
ehave
>> differently?  It is not immediately obvious to me why it is a good i=
dea.
>=20
> That's not what I meant to say. I thought the sequencer is supposed t=
o
> replace much of git-rebase and I thought that's what Johannes was
> referring to as well when he said not to make git-rebase too
> intelligent.

You are probably refering to what I said here:

http://thread.gmane.org/gmane.comp.version-control.git/194434/focus=3D1=
95074

When I wrote the post, I was not aware that rebase -p *is* indeed able
to transplant a branchy topic to a new upstream. I was convinced that
rebase -p can only move a (first-parent) topic line which may have
merged in some unrelated other topics. So, you should take it with a
large grain of salt.

-------

Today I was able to use rebase -i -p in the field. I used it to rebuild
an integration branch (akin to git's pu branch). Guess what? It did not
work as expected:

Two of the topic branches' early parts were already merged in the
upstream. The instruction sheet had only 'pick' of merge commits for th=
e
topics. Except for these two; there, all commits (that were not yet in
upstream) were offered to pick, including the merge commit.

I started with this:

    A--M--o--o   <- master
   /  /
--o--X--Y        <- side branch (partially merged in master)
   \     \
    R--S--N--T   <- integration (to be rebuilt on master)

I wanted this:

     A--M--o--o
    /  /       \
   /  /          R'--S'--N'--T'
--o--X--Y---------------=C2=B4

But I got this:

    A--M--o--o-------Y'
   /  /       \       \
--o--X--Y      R'--S'--N'--T'

(Note that this has nothing to do with my patch; the badness happens
already before any rebasing begins.)

Gah! I'm frustrated. When --preserve-merges was invented, it supported
two very important use-cases:

1. Rebuild an integration branch.
2. Rebase a topic that merges an 'unrelated side branch'.

Then people came along thinking that "preserve merges" means that *any*
sort of merges should be preserved, including a branchy-and-mergy topic
like the example you gave. *Of course* it is much more difficult to
support this case. And sure as hell with all the work-arounds needed to
support it, a good deal of other good functionality became broken
subtly. This is why I say that we should drop support for the
complicated cases and resurrect correctness for the simpler, but
important cases.

-- Hannes
