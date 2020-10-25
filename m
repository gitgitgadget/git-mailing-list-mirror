Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD9C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C87621707
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 18:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417820AbgJYSE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 14:04:56 -0400
Received: from mail-gateway-shared11.cyon.net ([194.126.200.64]:34240 "EHLO
        mail-gateway-shared11.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1417816AbgJYSE4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Oct 2020 14:04:56 -0400
X-Greylist: delayed 749 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 14:04:55 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1kWkBm-0008G9-Af
        for git@vger.kernel.org; Sun, 25 Oct 2020 18:52:20 +0100
Received: from [10.20.10.230] (port=17546 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <bb@drbeat.li>)
        id 1kWkBl-000ljw-5Q; Sun, 25 Oct 2020 18:52:17 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id CD871180F18; Sun, 25 Oct 2020 18:52:16 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] gitk: macOS: ignore osascript errors
Date:   Sun, 25 Oct 2020 18:51:49 +0100
Message-Id: <20201025175149.11853-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.26.0.277.gb8618d28a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting gitk on a macOS 10.14.6 (Mojave) system fails with the error

    Error in startup script: 2020-10-25 17:16:44.568 osascript[36810:18758270]
    Error loading /Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support:
    dlopen(/Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support, 0x0106):
    code signature in (/Library/QuickTime/EyeTV MPEG Support.component/Contents/MacOS/EyeTV MPEG Support)
    not valid for use in process: mapping process is a platform binary, but mapped file is not
    [[this same message repeated dozens of times]]
        while executing
    "exec osascript -e [format {
            tell application "System Events"
                set frontmost of processes whose unix id is %d to true
            end te..."
        invoked from within
    "if {[tk windowingsystem] eq "aqua"} {
        exec osascript -e [format {
            tell application "System Events"
                set frontmost of processes ..."
        (file "./gitk" line 12265)

Ignore errors from the osascript invocation, especially because this macOS
version seems to correctly place the gitk window in the foreground.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..8551711 100755
--- a/gitk
+++ b/gitk
@@ -12290,11 +12290,11 @@ if {[catch {package require Tk 8.4} err]} {
 
 # on OSX bring the current Wish process window to front
 if {[tk windowingsystem] eq "aqua"} {
-    exec osascript -e [format {
+    catch { exec osascript -e [format {
         tell application "System Events"
             set frontmost of processes whose unix id is %d to true
         end tell
-    } [pid] ]
+    } [pid] ] }
 }
 
 # Unset GIT_TRACE var if set
-- 
2.28.0

