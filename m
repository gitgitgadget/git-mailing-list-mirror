Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6CC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5D12098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eSro/Bpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIHUwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:52:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57051 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIHUw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6CF827E2;
        Tue,  8 Sep 2020 16:52:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=PxLRZPavLs+tiQatgxEJBA2dw
        iY=; b=eSro/BpauYfhuN1CVEWV3GjRI7D1eOlc/IR3X05HxzZWoSNS7EMTu9eRz
        7/q0KRkTXPi/QqYmb9iQAFcVe8FgTO4UblVIeypokem2RprYIE6M7zASKK/hen0D
        ilst+Y1gadHEnPwFqJFrcUc2lyEGhYh76vYlSbaMoBG2o02ENQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=SDR64eZSqSFlhHLI4H6
        EvN7acVIrz/GqzPQA/QaoUBuir2Fzx21OW/SMkFvd1TLz5+AbVegdqN3Kia/7vcT
        t091LVup+NEDERE+Cu6WcyFMycisUgDL7ZcKft3pCvb8raz58SdqapPpA/2EUh14
        3rOoAksESPqmP2S7gkF0GBXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F7E827E1;
        Tue,  8 Sep 2020 16:52:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA5A4827E0;
        Tue,  8 Sep 2020 16:52:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] quote_path() clean-ups
Date:   Tue,  8 Sep 2020 13:52:18 -0700
Message-Id: <20200908205224.4126551-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-539-g66371d8995
In-Reply-To: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 32D28A18-F215-11EA-B1B5-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, this is an alternative approach to tackle the same issue
<xmqq4ko8yxp9.fsf@gitster.c.googlers.com> tried to address.  It
ended up to be more involved than I would have liked, but it was
primarily because it needed some function signature changes.
=20
The overall structure of the series is:

 (1) rename quote_path_relative() to quote_path().

 (2) allow quote_path() to take a flags parameter and update all the
     callers to pass 0 (all bits false)

 (3) move the "always quote a path with SP in it, even if there is
     no byte that needs quoting" logic out of wt-status.c that is
     used to show "git status --short" for tracked paths to
     quote_path() and give it the QUOTE_PATH_QUOTE_SP bit in the
     flags parameter.

 (4) using QUOTE_PATH_QUOTE_SP bit, apply the "always quote a path
     with SP" to "git status --short" output for untracked, ignored
     and unmerged paths.

Patches (5) and (6) are not strictly necessary.  They are what I
found while reading the existing code and thought it might, or might
not, be worth cleaning up and couldn't decide ;-)

Junio C Hamano (6):
  quote_path: rename quote_path_relative() to quote_path()
  quote_path: give flags parameter to quote_path()
  quote_path: optionally allow quoting a path with SP in it
  wt-status: consistently quote paths in "status --short" output
  quote: rename misnamed sq_lookup[] to cq_lookup[]
  quote: turn 'nodq' parameter into a set of flags

 builtin/clean.c   | 22 +++++++++++-----------
 builtin/grep.c    |  2 +-
 diff.c            |  8 ++++----
 quote.c           | 39 ++++++++++++++++++++++++---------------
 quote.h           | 11 +++++++----
 t/t7508-status.sh | 21 +++++++++++++++++++++
 wt-status.c       | 37 +++++++++++++------------------------
 7 files changed, 81 insertions(+), 59 deletions(-)

--=20
2.28.0-539-g66371d8995

