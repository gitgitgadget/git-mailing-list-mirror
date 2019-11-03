Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FB31F454
	for <e@80x24.org>; Sun,  3 Nov 2019 01:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfKCBMb (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 21:12:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46191 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfKCBMb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 21:12:31 -0400
X-Originating-IP: 1.186.12.57
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ACBFCE0003;
        Sun,  3 Nov 2019 01:12:27 +0000 (UTC)
Date:   Sun, 3 Nov 2019 06:42:25 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert <logic@deltaq.org>
Cc:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Subject: Re: [PATCH 0/2] git-gui: revert untracked files by deleting them
Message-ID: <20191103011225.b6emr2ldskktokgd@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
 <CAPSOpYufF8B0sBUUYqBx5YTxH+02qRom+tz4a0_2iBcNOvvMXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSOpYufF8B0sBUUYqBx5YTxH+02qRom+tz4a0_2iBcNOvvMXA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/10/19 12:16PM, Jonathan Gilbert wrote:
> On Wed, Oct 30, 2019 at 4:09 AM Bert Wesarg
> bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|
> <xlwsizdz58ciy7t@sneakemail.com> wrote:
> > in Git speak, that operation is called 'clean' (see 'git clean') why
> > should we overload the 'revert' operation here?
> 
> It's less about overloading the 'revert' operation as overloading the
> UI action which is currently called "Revert". I think it would be a
> worse experience to have to activate a different option to remove
> unwanted files as to remove unwanted changes. Maybe the UI option
> could be renamed "Revert & Clean" or something?

I disagree. There are valid workflows where you want to remove all 
changes to tracked files, but leave untracked ones alone. As an example, 
say you wrote a small script to fix some textual things, like your 
variable re-name patch. Now you run a diff before you commit those 
changes just to be sure, and notice that your script was overzealous and 
made some changes it shouldn't have. So, you clean up all tracked files,
and give your script a fresh start. Here, you don't want to delete your 
script.

And in the other direction, say you want to delete all untracked files 
but have unstaged changes in your tracked files. Combining "Revert" and 
"Clean" does not give you an option to only delete untracked files. So 
you now either have to stash your changes, or run `git clean` from the 
command line.
 
> As a side note, `git clean untracked-file` won't do anything with a
> default configuration, you have to explicitly `-f` it. Not sure if
> that's relevant, but it does feel like a higher barrier to entry than
> `git revert`.

`git revert` is different from our "Revert", though I admit the naming 
is quite confusing. `git revert` creates a new commit that "reverses" 
the changes made in an earlier commit(s). The important point to note 
here is that `git revert` is used when you publish some commits, and 
then realise later they had some bugs. Now you can't just drop those 
commits because that would re-write the history, and it would change all 
the commit hashes since that commit. So, you use `git revert` to create 
a new commit that _textually_ reverses those changes. The buggy commit 
still exists in the tree, but its changes don't.

In contrast, git-gui's "Revert" works on unstaged changes. It does not 
create a new commit. In fact, our revert does something similar to `git 
checkout -- <file>` (it uses `git checkout-index` to be precise).

So I don't think you should, or _can_, use `git revert` for what you 
want to do. And so, I don't see why it is being factored in with this 
discussion. Am I missing something?

-- 
Regards,
Pratyush Yadav
