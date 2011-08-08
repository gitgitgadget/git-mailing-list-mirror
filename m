From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] test: cope better with use of return for errors
Date: Mon, 8 Aug 2011 03:17:09 +0200
Message-ID: <20110808011709.GC19551@elie.gateway.2wire.net>
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
X-From: git-owner@vger.kernel.org Mon Aug 08 03:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqET2-00044U-JW
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 03:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab1HHBRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 21:17:16 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:46838 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1HHBRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 21:17:16 -0400
Received: by iye16 with SMTP id 16so7992756iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 18:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xoJC7x3SFNIfAybWNmBf0/SnUsbS4OkzTSH6rITMFTU=;
        b=iR4vYJTeL4IAxXwXoBiLIe2M7YxGWmXDqZOxr227zTR+gIIT/RX0b8grx4vQG3hD7A
         YvGxZ+1r9SU6qGCVgR5NUXGux3NdLusOPjlQuPPpr2vDWvrxmORuvjgbKv+3/t+LcTuO
         5Qm0XHHhwhsel11MwiRULSwimG8kUcqEh5HyA=
Received: by 10.231.130.94 with SMTP id r30mr4364434ibs.95.1312766235638;
        Sun, 07 Aug 2011 18:17:15 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.sbcglobal.net [69.209.49.224])
        by mx.google.com with ESMTPS id t14sm3825151ibi.23.2011.08.07.18.17.14
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 18:17:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110808011341.GA19551@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178933>

In olden times, tests would quietly exit the script when they failed
at an inconvenient moment, which was a little disconcerting.
Therefore v0.99.5~24^2~4 (Trapping exit in tests, using return for
errors, 2005-08-10) switched to an idiom of using "return" instead,
wrapping evaluation of test code in a function to make that safe:

	test_run_ () {
		eval >&3 2>&4 "$1"
		eval_ret="$?"
		return 0
	}

Years later, the implementation of test_when_finished (v1.7.1.1~95,
2010-05-02) and v1.7.2-rc2~1^2~13 (test-lib: output a newline before
"ok" under a TAP harness, 2010-06-24) took advantage of test_run_ as a
place to put code shared by all test assertion functions, without
paying attention to the function's former purpose:

	test_run_ () {
		...
		eval >&3 2>&4 "$1"
		eval_ret=$?

		if should run cleanup
		then
			eval >&3 2>&4 "$test_cleanup"
		fi
		if TAP format requires a newline here
		then
			echo
		fi
		return 0
	}

That means cleanup commands and the newline to put TAP output at
column 0 are skipped when tests use "return" to fail early.  Fix it by
introducing a test_eval_ function to catch the "return", with a
comment explaining the new function's purpose for the next person who
might touch this code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b16a9b98..57c3d532 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -444,15 +444,21 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
+test_eval_ () {
+	# This is a separate function because some tests use
+	# "return" to end a test_expect_success block early.
+	eval >&3 2>&4 "$*"
+}
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
-	eval >&3 2>&4 "$1"
+	test_eval_ "$1"
 	eval_ret=$?
 
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
-		eval >&3 2>&4 "$test_cleanup"
+		test_eval_ "$test_cleanup"
 	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
-- 
1.7.6
