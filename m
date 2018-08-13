Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0121F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHMVqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:46:22 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:43184 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeHMVqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:46:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41q4qZ3KG1z5tlD;
        Mon, 13 Aug 2018 21:02:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 25A9A1C9A;
        Mon, 13 Aug 2018 21:02:50 +0200 (CEST)
Subject: [PATCH] mingw: enable atomic O_APPEND
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.17.git.gitgitgadget@gmail.com>
 <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
 <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
Date:   Mon, 13 Aug 2018 21:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Windows CRT implements O_APPEND "manually": on write() calls, the
file pointer is set to EOF before the data is written. Clearly, this is
not atomic. And in fact, this is the root cause of failures observed in
t5552-skipping-fetch-negotiator.sh and t5503-tagfollow.sh, where
different processes write to the same trace file simultanously; it also
occurred in t5400-send-pack.sh, but there it was worked around in
71406ed4d6 ("t5400: avoid concurrent writes into a trace file",
2017-05-18).

Fortunately, Windows does support atomic O_APPEND semantics using the
file access mode FILE_APPEND_DATA. Provide an implementation that does.

This implementation is minimal in such a way that it only implements
the open modes that are actually used in the Git code base. Emulation
for other modes can be added as necessary later. To become aware of
the necessity early, the unusal error ENOSYS is reported if an
unsupported mode is encountered.

Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6ded1c859f..858ca14a57 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -341,12 +341,44 @@ int mingw_mkdir(const char *path, int mode)
 	return ret;
 }
 
+static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
+{
+	HANDLE handle;
+	int fd;
+	DWORD create = (oflags & O_CREAT) ? OPEN_ALWAYS : OPEN_EXISTING;
+
+	/* only these flags are supported */
+	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
+		return errno = ENOSYS, -1;
+
+	/*
+	 * FILE_SHARE_WRITE is required to permit child processes
+	 * to append to the file.
+	 */
+	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
+			FILE_SHARE_WRITE | FILE_SHARE_READ,
+			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
+	if (handle == INVALID_HANDLE_VALUE)
+		return errno = err_win_to_posix(GetLastError()), -1;
+	/*
+	 * No O_APPEND here, because the CRT uses it only to reset the
+	 * file pointer to EOF on write(); but that is not necessary
+	 * for a file created with FILE_APPEND_DATA.
+	 */
+	fd = _open_osfhandle((intptr_t)handle, O_BINARY);
+	if (fd < 0)
+		CloseHandle(handle);
+	return fd;
+}
+
 int mingw_open (const char *filename, int oflags, ...)
 {
+	typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, ...);
 	va_list args;
 	unsigned mode;
 	int fd;
 	wchar_t wfilename[MAX_PATH];
+	open_fn_t open_fn;
 
 	va_start(args, oflags);
 	mode = va_arg(args, int);
@@ -355,9 +387,14 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (filename && !strcmp(filename, "/dev/null"))
 		filename = "nul";
 
+	if (oflags & O_APPEND)
+		open_fn = mingw_open_append;
+	else
+		open_fn = _wopen;
+
 	if (xutftowcs_path(wfilename, filename) < 0)
 		return -1;
-	fd = _wopen(wfilename, oflags, mode);
+	fd = open_fn(wfilename, oflags, mode);
 
 	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
 		DWORD attrs = GetFileAttributesW(wfilename);
@@ -375,7 +412,7 @@ int mingw_open (const char *filename, int oflags, ...)
 		 * CREATE_ALWAYS flag of CreateFile()).
 		 */
 		if (fd < 0 && errno == EACCES)
-			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);
+			fd = open_fn(wfilename, oflags & ~O_CREAT, mode);
 		if (fd >= 0 && set_hidden_flag(wfilename, 1))
 			warning("could not mark '%s' as hidden.", filename);
 	}
-- 
2.18.0.rc0.112.g5f42c6ebd3
