Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F0C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7774F20A8B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFPNqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:46:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:33208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFPNqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:46:20 -0400
Received: (qmail 22137 invoked by uid 109); 16 Jun 2020 13:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 13:46:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13166 invoked by uid 111); 16 Jun 2020 13:46:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 09:46:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 09:46:18 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/12] submodule: use the correct default for the main
 branch name
Message-ID: <20200616134618.GI666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <59d6267f099f30f830836a2422289bc83f5c35e5.1592225416.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59d6267f099f30f830836a2422289bc83f5c35e5.1592225416.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 12:50:15PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> To allow for overriding the default branch name, we have introduced a
> config setting. With this patch, the `git submodule` command learns
> about this, too.

This was the other reading case (besides guess_remote_head()) that I'm
most concerned with causing regressions in a world where some repos are
on "master" and some are on "main".

This value ends up as the output of "submodule--helper remote-branch".

I was initially worried that we used this branch name for the fallback
when the server doesn't allow us to fetch the sha1 directly, but it
doesn't look like it. That's good, because handling fallbacks there
would be tricky.

Instead, we seem to use this only after fetching all of the refs for a
submodule:

  $ git grep -h -B2 -A11 remote-branch git-submodule.sh
  		if test -n "$remote"
  		then
  			branch=$(git submodule--helper remote-branch "$sm_path")
  			if test -z "$nofetch"
  			then
  				# Fetch remote before determining tracking $sha1
  				fetch_in_submodule "$sm_path" $depth ||
  				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
  			fi
  			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
  			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
  				git rev-parse --verify "${remote_name}/${branch}") ||
  			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
  		fi

and then we just use that branch name to resolve a sha1. So this will
break cases where you've set init.mainBranch, the submodule repo is
still on "master", and you haven't configured a branch in .gitmodules.

It seems like, independent of any change in the default branch names, we
ought to be using $remote_name/HEAD for this case anyway. I suspect that
would be a behavior improvement by itself, as it means more cases could
avoid having to specify the branch name in .gitmodules manually.
Probably nobody noticed so far because "HEAD" is almost always "master"
in the current world. It technically breaks the case that you truly did
want to use "master" in the submodule, but they set HEAD to something
else, and you couldn't be bothered to put it into your .gitmodules file.
That seems rather unlikely to me.

And then everything would Just Work without having to worry about the
local mainbranch value at all.

Alternatively, submodule--helper could pass back the empty string for
"no, we don't have a configured branch name" and this shell code could
actually try a sequence of reasonable guesses: init.mainbranch, then
"master" (and between the two, "main" if that later becomes the
default).

-Peff
