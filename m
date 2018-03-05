Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0B01F576
	for <e@80x24.org>; Mon,  5 Mar 2018 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCEK5E (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:57:04 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:62620 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934440AbeCEK4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:47 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnResP0E; Mon, 05 Mar 2018 10:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247405;
        bh=zV2p4UnbBDhytt7oWrMBZcOfNaZIOOCfEPSSUGGCI+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SA5pkpcc7TW8HIc/XDb9/D+jUEbzK9mULE34UxdjlkrNCw40o6smdBdR3/DDa6Da2
         JgR/ol8kuiw7euzlgI8TrYBiN5NGIl7ygQYltJYO2fIMqvQJ1eMVnGPXc5ijxcIOtw
         s0oiyb/4EziKkiO1fuUWtcvOh0HwHWAEjnu40b40=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=btPmDDSnAHUVDtEEeN8A:9
 a=25fZjzjGu2l4HOCd:21 a=hEE-zIYjV4AsxFf3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 9/9] add -p: don't rely on apply's '--recount' option
Date:   Mon,  5 Mar 2018 10:56:30 +0000
Message-Id: <20180305105630.14407-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKzMatwMYEoLtPekFwJKSJ0E8T05KnRNakZttMVMqcdcwJ0cV5q29BsenrFMXVxDUjKBZP0lFbAOpt7NcCxzBYN4xG0BHutzDSdhg6AxVKudco2h+Uy7
 DzWK5a+mU7yoMvIoUj9v+44aPMg4ARTP4Wok5/UUA4gF+0WCRSFqi/fHHU5ASBpSpFPuAMm+cKVB1kU/UirKPZu4udA0Tr7nNar+JThFG3pGHRK3kJw7YH2l
 eVeVx5u/J4h5D9TRUw42q5jomHfhgNymdaV2trmkAqV/VTBFtaKe6L63TxiDRjZGuZOIxlJAzzk5Fcz/20fGVuAh4lWIyHMWoHQncoLjxhs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that add -p counts patches properly it should be possible to turn
off the '--recount' option when invoking 'git apply'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I can't think of a reason why this shouldn't be OK but I can't help
    feeling slightly nervous about it. I've made it a separate patch so it
    can be easily dropped or reverted if I've missed something.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d1b550d4d8..f83e7450ad 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -677,7 +677,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
+	open $fh, '| git ' . $cmd . " --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
2.16.2

