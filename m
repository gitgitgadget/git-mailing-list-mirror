From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 10:37:30 -0400
Message-ID: <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
	 <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
	 <20060806180323.GA19120@spearce.org>
	 <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
	 <20060807050422.GD20514@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 07 16:37:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA6Eb-00063f-7N
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 16:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHGOhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 10:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWHGOhd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 10:37:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:25689 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751030AbWHGOhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 10:37:32 -0400
Received: by wr-out-0506.google.com with SMTP id i21so59227wra
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 07:37:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DUB9vDc+fr/g/9+KUbOEnhSRSWmQJAVgi2GrDPIOPHYzTUpegpDcfusxllvTmY8KccQS25ytiuBfBbjGWlmgi9fOGOkQEcLkNxGJT0bqGZocVrkXvBvM5PKfGkR5m4ECqYuAmfZgI9Syo05JyLPXO4NSMudaM+qSNE/R8/98Gzk=
Received: by 10.78.127.6 with SMTP id z6mr2415396huc;
        Mon, 07 Aug 2006 07:37:30 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Mon, 7 Aug 2006 07:37:30 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060807050422.GD20514@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25015>

On 8/7/06, Shawn Pearce <spearce@spearce.org> wrote:
> > I'm staring at the cvs2svn code now trying to figure out how to modify
> > it without rewriting everything. I may just leave it all alone and
> > build a table with cvs_file:rev to sha-1 mappings. It would be much
> > more efficient to carry sha-1 throughout the stages but that may
> > require significant rework.
>
> Does it matter?  How long does the cvs2svn processing take,
> excluding the GIT blob processing that's now known to take 2 hours?
> What's your target for an acceptable conversion time on the system
> you are working on?

As is, it takes the code about a week to import MozCVS into
Subversion. But I've already addressed the core of why that was taking
so long. The original code forks off a copy of cvs for each revision
to exact the text. Doing that 1M times takes about two days. The
version with fast-import takes two hours.

At the end of the process cvs2svn forks off svn 250K times to import
the change sets. That takes about four days to finish. Doing a
fast-import backend should fix that.

> Any thoughts yet on how you might want to feed trees and commits
> to a fast pack writer?  I was thinking about doing a stream into
> fast-import such as:

The data I have generates an output that indicates add/change/delete
for each file name. Add/change should have an associated sha-1 for the
new revision. cvs/svn have no concept of trees.

How about sending out a stream of add/change/delete operations
interspersed with commits? That would let fast-import track the tree
and only generate tree nodes when they change.

The protocol may need some thought. I need to be able to handle
branches and labels too.


>         <4 byte length of commit><commit><treeent>*<null>
>
> where <commit> is the raw commit minus the first "tree nnn\n" line, and
> <treeent> is:
>
>         <type><sp><sha1><sp><path><null>
>
> where <type> is one of 'B' (normal blob), 'L' (symlink), 'X'
> (executable blob), <sha1> is the 40 byte hex, <path> is the file from
> the root of the repository ("src/module/foo.c"), and <sp> and <null>
> are the obvious values.  You would feed all tree entries and the pack
> writer would split the stream up into the individual tree objects.
>
> fast-import would generate the tree(s) delta'ing them against the
> prior tree of the same path, prefix "tree nnn\n" to the commit
> blob you supplied, generate the commit, and print out its ID.
> By working from the first commit up to the most recent each tree
> deltas would be using the older tree as the base which may not be
> ideal if a large number of items get added to a tree but should be
> effective enough to generate a reasonably sized initial pack.
>
> It would however mean you need to monitor the output pipe from
> fast-import to get back the commit id so you can use it to prep
> the next commit's parent(s) as you can't produce that in Python.
>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
