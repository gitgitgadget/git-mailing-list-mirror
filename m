Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D1C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF1020706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ptjEXUsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYWp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:45:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51269 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHYWp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 18:45:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA4E76A45;
        Tue, 25 Aug 2020 18:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cDyXfwfi04sRPikE2zYZ9oWsf7w=; b=ptjEXU
        sH0adswV03oT0y5w+qAJkkLyjvE6pQCfofgcGw4CINDu2ezcfcsx4ZrOABI/Okr5
        WfKDjOQt1ueOKUjR0hGtz+TdSD0mNwJP3qeG/xOdaSWKYxp2Dnqor/qLwvEfmAbz
        OL/jE3TwFruNccAfjx75DixwlSbitGF5dNRQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DTdXu/ryFJcYUFLdiyiSdc1aGYKd7Lsa
        La5cjo/mQSn2o1dLyGgi0qdmaCsLCa6OAP9znFVVL0pzHGago3ZoyZCW3MQYPuyD
        y6bopcX+4EfPUTiJRRl4OTXLcilix4ppxJLtxyPiGOBFWZwNH+n6MroHyfR2QN3i
        WxMutUdbVSo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01E3676A43;
        Tue, 25 Aug 2020 18:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 844FA76A42;
        Tue, 25 Aug 2020 18:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: [PATCH] pack-redundant: gauge the usage before proposing its removal
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
        <20200825022614.GA1391422@coredump.intra.peff.net>
        <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
        <20200825172214.GC1414394@coredump.intra.peff.net>
        <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
        <20200825182745.GA1417288@coredump.intra.peff.net>
Date:   Tue, 25 Aug 2020 15:45:52 -0700
In-Reply-To: <20200825182745.GA1417288@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 25 Aug 2020 14:27:45 -0400")
Message-ID: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB4EF062-E724-11EA-9F3B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand is unusably slow and the reason why nobody reports it
as a performance bug is suspected to be the absense of users.  Let's
show a big message that asks the user to tell us that they still
care about the command when an attempt is made to run the command,
with an escape hatch to override it with a command line option.

In a few releases, we may turn it into an error and keep it for a
few more releases before finally removing it (during the whole time,
the plan to remove it would be interrupted by end user raising hand).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Jeff King <peff@peff.net> writes:

    > A more gentle transition would I guess be:
    >
    >   1. Mention deprecation in release notes (hah, as if anybody reads
    >      them).
    >
    >   2. Issue a warning but continue to behave as normal. That might break
    >      scripts that care a lot about stderr, but otherwise is harmless. No
    >      clue if anybody would actually see the message or not.

    OK, so here is an update for the above.

 builtin/pack-redundant.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 178e3409b7..b94c2f2423 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -554,6 +554,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int i_still_use_this = 0;
 	struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
@@ -580,12 +581,24 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			alt_odb = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--i-still-use-this")) {
+			i_still_use_this = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(pack_redundant_usage);
 		else
 			break;
 	}
 
+	if (!i_still_use_this) {
+		fputs(_("'git pack-redundant' is nominated for removal.\n"
+			"If you still use this command, please add an extra\n"
+			"option, '--i-still-use-this', on the command line\n"
+			"and let us know you still use it by sending an e-mail\n"
+			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
+	}
+
 	if (load_all_packs)
 		load_all();
 	else
-- 
2.28.0-454-g5f859b1948

