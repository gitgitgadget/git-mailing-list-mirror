Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BE620989
	for <e@80x24.org>; Wed, 12 Oct 2016 10:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbcJLKqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 06:46:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46724 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcJLKqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 06:46:31 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Oct 2016 06:46:30 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
        id DF3341C013C; Wed, 12 Oct 2016 12:37:16 +0200 (CEST)
Date:   Wed, 12 Oct 2016 12:37:16 +0200
From:   Stepan Kasal <kasal@ucw.cz>
To:     git@vger.kernel.org
Subject: Bug with git merge-base and a packed ref
Message-ID: <20161012103716.GA31533@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

first, I observed a bug with git pull --rebase:
if the remote branch got rebased and the loval branch was updated,
pull tried to rebase the whole branch, not the local increment.

A reproducer would look like that

# in repo1:
git checkout tmp
cd ..
git clone repo1 repo2
cd repo1
git rebase elsewhere tmp
cd ../repo2
# edit
git commit -a -m 'Another commit'
git pull -r

The last command performs something like
   git rebase new-origin/tmp
instead of
   git rebase --onto new-origin/tmp old-origin/tmp

I'm using git version 2.10.1.windows.1


I tried to debug the issue:
I found that the bug happens only at the very first pull after clone.
I was able to reproduce it with git-pull.sh

The problem seems to be that command
  git merge-base --fork-point refs/remotes/origin/tmp refs/heads/tmp
returns nothing, because the refs are packed.

Could you please fix merge-base so that it understands packed refs?

Thanks,
  Stepan
