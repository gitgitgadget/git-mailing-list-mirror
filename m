From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/3] parse-options: disallow --no-no-sth
Date: Tue, 28 Feb 2012 21:12:53 +0100
Message-ID: <4F4D3545.6060704@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx> <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org> <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org> <4F4BC3B3.7080000@lsrfire.ath.cx> <7vzkc457g3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 21:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2TPy-00074G-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 21:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab2B1UM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 15:12:58 -0500
Received: from india601.server4you.de ([85.25.151.105]:38279 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2B1UM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 15:12:57 -0500
Received: from [192.168.2.105] (p4FFDAFAB.dip.t-dialin.net [79.253.175.171])
	by india601.server4you.de (Postfix) with ESMTPSA id 2FF362F8039;
	Tue, 28 Feb 2012 21:12:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vzkc457g3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191780>

Now that options whose definition starts with "no-" can be negated
by removing said "no-", there is no need anymore to allow them to
be negated by adding a second "no-", which just looks silly.

The following thirteen options are affected:

	apply          --no-add
	bisect--helper --no-checkout
	checkout-index --no-create
	clone          --no-checkout --no-hardlinks
	commit         --no-verify   --no-post-rewrite
	format-patch   --no-binary
	hash-object    --no-filters
	read-tree      --no-sparse-checkout
	revert         --no-commit
	show-branch    --no-name
	update-ref     --no-deref

E.g., with this patch --no-add and --add (its reverse) are still
accepted by git apply, but --no-no-add isn't anymore.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c          |    3 +++
 t/t0040-parse-options.sh |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 1908996..dc59bba 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -248,6 +248,9 @@ is_abbreviated:
 				}
 				continue;
 			}
+			/* double negation? */
+			if (!prefixcmp(long_name, "no-"))
+				continue;
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, long_name);
 			/* abbreviated and negated? */
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a44bcb9..b124f3c 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -101,11 +101,11 @@ test_expect_success 'OPT_BOOL() #5' 'check boolean: 1 -B'
 test_expect_success 'OPT_BOOL() is idempotent #1' 'check boolean: 1 --yes --yes'
 test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
 
-test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
-test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
+test_expect_success 'OPT_BOOL() negation' 'check boolean: 0 -D --no-yes'
 
 test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fear'
 test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-no-fear'
+test_expect_success 'OPT_BOOL() no negation #3' 'check_unknown --no-no-doubt'
 
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
-- 
1.7.9.2
