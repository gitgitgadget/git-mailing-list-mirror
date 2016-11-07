Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892152022A
	for <e@80x24.org>; Mon,  7 Nov 2016 19:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933761AbcKGS7l (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 13:59:41 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:52328 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbcKGS6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 13:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=V56GAJ3sIHjvOg
        LDmOaHEDd4/S2hzzITde5wRDB/xYw=; b=kxUDv5PwNPMogI5n2Pcq3JTyseBHIs
        3eD9cbxYcKrttUj1v6qKlYnLUWTbz1vjYQa6T8HwDv62/PdDqwEb/O/Qwa6bXEeg
        TU8tTLJpyCEcomGqMf/0kWkBkO0Ftz3x+1ElhjUCrxMMob2jYnhVwgFSJSEHIyy4
        OSl7DrOWr9SOY=
Received: (qmail 11354 invoked from network); 7 Nov 2016 19:57:42 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 7 Nov 2016 19:57:42 +0100
Subject: [PATCH 1/3] gitk: turn off undo manager in the text widget
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
Date:   Mon, 7 Nov 2016 19:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From e965e1deb9747bbc2b40dc2de95afb65aee9f7fd Mon Sep 17 00:00:00 2001
From: Markus Hitter <mah@jump-ing.de>
Date: Sun, 6 Nov 2016 20:38:03 +0100
Subject: [PATCH 1/3] gitk: turn off undo manager in the text widget

The diff text widget is read-only, so there's zero point in
building an undo stack. This change reduces memory consumption of
this widget by about 95%.

Memory usage of the whole program for viewing a reference commit
before; 579'692'744 bytes, after: 32'724'446 bytes.

Test procedure:

 - Choose a largish commit and check it out. In this case one with
   90'802 lines, 5'006'902 bytes.

 - Have a Tcl version with memory debugging enabled. This is,
   build one with --enable-symbols=mem passed to configure.

 - Instrument Gitk to regularly show a memory dump. E.g. by adding
   these code lines at the very bottom:

     proc memDump {} {
         catch {
             set output [memory info]
             puts $output
         }

         after 3000 memDump
     }

     memDump

 - Start Gitk, it'll load this largish commit into the diff text
   field automatically (because it's the current commit).

 - Wait until memory consumption levels out and note the numbers.

Note that the numbers reported by [memory info] are much smaller
than the ones reported in 'top' (1.75 GB vs. 105 MB in this case),
likely due to all the instrumentation coming with the debug
version of Tcl.

Signed-off-by: Markus Hitter <mah@jump-ing.de>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 805a1c7..8654e29 100755
--- a/gitk
+++ b/gitk
@@ -2403,7 +2403,7 @@ proc makewindow {} {
 
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
-	-state disabled -font textfont \
+	-state disabled -undo 0 -font textfont \
 	-yscrollcommand scrolltext -wrap none \
 	-xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
-- 
2.9.3

