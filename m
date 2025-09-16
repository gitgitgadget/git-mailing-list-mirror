Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42D306B13
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053440; cv=none; b=ATBykP7Y5AHrGdn0/NYuxtIsYJVxU+iv31H7/OkyrhXlBQ3T02wQFvMI/EYSv6/51PislWUdfOTV2vseSvV3XF1oD/dtmC9940B2zzITok2pfwLR4K0X29q5HFJTPp8QaNbFE3jfIAA94gOJWGibKqtPabemKg6oCE3RRu9UCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053440; c=relaxed/simple;
	bh=koPIrU10w+piXG6pk7n+x4ffHCQpitBOg1xjVjJ8IP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t40yC0WDsl53oIM6HTM72UdAnjQ4nxyebk7tPRbs+1KCcj6IW8hnB/PRgm2GqMHg7HfoQKH9YV/JyHs15QS0LSYvBUjIMy4j99eIgq+5+xbt2sWVGfvRBOdpIfgsxChal47gjXZlCYS/vxNNQvAhshVYnGAXlHnArVwsvfDTRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F1x1xs3t; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F1x1xs3t"
Received: (qmail 102229 invoked by uid 109); 16 Sep 2025 20:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=koPIrU10w+piXG6pk7n+x4ffHCQpitBOg1xjVjJ8IP4=; b=F1x1xs3tX8SMVotMeuUEkYxxVK80VoHGSzA4TrdZcwBI4XLMcVYQjUerUgl61+ew2LDso2lu45tzLe5qsjs/PrqeXq4l1h0F8A5byy7PZKU+FS0ExxBdcyUhcBdlsZO/41A932lGSQNptTqnQEwZVkQGcYHVjNIVA2smj88xLe1ZfGVgl7p3ha8QvsY+T4j9yEtQlfDViZaJJuqFpCm3F6qOILyMBcxq23XQlAYxoTsqp816yzSSwGLujnxLuYKWn1xAmOZYjwYd0YT9Py1nZ2dNll57Nn5fu7rQYvmXNu8EQ0B2a5KOvPwEwsREz0CaGKikmdfW+yTP0w2Sq1xZkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:10:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166041 invoked by uid 111); 16 Sep 2025 20:10:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:10:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:10:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/13] unraveling the mysteries of color variables
Message-ID: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While reviewing the patches that were applied as jk/add-i-patch, Patrick
noted that we could be using GIT_COLOR_UNKNOWN in more places. I punted
there because I knew it would be a bit of a rabbit hole, and I think the
patch count here perhaps justifies that view. ;)

The good news is that my digging did uncover two minor bugs, which are
fixed here in patches 2 and 3. And the series should improve the
readability of the code by using named constants and appropriate types
more consistently.

The latter part of the series untangles some of the oddities related to
color variables. I think the results are more readable, but they aren't
strictly necessary because of C's weak type system (and because we
define our constants in a favorable way). The final patch is gross and
should not be applied, but I included it here as it explains how I was
able to find all of the oddities.

  [01/13]: color: use GIT_COLOR_* instead of numeric constants
  [02/13]: color: return enum from git_config_colorbool()
  [03/13]: grep: don't treat grep_opt.color as a strict bool
  [04/13]: diff: simplify color_moved check when flushing
  [05/13]: diff: don't use diff_options.use_color as a strict bool
  [06/13]: diff: pass o->use_color directly to fill_metainfo()
  [07/13]: diff: stop passing ecbdata->use_color as boolean
  [08/13]: pretty: use format_commit_context.auto_color as colorbool
  [09/13]: color: use git_colorbool enum to type to store colorbools
  [10/13]: color: return bool from want_color()
  [11/13]: add-interactive: retain colorbool values longer
  [12/13]: config: store want_color() result in a separate bool
  [13/13]: color: convert git_colorbool into a struct

 add-interactive.c     | 25 ++++++++++----------
 add-interactive.h     |  4 ++--
 advice.c              |  2 +-
 builtin/add.c         |  2 +-
 builtin/am.c          |  4 ++--
 builtin/branch.c      |  2 +-
 builtin/clean.c       |  2 +-
 builtin/commit.c      |  4 ++--
 builtin/config.c      | 27 +++++++++++-----------
 builtin/grep.c        |  2 +-
 builtin/log.c         |  4 ++--
 builtin/push.c        |  2 +-
 builtin/range-diff.c  |  3 ++-
 builtin/show-branch.c |  2 +-
 color.c               | 30 ++++++++++++------------
 color.h               | 15 +++++++-----
 combine-diff.c        |  2 +-
 diff.c                | 54 ++++++++++++++++++++-----------------------
 diff.h                |  5 ++--
 grep.c                |  4 ++--
 grep.h                |  4 ++--
 log-tree.c            |  4 ++--
 log-tree.h            |  2 +-
 parse-options-cb.c    |  6 ++---
 pretty.c              | 12 +++++-----
 pretty.h              |  3 ++-
 ref-filter.h          |  4 ++--
 sequencer.c           |  2 +-
 sideband.c            |  8 +++----
 transport.c           |  2 +-
 wt-status.c           |  6 ++---
 wt-status.h           |  2 +-
 32 files changed, 127 insertions(+), 123 deletions(-)

-Peff
