Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0B2201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdCNQCU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 12:02:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38267 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751125AbdCNQCF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Mar 2017 12:02:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EA0D209F7;
        Tue, 14 Mar 2017 12:02:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 14 Mar 2017 12:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=n10l80/7ZhoxahUOg/y4Lnfpi2g
        =; b=Y+U9C/nkmsZleJr/QLklnk7C+bAxfvnj8zxuQYcBSsyqhNj1jtWOT8AxTD6
        Y2f2wpyzF1OhKlvyFbJNoGkmjwl4ce0owE9uZXp1TQywr3NvzjgROL0sLhikvRpz
        /3YCcpZRToftIEgcNaailbyyZNdUMyRAj1/CaCueJy/i/SBE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=n1
        0l80/7ZhoxahUOg/y4Lnfpi2g=; b=HV+Dmz/ufsMc8ltd6sYhch1pCMnuE8XPkk
        traGhUSmd7UnTdC0dDx2UAHKuNJ+nH/yG5a6CP+V/gO/CVB+YwiFM9mzFfMJ6J8p
        8DV8hNxH3d/DMtqjYr1PY90zsjwvm74D6a4EeCLdpSUBGk2DvMKSi7E3lAWL/Gtx
        HUbxe2inM=
X-ME-Sender: <xms:_BPIWDGGW5tAvheFETGhld9V3pfu8bizH-0VRw-eya-fkWvVZhBhPg>
X-Sasl-enc: eOQa5tFz1bboGno7gwaLSKyE04Kh921Pg+D4sxmIR5nb 1489507323
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECB752428D;
        Tue, 14 Mar 2017 12:02:03 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-status: make porcelain more robust
Date:   Tue, 14 Mar 2017 17:02:02 +0100
Message-Id: <54df68bd46f7a417e77eb71b636f6f7afd4fce75.1489507239.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.384.g157040b11f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git status provides a porcelain mode for porcelain writers with a
supposedly stable (plumbing) interface.
7a76c28ff2 ("status: disable translation when --porcelain is used", 2014-03-20)
made sure that ahead/behind info is not translated (i.e. is stable).

Make sure that the remaining two strings (initial commit, detached head)
are stable, too.

These changes are for the v1 porcelain interface. While we do have a perfectly
stable v2 porcelain interface now, some tools (such as
powerline-gitstatus) are written against v1 and profit from fixing v1
without any changes on their side.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 wt-status.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index d47012048f..234e77a6d6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1730,12 +1730,14 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	branch_name = s->branch;
 
+#define LABEL(string) (s->no_gettext ? (string) : _(string))
+
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, _("Initial commit on "));
+		color_fprintf(s->fp, header_color, LABEL(N_("Initial commit on ")));
 
 	if (!strcmp(s->branch, "HEAD")) {
 		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
-			      _("HEAD (no branch)"));
+			      LABEL(N_("HEAD (no branch)")));
 		goto conclude;
 	}
 
@@ -1760,8 +1762,6 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	if (!upstream_is_gone && !num_ours && !num_theirs)
 		goto conclude;
 
-#define LABEL(string) (s->no_gettext ? (string) : _(string))
-
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, LABEL(N_("gone")));
-- 
2.12.0.384.g157040b11f.dirty

