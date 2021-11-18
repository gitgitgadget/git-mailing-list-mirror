Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB7C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8181C61269
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbhKRJ5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:57:45 -0500
Received: from MTA-15-4.privateemail.com ([198.54.127.111]:51242 "EHLO
        MTA-15-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245294AbhKRJ4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 04:56:38 -0500
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id A034A18000AE;
        Thu, 18 Nov 2021 04:53:36 -0500 (EST)
Received: from hal-station.. (unknown [10.20.151.240])
        by mta-15.privateemail.com (Postfix) with ESMTPA id A58241800195;
        Thu, 18 Nov 2021 04:53:35 -0500 (EST)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] ci: add a job for PCRE2
Date:   Thu, 18 Nov 2021 04:53:31 -0500
Message-Id: <20211118095331.282468-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211118084143.279174-2-someguy@effective-light.com>
References: <20211118084143.279174-2-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since, git aspires to support many PCRE2 versions, it is only sensible to
test changes to git against versions of PCRE2 that are deemed to be
notable, to ensure those changes to git don't cause regressions when using
the aforementioned PCRE2 versions. This is underscored by the fact that,
commit ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
and UTF-8 data, 2021-10-15) was able to make it's way to master while
causing an otherwise easy to catch regression when an older version of
PCRE2 is used. So, to address this issue, add a job for PCRE2 to build all
of the notable versions, compile all of them against git and only run the
tests that can possibly be impacted by PCRE2.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v2: use 'ref' instead of doing a manual checkout and add jobname to
    the env.
---
 .github/workflows/main.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e807..6d8906139d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -319,3 +319,31 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
+  pcre2:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    strategy:
+      fail-fast: false
+      matrix:
+        jit: ['--enable-jit', '--disable-jit']
+        utf: ['--enable-utf', '--disable-utf']
+        version: [31, 34, 36, 39]
+    env:
+      jobname: linux-gcc-default
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - uses: actions/checkout@v2
+      with:
+        repository: 'PhilipHazel/pcre2'
+        path: 'compat/pcre2-repo'
+        ref: pcre2-10.${{matrix.version}}
+    - run: ci/install-dependencies.sh
+    - run: cd compat/pcre2-repo
+    - run: ./autogen.sh
+    - run: ./configure ${{matrix.jit}} ${{matrix.utf}} --prefix="$PWD/inst"
+    - run: make
+    - run: sudo make install
+    - run: cd ../..
+    - run: make USE_LIBPCRE=Y CFLAGS=-O3 LIBPCREDIR="$PWD/compat/pcre2-repo/inst"
+    - run: cd t && make *{grep,log,pickaxe}*
-- 
2.34.0

