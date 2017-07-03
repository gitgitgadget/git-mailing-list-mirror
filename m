Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA383201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 14:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755545AbdGCOlz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 10:41:55 -0400
Received: from mout.web.de ([212.227.15.3]:50904 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753963AbdGCOly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 10:41:54 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoYJu-1duDMd32mA-00gaqu; Mon, 03
 Jul 2017 16:41:41 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] cygwin: Allow pushing to UNC paths
Date:   Mon,  3 Jul 2017 16:41:37 +0200
Message-Id: <20170703144137.27176-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <xmqqr2y0nk88.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2y0nk88.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Kohx/yni/5JLS/ByKznjcHmNMoaNMgqdAkVZkaA/lJOpMK7mgRp
 n/ylvr9wNJbhRxdbUtUK+Q7DCpsqNv1qsCMZGTv/dZoxksYbzECsdzZnQpqaZ4iiqK6iBfw
 LFgIr4jcTARci5Qb1smCiBFWf7/WrA9c8TDtJ0LVxxO3yxFQYz+XM/tNVdvB4zV35Px0n26
 7e1K31w+6Al8CLgulsEYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZvKAn10mIls=:P7185ix9spXq7k18hyVVDW
 B2MbHB7XheOrMsKV/M+4qnouyx7ne/9nsJJwlZSCwarblf6SmjQiWxekX4xPnMA7m6JaRtD6t
 DnMAxVJU1Q1FLJRF4Z3Sp4GHeGOO1xo9mMZfNRFppPcJ4B2thoUMUKqrCyZ/FQEhc6tp6dXtw
 UWw9YEB2H6DwEf4yAthWhj8mJZEf/OV/BjO47hP5uYi/8Dgrn4YshUoPEhscvXdD3Y3jyvvO4
 P0TLm22WIVm3KlBgZOTWr3sYygU9kOTKr3SAlnhgPpCGf6nZxH7KWJxhXofEqDlxUnix0FarK
 SoX7Mf+kMkJcFj7erMegZownrrm0Eun33zMhzCMixZAPly0jjZ4rXGAjo9AvQ2wHslHtbH9/w
 Vm3YrF69E6g3HLi8SHrC3/zCVSFbPvo5ozfqQmuCzXaNO+Jlm7ioL6eC2bG9b0Gr5OqXJwe65
 Zk3bU5yjGptAWTFODalGlirKBaJX9eNMLyUUNkWoungkUU6aLeevGjBEHLkpgv6gSNONb7CDn
 VwfN3bpzSYWaLQDdR2VvHc7/tBaD9tr+WrVmpvVRYsI4kxlIjaC2jGIAj/GJcUBpeppixhNMT
 UK6agSbS4UfPDDqw3fEjPpiSxj7VtrSVshxN31WDgU1Z4sWnwbxgPATK3k+laYcX/JDFfCG5b
 pPzd4YxwwJ4g4etESCum9xucJdsOOLCFDhL2RzxjArPaHQXlhE+PH7mWkDelN6In7aQRgTvgp
 6+Gp23sfnbkesmYnE2AUohy/VAw6WEffzP9AD7Ti+/HdZvXK+HSQPBvCRoKqtkpk25MgMowi2
 YO2o01E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

 cygwin can use an UNC path like //server/share/repo
 $ cd //server/share/dir
 $ mkdir test
 $ cd test
 $ git init --bare

 However, when we try to push from a local Git repository to this repo,
 there is a problem: Git converts the leading "//" into a single "/".

 As cygwin handles an UNC path so well, Git can support them better:
 - Introduce cygwin_offset_1st_component() which keeps the leading "//",
   similar to what Git for Windows does.
 - Move CYGWIN out of the POSIX in the tests for path normalization in t0060

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

I think I skip all the changing in setup.c and cygwin_access() for the
moment:
- It is not clear, what is a regression and what is an improvement
- It may be a problem that could be solved in cygwin itself
- I was able to push a an UNC path on a Windows server
  when the domain controller was reachable.


compat/cygwin.c       | 19 +++++++++++++++++++
 compat/cygwin.h       |  2 ++
 config.mak.uname      |  1 +
 git-compat-util.h     |  3 +++
 t/t0060-path-utils.sh |  2 ++
 5 files changed, 27 insertions(+)
 create mode 100644 compat/cygwin.c
 create mode 100644 compat/cygwin.h

diff --git a/compat/cygwin.c b/compat/cygwin.c
new file mode 100644
index 0000000..b9862d6
--- /dev/null
+++ b/compat/cygwin.c
@@ -0,0 +1,19 @@
+#include "../git-compat-util.h"
+#include "../cache.h"
+
+int cygwin_offset_1st_component(const char *path)
+{
+	const char *pos = path;
+	/* unc paths */
+	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+		/* skip server name */
+		pos = strchr(pos + 2, '/');
+		if (!pos)
+			return 0; /* Error: malformed unc path */
+
+		do {
+			pos++;
+		} while (*pos && pos[0] != '/');
+	}
+	return pos + is_dir_sep(*pos) - path;
+}
diff --git a/compat/cygwin.h b/compat/cygwin.h
new file mode 100644
index 0000000..8e52de4
--- /dev/null
+++ b/compat/cygwin.h
@@ -0,0 +1,2 @@
+int cygwin_offset_1st_component(const char *path);
+#define offset_1st_component cygwin_offset_1st_component
diff --git a/config.mak.uname b/config.mak.uname
index adfb90b..551e465 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -184,6 +184,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	COMPAT_OBJS += compat/cygwin.o
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 047172d..db9c22d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,6 +189,9 @@
 #include <sys/sysctl.h>
 #endif
 
+#if defined(__CYGWIN__)
+#include "compat/cygwin.h"
+#endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4..7ea2bb5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -70,6 +70,8 @@ ancestor() {
 case $(uname -s) in
 *MINGW*)
 	;;
+*CYGWIN*)
+	;;
 *)
 	test_set_prereq POSIX
 	;;
-- 
2.10.0

