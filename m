Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82F120966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdDBTHZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:07:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:55762 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdDBTHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:07:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUI8w-1cUrxT02cc-00R1HO; Sun, 02
 Apr 2017 21:07:21 +0200
Date:   Sun, 2 Apr 2017 21:07:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] Use uintmax_t for timestamps
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <129b286d19fc47cf44a1517be11fe35b543495a0.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6FsYPF5282+7JFB0gU+Ps15659ttoplc7/tiDgEoFJIyL9BpHtW
 X6eckZHCBLhyaAc0VVE5AEME4fWV19nbFEranUCSAqmOuFtMQf/Fzc5jluPQ7OcoBL2PixQ
 JSJSfDg03ry34rEWVMQ/8Uoj3MUE0LZXAvBXg81pxujOeeTgQkzk6LJ+DL4Eg7YHW2mU/wI
 CUsFlFaUEz57v/qWe/8IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsjgLmAFp7k=:cXQ1Xz+2WV/hrQFKSPwSJU
 eorUQAtT5hJRxIywWB1dXj7AC3Xia3tOcEBMKj5pJ4Wm+pE5n9/PRD41HYX3o8bSpIa345AR7
 HPO15wUVXkf3pIBDo3gdc+sGxiv2w5YD3u21nVE+PMtzBvU7Gv0XAIFvAsfkvcweqi60F/Obx
 jLir83Q/VPkF8zc1+WQwkCF70fJN0Y75sQloJB5gmYZ0JaQRYGl3NsWV1gitmclfc9ZjNYTZI
 L1Erkqq/PW/Pkxi55jWtDVvRx6EiTzuyldgpe6IapokCr/iDfFrwVVGfo79LynnELH+XbkPmh
 Zn3JgDZroX/nkfYKYKV7mfQN7DCvLswSH6CR+zphTmbN+g+ZmIf2Bgk65tEYZP1Vs2ILZabLM
 7OSxMd9UTqPBNBRlj4XZ2jD0LqEuxxmS3Xp3/cyAZm6mU+g7RyF9rbC6opgsFGlam31hZENNE
 phuR6v2fHthKmryP8vs/xmX7ebsCaHoG6YEGEdaP0T44u5gimS6Qm0qCjtSgCK9BbFfEGUbVo
 EERtSzON2slsQ/VpSy9bQAZOV+y51uc1s/y208VtzTDcQDzLyYnclc2CbREq19F+W1lfzcVM7
 cHd3THsihSDeRjd3w8hSQPd5MG1b/7smTlM1GJ5a+hxanOEAxDDMbSH6S48bps1QJqbZSl/Gx
 FiV40bTnkpb1ges7UUXnH+Lrufdue78HiVfFX1ZvfzgIrBm9UfuIjrTbuP4pK/kgxk17ymg7l
 SKXPPmYp7lQA4UJVlP29GiPrnH2UhBOCW3yXin6TuQQ4n76rn7/1Eq8pldB6vQbFR47T2RpSn
 I1SXae6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we used `unsigned long` for timestamps. This was only a good
choice on Linux, where we know implicitly that `unsigned long` is what is
used for `time_t`.

However, we want to use a different data type for timestamps for two
reasons:

- there is nothing that says that `unsigned long` should be the same data
  type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
  `unsigned long` is 32-bit but `time_t` is 64-bit.

- even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
  32-bit, we *want* to be able to encode timestamps in Git that are
  currently absurdly far in the future, *even if* the system library is
  not able to format those timestamps into date strings.

So let's just switch to the maximal integer type available, which should
be at least 64-bit for all practical purposes these days. It certainly
cannot be worse than `unsigned long`, so...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 72c12173a14..c678ca94b8f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,10 +319,14 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
-typedef unsigned long timestamp_t;
-#define PRItime "lu"
-#define parse_timestamp strtoul
+typedef uintmax_t timestamp_t;
+#define PRItime PRIuMAX
+#define parse_timestamp strtoumax
+#ifdef ULLONG_MAX
+#define TIME_MAX ULLONG_MAX
+#else
 #define TIME_MAX ULONG_MAX
+#endif
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
-- 
2.12.2.windows.1
