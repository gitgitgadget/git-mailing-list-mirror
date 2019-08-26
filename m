Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1896C1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 08:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfHZI6s (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 04:58:48 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:48756 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfHZI6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 04:58:48 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i2Apo-0007ex-JN
        for git@vger.kernel.org; Mon, 26 Aug 2019 17:58:44 +0900
Date:   Mon, 26 Aug 2019 17:58:44 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: revision.c alters commit object state ; also no cleanup
Message-ID: <20190826085844.ue77hen2z6rggpe5@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

First, a little context: As you may have noticed, I've recently found a
small bunch of memory leaks in different parts of the code base. The
reason I did is that git-cinnabar[1] uses libgit.a, and I very recently
upgraded its CI to use a slightly more recent version of GCC, which
either enabled leak detection by default in ASAN or detect more leaks
than before. Anyways, my CI was busted because of leaks detected after
the upgrade, which made me look around.

git-cinnabar does make some specific uses of libgit.a that git itself
doesn't, and this is where things kind of fall apart:

First, revision.c doesn't come with a function to clear a struct
rev_info. I did create a function that does enough cleanup for my own
use (which turned out to be not enough), but I'm wondering if git
shouldn't itself have one in revision.c (and seeing that there's now
e.g. repo_clear, which didn't exist when I started git-cinnabar, I think
the answer would be that it should).

Then, revision.c kind of does nasty things to commit objects:
- remove_duplicate_parents alters commit->parents to skip duplicates[2]
- try_to_simplify_commit removes all parents but one[3] or all of them
  [4] in some cases

That's for the case that I did encounter. Maybe there's more.

One problem this causes is that it leaks the commit_list items that used
to contain the removed parents.

Another problem is that if something else uses the commits afterwards,
those commits parents don't match what you'd get before revision
walking. And I don't know how this should be addressed.

Ideas welcome.

Relatedly, the subthread that started at
<xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com> is kind of relevant. There
are two main reasons I'm using libgit.a: one is that I'm doing things
low-level enough that I don't know any other library that would work for
my use case. Another is that I was hoping that in the long term, it
could be merged into git.git. I guess the more time passes, the less
likely the latter is to happen. Which is fine, but it's good to know.

Mike


1. https://github.com/glandium/git-cinnabar/
2. https://github.com/git/git/blob/745f6812895b31c02b29bdfe4ae8e5498f776c26/revision.c#L2742
3. https://github.com/git/git/blob/745f6812895b31c02b29bdfe4ae8e5498f776c26/revision.c#L869
4. https://github.com/git/git/blob/745f6812895b31c02b29bdfe4ae8e5498f776c26/revision.c#L888
