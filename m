Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6252D20966
	for <e@80x24.org>; Thu, 30 Mar 2017 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbdC3Tte (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:49:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934152AbdC3Tte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:49:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AFF56E4CD;
        Thu, 30 Mar 2017 15:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/onbMK5bm/3AvpfMoVfjubNSY/8=; b=k4AAZd
        Fpscq0egGrz5lDtPOa7ZCeReqwkxXmTXFvCAm9ALZKSHewqs9t0pWsc1SCD3MJf+
        j3Mr6EbwFXkWifsFonsGuysZXGuFKrBuTXmcI68dbdsTVn1NyP8ySHptE3LF7FVW
        6ErXrFA0AkGnlJqxQZBRwXktm2fZo4sX9WIqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BC+GcmknukKUI+9fxHJuPBZ4hFVqzVpJ
        laerzqylOxVfjj5PfjxCzMamn+0HeVN8jGLMCN4dMquMut9rz4H0wP0dUs8mEk7A
        oLEEIx+MfxUpVB7EWnnCEkctNgqsmNTw+BZrxTr9dUshd0Bv8vh6kRRQvgTQ5oWi
        f7vmiaAsHjI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E83D6E4CC;
        Thu, 30 Mar 2017 15:49:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86AEB6E4CB;
        Thu, 30 Mar 2017 15:49:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background thread
References: <20170328190732.59486-1-git@jeffhostetler.com>
        <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
        <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
        <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 12:49:15 -0700
In-Reply-To: <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 15:56:06 -0400")
Message-ID: <xmqqtw6a35qc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE11F976-1581-11E7-8F70-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So just mentioning the test case and the improvement in the commit
> message is sufficient, IMHO.

So here is how I butchered [v3 1/2] to tentatively queue it on 'pu'.

Notable suggested changes I have in this one are:

 * I stole the numbers from the cover letter of v2 and added them at
   the end of the log message.

 * As the checksum is not a useless relic, but is an integrity
   check, I dropped the "ancient relic" from the proposed log
   message.  It is just that the modern disks are reliable enough to
   make it worthwhile to think about a trade-off this patch makes
   between performance and integrity.

 * As it is customary, the configuration variable starts as an opt
   in feature.  In a few releases, perhaps we can flip the default,
   but we do not do so from day one.

 * Updated the code around the call to config-get-bool to avoid
   asking the same question twice.

 * Added minimum documentation.

By the way, are we sure we have something that validates the
checksum regardless of the configuration setting?  If not, we may
want to tweak this further so that we can force the validation from
"git fsck" or something.  I am not going to do that myself, but it
may be necessary before this graduates to 'master'.

Thanks.

-- >8 --
From: Jeff Hostetler <jeffhost@microsoft.com>
Date: Tue, 28 Mar 2017 19:07:31 +0000
Subject: [PATCH] read-cache: core.checksumindex

Teach git to skip verification of the SHA-1 checksum at the end of
the index file in verify_hdr() called from read_index() when the
core.checksumIndex configuration variable is set to false.

The checksum verification is for detecting disk corruption, and for
small projects, the time it takes to compute SHA-1 is not that
significant, but for gigantic repositories this calculation adds
significant time to every command.

On the Linux kernel repository, the effect is rather trivial.
The time to reading its index with 58k entries drops from 0.0284 sec
down to 0.0155 sec.

On my Windows source tree (450MB index), I'm seeing a savings of 0.6
seconds -- read_index() went from 1.2 to 0.6 seconds.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  8 ++++++++
 read-cache.c             | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1df1965457..bc7b216d43 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -329,6 +329,14 @@ advice.*::
 		show directions on how to proceed from the current state.
 --
 
+core.checksumIndex::
+	Tell Git to validate the checksum at the end of the index
+	file to detect corruption.  Defaults to `true`.  Those who
+	work on a project with too many files may want to set this
+	variable to `false` to make it faster to load the index (in
+	exchange for reliability, but in general modern disks are
+	reliable enough for most people).
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/read-cache.c b/read-cache.c
index e447751823..3195702cf7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1376,12 +1376,28 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	git_SHA_CTX c;
 	unsigned char sha1[20];
 	int hdr_version;
+	static int do_checksum = -1;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+
+	if (do_checksum < 0) {
+		/*
+		 * Since we run very early in command startup, git_config()
+		 * may not have been called yet and the various "core_*"
+		 * global variables haven't been set.  So look it up
+		 * explicitly.
+		 */
+		git_config_get_bool("core.checksumindex", &do_checksum);
+		if (do_checksum < 0)
+			do_checksum = 0; /* default to false */
+	}
+	if (!do_checksum)
+		return 0;
+
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
-- 
2.12.2-727-gf32eb5229d

