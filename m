Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEB21F461
	for <e@80x24.org>; Mon, 20 May 2019 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbfETOlj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 10:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391861AbfETOlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 10:41:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5CDAAFE8;
        Mon, 20 May 2019 14:41:35 +0000 (UTC)
Date:   Mon, 20 May 2019 16:41:34 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520164134.6b35b9f9@kitsune.suse.cz>
In-Reply-To: <20190520141417.GA83559@thyrsus.com>
References: <20190515191605.21D394703049@snark.thyrsus.com>
        <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
        <20190515233230.GA124956@thyrsus.com>
        <87woiqvic4.fsf@evledraar.gmail.com>
        <86woimox24.fsf@gmail.com>
        <20190520004559.GA41412@thyrsus.com>
        <86r28tpikt.fsf@gmail.com>
        <20190520141417.GA83559@thyrsus.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 May 2019 10:14:17 -0400
"Eric S. Raymond" <esr@thyrsus.com> wrote:

> Jakub Narebski <jnareb@gmail.com>:
> > > What "commits that follow it?" By hypothesis, the incoming commit's
> > > timestamp is bumped (if it's bumped) when it's first added to a branch
> > > or branches, before there are following commits in the DAG.  
> > 
> > Errr... the main problem is with distributed nature of Git, i.e. when
> > two repositories create different commits with the same
> > committer+timestamp value.  You receive commits on fetch or push, and
> > you receive many commits at once.
> > 
> > Say you have two repositories, and the history looks like this:
> > 
> >  repo A:   1<---2<---a<---x<---c<---d      <- master
> > 
> >  repo B:   1<---2<---X<---3<---4           <- master
> > 
> > When you push from repo A to repo B, or fetch in repo B from repo A you
> > would get the following DAG of revisions
> > 
> >  repo B:   1<---2<---X<---3<---4           <- master
> >                  \
> >                   \--a<---x<---c<---d      <- repo_A/master
> > 
> > Now let's assume that commits X and x have the came committer and the
> > same fractional timestamp, while being different commits.  Then you
> > would need to bump timestamp of 'x', changing the commit.  This means
> > that 'c' needs to be rewritten too, and 'd' also:
> > 
> >  repo B:   1<---2<---X<---3<---4           <- master
> >                  \
> >                   \--a<---x'<--c'<--d'     <- repo_A/master  
> 
> Of course that's true.  But you were talking as though all those commits
> have to be modified *after they're in the DAG*, and that's not the case.
> If any timestamp has to be modified, it only has to happen *once*, at the
> time its commit enters the repo.

And that's where you get it wrong. Git is *distributed*. There is more
than one repository. Each repository has its own DAG that is completely
unrelated to the other repositories and their DAGs. So when you take
your history and push it to another repository and the timestamps
change as the result what ends up in the other repository is not the
history you pushed. So the repositories diverge and you no longer know
what is what.

> 
> Actually, in the normal case only x would need to be modified. The only
> way c would need to be modified is if bumping x's timestamp caused an
> actual collision with c's.
> 
> I don't see any conceptual problem with this.  You appear to me to be
> confusing two issues.  Yes, bumping timestamps would mean that all
> hashes downstream in the Merkle tree would be generated differently,
> even when there's no timestamp collision, but so what?  The hash of a
> commit isn't portable to begin with - it can't be, because AFAIK
> there's no guarantee that the ancestry parts of the DAG in two
> repositories where copies of it live contain all the same commits and
> topo relationships.

If you push form one repository to another repository now you get exact
same history with exact same hashes. So the hashes are portable across
repositories that share history. With your proposed change hashes can
be modified on push/pull so repositories no longer share history and
hashes become non-portable. That's why it is a bad idea.

The commits are currently identified by the hash so it must not change
during push/pull. Changing the identifier to something else (eg content
has without (some) metadata) might be useful to make the identifier
more stable but will bring other problems when you need two
different identifiers for the same content to include it in two
unrelated histories.

Thanks

Michal
