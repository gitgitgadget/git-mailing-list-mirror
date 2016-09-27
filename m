Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C981F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 06:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbcI0Gto (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 02:49:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752303AbcI0Gtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 02:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D9EF3736F;
        Tue, 27 Sep 2016 02:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=P
        t0pC/ooCwwRcrTCdpvoXQrp474=; b=L+2FEdN8Nb4QaLRPdykNbDhscDWLND8r9
        Xyqdr9ga144uYeYJtkWACGa1UjODywScq3vHrEi2ALa0hr1tURUP+YFpNb1RHBWW
        WZZQ+qolfjvfGwULK7Bn4fOIdmJx14T8Ud6ZdWWB7Ka6IMy845qPBHVBnDTDGT48
        cP3Fny5vKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=JrN
        l/CrRGykWimjYwuFvDgcRwLhTTsXUFGUTp4ID+isg7mWspJGtf1lma2eX8s6geyr
        mMlUykRibc6Y7ZakwKcbwp8KuiDACkF3NNNI9RgAJ/m3sFIeOVPadqjqFzjzjROj
        TAZHGOjWc4pBvfZXjBcIcBCKyC4RAWl4KxJUa4Kk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 865993736E;
        Tue, 27 Sep 2016 02:49:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C0993736D;
        Tue, 27 Sep 2016 02:49:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] worktree: honor configuration variables
Date:   Mon, 26 Sep 2016 23:49:39 -0700
Message-ID: <xmqqzimtrg58.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90BFDB52-847E-11E6-A991-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command accesses default_abbrev (defined in environment.c and is
updated via core.abbrev configuration), but never makes any call to
git_config().  The output from "worktree list" ignores the abbrev
setting for this reason.

Make a call to git_config() to read the default set of configuration
variables at the beginning of the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6dcf7bd..5c4854d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -528,6 +528,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
 	if (!prefix)
-- 
2.10.0-561-g98a6b79

