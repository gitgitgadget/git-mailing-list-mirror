Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F08AC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40286208BA
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhACVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:19:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45738 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhACVTq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:19:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 495B560810;
        Sun,  3 Jan 2021 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708745;
        bh=eqdgwt1w7i8HhhstoyGuaa8NiX8rc+zQ649MoOUL7JA=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=J2QI6fJnBqizJQZ7d4Q9wcDoMGY2e5tQZ73ZsoWAk9Y4EA+FQ9xJ38P8ZhOeDBf7b
         2+yUh9lctooCWoB56AhqJcPwALtn8q3S8N1S9hNrRlK4jd0Xbb5xPlS168yKW4TfTd
         BCaFzp6QIrva6VsUBb/vBLOhWFnOVy37waroFqFuyHKKldxyn/7jzbCqXlkWc6Q21B
         kHmoVsoxOlGRnG75MhUoBEzHgteybAiueMwdAiC0P5As+vELQyiNIjQjIKkiIL9/17
         2CEfIwwaloJ51FDFFO+Wij0guPuVCweGDFv2fqmXt5Wiq/6k3oe09ewyL6MswBWPoZ
         X7azEpkqqxrM+gGYaBKppZ9P47vhkdDQK3TrHlkXxNdQ9W7X23hbL2imfer/18Ypwl
         6eLqYX1KzQGEYZJG5mDNPLSsVYPQHBn4J/+Y53vER9NF2DUcIo16t6RTIJMTulDUrX
         /rSg3XbfKiwSJVCXXgSEJCt0hpkvOPNMANNEUxiQAOjHQdV2xnL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/5] Hashed mailmap
Date:   Sun,  3 Jan 2021 21:18:44 +0000
Message-Id: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many people, through the course of their lives, will change either a
name or an email address.  For this reason, we have the mailmap, to map
from a user's former name or email address to their current, canonical
forms.  Normally, this works well as it is.

However, sometimes people change a name (or an email) and want to
completely cease use of the former name or email.  This could be because
a transgender person has transitioned, because a person has left an
abusive partner or broken ties with an abusive family member, or for any
other number of good and valuable reasons.  In these cases, placing the
former name in the .mailmap may be undesirable.

For those situations, let's introduce a hashed mailmap, where the user's
former name or email address can be in the form @sha256:<hash>.  This
obscures the former name or email.

In the course of experimenting with some solutions for v2, I noticed
that our mailmap support has a bunch of problems with case sensitivity.
Notably, it treats local-parts of email addresses in a case-insensitive
way, when the RFC specifically says that they are case sensitive, and we
also treat names case insensitively, but only for ASCII characters.
Both of those have been fixed here, and the commit messages explain in
lurid detail why, while incompatible, this is the correct behavior.

I've also added some performance numbers and explained some alternate
solutions in the commit message for the final patch.  That's in addition
to the performance improvements I've done so that the feature is both
cheaper for users and nearly invisible for non-users.  That isn't quite
the same as adding a perf test, which I haven't done, but I think this
explains the situation quite well.  If folks are still dying for a perf
test, I can add one in v3.

I will point out that fully hashing a mailmap isn't necessarily cheap,
but how expensive it is depends on the weighting of current and former
members of the project.  As mentioned in the original thread, I think a
hash rather than an encoding is the right choice here.  It is likely
that in a few iterations of hardware, all users will have accelerated
SHA-256 and the cost will end up being a handful of cycles per name
overall.

Changes from v1:
* Fix case-sensitivity problems in the mailmap.
* Add documentation.
* Add explanation of how to compute the value.
* Add some optimizations to improve performance.
* Improve commit message to discuss performance numbers and explain
  rationale better.

brian m. carlson (5):
  mailmap: add a function to inspect the number of entries
  mailmap: switch to opaque struct
  t4203: add failing test for case-sensitive local-parts and names
  mailmap: use case-sensitive comparisons for local-parts and names
  mailmap: support hashed entries in mailmaps

 Documentation/mailmap.txt |  28 ++++++++
 builtin/blame.c           |   2 +-
 builtin/check-mailmap.c   |   4 +-
 builtin/commit.c          |   2 +-
 mailmap.c                 | 139 +++++++++++++++++++++++++++++++++-----
 mailmap.h                 |  15 ++--
 pretty.c                  |   4 +-
 pretty.h                  |   2 +-
 revision.c                |   2 +-
 revision.h                |   3 +-
 shortlog.h                |   3 +-
 t/t4203-mailmap.sh        |  64 +++++++++++++++++-
 12 files changed, 236 insertions(+), 32 deletions(-)

