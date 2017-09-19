Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2392047F
	for <e@80x24.org>; Tue, 19 Sep 2017 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdISPY4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 11:24:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:64028 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdISPYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 11:24:54 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbxQO-1dV7yV0uJg-00jM8g; Tue, 19
 Sep 2017 17:24:47 +0200
Date:   Tue, 19 Sep 2017 17:24:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Win32: simplify loading of DLL functions
Message-ID: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zOtuiyJOAD03WmKvjbNCpA7aNsaSrx8zxNXkwBDodLCtLidGMWS
 6xvFkSfsqF+vDPlOuUCI04gdAXRyi0C72KOsgvDxbjjnInctT6J3zwPOblcOHqBeUAd8JKi
 pmdKLTxe4kcrNgpZQMzCI5ObU0v6Zb9Z0Eb476AP+/HS1jBatcrhyZOr1sADbWa8OCze4Y9
 a7sBGgVgphcMnKJXS88Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j7C/4V6285Y=:15kP3eLThOeFv0ZIYyVMiG
 6l7hX/q7/HF4/MTXg35pWjgb4TTw7kSbv9dvVO5KI+F3/eeCxJK1lXbv/Gb8QqFmfmdnfPd8n
 MIpRj0jVSH9bH62KqtvSX168MBCd1GYqg9+7ZotnuaPYr4hJredginZEfFa80W18l6/8ltxig
 JxjrIkppmsujZvALMtmJLod+f6rVC9eHSDRecmrFCIE9EK1Ocwk/XiydpNktOidjx/Z4movXp
 Zxv/oJjsuS21eAeos7ZqcyZqOnGx3M8hoOv9Gk2eOz1RRLM/VgyH+WTs3X4WKVRur0L4202in
 SJ0jgZDYtaQYdKhanOWsdY6l+C8h8AGFMGh/ODOHEgABIZHm+4NNskEr4O941zxWBI1t7XdSH
 06uQz7c6XoeMHnj7lsHu/A2V9RKk2w1V0yNBxNQ311uFaTJwsGbwLDmAyMgcs+5TCiRJ6rDVu
 jEwc5VxGp3fzi7X1TS4YqF/AvdmgHZRW4Km/8n4W0MFP4rfw71a98ejHBItRBvTtC2AD91D5s
 B5hdR3IW4V/KqJEY/aA+1M+yufTe/cUJagrxZkVA4Zpg6p8iYZNN7dq1BGCEL2rm6xQpkZxpe
 XWICVp7jW/qNKL7JJ2ZjLeiWEIKLTdJN1iJ7J2ex0qvDtqbTRST4M825f4G4Bfu7vry0d5puy
 +fo9tF/k3MuHI5AJogwbTSKRAVR7a57nLM6fEF2d9pdLVecmqCEeNhoyiqHvNkxyGg/33NxFQ
 2Ae25L7+1MbOQ5pdosUTTGKE5fDaee+c8na28dJ1emzw3aqwmKNnTPB9G4+5oG0s/pMzTgWA0
 g9hwhqNogJu5sSjOhi2ZXDpkWIyxV2193/loNiPDQitcO9cpZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dynamic loading of DLL functions is duplicated in several places in Git
for Windows' source code.

This patch adds a pair of macros to simplify the process: the
DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
...<function-parameter-types>...) macro to be used at the beginning of a
code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
using the declared function. The return value of the INIT_PROC_ADDR()
call has to be checked; If it is NULL, the function was not found in the
specified DLL.

Example:

        DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
                          LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);

        if (!INIT_PROC_ADDR(CreateHardLinkW))
                return error("Could not find CreateHardLinkW() function";

	if (!CreateHardLinkW(source, target, NULL))
		return error("could not create hardlink from %S to %S",
			     source, target);
	return 0;

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	So far, there are no users (except in Git for Windows). Ben
	promised to make use of it in his fsmonitor patch series.

Published-As: https://github.com/dscho/git/releases/tag/lazyload-v1
Fetch-It-Via: git fetch https://github.com/dscho/git lazyload-v1
 compat/win32/lazyload.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 compat/win32/lazyload.h

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
new file mode 100644
index 00000000000..91c10dad2fb
--- /dev/null
+++ b/compat/win32/lazyload.h
@@ -0,0 +1,44 @@
+#ifndef LAZYLOAD_H
+#define LAZYLOAD_H
+
+/* simplify loading of DLL functions */
+
+struct proc_addr {
+	const char *const dll;
+	const char *const function;
+	FARPROC pfunction;
+	unsigned initialized : 1;
+};
+
+/* Declares a function to be loaded dynamically from a DLL. */
+#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
+	static struct proc_addr proc_addr_##function = \
+	{ #dll, #function, NULL, 0 }; \
+	static rettype (WINAPI *function)(__VA_ARGS__)
+
+/*
+ * Loads a function from a DLL (once-only).
+ * Returns non-NULL function pointer on success.
+ * Returns NULL + errno == ENOSYS on failure.
+ */
+#define INIT_PROC_ADDR(function) \
+	(function = get_proc_addr(&proc_addr_##function))
+
+static inline void *get_proc_addr(struct proc_addr *proc)
+{
+	/* only do this once */
+	if (!proc->initialized) {
+		HANDLE hnd;
+		proc->initialized = 1;
+		hnd = LoadLibraryExA(proc->dll, NULL,
+				     LOAD_LIBRARY_SEARCH_SYSTEM32);
+		if (hnd)
+			proc->pfunction = GetProcAddress(hnd, proc->function);
+	}
+	/* set ENOSYS if DLL or function was not found */
+	if (!proc->pfunction)
+		errno = ENOSYS;
+	return proc->pfunction;
+}
+
+#endif

base-commit: 9ddaf86b06a8078420f59aec8cab6daa93cf1a91
-- 
2.14.1.windows.1.1020.g03faabc8bc8.dirty
