Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C43C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55A610A5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhJFOFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:05:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30914 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhJFOFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 10:05:34 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mY7WH-000CVv-6t; Wed, 06 Oct 2021 15:03:41 +0100
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <nycvar.QRO.7.76.6.2110051244000.395@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7ac923e5-9bda-b534-a2f6-0be68fc80ed9@iee.email>
Date:   Wed, 6 Oct 2021 15:03:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2110051244000.395@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,
On 05/10/2021 11:53, Johannes Schindelin wrote:
> Hi Philip,
>
> On Sat, 18 Sep 2021, Philip Oakley wrote:
>
>> Is there a method within `git rev-list` to trim side branch merges where
>> the merge's tree is identical to the first parent's commit-tree?
> Yes, there is, but it is not as easy as a command-line option: `git
> replace`.
>
> For example, to pretend that the most recent merging-rebase in Git for
> Windows was (almost) a regular rebase, you replace the "Start the
> merging-rebase" commit with a graft that only keeps its first parent:
>
> 	git replace --graft HEAD^{/^Start.the} HEAD^{/^Start.the}^

If I remember rightly, the ever-green script needs to go to special
lengths to ensure that it gets the topographic (DAG) sort order, rather
than the default chrono - time ordered commit searching, which was part
of the deadheads question.

I need to learn the dot trick to avoid the quoting needed for the spaces
in the commit message title! It always slips my mind. I've added a
pseudo alias for the command style (I can never remember what I named
it.. but its easy to look up all aliases..) I also never remember that
"Start.the" subject line..
>
> (Of course, you still have to find out the first-parent-treesame merge
> commits that you want to replace.)

I was thinking of cases beyond the current Git-for-Windows, that other
maintainers may start to use where keeping the 'deadheads' is a valid,
or even required, part of their real-world projects, hence the idea of a
`--deadheads` variant of 'first-parent'.
>
> If you want to do that only temporarily, you can use a throw-away
> namespace instead of the refs/replace/ one:
>
> 	export GIT_REPLACE_REF_BASE=refs/philipoakley/
> 	git replace --graft HEAD^{/^Start.the} HEAD^{/^Start.the}^

Useful.
>
> Before:
>
> 	[...]
> 	| > | | 23e09ef1080 Merge 'remote-hg-prerequisites' into HEAD
> 	|/| | |
> 	| > | | 0221569db1c Always auto-gc after calling a fast-import transport
> 	| > | | f189282dcfc remote-helper: check helper status after import/export
> 	| > | | 158907ceb87 transport-helper: add trailing --
> 	| > | | 6e34e54050c t9350: point out that refs are not updated correctly
> 	|/ / /
> 	> | |   7b2b910b080 Start the merging-rebase to v2.33.0
> 	|\ \ \
> 	| |_|/
> 	|/| |
> 	| > |   508bb26ff90 (tag: v2.33.0-rc2.windows.1) Merge pull request #3349 from vdye/feature/ci-subtree-tests
> 	[...]
>
> After:
>
> 	[...]
> 	| > | | 23e09ef1080 Merge 'remote-hg-prerequisites' into HEAD
> 	|/| | |
> 	| > | | 0221569db1c Always auto-gc after calling a fast-import transport
> 	| > | | f189282dcfc remote-helper: check helper status after import/export
> 	| > | | 158907ceb87 transport-helper: add trailing --
> 	| > | | 6e34e54050c t9350: point out that refs are not updated correctly
> 	|/ / /
> 	> | / 7b2b910b080 (replaced) Start the merging-rebase to v2.33.0
> 	| |/
> 	|/|
> 	> | 225bc32a989 (tag: v2.33.0, upstream/maint, mirucam/maint, gitgitgadget/snap, gitgitgadget/maint) Git 2.33
> 	[...]
>
> You can always clean up _all_ replace objects via `git replace -d $(git
> replace -l)`.

That's a useful clean up tip. Thanks!

>
> Ciao,
> Dscho
Thanks
Philip
