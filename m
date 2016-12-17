Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997B41FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 13:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbcLQN2n (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 08:28:43 -0500
Received: from p3plsmtpa12-08.prod.phx3.secureserver.net ([68.178.252.237]:44642
        "EHLO p3plsmtpa12-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752656AbcLQN2m (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Dec 2016 08:28:42 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Dec 2016 08:28:42 EST
Received: from wheezy.local ([82.181.81.240])
        by :SMTPAUTH: with SMTP
        id IEunc4LTDTStiIEuxcTrSO; Sat, 17 Dec 2016 06:20:53 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH] mingw: consider that UNICODE_STRING::Length counts bytes
Date:   Sat, 17 Dec 2016 15:20:31 +0200
Message-Id: <1481980831-18511-1-git-send-email-max@max630.net>
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
X-CMAE-Envelope: MS4wfP/I5eB1CtwESMTm74jcey8cvLNCgWTDJA1cb2eJasGed+i+amCQkoooYjc7TbYUMRnifVTdIMDjaksiLLXz/S+5M9ytvwbS4MYz9hAKKTpSkMq6Uuhx
 FaFp71gBmBlB5G7Ow9Nckxi7qm/TDKoBaxBXgQA0sHMYBgdXO4hRn07VUbxoZ7Wk22rw5wwUdEqarQ5hzkQxiWJV48CVohSTfKbj1bf9ighUKO3a9q5KXFFo
 TV5QcOKSn+iIs56RZapTDbGmlJdYgvznI7fhqKmQglk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UNICODE_STRING::Length field means size of buffer in bytes[1], despite of buffer
itself being array of wchar_t. Because of that terminating zero is placed twice
as far. Fix it.

[1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa380518.aspx

Signed-off-by: Max Kirillov <max@max630.net>
---
Access outside of buffer was very unlikely (for that user needed to redirect
standard fd to a file with path longer than ~250 symbols), it still did not
seem to do any harm, and otherwise it did not break because only substring is
checked, but it was still incorrect.
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3be60ce..6b4f736 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -553,7 +553,7 @@ static void detect_msys_tty(int fd)
 			buffer, sizeof(buffer) - 2, &result)))
 		return;
 	name = nameinfo->Name.Buffer;
-	name[nameinfo->Name.Length] = 0;
+	name[nameinfo->Name.Length / sizeof(*name)] = 0;
 
 	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
 	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
-- 
2.3.4.2801.g3d0809b

