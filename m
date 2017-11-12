Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7798201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbdKLU5U (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:57:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:57599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdKLU5T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:57:19 -0500
Received: from fermat.fritz.box ([92.76.226.11]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFuWk-1eSmc540UI-00EsI7; Sun, 12
 Nov 2017 21:57:13 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bisect run: die if no command is given
Date:   Sun, 12 Nov 2017 21:55:33 +0100
Message-Id: <20171112205533.9593-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.15.0.165.g0dc13a7db.dirty
X-Provags-ID: V03:K0:GJTqgiBAjwqO3GSUp75mfHEVEWybhHZNjSrhGZCJrEBJBqUvJ1r
 mNoozkqrRyuV5ng8ThKVPYO5M7sHAdMuLzmpPaAJs66hMZ6NyjwnHie3O/uDS3POHWPYq6V
 /2jviDC9ualpCrSXey9Ld04dyV8LW61EmMGoXBQKIo9nMcmiK6E/Mo0a2Mu6Dh4vNklbEeA
 nlZUHTDB2g0Q/S4A/qwOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UFniocRVIj4=:z1PEDuCzDFpbSErxM0PPQ6
 s9zkbw2QJMDr84BWX/Vl2wiJ2eYqRTt+S/TNzVB/DLuzoZ/BAFi7x1TfCNWCmzviIn/rGppxM
 lMYVlt10XUFS+XVEHsYOP+3Uf3d11yzPmaLCwmQHxjNBPnjyBe7H7XUR8vVy4CPP/JJWT8K0A
 Lkmd3f2bDaksD7g1kLZjWqAbCPxTuNTh9qbmqITwbCvTvJgZLnpf6S7MS4uV0gs1QO0Fzfpe3
 bP0NDeEeht5TICY1aCF4qPxvL1EVD6cpRf7O8E3e6WrBgGbXeOGBPMOG7+jDTmd+mYXbyj6Dq
 EFr9oxOi7DzHo8RdMRcuzzPTW6lYwkkXVvc6n0RTus4tJdPsJbyy9R5cDYUlU5SLIvSJGFfvX
 COhMpaA4nws5pTg/dg58mHEorgkh8+HY3i7alGoO1QPB9W9XQgnxIVDCz4whBx8T3BG/INzwH
 BSfozMGcOcXn9YlmiF2LnUj5wqlXxaazFGPbUJZffnu4V3EUY94jGKFfEdsypmsBR5SHmW09C
 i9+F7VPdOcojb6wB45N5OZYwsnY2m5LRLi0E4Dm6L5bOduL4DBnvLXotVXvAbJztLpfLKoYbj
 tiKC0LwOj9YXB2y9AE3Gfa7NKplU9IknassFnr9SVep08QcIxH2LAra5fGZ65HfIcPrI5IZMZ
 xpOENr75eCejwR7Hw1BgtFmapuIw3f2ByN/XqUVhsQi4xZQ3UZFDthjhBMlb0t21lTqGnwKGG
 foAp23uDW29fa8mDBzpIEzuwuMbZNukX6CMa40WEOyvBqMnCAIuJQ3Dfv/XTZBExKJnsFGAB9
 zQzDigjMtwFBV08zmttTKqSPN19Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was possible to invoke "git bisect run" without any command.
This considers all commits as good commits since "$@"'s return
value for empty $@ is 0.

This is most probably not what a user wants (otherwise she would
invoke "git bisect run true"), so not providing a command now
results in an error.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-bisect.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index 0138a8860..a69e43656 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -450,6 +450,8 @@ bisect_replay () {
 bisect_run () {
 	bisect_next_check fail
 
+	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
+
 	while true
 	do
 		command="$@"
-- 
2.15.0.165.g0dc13a7db.dirty

