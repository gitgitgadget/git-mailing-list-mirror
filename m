From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 14:36:30 +0200
Message-ID: <200909081436.30761.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 14:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkzxo-0008Dv-JS
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 14:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbZIHMiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbZIHMiM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 08:38:12 -0400
Received: from sam.opera.com ([213.236.208.81]:37481 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZIHMiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 08:38:11 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n88CaVNP023257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 8 Sep 2009 12:36:36 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128001>

Hi,

On Tuesday 08 September 2009, Johannes Schindelin wrote:
> On Tue, 8 Sep 2009, Johan Herland wrote:
> > Algorithm / Notes tree   git log -n10 (x100)   git log --all
> > ------------------------------------------------------------
> > next / no-notes                4.77s              63.84s
> >
> > before / no-notes              4.78s              63.90s
> > before / no-fanout            56.85s              65.69s
> >
> > 16tree / no-notes              4.77s              64.18s
> > 16tree / no-fanout            30.35s              65.39s
> > 16tree / 2_38                  5.57s              65.42s
> > 16tree / 2_2_36                5.19s              65.76s
> >
> > flexible / no-notes            4.78s              63.91s
> > flexible / no-fanout          30.34s              65.57s
> > flexible / 2_38                5.57s              65.46s
> > flexible / 2_2_36              5.18s              65.72s
> > flexible / ym                  5.13s              65.66s
> > flexible / ym_2_38             5.08s              65.63s
> > flexible / ymd                 5.30s              65.45s
> > flexible / ymd_2_38            5.29s              65.90s
> > flexible / y_m                 5.11s              65.72s
> > flexible / y_m_2_38            5.08s              65.67s
> > flexible / y_m_d               5.06s              65.50s
> > flexible / y_m_d_2_38          5.07s              65.79s
>
> It's good to see that the no-notes behaves roughly like baseline.

Agreed.

> I can see that some people may think that date-based fan-out is the
> cat's ass, but I have to warn that we have no idea how notes will be
> used,

I don't agree. Although we will certainly see many more use cases for 
notes, I believe that the vast majority of them can be placed in one of 
two categories:

1. Looking up a few (1 - 10) notes on an individual basis. In this case, 
performance will always be "good enough", and I don't believe it's 
worth spending much time optimizing for this case.

2. Looking up many notes in a sequence based on the chronology of the 
objects (commits) they annotate. This is what 'git log' does, and I 
believe this is the case we should optimize for.

Once you work from this assumption, it is clear that date-based fanout 
beats pure SHA1-based fanout, because it changes the notes lookup 
process from random-access to near-streaming. This is clearly reflected 
in the memory usage graphs I posted.

Also note that the "flexible" code to some degree resolves the whole 
date-based fanout vs. SHA1-based fanout discussion: We are now free to 
choose -- at runtime -- which notes tree structure is more optimal for 
a given collection of notes.

> and the date-based fan-out is rather limiting in certain respects:
>
> - for the typical nightly-build-generated notes, this fan-out is
> pretty inefficient memory-wise.

Yes and no. A y/m/d/40 structure with 1 note for every y/m/d is indeed 
wasteful, but using a y/40 structure instead creates a much better 
situation with a "healthy" ~365 notes per year level. And the y/40 
still preserves some of the 'streaming' aspects mentioned above.

> - I find the restriction to commits rather limiting.

I see your point, but I don't agree until I see a compelling case for 
annotating a non-commit.

In any case, the flexible lookup code still allow us to organize notes 
purely by SHA1-based fanout, so annotated trees/blobs could still be 
supported by the same code (modulo a small s/struct commit/struct 
object/ patch) provided that they are stored in a notes tree that 
simply does not use date-based fanout.

> - most of the performance difference between the date-based and the
> SHA-1 based fan-out looks to me as if the issue was the top-level
> tree. Basically, this tree has to be read _every_ time _anybody_
> wants to read a note.

Not sure what you're trying to say here. The top-level notes tree is 
read (as in fill_tree_descriptor()) exactly _once_. After that, it is 
cached by the internal data structure (until free_commit_notes() or 
end-of-process).

In the SHA1-based case, each notes lookup does indeed start at the root 
of the data structure (corresponding to the top-level tree), but in the 
date-based case, we keep a pointer (cur_node) to the innermost 
date-based tree that was most recently used. Thus, if the next note is 
within the same date-based tree (which I assume is the common case), 
then we don't need to look at the root of the data structure.

>   Maybe a finer-grained fan-out (finer than 16-bits) could help. 
> After all, if you have 16 different notes, chances are that they have
> 16 different first letters, but all have the same commit year. 
> That's where the top-level notes with a fan-out perform incredibly
> bad.

Not really, the first lookup would start at the root node, and navigate 
into the year node, but all subsequent lookups would start directly at 
the year node (and only backtrack if the commit year doesn't match the 
year node).

BTW, when you mention "finer than 16-bits", do you mean moving from a 
16-tree to a, say, 32-tree or 64-tree structure? That will complicate 
the tree navigation somewhat, and increase memory waste. (Remember, I 
started out with a 256-tree idea, but scrapped it because of memory 
waste).

>   But I think that having a dynamic fan-out that can even put blobs
> into the top-level tree (nothing prevents us from doing that, right?)

Well, the "flexible" code does add the new requirement that all entries 
in a notes (sub)tree object must follow the same scheme, i.e. you 
cannot have:

  /12/34567890123456789012345678901234567890
  /2345/678901234567890123456789012345678901

but you can have

  /12/34567890123456789012345678901234567890
  /23/45/678901234567890123456789012345678901

> would _outperform_ the date-based one, at least with less than 1
> note/commit (and maybe even then, because the year-based fan-out
> results in pretty varying entropies per fan-out depth).
>
>   The real question for me, therefore, is: what is the optimal way to
>   strike the balance between size of the tree objects (which we want
> to be small, so that unpacking them is fast)  and depth of the
> fan-out (which we want to be shallow to avoid reading worst-case 39
> tree objects to get at one single note).

s/39/19/ (each fanout must use at least 2 chars of the 40-char SHA1)

Yes, the challenge is indeed striking the correct balance. I believe 
that the notes code should be taught to write (and automatically 
re-organize) the notes tree so that it is optimized for the current 
collection of notes.

> - related to the previous point is my gut feeling that the date-based
>   fan-out has nothing to do with any theoretical optimum.  I am
> pretty certain that the optimal fan-out strategy depends heavily on
> the SHA-1s of the annotated objects (if you have 10,000 notes in
> 2009, but only 1 in 2008, the year-based fan-out _must_ be
> suboptimal)  and maybe is something like a sibling to the Fibonacci
> heap.

Yes, it is trivial to create scenarios where any rigid date-based fanout 
is suboptimal. However, it is equally trivial to create scenarios where 
any SHA1-based fanout will perform worse than a carefully chosen 
date-based fanout. I believe the best way forward is to design for 
flexibility in the notes tree structure, and then teach the notes 
_writing_ code to choose a notes tree structure that is good/optimal 
for the given set of notes.

> - I'd love to see performance numbers for less than 157118 notes. 
> Don't get me wrong, it is good to see the worst-case scenario in
> terms of notes/commits ratio.  But it will hardly be the common case,
> and I very much would like to optimize for the common case.
>
>   So, I'd appreciate if you could do the tests with something like
> 500 notes, randomly spread over the commits (rationale: my original
> understanding was that the notes could amend commit messages, and
> that is much more likely to be done with relatively old commits that
> you cannot change anymore).

Ok. I will try to test that.

> Please understand that I might not have the time to participate in
> this thread as much as I would like to.  The next 4 days will be
> especially hard.

Thanks for the feedback! I appreciate any time you're able to spend on 
this. And I don't mind waiting for a few days for more feedback.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
