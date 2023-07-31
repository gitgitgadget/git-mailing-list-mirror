Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88EFC001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGaWsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaWsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:48:16 -0400
X-Greylist: delayed 216 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 15:48:15 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1791BCD
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:48:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E24771ACBB5;
        Mon, 31 Jul 2023 18:44:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=ZASdtdfWnsuv7F5J3DEoo0++jHCCrsdJYdmOD2o+J1k=; b=tMs6
        eC6qQlZHhRpM6fx2ScP4bkNRo+h8i8n0swz0467MIO3rK7KgvCR2fuMMWvg4HqYQ
        D/esSAEabuJgFGdqJOja1MJ1GRp/TCB7AuCN/oTAt4rvNTo5g9zpA4BIcO1THtxA
        lK0JTzWq0PdyGvgQfu17sZGr3hi7HB2bc9CDv8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB3CA1ACBB4;
        Mon, 31 Jul 2023 18:44:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5219A1ACBB3;
        Mon, 31 Jul 2023 18:44:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] unresolve removal
Date:   Mon, 31 Jul 2023 15:44:02 -0700
Message-ID: <20230731224409.4181277-1-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-478-gee48e70a82
MIME-Version: 1.0
X-Pobox-Relay-ID: C3CB2664-2FF3-11EE-A748-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a culmination of various draft patches I have sent
out recently and have queued in two topics near the tip of 'seen'.

The primary objective is to allow undoing conflict resolution that
was done via "git rm".  When a conflicted path is resolved with "git
add" (i.e. replace higher stage index entries with stage #0 entry),
"git checkout -m -- path" and "git update-index --unresolve path"
worked using the resolve-undo information stored in the index, but a
conflicted path that is resolved with "git rm" (i.e. remove higher
stage index, without adding any stage #0 entry for the path), these
two commands did not work at all, or did not function correctly.


Junio C Hamano (7):
  update-index: do not read HEAD and MERGE_HEAD unconditionally
  resolve-undo: allow resurrecting conflicted state that resolved to
    deletion
  update-index: use unmerge_index_entry() to support removal
  update-index: remove stale fallback code for "--unresolve"
  checkout/restore: refuse unmerging paths unless checking out of the
    index
  checkout/restore: add basic tests for --merge
  checkout: allow "checkout -m path" to unmerge removed paths

 Documentation/git-checkout.txt |   9 ++-
 Documentation/git-restore.txt  |   4 ++
 builtin/checkout.c             |  15 +++--
 builtin/update-index.c         |  98 ++++----------------------------
 rerere.c                       |   2 +-
 resolve-undo.c                 | 101 ++++++++++++---------------------
 resolve-undo.h                 |   5 +-
 t/t2030-unresolve-info.sh      |  45 +++++++++++++--
 t/t2070-restore.sh             |  71 ++++++++++++++++++++++-
 t/t7201-co.sh                  |  47 +++++++++++++++
 10 files changed, 230 insertions(+), 167 deletions(-)

--=20
2.41.0-478-gee48e70a82

