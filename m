Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13221205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdABP03 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:63407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756068AbdABP02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:28 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbfnB-1c7mZN3pVF-00J4ar; Mon, 02
 Jan 2017 16:26:21 +0100
Date:   Mon, 2 Jan 2017 16:26:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 03/38] sequencer: use a helper to find the commit
 message
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <780d71b5844b526a850ac9b76d36b764b2580efd.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JO8mNipwNY9QiybZAEiuZ+u91nncBpZMGFqSmaNi1KuO/XrrfF5
 t2UGQo4EO4KQijTu223ysG2yR4eBOb1yAaU/uethheEkwCPeSMIEXDlMXeTIiNpyfmKwmMx
 A+C+UMvwoC7FARpnZ1zjsWNch2JyNG1Yib9Emb2hXxKAXlZzvu0oU8V4ReHphq4y4CdQcJ3
 tsep6Csb5tjl1y9Ri+/fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jwD6fOD6p+E=:3Opq+2S4Y4iphuiMGJb7rk
 c4VrCZeIx+oyEYaQqWe697RgSAAaLsgLzPFKF9KPCnpVFB1ve3pyCHH++mzc/uKKlj8BRqFLI
 fHWcJqOEWNCf8woNo8bz0EfIo/OYKLULR2bvgRGUQA4GY0RYlMQOcWsS3KI/SE2UkLktZkoNq
 ZKRXmvR935LBrWwMYY+xgxaBNRjJKYU3LXsMUv02xthMISwk+R/Qk10zGJJxrkea47EvZet3R
 UkJtpHlqdyrqiZPabLOqh098NJBhGxF3OA5e3CYjhBX+JG730E59acSQErDMDYFuFmBBOSWsY
 0Af07I0k6V/4/eP8sONHtjA3DvI+6/zE5i/fiCc0cvvgy2t1Hf+ZDa7L1DEsXa1x+6dAgmf/t
 mj7ummv87WNB2LfxKBRTj3WpPP2ON4CEYq/W1WF+7qLoGwKL0i4NgQQGvykRk9Qoa1By3wbmn
 syiL6Iz1RWdxDFsJDIJcmakjn9KcqWYKuNwNYK0DrotGNzu3kxU5weaD6ZRWmuOh2A9MdpSPn
 hCfXHuvGFwx4S1l3corfSolfDS/dR4PaVNB/ujkkJBFWYU7OPdmxTWbBP2PSWgWD1ieHDAjbz
 xrwUNdSLPfhBD7QSRlGzwUTMd1b7yg4m3isvvrRDXD0PDOqLS70aj4Mht9xMD3aGqqeCWvhuP
 5kK/pLPZDGvDoVC7iYbdDg2yO1WDp0sbrD4ppnsWhW5mK1a/0WWFDXrZgkp61ImwGi2+jgrFZ
 IRJlwSpU/GKR7EwloMrEMrsonwTSbDvsVZYm6ImQ2kawZcogSPrqCpwNgurHM26YSdAtKQZNL
 RhsNNJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is actually not safe to look for a commit message by looking for the
first empty line and skipping it.

The find_commit_subject() function looks more carefully, so let's use
it. Since we are interested in the entire commit message, we re-compute
the string length after verifying that the commit subject is not empty
(in which case the entire commit message would be empty, something that
should not happen but that we want to handle gracefully).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3eededcb98..720857beda 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -703,14 +703,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		next = commit;
 		next_label = msg.label;
 
-		/*
-		 * Append the commit log message to msgbuf; it starts
-		 * after the tree, parent, author, committer
-		 * information followed by "\n\n".
-		 */
-		p = strstr(msg.message, "\n\n");
-		if (p)
-			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
+		/* Append the commit log message to msgbuf. */
+		if (find_commit_subject(msg.message, &p))
+			strbuf_addstr(&msgbuf, p);
 
 		if (opts->record_origin) {
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
-- 
2.11.0.rc3.windows.1


