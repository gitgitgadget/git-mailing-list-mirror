Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC09B1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 00:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJHAAJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 20:00:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43193 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfJHAAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 20:00:09 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0009460007;
        Tue,  8 Oct 2019 00:00:05 +0000 (UTC)
Date:   Tue, 8 Oct 2019 05:30:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Gui: Branch->create currently fails...
Message-ID: <20191008000003.qlulu5ie36eij4uq@yadavpratyush.com>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/19 11:02PM, Philip Oakley wrote:
> I'd never used the Branch:Create before (this is via mouse) and it threw an
> error, which appears to be repeatable, so I'm reporting it at the moment so

I'm afraid I can't reproduce it. I tested by creating a worktree of 
git.git by running:

  git worktree add ../git-2

Then I opened git-gui in the worktree and clicked the "Create" option 
under the "Branch" menu.

The dialog opened just fine, which I assume is what your error is. But 
just to be sure, I created a branch too, and that also works pretty 
well.

Same behaviour with a "normal" branch, which is not inside a worktree.

So is there anything else in your setup that would cause this problem?

> I don't forget ...
> (I'm chasing down other issue at the moment ;-)
> 
> This is with the version 0.21.GI git version 2.23.0.windows.1 Tcl/Tck 8.6.9
> 
> 
> missing "
> missing "
>     while executing
> "list "refs/heads/redo-v0" [list ""
>     ("eval" body line 1)
>     invoked from within
> "eval $line"
>     (procedure "_new" line 87)
>     invoked from within
> "_new $path 0 $title"
>     (procedure "::choose_rev::new" line 2)
>     invoked from within
> "::choose_rev::new $w.rev [mc "Starting Revision"]"
>     (procedure "branch_create::dialog" line 35)
>     invoked from within
> "branch_create::dialog"
>     (menu invoke)

Looking at the log, the culprit seems to be the line:

  set line [eval $line]

over at lib/choose_rev.tcl:159. The $line comes from reading the output 
of a call to `git for-each-ref` with '--tcl' passed in. Looking at the 
man page for 'for-each-ref', the description of the option is:

  --shell, --perl, --python, --tcl
    If given, strings that substitute %(fieldname) placeholders are 
    quoted as string literals suitable for the specified host language. 
    This is meant to produce a scriptlet that
    can directly be `eval`ed.

So this might possibly me an upstream bug.

If I had to guess a fix, I'd suggest trying to wrap the $line in 
lib/choose_rev.tcl:159 in quotes like so:

  set line [eval "$line"] 

If this doesn't fix it, see if you can find out which $line is causing 
problem by printing the variable before 'eval'ing it by adding a:

  puts "$line"

before the call to eval.

-- 
Regards,
Pratyush Yadav
