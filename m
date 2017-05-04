Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564F2207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755241AbdEDN7q (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:58242 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755483AbdEDN7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:59:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1dzTIf1aoq-00xYkJ; Thu, 04
 May 2017 15:59:21 +0200
Date:   Thu, 4 May 2017 15:59:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 25/25] submodule_uses_worktrees(): plug memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <83eb0a0551b78103ec08a367f951c1c81df3662c.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WJnxB8R0G/WRg9Np3Z7X5/y9ozIDneK1XUlubLCzY1cJO2GfGZC
 cS28Y/1Enln6MurhvahEo1XcRN5QzHnvZwVEw4F3zRw2KtVG7VBN0bnK1njZJ5oLFM35fwS
 R3ZnB36WnF2YtpUjH3O1bbPipzTkK5Y99XQa6oj/TIvAUZTpTd2paHV2Zx2eN9KCmWia73Z
 odl/paR5w1leC+7OvKVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tTsfAZOTqDE=:VT3hX8sOveBxF6Cd5vUm94
 C+B1Eq+1eAtliC8jF+DesLB/wFU7EYb/S/4Kx3ujBw5hyVQ3HHRTOlyF2xtUgvVgbWctGEW6d
 aqo2SJqJ/6J95jncccT7nmc9nVSGqPp4v+6qRWfIzH9muvK90rANkbZJZ3nTd6zvdWgL4KDiM
 pQbIrgrT/ED9hLi/+VFOxq0qXHiyY5BCfJ3TcGdj7XMpGVNxuOrGHNLFoquOwcP0pCNIk12Xr
 +pzT9/Q+wcYGo61Jd2rnvPht/fGREJa4hyOr7++R4gy8XoogKskJbn5hTDd+YE9yLg41qjtY4
 SOaKHKv4Xafbv+lfCi2vUqv+CEkIOiL9oCPsT4lpfgRbkeioqUAGiCR8qprnp/I/u9zXiw/1g
 0zR7jn8vowveCe0S0peWvt/OqmWqKAH8ydYXF5s75SSQfwGp04Ci89h9MQB4iGh6lGGs0uRuK
 CVLuIizCHzOGsT2q2rHxvkXnXMYopQKFCaFAnnapTl3mCWSZMvkstci0l46REW7xQJR7SJCmJ
 0l5dgDXycMNgduCXytU/gmNEpv7G1cJDgQzWoa1hVr99+t4Tds2kzRcTaJn4nWzhLJ1fLrSJX
 Kcjt1QFqkEhnWpDLrwtCnCw694moyRhtx8gPRawanFcos8ONhXJXwDFDnDsbpx0li+tvNEKGn
 htlG7s4XjNflc2OZQjF92nS11Fvwv/B4D3pzACmsBTRRWeP4kEgt0vbXNv4DDyxEamp7Mw5HQ
 lHCsV3TQ3R8va+vJV1uXCGelOpFXpFIP3ayuB2OCKay2jcunubIhx8h/1kXMshO4uMO7qcENc
 fVVDbru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is really no reason why we would need to hold onto the allocated
string longer than necessary.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index bae787cf8d7..89a81b13de3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -399,6 +399,7 @@ int submodule_uses_worktrees(const char *path)
 
 	/* The env would be set for the superproject. */
 	get_common_dir_noenv(&sb, submodule_gitdir);
+	free(submodule_gitdir);
 
 	/*
 	 * The check below is only known to be good for repository format
@@ -418,7 +419,6 @@ int submodule_uses_worktrees(const char *path)
 	/* See if there is any file inside the worktrees directory. */
 	dir = opendir(sb.buf);
 	strbuf_release(&sb);
-	free(submodule_gitdir);
 
 	if (!dir)
 		return 0;
-- 
2.12.2.windows.2.800.gede8f145e06
