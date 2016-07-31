Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B151F858
	for <e@80x24.org>; Sun, 31 Jul 2016 14:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbcGaOhP (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 10:37:15 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:42837 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbcGaOgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 10:36:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 8276F46287C;
	Sun, 31 Jul 2016 15:35:58 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wwIAlIAnX75R; Sun, 31 Jul 2016 15:35:56 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 30658462868;
	Sun, 31 Jul 2016 15:35:56 +0100 (BST)
Date:	Sun, 31 Jul 2016 15:35:39 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160731143539.GA15477@salo>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <20160729110426.GA2945@x>
 <20160729124443.GA3686@salo>
 <20160729130054.GD4340@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729130054.GD4340@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 06:00:55AM -0700, Josh Triplett wrote:
> On Fri, Jul 29, 2016 at 01:44:44PM +0100, Richard Ipsum wrote:
> > On Fri, Jul 29, 2016 at 04:04:26AM -0700, Josh Triplett wrote:
> > > I hope to use git notes with git-series in the future, by putting
> > > another gitlink under the git-series for notes related to the series.
> > > I'd intended that for more persistent notes; putting them in the series
> > > solves some of the problems related to notes refs, pushing/pulling, and
> > > collaboration.  Using notes for review comments makes sense as well,
> > > whether in a series or in a separate ref.
> > 
> > Sounds interesting, can you explain how this works in more detail?
> 
> The tree within a git-series commit includes a blob "cover" for the
> cover letter, a gitlink "base" for the base commit, and a gitlink
> "series" for the top of the series.  I could add a gitlink "notes",
> which acts like a notes ref; then, each version of the series would have
> its own notes ref.  As with the series, git-series would track the
> "history of history"; since git-notes themselves use git history to
> store a set of notes, git-series would store the history of the notes.
> So if you add, remove, or change a note, git-series would track that as
> a change to the notes ref.  If you merge/rebase/etc the notes ref to
> merge notes, git-series would track that too.  A different series would
> have a different set of notes, so you wouldn't be limited to
> one notes ref per repository.
> 
> This doesn't solve the problem of merging notes, but it *does* mean you
> have a full history of the changes to notes, not just the notes
> themselves.
> 
> Something similar might work for the Gerrit notesdb.
> 

Okay I think there is a misunderstanding, Notedb is based on notes,
but they're not used in the same way as git-notes,
an example will help explain what I mean,

For a candidate 'update_readme' we store the change/candidate/whatever
metadata at refs/candidates/heads/up/update_readme/meta which is analogous
to Gerrit's notedb refs which uses something like refs/changes/34/1234/meta,
the prototype library I've written supports both forms and allows for some
flexibility in the naming of the prefix of the former type of ref
(so you may use refs/series/heads/up/update_readme/meta for example).

So the output of,
    git log -p refs/candidates/heads/up/update_readme/meta

gives

commit 38d0c182a46dc5a0f5d04ea0890e278b8e7a6eb6
Author: Richard Ipsum <richardipsum@fastmail.co.uk>
Date:   Sun Jul 24 16:59:16 2016 +0100

    Metadata update
    
    Patch-set: 1
    Status: merged

commit f45a396a156e121f923321e7530e74746e10bdb8
Author: Richard Ipsum <richardipsum@fastmail.co.uk>
Date:   Sun Jul 24 16:50:13 2016 +0100

    Vote on patch set 1
    
    
    
    Label: CodeReview=+1
    Patch-set: 1

commit b74eb15c1847d3bb28618c738c8ebc3412b6935a
Author: Richard Ipsum <richardipsum@fastmail.co.uk>
Date:   Sun Jul 24 16:48:11 2016 +0100

    Update our README to reflect reality
    BranchCommit; 59c46c9fa03725308779841f95ad71e7ccdb919c
    
    Branch: master
    Commit: 761d8da03a10b63b0b1e3cf97ffd7ececb09e3d6
    Patch-set: 1
    Status: new
    Subject: update_readme

This Notedb history is the result of the following git-candidate invocations

    git candidate create update_readme -m "Update our README to reflect reality"
    git candidate vote +1
    (use whatever git commands you like to merge the change)
    git candidate close update_readme

Basically any change made to a change in Notedb is recorded in a git history.

The format is explained in some more detail here[1].

[1]: https://storage.googleapis.com/gerrit-talks/summit/2015/NoteDB.pdf
