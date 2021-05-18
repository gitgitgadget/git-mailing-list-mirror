Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA138C43470
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECFE610FA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbhERLTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 07:19:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348739AbhERLTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 07:19:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67056123EC4;
        Tue, 18 May 2021 07:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=t
        2C19L0n2vb7ZK6lKOgmJ8DG8wGYq7TY7GYh2Uxrj18=; b=ErsVGkY4RPR6MrLaq
        wOdW5j2pE/YPkwLQyMZNTrw6+twQdO9852RNx+E3AkxQ9brfVPsdCUuxc0u9TDZc
        uiGgrzLeq8zTmivHOyQmrAe3e9vqqOIPm3OyOt3qilJsNgasiWZuC7FDKs+bQI45
        hRLnlvlC9SfMmBr98Q3n/Hb15Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60A54123EC3;
        Tue, 18 May 2021 07:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FBD1123EC2;
        Tue, 18 May 2021 07:17:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] revisions(7): clarify that most commands take a single
 revision range
Date:   Tue, 18 May 2021 20:17:42 +0900
Message-ID: <xmqqv97g2svd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB040054-B7CA-11EB-9E42-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes new people are confused by how a revision "range" works,
in that it is not a random collection of commits but a set of
commits that are all connected to each other, and most Git commands
work on a single such "range".

Give an example to clarify it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, here it is in a proper patch form, with an extended
   description and illustration.

 Documentation/revisions.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d9169c062e..f5f17b65a1 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -260,6 +260,9 @@ any of the given commits.
 A commit's reachable set is the commit itself and the commits in
 its ancestry chain.
 
+There are several notations to specify a set of connected commits
+(called a "revision range"), illustrated below.
+
 
 Commit Exclusions
 ~~~~~~~~~~~~~~~~~
@@ -294,6 +297,26 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+Commands that are specifically designed to take two distinct ranges
+(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
+they are exceptions.  Unless otherwise noted, all "git" commands
+that operate on a set of commits work on a single revision range.
+In other words, writing two "two-dot range notation" next to each
+other, e.g.
+
+    $ git log A..B C..D
+
+does *not* specify two revision ranges for most commands.  Instead
+it will name a single connected set of commits, i.e. those that are
+reachable from either B or D but are reachable from neither A or C.
+In a linear history like this:
+
+    ---A---B---o---o---C---D
+
+because A and B are reachable from C, the revision range specified
+by these two dotted ranges is a single commit D.
+
+
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Three other shorthands exist, particularly useful for merge commits,
-- 
2.32.0-rc0-111-g32b9632252

