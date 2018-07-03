Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEBF1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeGCWi1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:38:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:44392 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753434AbeGCWi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:38:27 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1faTwF-0006LJ-7i; Wed, 04 Jul 2018 07:38:23 +0900
Date:   Wed, 4 Jul 2018 07:38:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: fast-import slowness when importing large files with small
 differences
Message-ID: <20180703223823.qedmoy2imp4dcvkp@glandium.org>
References: <20180629094413.bgltep6ntlza6vhz@glandium.org>
 <87o9ftckhb.fsf@evledraar.gmail.com>
 <20180629233538.7zxxrvou4twqyd6d@glandium.org>
 <87muv8cnk3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muv8cnk3.fsf@evledraar.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 06:05:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jun 29 2018, Mike Hommey wrote:
> 
> > On Sat, Jun 30, 2018 at 12:10:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Fri, Jun 29 2018, Mike Hommey wrote:
> >>
> >> > I noticed some slowness when fast-importing data from the Firefox mercurial
> >> > repository, where fast-import spends more than 5 minutes importing ~2000
> >> > revisions of one particular file. I reduced a testcase while still
> >> > using real data. One could synthesize data with kind of the same
> >> > properties, but I figured real data could be useful.
> >> >
> >> > To reproduce:
> >> > $ git clone https://gist.github.com/b6b8edcff2005cc482cf84972adfbba9.git foo
> >> > $ git init bar
> >> > $ cd bar
> >> > $ python ../foo/import.py ../foo/data.gz | git fast-import --depth=2000
> >> >
> >> > [...]
> >> > So maybe it would make sense to consolidate the diff code (after all,
> >> > diff-delta.c is an old specialized fork of xdiff). With manual trimming
> >> > of common head and tail, this gets down to 3:33.
> >> >
> >> > I'll also note that Facebook has imported xdiff from the git code base
> >> > into mercurial and improved performance on it, so it might also be worth
> >> > looking at what's worth taking from there.
> >>
> >> It would be interesting to see how does this compares with a more naïve
> >> approach of committing every version of this file one-at-a-time into a
> >> new repository (with & without gc.auto=0). Perhaps deltaing as we go is
> >> suboptimal compared to just writing out a lot of redundant data and
> >> repacking it all at once later.
> >
> > "Just" writing 26GB? And that's only one file. If I were to do that for
> > the whole repository, it would yield a > 100GB pack. Instead of < 2GB
> > currently.
> 
> To clarify on my terse response. I mean to try this on an isolated test
> case to see to what extent the problem you're describing is unique to
> fast-import, and to what extent it's encountered during "normal" git use
> when you commit all the revisions of that file in succession.
> 
> Perhaps the difference between the two would give some hint as to how to
> proceed, or not.

AIUI, git repack will end up creating delta indexes for every blob, so the
problem should exist there, but because it will be comparing "random"
blobs, it can't take the same kinds of shortcuts as fast-import could,
because fast-import only cares about diffing with the last imported
blob. So while fast-import can reduce the amount of work it does by not
creating an index for common heads and tails of the compared blobs, git
repack can't.

Mike
