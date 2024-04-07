Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCF812
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451427; cv=none; b=JlboYeWsdXIYdGodQQnuDEmD3hmNnRAZ5bA+W7Kf/3+V9eHgdQMrIU4kjfAOv0OVMmjsvLL4nhAv2iPgrGq+9qAyHrXX74+F9Lbt+kuCbIg7TvKg/sxCUKLp47PTnI9uXvWhG6plbqK3JlkfP9MSdJsfbdAicbmvpp/RmlsiON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451427; c=relaxed/simple;
	bh=1AFy6Fyd4qmvDRoA47IgQyayOmFZbySvFhRsnPdRQzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFy4YfO6ue334+8pOKWfjTLWwU4RUAOo872xifV7t3Tf1qokh3QQgMqixVba8KvkNc1C2W51d0pdY67Rcq67AlVtgxsaaqSogY/JE9CXH1RBvFSCbBZMjPR8IGd59g6+hvku+kOgUHS5RT+zM+pv+vM5IIBXxcj2vl6/TwfXMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7243 invoked by uid 109); 7 Apr 2024 00:56:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 00:56:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11175 invoked by uid 111); 7 Apr 2024 00:56:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 20:56:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 20:56:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 0/12] git_config_string() considered harmful
Message-ID: <20240407005656.GA436890@coredump.intra.peff.net>
References: <xmqqttkeicov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttkeicov.fsf@gitster.g>

On Sat, Apr 06, 2024 at 11:11:12AM -0700, Junio C Hamano wrote:

> The excludes_file variable is marked "const char *", but all the
> assignments to it are made with a piece of memory allocated just
> for it, and the variable is responsible for owning it.
> 
> When "core.excludesfile" is read, the code just lost the previous
> value, leaking memory.  Plug it.
> 
> The real problem is that the variable is mistyped; our convention
> is to never make a variable that owns the piece of memory pointed
> by it as "const".  Fixing that would reduce the chance of this kind
> of bug happening, and also would make it unnecessary to cast the
> constness away while free()ing it, but that would be a much larger
> follow-up effort.

As you noticed in your follow-up, this is just the tip of the iceberg.
And it's not just git_config_pathname(), but really git_config_string(),
and it is a potential problem for almost every call.

I have a series that I started a few months ago to try to improve this,
but I never sent it in because I didn't have a good solution for the
long tail of variables where we assign a string literal as the default.

But that doesn't mean we can't incrementally make things better. So I
polished it up a bit, and will send the result in a minute.

Looking at your sketch, I think I glossed over the parse-options
OPT_FILENAME_DUP() issue. In practice it's OK because we wouldn't
generally re-read the config after parsing the options. But leaving it
does seem rather ugly, and your solution looks reasonable. I'm not sure
if there's an easy way to get the compiler to point to spots which need
it; the type information is all lost when parse-options passes
everything through a void pointer.

(I remember a while ago looking at retaining type annotations for
parse-options; this could be another use case for that).

I think it would also be useful if we could enable -Wwrite-strings to
catch cases where string literals are assigned to non-const pointers.
But there's some cleanup/refactoring to get that to compile cleanly.

  [01/11]: config: make sequencer.c's git_config_string_dup() public
  [02/11]: config: add git_config_pathname_dup()
  [03/11]: config: prefer git_config_string_dup() for temp variables
  [04/11]: config: use git_config_string_dup() for open-coded equivalents
  [05/11]: config: use git_config_string_dup() to fix leaky open coding
  [06/11]: config: use git_config_string() in easy cases
  [07/11]: config: use git_config_pathname_dup() in easy cases
  [08/11]: http: use git_config_string_dup()
  [09/11]: merge: use git_config_string_dup() for pull strategies
  [10/11]: userdiff: use git_config_string_dup() when we can
  [11/11]: blame: use "dup" string_list for ignore-revs files

 alias.c                |   3 +-
 archive-tar.c          |  10 ++--
 attr.c                 |   2 +-
 attr.h                 |   2 +-
 builtin/blame.c        |   7 +--
 builtin/commit.c       |   8 ++--
 builtin/config.c       |   6 +--
 builtin/help.c         |   7 +--
 builtin/log.c          |  16 +++----
 builtin/merge.c        |  12 ++---
 builtin/receive-pack.c |  10 ++--
 builtin/repack.c       |  16 +++----
 compat/mingw.c         |   7 +--
 config.c               |  48 ++++++++++++-------
 config.h               |  19 ++++++++
 convert.c              |  12 ++---
 delta-islands.c        |   4 +-
 diff.c                 |  12 ++---
 environment.c          |  14 +++---
 environment.h          |  14 +++---
 fetch-pack.c           |   6 +--
 fsck.c                 |   6 +--
 gpg-interface.c        |   9 ++--
 http.c                 | 105 +++++++++++++++++++----------------------
 imap-send.c            |  20 ++++----
 mailmap.c              |   4 +-
 mailmap.h              |   4 +-
 merge-ll.c             |  17 +++----
 pager.c                |   4 +-
 promisor-remote.c      |   2 +-
 promisor-remote.h      |   2 +-
 remote.c               |  45 +++++++++---------
 remote.h               |   8 ++--
 sequencer.c            |  12 +----
 setup.c                |  11 ++---
 upload-pack.c          |   4 +-
 userdiff.c             |   6 +--
 userdiff.h             |   6 +--
 38 files changed, 251 insertions(+), 249 deletions(-)

-Peff
