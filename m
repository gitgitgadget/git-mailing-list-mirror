Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C961FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbcLEXg7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 18:36:59 -0500
Received: from pug.qqx.org ([50.116.43.67]:38348 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbcLEXg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:36:59 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Dec 2016 18:36:59 EST
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 76B0222EB4; Mon,  5 Dec 2016 18:27:12 -0500 (EST)
Date:   Mon, 5 Dec 2016 18:27:12 -0500
From:   Aaron Schrab <aaron@schrab.com>
To:     Jan Hudec <bulb@ucw.cz>
Cc:     git@vger.kernel.org
Subject: Re: git describe number of commits different from git log count
Message-ID: <20161205232712.GA23868@pug.qqx.org>
References: <1701823.75Syo8h0k0@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1701823.75Syo8h0k0@box>
User-Agent: Mutt/1.7.2+125 (g65b7094) (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 12:17 +0100 05 Feb 2016, Jan Hudec <bulb@ucw.cz> wrote:
>I have a repository with following situation:
>
>    $ git describe next
>    v4.1-2196-g5a414d7
>    $ git describe next --match=v4.2
>    v4.2-4757-g5a414d7
>
>Since the tag with fewest commits since is selected, it appears logical.
>However, v4.2 is descendant of v4.1, so it does not make sense for it to have
>more commits since. And rev-list or log confirm that:
>
>    $ git rev-list v4.1..next | wc -l
>    2196
>    $ git rev-list v4.2..next | wc -l
>    1152
>
>The number of commits since v4.1 matches what the describe counted, but the
>number of commits since v4.2 does not.

I'm encountering what seems to be a similar issue. I'm working with the 
`build` branch of https://github.com/aschrab/mutt currently at 65b7094.  
Most of the commits in that repo come from a mercurial repository, but I 
don't think that is really effecting things (other than being related to 
the need to use the --tags option).

  $ git describe --tags
  mutt-1-7-1-rel-137-g65b7094

  $ git describe --tags --match=mutt-1-7-2-rel
  mutt-1-7-2-rel-6246-g65b7094

  $ git rev-list --count mutt-1-7-2-rel..HEAD
  126

  $ git rev-list --count mutt-1-7-1-rel..HEAD
  137

  $ git --version
  git version 2.10.2

The number of additional commits shown when I force the tag is 
completely insane! That's nearly every commit that is part of that 
branch:

  1036$ git rev-list --count HEAD
  6250

Both of the tags above should be reachable along the first-parent path.  
If I add the `--first-parent` option to the describe command it picks 
the expected tag and the number additional commits seems sane:

  $ git describe --tags --first-parent
  mutt-1-7-2-rel-14-g65b7094
