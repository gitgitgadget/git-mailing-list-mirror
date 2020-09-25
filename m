Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F7C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141CC21D7F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VmPSvk4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgIYGJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:09:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51314 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgIYGJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:09:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 123B6EE00F;
        Fri, 25 Sep 2020 01:59:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=pi6Cl+72yHvGTNpS3ULGgRv+g5A=; b=VmPSvk4z2Plnzt5Ar/c9
        nrWtZ/MZyay2m2STijRJSwbAk48rSSQY7lDh/KEoIEba7Pq79HXDrRp2PktWJXVx
        EeHSI/KtXgkE2intg7+shhRCg5w8ajXtLQZJ+9diVS62OSAQ/r6h/qlueNNPmOHb
        YYWRWgjrPWBoMmOJbU0Z47o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-transfer-encoding; q=dns;
         s=sasl; b=WmwdIaDQe5G39vKtizbx1DPM9QACcw7Jp30yh5Ot2/MP21U6408rq
        1DZy5run+z3wnPL2R/jseDvQu6jtBnMWjUNkwKF8zoI6DTQ4yc7lITFSTDoGPode
        OhaYDAJlWgFTVApdsLns3celIXJq0WPKDB9NOImmeitCCDB+4MH6EI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BF05EE00E;
        Fri, 25 Sep 2020 01:59:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55A82EE00C;
        Fri, 25 Sep 2020 01:59:56 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] Clean-up around get_x_ish() 
Date:   Thu, 24 Sep 2020 22:59:50 -0700
Message-Id: <20200925055954.1111389-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-718-gd8d5e3da39
MIME-Version: 1.0
X-Pobox-Relay-ID: 566C7A92-FEF4-11EA-9096-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is to clean some code I noticed while auditing the use of
get_committish() and get_treeish() API functions.

The main topic is to tighten error checking of "blame --ignore-rev"
and "blame --ignore-revs-list" arguments, which were not checked all
that much.  We make sure the ignore revs are committish objects, and
also peel tags pointing at commits down to commits before using them.
The breakage in the original is demonstrated by the tests added and/or
tweaked in the second patch.

The last two patches are icing on the cake.

Junio C Hamano (4):
  t8013: minimum preparatory clean-up
  blame: validate and peel the object names on the ignore list
  t1506: rev-parse A..B and A...B
  sequencer: stop abbreviating stopped-sha file

 builtin/blame.c                | 27 +++++++++++++--
 oidset.c                       |  9 ++++-
 oidset.h                       |  9 +++++
 sequencer.c                    | 11 +++---
 t/t1506-rev-parse-diagnosis.sh | 18 ++++++++++
 t/t8013-blame-ignore-revs.sh   | 61 ++++++++++++++++++++++------------
 6 files changed, 105 insertions(+), 30 deletions(-)

--=20
2.28.0-718-gd8d5e3da39

