Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609921F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbcG2SiG (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:38:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834AbcG2SiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0611232CB6;
	Fri, 29 Jul 2016 14:38:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p6+RaclkJA267lj3mwv8JV6be6o=; b=o1FuEj
	2H/d+4I22zZqxMdgCQ5qy3KujJcmepulL7NAn+DQJgenfveyFSKYDiZDU+uUhz1T
	2BTvvGlrSt5v9GawFs+9H0iY1muWLHFfY1SIxxLOPT8UAq2aUkyhbEBZOJcA46oG
	Xhqm563TzW14OlVK5C3aUDafe9o28PsbOYMFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oQgU33rUiITi7kDvEgVT/OBiJm84tyZm
	g8ER5e2166+QzYVLJsyqJLNJT6wwkdNODIUcqmeN3PQVU+E7/sbzC82hToObpW2/
	7ljRwiS2o7AH/yUb9V/P99emPV298YFX2qEdDdlNrdIROJOcVgrct9GHJWlEeQ/p
	mFrBGGscz8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2A0232CB5;
	Fri, 29 Jul 2016 14:38:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76F4632CB4;
	Fri, 29 Jul 2016 14:38:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	<xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
	<20160729181121.GB14953@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 11:37:59 -0700
In-Reply-To: <20160729181121.GB14953@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 14:11:22 -0400")
Message-ID: <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94CB8ABC-55BB-11E6-A9A9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... So I do think there may be a bug to be fixed,
> but it is simply commands being over-eager to make sure we have an
> ident when they might not need it.

36267854 (pull: fast-forward "pull --rebase=true", 2016-06-29) may
be a part of a good solution for that, perhaps?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 29 Jun 2016 10:22:31 -0700
Subject: [PATCH] pull: fast-forward "pull --rebase=true"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f..2a41d41 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -878,10 +878,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(*merge_heads.sha1, curr_head);
-	} else if (opt_rebase) {
-		if (merge_heads.nr > 1)
-			die(_("Cannot rebase onto multiple branches."));
+	}
+	if (opt_rebase && merge_heads.nr > 1)
+		die(_("Cannot rebase onto multiple branches."));
+
+	if (opt_rebase) {
+		struct commit_list *list = NULL;
+		struct commit *merge_head, *head;
+
+		head = lookup_commit_reference(orig_head);
+		commit_list_insert(head, &list);
+		merge_head = lookup_commit_reference(merge_heads.sha1[0]);
+		if (is_descendant_of(merge_head, list)) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			return run_merge();
+		}
 		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
-	} else
+	} else {
 		return run_merge();
+	}
 }
-- 
2.9.2-685-g483c9ea

