Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06547C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 11:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbhKZLtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:49:46 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:33408 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351063AbhKZLrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 06:47:46 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 06:47:46 EST
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id qZWhm5FMyCcoVqZWhmUAfO; Fri, 26 Nov 2021 11:36:23 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=ebBDgIMH c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8
 a=MqGAGtWxLCuYLGaZFB8A:9 a=QEXdDO2ut3YA:10 a=siDj0t9eB8kA:10
 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 0/4] Fix LLP64 `(size_t)1` compatibility VS C4334 warnings
Date:   Fri, 26 Nov 2021 11:36:10 +0000
Message-Id: <20211126113614.709-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJwf0gQ/qX2+jzQALsKdeBQxpdunAFxo2jKLjGuKxw/LDJVxjNek8PR0xHKJKuopYXm2MwkWZxXmxw1keMfMBnNv10XwMN2mE9FHViTyv9xsKHgqunnc
 JvAPTw2ZVynkOBrsrBPCyK+O10zmp3lZRb60yVPJ2rtaXYhkHUy38tHRVL3CYzpxigQLV43WiYHe3MIFyL6Lic789h4BCSILilBVmqV1zBS+3rtOVBDN5NFI
 g4QeAgIKj1VUBQ7u//jnNhz2EnUTbbZlmjf+9t4PQdRA3xOr4v5Ah/d75wE9qjuu3AFopv6dGKLEsYu/jacfFA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Visual Studio MSVC compilation reports a number of C4334 "was 64-bit
shift intended" size mismatch warnings. In most of these cases a size_t
is ANDed (masked) with a bit shift of 1, or 1U. On LLP64 systems the unity
value is 32 bits, while size_t is 64 bits. 

The fix is to upcast the unity value to size_t.   

The first patch has also been reported [1] by René Scharfe as an extra patch
to the rs/mergesort series. That patch had been on maint.

The middle two patches are similar changes, though [2/4] is a uintptr_t.

The final patch is applied to object-file.c, which has recently been
renamed from sha1-file.c, so couldn't be applied to the earlier maint
branch.[2]

These fixes clear all the current C4334 warnings.

The patches can be squashed together if required.

[1] https://lore.kernel.org/git/7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email/
[2] https://lore.kernel.org/git/3e7af5d3-58fd-3a92-371f-3fa26cfe05a0@iee.email/

Philip Oakley (4):
  mergesort.c: LLP64 compatibility, upcast unity for left shift
  repack.c: LLP64 compatibility, upcast unity for left shift
  diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
  object-file.c: LLP64 compatibility, upcast unity for left shift

 builtin/repack.c | 2 +-
 diffcore-delta.c | 6 +++---
 mergesort.c      | 2 +-
 object-file.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.0.rc1.windows.1.4.ga126985b17

