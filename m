Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A75C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8977920775
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihq8Hh/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD0XyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:54:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62872 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD0XyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 19:54:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 498B65DEC5;
        Mon, 27 Apr 2020 19:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0nadclpNZgJq8F+m4e0UWk6CR00=; b=ihq8Hh
        /zW6+mAuivH031PeGg4aJXTeZ118ijE/0Z9fb/XwXL90bxiwAx7IaJOJz1IxNRh0
        xNWl5fp+9J9weua83AZ/r/pKxmtjLZYN1lu40H8N05qgpbeq/RirpbmH1nXu22uN
        05jcIepP47zfhGlSad/dtzddHQ0+DHdYkeJS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iMxEBs+5xPcUT8gVeZgDq37d50XoQ90q
        hiFnAxMauMxgxWM5b7WJHbea1lkQerG/aM/ONw0mfeJCSk+m2a/BDtLPh3X9C40g
        XHR6cnSNWSHVURlFxBnEV7GS5qKwqBrGXtJAGD3jD7Ozp9eZG88CuASGSiefE7Sw
        IiA0PwRJZGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E5D95DEC4;
        Mon, 27 Apr 2020 19:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0A775DEC3;
        Mon, 27 Apr 2020 19:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as read-only
References: <cover.1587422630.git.me@ttaylorr.com>
        <cover.1588004647.git.me@ttaylorr.com>
        <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
Date:   Mon, 27 Apr 2020 16:54:09 -0700
In-Reply-To: <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 27 Apr 2020 10:28:02 -0600")
Message-ID: <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6337C21E-88E2-11EA-BC4D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In the previous commit, Git learned 'hold_lock_file_for_update_mode' to
> allow the caller to specify the permission bits (prior to further
> adjustment by the umask and shared repository permissions) used when
> acquiring a temporary file.
>
> Use this in the commit-graph machinery for writing a non-split graph to
> acquire an opened temporary file with permissions read-only permissions
> to match the split behavior. (In the split case, Git uses
> git_mkstemp_mode' for each of the commit-graph layers with permission
> bits '0444').
>
> One can notice this discrepancy when moving a non-split graph to be part
> of a new chain. This causes a commit-graph chain where all layers have
> read-only permission bits, except for the base layer, which is writable
> for the current user.
>
> Resolve this discrepancy by using the new
> 'hold_lock_file_for_update_mode' and passing the desired permission
> bits.
>
> Doing so causes some test fallout in t5318 and t6600. In t5318, this
> occurs in tests that corrupt a commit-graph file by writing into it. For
> these, 'chmod u+w'-ing the file beforehand resolves the issue. The
> additional spot in 'corrupt_graph_verify' is necessary because of the
> extra 'git commit-graph write' beforehand (which *does* rewrite the
> commit-graph file). In t6600, this is caused by copying a read-only
> commit-graph file into place and then trying to replace it. For these,
> make these files writable.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c          |  3 ++-
>  t/t5318-commit-graph.sh | 11 ++++++++++-
>  t/t6600-test-reach.sh   |  2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)

This step, queued as 3a5c7d70 (commit-graph.c: write non-split
graphs as read-only, 2020-04-27), starts failing 5318#9 at least for
me.  Do we need to loosen umask while running this test to something
not more strict than 022 or something silly like that?

Here is what I'll use as a workaround for today's pushout.

commit f062d1c028bcc839f961e8904c38c476b9deeec3
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Apr 27 16:50:30 2020 -0700

    SQUASH??? force known umask if you are going to check the resulting mode bits

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fb0aae61c3..901eb3ecfb 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -12,6 +12,10 @@ test_expect_success 'setup full repo' '
 	test_oid_init
 '
 
+test_expect_success POSIXPERM 'tweak umask for modebit tests' '
+	umask 022
+'
+
 test_expect_success 'verify graph with no graph file' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify
