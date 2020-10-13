Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02680C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD96238E5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgJMNdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 09:33:41 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:56252 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgJMNdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 09:33:41 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 09:33:40 EDT
Received: from client3368.fritz.box (i5C747545.versanet.de [92.116.117.69])
        by dd36226.kasserver.com (Postfix) with ESMTPA id E84A13C00B5;
        Tue, 13 Oct 2020 15:26:46 +0200 (CEST)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
Subject: [PATCH] git-gui blame: prevent tool tips from sticking around after Command-Tab
Date:   Tue, 13 Oct 2020 15:26:43 +0200
Message-Id: <20201013132643.3209-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.rc1.12.gf22076828a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mac, tooltips are not automatically removed when a window loses
focus. Furthermore, mouse-move events are only dispatched to the active
window, which means that if we Command-tab to another application while
a tool tip is showing, the tool tip will stay there forever (in front of
other applications). So we must hide it manually when we lose focus.

I'm doing this unconditionally here (i.e. without if {[is_MacOSX]}); it
shouldn't hurt on other platforms, even though they don't seem to have
this problem.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 lib/blame.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 62ec083..8441e10 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -328,6 +328,7 @@ constructor new {i_commit i_path i_jump} {
 		bind $i <Any-Motion>  [cb _show_tooltip $i @%x,%y]
 		bind $i <Any-Enter>   [cb _hide_tooltip]
 		bind $i <Any-Leave>   [cb _hide_tooltip]
+		bind $i <Deactivate>  [cb _hide_tooltip]
 		bind_button3 $i "
 			[cb _hide_tooltip]
 			set cursorX %x
-- 
2.29.0.rc1.12.gf22076828a

