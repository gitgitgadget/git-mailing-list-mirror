Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EE21FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbdJ3RK3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:10:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:49876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbdJ3RK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:10:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfjlS-1dOcVG2dg2-00pInk; Mon, 30
 Oct 2017 18:10:24 +0100
Date:   Mon, 30 Oct 2017 18:10:23 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] mingw: add experimental feature to redirect standard
 handles
In-Reply-To: <cover.1509382976.git.johannes.schindelin@gmx.de>
Message-ID: <804f26293de8f7cf805711313e376a513011a048.1509382976.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zoVmRjnorqFYPqXiEdNnfhfnIWhOyYavgXKaeAVvGvNLoh87iB5
 MfQxa8Pg6YlrZQ1opIC3N0F13/hdf8f/zkkQPr4k1HsOMW4cXY6XTFsWNIWzGKq3OHU+k2T
 8vU0b1LaUt2nbH7BqNYNyky4XhqpRSrb+WM/e42jMVn6hUNz1Zz7lopgqUuO1bZ38lZ3GXH
 /6BS/PpD8hk8MUC9jE+GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w29AB/7QqE0=:PSpfIlXlJE6Ka+B3BkHb2e
 NLrvFC70U37GOKvbDwrWZkEZJCvzI8hJfe/LZDEEMJMcHrxuYIKoeZ7LW4vxaSMB1cK9YXWwS
 rbAPlcyfMR1zZJdNGSAhqp8Lxg22w5HPam6TFOXGhI+CFx4bgkv8nvQurl0Ksy+d24C1SgCMe
 W6I/0d/chov1eHx/i3FQmNL6ooECyJZWd1URsanyxoS3vcaB1bSUyYtyHy2uUIYGmFz0U94BT
 KuDxyW++lpaeadGYONLKpzdO4CBy85v5rbaQXXVYobkRlsHckebDqdMOJMCKtj2K1OcWDCbUs
 PdFsSc+bM0HvU8AQfQzF4DDHbSI/HIZxgYEFQh2elsWOJndKs20eg1wcvkyvfIiwA9l3XNYMm
 X5DjrKrG+cqZKzfNLWoCtZ4ybzFMLNRhwlqCS2n9sfN47mNknSZXIOOI1psxuVTv7MA+3TL/N
 mbZEiKL5iM2nE1nbKbhabLe/6uMh541ilgXm/kD3qDZA6OUZiOcw/FYzSXWH9gsr1Stbp33AA
 WtBcXl0j9DSDYQoxlodbgzZo4frbedEc6d5jlHJlkW+0PmWxh/xvtq/PU9woLx5umFTrZfO9V
 zc21OEr04Nj7COLolqjpf0Rm8LuE7LJIumXsXXl70l4WNj1emVFs3kxSqwdWUZ0TREY+2j5VY
 /XaJ+5M5uTUM7sHsQNdNsOyBabd5kQkm0CUVJxq3gX/Bm5L4bmy41edE2cpDHEShdc0CUWJBj
 W7Tt/qDaBe2FyMGG5iav8ZcpdRGGBnedqniCJWCV6sCbkX1UkdDfWght5JKZ1INZbt2EEEqLF
 pz4CO8pRG7YZZ6Tf9TvgKD5nnqwkbnTN2t4pOS0n8SFE9Uy4kldtyYixeNqcn1bvnlr4F7J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, file handles need to be marked inheritable when they need to
be used as standard input/output/error handles for a newly spawned
process. The problem with that, of course, is that the "inheritable" flag
is global and therefore can wreak havoc with highly multi-threaded
applications: other spawned processes will *also* inherit those file
handles, despite having *other* input/output/error handles, and never
close the former handles because they do not know about them.

Let's introduce a set of environment variables (GIT_REDIRECT_STDIN and
friends) that point to files, or even better, named pipes and that are
used by the spawned Git process. This helps work around above-mentioned
issue: those named pipes will be opened in a non-inheritable way upon
startup, and no handles are passed around.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh |  6 ++++++
 2 files changed, 49 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8b6fa0db446..6c6c7795a70 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2139,6 +2139,47 @@ static char *wcstoutfdup_startup(char *buffer, const wchar_t *wcs, size_t len)
 	return memcpy(malloc_startup(len), buffer, len);
 }
 
+static void maybe_redirect_std_handle(const wchar_t *key, DWORD std_id, int fd,
+				      DWORD desired_access, DWORD flags)
+{
+	DWORD create_flag = fd ? OPEN_ALWAYS : OPEN_EXISTING;
+	wchar_t buf[MAX_PATH];
+	DWORD max = ARRAY_SIZE(buf);
+	HANDLE handle;
+	DWORD ret = GetEnvironmentVariableW(key, buf, max);
+
+	if (!ret || ret >= max)
+		return;
+
+	/* make sure this does not leak into child processes */
+	SetEnvironmentVariableW(key, NULL);
+	if (!wcscmp(buf, L"off")) {
+		close(fd);
+		handle = GetStdHandle(std_id);
+		if (handle != INVALID_HANDLE_VALUE)
+			CloseHandle(handle);
+		return;
+	}
+	handle = CreateFileW(buf, desired_access, 0, NULL, create_flag,
+			     flags, NULL);
+	if (handle != INVALID_HANDLE_VALUE) {
+		int new_fd = _open_osfhandle((intptr_t)handle, O_BINARY);
+		SetStdHandle(std_id, handle);
+		dup2(new_fd, fd);
+		close(new_fd);
+	}
+}
+
+static void maybe_redirect_std_handles(void)
+{
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDIN", STD_INPUT_HANDLE, 0,
+				  GENERIC_READ, FILE_ATTRIBUTE_NORMAL);
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDOUT", STD_OUTPUT_HANDLE, 1,
+				  GENERIC_WRITE, FILE_ATTRIBUTE_NORMAL);
+	maybe_redirect_std_handle(L"GIT_REDIRECT_STDERR", STD_ERROR_HANDLE, 2,
+				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
+}
+
 void mingw_startup(void)
 {
 	int i, maxlen, argc;
@@ -2146,6 +2187,8 @@ void mingw_startup(void)
 	wchar_t **wenv, **wargv;
 	_startupinfo si;
 
+	maybe_redirect_std_handles();
+
 	/* get wide char arguments and environment */
 	si.newmode = 0;
 	if (__wgetmainargs(&argc, &wargv, &wenv, _CRT_glob, &si) < 0)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 86c1a51654f..0fd2fc45385 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -453,4 +453,10 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success MINGW 'redirect std handles' '
+	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
+	test .git = "$(cat output.txt)" &&
+	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)"
+'
+
 test_done
-- 
2.15.0.windows.1


