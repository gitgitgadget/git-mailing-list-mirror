Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DAA51F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTS47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:56:59 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33813 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTS46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:56:58 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 49221240007;
        Tue, 20 Aug 2019 18:56:56 +0000 (UTC)
Date:   Wed, 21 Aug 2019 00:26:54 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Leam Hall <leamhall@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Only track built files for final output?
Message-ID: <20190820185654.fhelqfub2on67mre@localhost.localdomain>
References: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
 <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
 <f899594c-4f57-b941-f4f1-fd3b8f81136a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f899594c-4f57-b941-f4f1-fd3b8f81136a@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/19 02:01PM, Leam Hall wrote:
> On 8/20/19 1:46 PM, Pratyush Yadav wrote:
> > On 20/08/19 08:21AM, Leam Hall wrote:
> > > Hey all, a newbie could use some help.
> > > 
> > > We have some code that generates data files, and as a part of our build
> > > process those files are rebuilt to ensure things work. This causes an issue
> > > with branches and merging, as the data files change slightly and dealing
> > > with half a dozen merge conflicts, for files that are in an interim state,
> > > is frustrating. The catch is that when the code goes to the production
> > > state, those files must be in place and current.
> > > 
> > > We use a release branch, and then fork off that for each issue. Testing, and
> > > file creation, is a part of the pre-merge process. This is what causes the
> > > merge conflicts.
> > > 
> > > Right now my thought is to put the "final" versions of the files in some
> > > other directory, and put the interim file storage directory in .gitignore.
> > > Is there a better way to do this?
> > > 
> > 
> > My philosophy with Git is to only track files that I need to generate
> > the final product. I never track the generated files, because I can
> > always get to them via the tracked "source" files.
> > 
> > So for example, I was working on a simple parser in Flex and Bison. Flex
> > and Bison take source files in their syntax, and generate a C file each
> > that is then compiled and linked to get to the final binary. So instead
> > of tracking the generated C files, I only tracked the source Flex and
> > Bison files. My build system can always get me the generated files.
> > 
> > So in your case, what's wrong with just tracking the source files needed
> > to generate the other files, and then when you want a release binary,
> > just clone the repo, run your build system, and get the generated files?
> > What benefit do you get by tracking the generated files?
> 
> For internal use I agree with you. However, there's an issue.
> 
> The generated files are used by another program's build system, and I can't
> guarantee the other build system's build system is built like ours. It seems
> easier to provide them the generated files and decouple their build system
> layout from ours.

Maybe I don't completely understand your use case, but you can still 
pass off the generated files to the external build system without having 
to track them. Unless the external build system exclusively relies on 
git clones/fetches, how about packaging your release with your files 
generated from your build system in a tarball (or anything else that 
works for you) and pushing them to the external build system?

Assuming you just _have_ to track those files, will always resolving the 
merge conflicts as 'theirs' work?

My guess about your process works is you branch off, make a new feature 
or fix, and then merge those changes to your master. In that case, the 
changes that the feature branch made to your generated files should 
always be the ones that get committed, correct? master's version of the 
generated files should be stale. So your merge conflicts always need to 
be resolved as 'theirs', at least on the generated files. I don't know 
if git-merge supports file-specific merge strategies though, please 
check once. Otherwise, maybe you can write a script that resolves 
conflicts as 'theirs' for the generated files, and lets you figure it 
out manually for the rest. 

I'm just thinking out loud. I don't know how well this will scale. Maybe 
the more experienced folks here will have better ideas.

-- 
Regards,
Pratyush Yadav
