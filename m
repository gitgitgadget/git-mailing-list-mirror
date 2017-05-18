Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B8A2023D
	for <e@80x24.org>; Thu, 18 May 2017 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbdERKDS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 06:03:18 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19718 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbdERKDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 06:03:18 -0400
Received: from lindisfarne.localdomain ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BIGsdcxC6xR4bBIH6dCNJV; Thu, 18 May 2017 11:03:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495101797; bh=1L0M6WgCSuH3Ra71XQrQhMdJEh+RA92k4JAUuJU2suI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=N1GTtLa3wOmUsj80zR9WhCYTlDWzvcGCN5a13YVoOAc1mzV2g3CUeeq2L37Eg+21Y
         1/I6MNIhd7hHnTJeVVjGPWdTY14qumCev7eNQWXbAy6JirwcPIBdE0ON04PLdwYyL+
         2U8RgFbed2+tt2AjFYTpd3wMhuMLKHgjXe1gLguw=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=evINK-nbAAAA:8 a=iphdqggO2FKMtSuLOZwA:9
 a=X11E6GMcUPIp-zwk:21 a=nkf0MnhKzooirXdB:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] rebase -i: fix reflog message
Date:   Thu, 18 May 2017 11:02:32 +0100
Message-Id: <20170518100233.30559-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518100233.30559-1-phillip.wood@talktalk.net>
References: <20170518100233.30559-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKskTA8eqy7HpT2TrTilX5Xjoech8KiIwvMeBgd3brfX8kF33cyHkvRyb6/+UBknEU815AsGsTbAggCn6gR0lblM/ZU5mZuB/lx20jSENvwL2SVUj7Pf
 PFS7RKnsPtISppaDknHoApTndbpPuoTeUKa143+qMH6EI1voavI4If2dtiRrvuQy1F9M09vrzkmogNCL6W34CL+I+aDDVp06euSvFhu6crzmZBmS/1TYjDHi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebase -i was converted to C a bug was introduced into the code
that creates the reflog message. Instead of saying
rebase -i (finish): <head-name> onto <onto>
it says
rebase -i (finish): <head-name> onto <orig-head><onto>
as the strbuf is not reset between reading the value of <orig-head>
and <onto>.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 0fa3fb14f7c1df5f11ba0ef7e4e46a44a32817bd..f8bc18badf1a3fb1b39656501c5a316e229968d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2089,6 +2089,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				res = error(_("could not read orig-head"));
 				goto cleanup_head_ref;
 			}
+			strbuf_reset(&buf);
 			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
-- 
2.13.0

