Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F2C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DD82078C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uNgIaKrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEFUSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 16:18:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52769 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFUSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 16:18:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3BC04850F;
        Wed,  6 May 2020 16:18:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=rhp3wrzoZraAgzmWVszMgiLXm
        BI=; b=uNgIaKrm6z7VMs5hMTwZ4TsMg0GXl4MyjS76qLXfxlI3r04z0Yr4JdtV2
        xCO8YmCM/m4gvHB7JwFSPqAMrw+KH3ec6IAqEeOIFygLwqgUbwk1Q7ffSazu1gqj
        Mz0I1GEtvEAzs7eV534PaACLFqbXZNPMHVDQ2Wse6+N18RLYbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=QI6pF0QvvygNKep+cQ/
        GicC192bnIYc9+u5Xoh3DZsy1JKwt0uDNE3bPbHULmMKGB9HUdtgPyBRphodtp2A
        a65Am6X5QGEGYTmFDkAjiHfufX+q9lbkdVFxJ1rPdPdBWE3d8tQBz4M9IeTBXNs9
        1sVf96kQ21ZJoSm/tCqMfEgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AD414850E;
        Wed,  6 May 2020 16:18:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 236E14850D;
        Wed,  6 May 2020 16:18:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Pass down "--quiet" to "gc --auto"
Date:   Wed,  6 May 2020 13:18:28 -0700
Message-Id: <20200506201830.92818-1-gitster@pobox.com>
X-Mailer: git-send-email 2.26.2-561-g07d8ea56f2
In-Reply-To: <20200506094327.GC31637@rillettes>
References: <20200506094327.GC31637@rillettes>
MIME-Version: 1.0
X-Pobox-Relay-ID: C0FA1834-8FD6-11EA-AA6E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A handful commands take "--quiet" from their command line,
but forgets to pass it down, when they trigger an auto gc,
to the "git gc --auto" they internally invoke.

Back in 1991006c (fetch: convert argv_gc_auto to struct argv_array,
2014-08-16), we patched "git fetch" but seems to have forgotten
doing the same for "git merge".  Since then, rewrite of "git am" and
"git rebase" in C spread the same problem into two more codepaths.

Let's clean them up once and for all.

Junio C Hamano (2):
  run_auto_gc(): extract a reusable helper
  auto-gc: pass --quiet down from am, commit, merge and rebase

 builtin/am.c     |  3 +--
 builtin/commit.c |  3 +--
 builtin/fetch.c  | 10 ++--------
 builtin/merge.c  |  3 +--
 builtin/rebase.c |  3 +--
 run-command.c    | 13 +++++++++++++
 run-command.h    |  5 +++++
 7 files changed, 24 insertions(+), 16 deletions(-)

--=20
2.26.2-561-g07d8ea56f2

