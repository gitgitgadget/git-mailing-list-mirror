Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F713C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20FA206EB
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cw+rhPfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYSFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:05:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52617 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYSFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:05:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36137E3326;
        Tue, 25 Aug 2020 14:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ifqd49c0Y5t9N6z9MFFHdLgLV6M=; b=cw+rhP
        fP+K3P5X08Gq/gZsQIrzc+3CjSxufusmiaX9cwy72/BCZxJc+GW11JgVFQRHodxj
        VHCVwfVlgRK7n/hKyaZ7iuIo0M7TwxwE95OgDwYcvBWVUAgSpoRd99fkHATs7pHX
        KY5Nws9rUDEDFM7oyP+JiUVnVvTQZiG3t9CSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CW1R+tvAqnun9UkZTH551ZiVI5FhwTex
        MMKXZNKdSoIYORTJS5hUWanEeV5CjpXU28l96SbpmAKu3KPQj7+lRPbw20uV7L7z
        ZY7+thWxZvyfqyWUX5sxc0ukqgSYvJsOkD5VR+9HnXtllyfclDWhzxxuf79uiWEu
        Fph21rZcRFw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E521E3325;
        Tue, 25 Aug 2020 14:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 759B7E331F;
        Tue, 25 Aug 2020 14:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
        <20200825022614.GA1391422@coredump.intra.peff.net>
        <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
        <20200825172214.GC1414394@coredump.intra.peff.net>
Date:   Tue, 25 Aug 2020 11:05:09 -0700
In-Reply-To: <20200825172214.GC1414394@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 25 Aug 2020 13:22:14 -0400")
Message-ID: <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84A89B98-E6FD-11EA-9CF9-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK, that's the part I was missing. The discussion here and the statement
> from git-repack(1):
>
>   -d
>       After packing, if the newly created packs make some existing packs
>       redundant, remove the redundant packs. Also run git prune-packed
>       to remove redundant loose object files.
>
> made me think that it was running pack-redundant. But it doesn't seem
> to. It looks like we stopped doing so in 6ed64058e1 (git-repack: do not
> do complex redundancy check., 2005-11-19).

Thanks for digging.  A good opportunity for a #leftoverbits
documentation update from new people is here.

> As an aside, we tried using pack-redundant at GitHub several years ago
> for dropping packs that were replicated in alternates storage. It
> performs very poorly (quadratically, perhaps?) to the point that we
> found it unusable,...

Yes, I originally wrote "the pack-redundant subcommand" in the
message you are responding to with a bit more colourful adjectives,
but rewrote it ;-)  My recollection from the last time I looked at
it is that it is quadratic or even worse---that was long time ago,
but on the other hand I think the subcommand had no significant
improvement over the course of its life.

Perhaps it is time to drop it.

-- >8 --
Subject: [RFC] pack-redundant: gauge the usage before proposing its removal

The subcommand is unusably slow and the reason why nobody reports it
as a performance bug is suspected to be the absense of users.  Let's
disable the normal use of command by making it error out with a big
message that asks the user to tell us that they still care about the
command, with an escape hatch to override it with a command line
option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 178e3409b7..97cf3df79b 100644
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
@@ -580,12 +581,25 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
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
+		puts(_("'git pack-redundant' is nominated for removal.\n"
+		       "If you still use this command, please add an extra\n"
+		       "option, '--i-still-use-this', on the command line\n"
+		       "and let us know you still use it by sending an e-mail\n"
+		       "to <git@vger.kernel.org>.  Thanks\n"));
+		exit(1);
+	}
+
 	if (load_all_packs)
 		load_all();
 	else
