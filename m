Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5861FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754286AbcIBQXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:63165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754257AbcIBQXO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:14 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGAdz-1buPIh2mlb-00FDdd; Fri, 02 Sep 2016 18:23:08
 +0200
Date:   Fri, 2 Sep 2016 18:23:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <943801411097f3f68004423bc8a78725c8023dc2.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M9F25QNPWnzz4yEqvDZcPCFfLJfxMjNmHj6zEfDJMrtmrreNrUJ
 CbTq3iTDi286kVyMo+XMJq7RpWqIixSSq94H4OLNndadrHrQEu4aYjMjJOtWyBdqZG9V58g
 1CtDnYQjVzM8J2RR6Ma9z/nyoDUoqDPrMSrAeq1+NkechuQcYx8NjrIZDKxGl/uLhtrGw/t
 zrhX0OkXmD9h/3zx+DGhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nFj7gcUB6Eo=:76WQ2h7mzXC2/KB28mtN26
 lDQ4Re4AIEJRouV3/pQQSBZDVZTFSL+k90GEAg9q1hHF9XABoReTVXqcPYL1WUqmzhd9JBVmV
 V12WSLhmO6wqKEF1mcniidWSufOaTyv4rjH96oJX4a+nIJ7XELOVaZ04/8SGNK0itLIYwsaef
 mHbka/EZqVdiswMI2iz5PmV545SEudDA0EJO3VvQP8+h0EyAd5YsxnJpKQRv1eRdr7IIBJ/TB
 Mt3tOlBgK0KaORQr+SU0UTvVzuYzvZ2TKOQ5Yba5IgNleogaxTwOjR4xtlNg4/L3hnikfQ7nx
 qpW+CXZghXhEP6jrz6Kg46+UxWrWMg036MvxqnqeU2km1wA77C0Qv+CfOVt0Rv62iL1W7JRY6
 +KMkJTUhSBYlneXw2YHauGxrjhz1qaCv8JgCUSMMiot26Wf0RAYqoYxmSvkgFTHQ01nEJtU36
 X0AVUGSZgIMSAM9fHm20Zr9QIvgwI3uMYBmNdxTHOjortGMLo8nRkf8rdxvrkvTioi19fqPp5
 GJ/0KqsPq1cWvMLCMk3gFgf68eo5zmV0PB64TNBrlyUUsxEt64KcCI0mJYvPxJIYHAMVlooce
 3Ecgvi72vx3tIT2/jrnyDFDpR2VNFCEe7G7Dm8lZgrHvSdywnlgOn/IUy45nscfaacC+NlonL
 OHyyGCiZRyP4Rto/Vlc08OFyDx179c4/8IbjTeRBaRzzlRoeMa+FSO8f5Oczo0n0FrhJktYul
 rAKCNvekwc0S64CHNvXKgfbh4rkk/y0VjM5QE+L3Door+0QfaqHMUvQLvRudG2hQljFCiY8vf
 yuOGQ8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid problems with short SHA-1s that become non-unique during the
rebase, we rewrite the todo script with short/long SHA-1s before and
after letting the user edit the script. Since SHA-1s are not intuitive
for humans, rebase -i also provides the onelines (commit message
subjects) in the script, purely for the user's convenience.

It is very possible to generate a todo script via different means than
rebase -i and then to let rebase -i run with it; In this case, these
onelines are not required.

And this is where the expand/collapse machinery has a bug: it *expects*
that oneline, and failing to find one reuses the previous SHA-1 as
"oneline".

It was most likely an oversight, and made implementation in the (quite
limiting) shell script language less convoluted. However, we are about
to reimplement performance-critical parts in C (and due to spawning a
git.exe process for every single line of the todo script, the
expansion/collapsing of the SHA-1s *is* performance-hampering on
Windows), therefore let's fix this bug to make cross-validation with the
C version of that functionality possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5df5850..0eb5583 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -750,7 +750,12 @@ transform_todo_ids () {
 			;;
 		*)
 			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
-			rest="$sha1 ${rest#*[	 ]}"
+			if test "a$rest" = "a${rest#*[	 ]}"
+			then
+				rest=$sha1
+			else
+				rest="$sha1 ${rest#*[	 ]}"
+			fi
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest"
-- 
2.9.3.windows.3


