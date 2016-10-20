Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E819E1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 23:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbcJTXgO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 19:36:14 -0400
Received: from pug.qqx.org ([50.116.43.67]:56758 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcJTXgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 19:36:14 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Oct 2016 19:36:14 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
        id D75681E61F; Thu, 20 Oct 2016 23:29:15 +0000 (UTC)
Date:   Thu, 20 Oct 2016 19:29:15 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: A couple errors dealing with uninitialized submodules
Message-ID: <20161020232915.GB3667@pug.qqx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.7.1+66 (g8a413c8) (2016-10-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was working with a fresh clone of a repository where I'd forgotten 
that one of the directories was setup as a submodule, so I hadn't 
initialized it.

I tried to add a symlink to a location outside the repository and this 
failed with an assertion (exact text in comment below). When looking 
into that I realized that the directory was meant to be a submodule and 
decided to try to change that.  So I tried to remove the submodule, and 
got an error (misleadingly) saying that couldn't be done because it uses 
a .git directory.

I first noticed this with git 2.9.3 from Debian unstable, but I also see 
it building from v2.10.1-502-g6598894 fetched from master recently.

The following script replicates both of these issues. These could both 
be classified as "don't do that", although at lease the assertion is 
quite ugly.

--- >8 ----
#!/bin/sh -e

directory=$(mktemp -d)
echo "Using directory '$directory'"
cd $directory
git init --quiet orig
(
  cd orig
  # Using a random, small repository for the submodule.
  git submodule --quiet add https://github.com/diepm/vim-rest-console.git sub
  git commit -m init >/dev/null
)
git clone --quiet orig dup
cd dup

(
  cd sub
  ln -s /tmp/dont_care
  # Next command aborts with
  # git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.`
  git add . || : expected to fail
)

rm -f .git/index.lock
# Next command fails with error wrongly saying that the submodule uses a .git
# directory.  I believe that the real problem is that the uninitialized
# submodule has content.
git rm sub
