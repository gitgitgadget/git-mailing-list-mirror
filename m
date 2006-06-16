From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 11:25:22 -0400
Message-ID: <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
	 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 17:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrGCT-0003Xm-Qe
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 17:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWFPPZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWFPPZY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 11:25:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:2804 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751445AbWFPPZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 11:25:23 -0400
Received: by nz-out-0102.google.com with SMTP id s18so949832nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 08:25:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XTZF+iJ9hMaGX5G6irG22QEH/AHpezT1AwMEma3CxwYqdUlNkZcr/I4yyZTt2J/W6xOcUEcgLhOJ+M4emt1e1USToZLuAnlm5RDAWHHqnUO5t1Hy4Q4msTm3tmNfy4beDlG46Ut7MEj4eoxYfUBb71ABUrUf3EYryQuc0FaMBqU=
Received: by 10.36.215.21 with SMTP id n21mr4015074nzg;
        Fri, 16 Jun 2006 08:25:22 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 08:25:22 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21945>

On 6/16/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 16 Jun 2006, Jon Smirl wrote:
> >
> > I am spending over 40% of the time in the kernel. This looks to be
> > caused from forks and starting small tasks, is that the correct
> > interpretation?
>
> Yes. Your kernel profile is all for stuff related to setting up and
> tearing down process space (well, __mutex_lock_slowpath at 1.88% and
> __d_lookup at 1.3% is not, but every single one before that does seem to
> be about fork/exec/exit).
>
> I think it's both the CVS server that continually forks/exits (it doesn't
> actually do a exec at all - it seem sto be using fork/exit as a way to
> control its memory usage - knowing that the OS will free all the temporary
> memory on exit - I think the newer CVS development trees don't do this,
> but that also seems to be why they leak memory like mad and eventually run
> out ;).

I am using cvs-1.11.21-3.2
I can try running their development tree.

>
> AND it's git-cvsimport forking and exec'ing git helper processes.

Is it worthwhile to make a library version of these? Svn has lib
versions and they barely show up in oprofile. cvsimport is only using
4-5 low level git funtions.

>
> So that process overhead is expected.
>
> What I would _not_ have expected is:
>
> >   933646  2.0983 /usr/local/bin/git-read-tree
>
> I don't see why git-read-tree is so hot for you. We should never need to
> read a tree when we're importing something, unless there are tons of
> branches and we switch back and forth between them.
>
> I guess mozilla really does use a fair number of branches?

Is 1,800 a lot?

>
> Martin sent out a patch (that I don't think has been merged yet) to avoid
> the git-read-tree overhead when switching branches. Look for an email with
> a subject like "cvsimport: keep one index per branch during import", I
> suspect that would speed up the git part a lot.

I'll check this out

> (It will also avoid a few fork/exec's, but you'll still have most of them,
> so I don't think you'll see any really _fundamental_ changes to this, but
> the git-read-tree overhead should be basically gone, and some of the
> libz.so pressure would also be gone with it. It should also avoid
> rewriting the index file, so you'd get lower disk pressure, but it looks
> like none of your problems are really due to IO, so again, that probably
> won't make much of a difference for you).

I have been CPU bound for two days, disk activity is minor.
git-cvsimport is 250MB and I have 2GB of disk cache.

After looking at this process for about a week it doesn't look like
processing chronologically is the best strategy. cvsps can quickly
work out the changesets, 15 minutes. Then it might be better to walk
the CVS files one at a time generating git IDs for each revision. Next
use the IDs and changeset info to build the git trees. Finally pack
everything. This strategy would minimize the work load on the CVS
files (adding all those delta to get random revs).

Can git build a repository in this manner? If this is feasible it may
be possible to do all of this in a single pass over the CVS tree by
modifying cvsps.

-- 
Jon Smirl
jonsmirl@gmail.com
