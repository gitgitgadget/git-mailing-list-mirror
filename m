From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] test: simplify return value of test_run_
Date: Mon, 8 Aug 2011 03:15:34 +0200
Message-ID: <20110808011534.GB19551@elie.gateway.2wire.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
 <20110808011341.GA19551@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 03:15:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqERW-0003jW-8j
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 03:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1HHBPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 21:15:42 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37656 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1HHBPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 21:15:41 -0400
Received: by iye16 with SMTP id 16so7990712iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ru6qzxdyxtQXH0Pj/WBiMVos4n2nk/kqfAU5PFMRhRs=;
        b=u06WG4xPtCpwqbEIZnEkTW6tggmYfUyINAE9aHdXQlbUYfE3hGNvAzHQTljcm0aFus
         Ml7+CAUQxlTXcpIJfQMrcJyIC0AQ0Au9EpoTi2k50YqxGL+oDLdudxo0lLGvom7Hfj6l
         4tXhwXe0lU2SmON7SvJoKFP+bxZa6kiroV08Q=
Received: by 10.42.139.2 with SMTP id e2mr4669857icu.237.1312766140962;
        Sun, 07 Aug 2011 18:15:40 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id n18sm2145603ibg.1.2011.08.07.18.15.40
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 18:15:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110808011341.GA19551@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178932>

As v0.99.5~24^2~4 (Trapping exit in tests, using return for errors,
2005-08-10) explains, callers to test_run_ (such as test_expect_code)
used to check the result from eval and the return value separately so
tests that fail early could be distinguished from tests that completed
normally with successful (nonzero) status.  Eventually tests that
succeed with nonzero status were phased out (see v1.7.4-rc0~65^2~19,
2010-10-03 and especially v1.5.5-rc0~271, 2008-02-01) but the weird
two-return-value calling convention lives on.

Let's get rid of it.  The new rule: test_run_ succeeds (returns 0)
if and only if the test succeeded.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index df25f179..b16a9b98 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -457,7 +457,7 @@ test_run_ () {
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
-	return 0
+	return "$eval_ret"
 }
 
 test_skip () {
@@ -502,8 +502,7 @@ test_expect_failure () {
 	if ! test_skip "$@"
 	then
 		say >&3 "checking known breakage: $2"
-		test_run_ "$2" expecting_failure
-		if [ "$?" = 0 -a "$eval_ret" = 0 ]
+		if test_run_ "$2" expecting_failure
 		then
 			test_known_broken_ok_ "$1"
 		else
@@ -521,8 +520,7 @@ test_expect_success () {
 	if ! test_skip "$@"
 	then
 		say >&3 "expecting success: $2"
-		test_run_ "$2"
-		if [ "$?" = 0 -a "$eval_ret" = 0 ]
+		if test_run_ "$2"
 		then
 			test_ok_ "$1"
 		else
-- 
1.7.6
