Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFEC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740BC207F5
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405723AbgE1SLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:20223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405688AbgE1SLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:02 -0400
IronPort-SDR: L5556AN5QTVfWWHzqZ+XhBjNmlVQ1/T+SN0uRdY+KYSDwrhmIVPmrfp5wS0f14bdOmXbuELrBo
 RY0Me7xC5aHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: 4IrkSNpKqBq7q/vYtafY679p8AG5qVuUk42csR6zEsMTgsm9eNT5FyQj/CiibtlqhVBl1uFf2F
 KpcK7FcWaT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301344"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 00/16] improve switch/checkout completion
Date:   Thu, 28 May 2020 11:10:32 -0700
Message-Id: <20200528181048.3509470-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Recently I noticed that the completion support for git switch is subpar, and
can lead to frustrating moments. Specifically the difference between
completing `git switch` vs `git switch --track`:

  $git switch <TAB>
  Display all 784 possibilities? (y or n)
  <list of all references and DWIM remotes>

Notice that git switch will complete basically all references, including
things like HEAD, and remote references like "origin/master". Many of these
values are useless and clutter the output. It's not too bad, but could be
somewhat improved. At least it still completes useful words.

However, the same cannot be said for --track:

  $git switch --track<TAB>
  jk-refactor-git-switch-completion master

Notice that with --track, we suddenly start completing only local branches.
Not only does this severely limit what we complete, it includes *only*
useless words. This leads to incredibly frustrating moments, as I often use
"git switch --track remote/<TAB>" to create tracking branches. I found
myself often having to backspace --track just to complete what I wanted and
then re-add it.

The primary original motivation of this series was to improve the handling
of track. Several other issues were discovered, and I attempt to improve
pretty much every mode of switch.

The first few patches simply add new test cases, most of which fail. This is
done in order to give time to fully explain what I believe is deficient
about the specific case.

Following these patches are some cleanup improvements to remove some
confusing terminology and introduce new functions that will be useful to
improve the completion functions.

Finally, several patches which improve completion follow. By the end,
completion for both git switch and git checkout should be more useful and
more aware of the intention of the current argument being completed.

A patch to initially fix just the --track behavior was posted at
https://lore.kernel.org/git/20200422201541.3766173-1-jacob.e.keller@intel.com/

This original patch was reviewed by Jonathan Nieder, and he suggested
further improvements, which led to v1 of this series
https://lore.kernel.org/git/20200425022045.1089291-1-jacob.e.keller@intel.com/

This was further reviewed, and some issues with the handling of completing
the argument to -c/-C were brought up by Junio, which I then improved in v2
https://lore.kernel.org/git/20200527113831.3294409-1-jacob.e.keller@intel.com/

Junio mentioned that the commit messages for this v2 series were difficult
to follow. I have split the tests from the implementation patches and
re-written the commit messages. Hopefully this now better highlights the
places where completion isn't behaving as I would expect.

Once again, given the nature of the rework I did not find a suitable
range-diff that expressed the evolution from v2 to v3, so I haven't included
it here.

I would really like opinions on whether the suggested -c/-C argument
completion makes sense. I opted to limit it to complete local branch names,
and optionally the unique remote branch names. I'm open to alternative
suggestions if anyone has a better suggestion? I had thought perhaps also
some users might wish to see tags, if they have branches named after tags or
similar.. I don't think completing all references makes sense: branches with
remote prefixes in their name would be confusing.

Jacob Keller (16):
  completion: add test showing subpar git switch completion
  completion: add tests showing subpar DWIM logic for switch/checkout
  completion: add tests showing subar checkout --detach logic
  completion: add tests showing subpar switch/checkout --track logic
  completion: add tests showing subpar -c/-C startpoint completion
  completion: add tests showing subpar -c/C argument completion
  completion: add tests showing subpar switch/checkout --orphan logic
  completion: replace overloaded track term for __git_complete_refs
  completion: extract function __git_dwim_remote_heads
  completion: perform DWIM logic directly in __git_complete_refs
  completion: improve handling of DWIM mode for switch/checkout
  completion: improve completion for git switch with no options
  completion: improve handling of --detach in checkout
  completion: improve handling of --track in switch/checkout
  completion: improve handling of -c/-C and -b/-B in switch/checkout
  completion: improve handling of --orphan option of switch/checkout

 contrib/completion/git-completion.bash | 252 +++++++++++---
 t/t9902-completion.sh                  | 456 +++++++++++++++++++++++++
 2 files changed, 669 insertions(+), 39 deletions(-)

-- 
2.25.2
