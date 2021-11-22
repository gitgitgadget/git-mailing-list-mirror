Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87BC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKVWcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:32:46 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:39143 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhKVWcp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Nov 2021 17:32:45 -0500
Received: from MTA-06-4.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 6F6DA80BCE
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:29:38 -0500 (EST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id 3A84318000A4;
        Mon, 22 Nov 2021 17:29:37 -0500 (EST)
Received: from hal-station.. (unknown [10.20.151.201])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 61253180009F;
        Mon, 22 Nov 2021 17:29:36 -0500 (EST)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v3] ci: add a job for PCRE2
Date:   Mon, 22 Nov 2021 17:29:33 -0500
Message-Id: <20211122222933.11872-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.34.0
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

v3: make the changes suggested by Ævar.
---
 .github/workflows/main.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e807..e30cf6155e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -319,3 +319,36 @@ jobs:
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
+        unicode: ['--enable-unicode', '--disable-unicode']
+        version:
+        - 'pcre2-10.20'
+        - 'pcre2-10.31'
+        - 'pcre2-10.34'
+        - 'pcre2-10.36'
+        - '`git tag -l --sort=-version:refname | head -n 1`'
+    env:
+      jobname: linux-gcc-default
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - run: echo "VER=${{matrix.version}}" >>$GITHUB_ENV
+    - uses: actions/checkout@v2
+      with:
+        repository: 'PhilipHazel/pcre2'
+        path: 'compat/pcre2-repo'
+        ref: ${{env.VER}}
+    - run: ci/install-dependencies.sh
+    - run: |
+        cd compat/pcre2-repo &&
+        ./autogen.sh &&
+        ./configure ${{matrix.jit}} ${{matrix.unicode}} --prefix="$PWD/inst" &&
+        make install
+    - run: make USE_LIBPCRE=Y LIBPCREDIR="$PWD/compat/pcre2-repo/inst"
+    - run: cd t && make *{grep,log,pickaxe}*
-- 
2.34.0

