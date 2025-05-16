Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB64B1E44
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370963; cv=none; b=R7YZOWGl9Lr0vVFhW4Pnh8Kfl13lIawynX70OtGKsLwrMiUuwJxrmmY3OzFoJL99hWCOFRcWHTFD0+fHUJcCY2zddaXt71CB1q7nVzRjdIUzCBcUhYCMXdVEsKXxZd2N2fIM14z9RwxcodjJ39GBl5DHjscPt6Ks86CACyCcMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370963; c=relaxed/simple;
	bh=b4cB3hjc7jioG0pRwCI7bIjmBYDsYmoWOE9Vv+1Z0iM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GTl/jdXrUNbH0t8zASV/KaMY7fh8XL64kv2fZI7KkvzjHAc5ohmb3OD0l4FwE/tJrMKq2LDDdpe/YP/Hoy59CQPnPvxDUIsZnb2EIAe4+Bh+uuNGa8KZXRcZe5og3Yfl00S0I/86PMyrmUtrhMmR86fLD0VoOxMePPeV7YZGq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fPmiFMDm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fPmiFMDm"
Received: (qmail 5142 invoked by uid 109); 16 May 2025 04:49:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=b4cB3hjc7jioG0pRwCI7bIjmBYDsYmoWOE9Vv+1Z0iM=; b=fPmiFMDmJnx/hAnRWBfzkMQ8V/pu8eVcGlLktUknY5H8VWMh2QZ4mGFcKgpeRsrcMHAnB4r18nqXpYiyWYh5pN1ah+lUbzcUHJ0jIcqfH86w8P3R26N695YrdhxsWyXfIThJgGNvhFxsLNpUKvl6BwTPGbI7bPVerEDczus5Keri/XQdYh8EvyzIU16QLqW7F0ZXVR0IoanNDQZHS/6QRltu+dpYgzZ6QCqKBeCvK4Kkc7ESFRQKWtWdLbz96OlFxlvZPeziZALZgwWoMmJiz7imch4zyISelC9YTPg7tqxfeZQXppBbN/nUoi0yMz3qMZndZ3xtFdQ7KDbfEKruFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4880 invoked by uid 111); 16 May 2025 04:49:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/13] dropping support for non-standard object types
Message-ID: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While fixing some bugs last month in c39e5cbaa5 (Merge branch
'jk/zlib-inflate-fixes', 2025-04-15), I noted that objects with
non-standard types are not really usable. You can get their size and
type, but nothing else, not even their contents. And you can't transfer
them to other repositories, as packfiles have no way to represent them.

We've had that code since 2015, but beyond using it in a few tests,
it's never gone anywhere. So I'd like to consider the whole direction a
failed experiment and rip it out, which simplifies some of the core
object code.

IMHO this doesn't need to follow the breaking-change flow and wait until
Git 3.0, because what's there is not really usable in any useful way.
But others may disagree.

I've tried to group the patches logically:

  [01/13]: object-file.h: fix typo in variable declaration

    Nearby cleanup that can be taken independently.

  [02/13]: cat-file: make --allow-unknown-type a noop
  [03/13]: object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag

    This drops the user-facing reading feature, and the hairiest bits of
    the reading code.

  [04/13]: cat-file: use type enum instead of buffer for -t option
  [05/13]: oid_object_info_convert(): stop using string for object type
  [06/13]: fsck: stop using object_info->type_name strbuf
  [07/13]: oid_object_info(): drop type_name strbuf

    This drops the rest of the unknown-type code. The first three are
    refactors to prepare for it, then the final one drops the code.
    These are mostly not user-facing, though patch 6 does change some
    fsck stderr output.

    This is not strictly necessary to happen along with patches 2+3, but
    I think the resulting code is an improvement.

    All the patches after this deal with the writing side (the two are
    conceptually independent, but of course many of the reading-side
    tests removed by earlier commits did depend on the writing side for
    setup).

  [08/13]: t/helper: add zlib test-tool
  [09/13]: t: add lib-loose.sh
  [10/13]: hash-object: stop allowing unknown types

    This drops the user-facing support for writing objects with
    non-standard types. We do use that feature in the test suite (e.g.,
    to see how fsck reacts), so there's a new helper to enable that. So
    in a sense we are trading code removed from the object-writing
    system and putting it in the test suite. But IMHO that is still a
    win, because we care more about the "production" code in git itself.

  [11/13]: hash-object: merge HASH_* and INDEX_* flags
  [12/13]: hash-object: handle --literally with OPT_NEGBIT
  [13/13]: object-file: drop support for writing objects with unknown types

    These are some cleanups enabled by patch 10, culminating in dropping
    write_object_file_literally().

 Documentation/git-cat-file.adoc     |   6 +-
 Makefile                            |   1 +
 builtin/cat-file.c                  |  31 ++--
 builtin/fsck.c                      |  13 +-
 builtin/hash-object.c               |  69 +++------
 object-file.c                       | 142 +++---------------
 object-file.h                       |  17 +--
 object-store.c                      |  17 +--
 object-store.h                      |   3 -
 packfile.c                          |   7 +-
 streaming.c                         |   2 +-
 t/helper/meson.build                |   1 +
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/helper/test-zlib.c                |  62 ++++++++
 t/lib-loose.sh                      |  30 ++++
 t/t1006-cat-file.sh                 | 216 +++++++---------------------
 t/t1007-hash-object.sh              |  11 +-
 t/t1450-fsck.sh                     |  32 +----
 t/t1512-rev-parse-disambiguation.sh |   5 +-
 20 files changed, 220 insertions(+), 447 deletions(-)
 create mode 100644 t/helper/test-zlib.c
 create mode 100644 t/lib-loose.sh

-Peff
