Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5300E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997673AbdD1OEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:56634 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2997363AbdD1OEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbM2k-1dnuZm1knS-00ktNz; Fri, 28
 Apr 2017 16:04:40 +0200
Date:   Fri, 28 Apr 2017 16:04:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 23/25] name-rev: avoid leaking memory in the `deref`
 case
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YZ9glGnNogLUMThaeud5BzV66XVBhYolzQZr8XSip+qsfWK4DSS
 Vf29uS7v2zhFEc3tkyg1aaD3aaZdWi93f8PyzCYgpPM6RN8b/1vEKi8kzQIPXTiBCeTqoja
 K+fv/R9zmi7E/PlMckye8YPJMhkjEqNFj6cUSZRjY9b4U5Ay8wkzIiCw4EFeAmV3Jei442v
 +2ZpzGki9IWoi8tSnsvjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5mxrL6FiGx8=:a8fEFCyWP3ZykWIglGTlS9
 YH3Y+lt1jH0JutT3kSeB5D7bfH5K8nHWWo8BXh/VLd/GArisJYBeJZHj1Y77+O2T5sCvXoak6
 +G4IkscSEIUsKNM7Zt2wDwt7Tw2Eu2vlznc2eit3yKb4TlA4nF/bzSI4SHIuGolO4YbOSQWz3
 FvZFMdzbbpj35WjmGUQbi0MTZGDxlBSofYcxJqLFbKLNkNU1Ulhe2tN9kN4S9a2NexNsgjtdf
 TH43b6TP8xkjRXPI+LIfuEFa/x9FYIf0y6zcKBclRY/wRS+MgNKXExY3EHcKJ5YfTvrJTwUtF
 u1C+aQsF9v+edcltM51CnCe1uHN/KWT8mxYqzse4+N3DGlQq1qVN6EBXXFfzpogLvkzchgKt7
 V0060as2vSpOSTKoegcTV3iMwpNmpVq+jG8EvCajOdgtZOwEwhkDClhBKlrz8gn5GObREnL2i
 MuYrLonQJsDKYbti7/Wu26uocW/L08apdz1VEN37wmYSzAIb4HhNoSj3zvNY5jm0mjIgt9AVm
 eVZ9sussJOCmzXjb8/ncxWvYyYAft4/s0qe/vdsgDbu53mvXpFRig3gNbuHG4qE9fjyez0Ip3
 FI9c+3l9I/r8P9f4/tNpsankhKGPvd4eGYiMbK1S3DAcRdaLgREKeZaxX+5OqxJbbg4BaGjMl
 cYb9R9iBEoR3IPpe7RWrZ6TA5qxblVKfbaUJjjxQxv6LEdF2EtB2RCa5gg3Dm+2n6hfNVOFPb
 95zUHwIElXyzbqYszEXT1tKd4e/1u1dSQtb4OWC5v954mBQ42WvI1Bw/I+Dbg8sC+ifpwFy+M
 tQek39A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the `name_rev()` function is asked to dereference the tip name, it
allocates memory. But when it turns out that another tip already
described the commit better than the current one, we forgot to release
the memory.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/name-rev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d26..a4ce73fb1e9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
 	int parent_number = 1;
+	char *p = NULL;
 
 	parse_commit(commit);
 
@@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
 		return;
 
 	if (deref) {
-		tip_name = xstrfmt("%s^0", tip_name);
+		tip_name = p = xstrfmt("%s^0", tip_name);
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -53,8 +54,10 @@ static void name_rev(struct commit *commit,
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
-	} else
+	} else {
+		free(p);
 		return;
+	}
 
 	for (parents = commit->parents;
 			parents;
-- 
2.12.2.windows.2.800.gede8f145e06


