Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6818C34
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uCoLdcM7"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72BE5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698413561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUHMZ5bYKKNRaljUbXYlrcO215Y95lBGp99vWsaF7bs=;
	b=uCoLdcM77CLeZWCENwWKpSHssV9vPaR9rlGqlSJCiEatOLMvfON/3Xhgk4s30bwnOwZTPS
	UodfhFCmtmyS2MkLQ3hudx6MPvpPwTMBaYrJyak0Oj1ZNpfJnRjcp2xFuI7kXAX4CBgu5E
	k2HMZeb8lIkVQQuB24H96+eIho3R+C0SOJ8LK2n/oW1Mj/Nn+6YG/83e5ytuQ3HO6yk+me
	5/L7RwlXKF0auI4VFOukMjIUUxboz0GdcAkS5/Eve4hgu/ZCFfe/kWzBrXlG6rRehHZYFH
	d7h+tFgTzj2r1RSBh3qFk9+TK70RvM+SClBpjGf/KO5D1Y2nFlcwNQ2cEKtZ4A==
Date: Fri, 27 Oct 2023 15:32:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
In-Reply-To: <20231026224615.675172-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
Message-ID: <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-27 00:46, Jacob Stopak wrote:
> Take into account reviewer feedback by doing several things 
> differently:
> 
>   * Rename this feature (for now) as "noob format mode" (or just "noob
>     mode") instead of the original "--table" verbiage. As pointed out,
>     this no longer ties the name of the setting to it's proposed
>     implementation detail as a table. Noob mode is not necessarily the
>     right name, just a placeholder for now. Unless people like it :D
> 
>   * Instead of manually having to invoke the -t, --table every time 
> this
>     format is to be used, set the config option "status.noob" to true.
>     Although this is logically tied to the status command, there are 
> many
>     commands that produce status output, (and this series adds more), 
> so
>     assume that if the user wants to see the status this way, that it
>     should be enabled whenever the status info is displayed.

How would "status.noob" relate to and coexist with possible future 
configuration options named "<command>.verbose", which would be somewhat 
similar to the currently existing "commit.verbose" option?  IOW, perhaps 
it would be better to have per-command options "<command>.verbose = 
noob" or, even better, "<command>.verbose = extended", to make it all 
more future-proof and more granular.

>   * When running "git add" and "git restore" while noob mode is 
> enabled,
>     perform the add/restore function as usual, but display the table
>     formatted output with arrows showing how file changes moved around.
>     Displaying the output in this understandable format after each
>     command execution allows the noob to immediately see what they did.
>     Although this series only implements for status, add, and restore,
>     this output format would make sense in other commands like rm, mv,
>     commit, clean, and stash.
> 
>   * Works consistently with commands that already have a --dry-run
>     (-n) option. The dry run shows the exact same output, but
>     doesn't actually do the thing.
> 
>   * If `advice.statusHints` is true, add a table footer with status 
> hints.
>     Shorten these hints so that they are still clear but better fit 
> into a
>     table. Make the hint text yellow to distinguish them. The hints 
> only
>     appear when explicitly running "git status", which helps the user
>     answer the question "what can I do next?". Hints are omitted in
>     "impact" commands like add and restore. Having hints here distracts
>     from the file change moves being showed in the table by arrows.
> 
> TODO:
> 
>   * "git status" outputs myriad other information depending on the 
> state
>     of the repo, like branch info, merge conflicts, rebase info, 
> bisect,
>     etc. Need to think about how to convey that info with the new 
> setting.
> 
>   * Some commands (like stash) might need more than 3 table columns to
>     display everything clearly.
> 
>   * For destructive commands, think about adding a prompt describing 
> the
>     effect, so the user can confirm before the action is taken.
> 
>   * Fix horrible things in the patch series code.
> 
>   * Probably other things.
> 
> Play around with it! It's fun!
> 
> Jacob Stopak (6):
>   status: add noob format from status.noob config
>   status: handle long paths in noob format
>   add: implement noob mode
>   add: set unique color for noob mode arrows
>   restore: implement noob mode
>   status: add advice status hints as table footer
> 
>  Makefile           |   2 +
>  builtin/add.c      |  47 +++++--
>  builtin/checkout.c |  46 +++++--
>  builtin/commit.c   | 157 +----------------------
>  commit.c           |   2 +
>  noob.c             | 198 +++++++++++++++++++++++++++++
>  noob.h             |  21 ++++
>  read-cache-ll.h    |  10 +-
>  read-cache.c       |  41 +++++-
>  table.c            | 301 +++++++++++++++++++++++++++++++++++++++++++++
>  table.h            |   6 +
>  wt-status.c        |  75 +++++++----
>  wt-status.h        |   6 +
>  13 files changed, 708 insertions(+), 204 deletions(-)
>  create mode 100644 noob.c
>  create mode 100644 noob.h
>  create mode 100644 table.c
>  create mode 100644 table.h
