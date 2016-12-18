Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3011FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 15:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755277AbcLRP0H (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 10:26:07 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:30985 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753631AbcLRP0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 10:26:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3thSYm1YQCz5tlT;
        Sun, 18 Dec 2016 16:26:04 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E677C2222;
        Sun, 18 Dec 2016 16:26:02 +0100 (CET)
Subject: [PATCH] winansi_isatty(): fix when Git is used from CMD
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
 <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
 <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
 <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
Date:   Sun, 18 Dec 2016 16:26:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code in winansi.c emulates ANSI escape sequences when Git is
connected to the "real" windows console, CMD.exe. The details are
outline in eac14f8909d9 (Win32: Thread-safe windows console output,
2012-01-14). Essentially, it plugs a pipe between C code and the actual
console output handle.

This commit also added an override for isatty(), but it was made
unnecessary by fcd428f4a952 (Win32: fix broken pipe detection,
2012-03-01).

The new isatty() override implemented by cbb3f3c9b197 (mingw: intercept
isatty() to handle /dev/null as Git expects it, 2016-12-11) does not
take into account that _get_osfhandle() returns the handle visible by
the C code, which is the pipe. But it actually wants to investigate the
properties of the handle that is actually connected to the outside
world. Fortunately, there is already winansi_get_osfhandle(), which
returns exactly this handle. Use it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
I was able to test the idea earlier than anticipated and it does work
for me.

 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cb725fb02f..ba360be69b 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -586,7 +586,7 @@ int winansi_isatty(int fd)
 		 *
 		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
 		 */
-		HANDLE handle = (HANDLE)_get_osfhandle(fd);
+		HANDLE handle = winansi_get_osfhandle(fd);
 		if (fd == STDIN_FILENO) {
 			DWORD dummy;
 
-- 
2.11.0.79.gf6b77ca

