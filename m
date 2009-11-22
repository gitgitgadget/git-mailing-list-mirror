From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Sun, 22 Nov 2009 16:58:09 +0100
Message-ID: <4B095F91.8030305@lsrfire.ath.cx>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 16:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCEpT-00028J-1g
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 16:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbZKVP6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 10:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbZKVP6K
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 10:58:10 -0500
Received: from india601.server4you.de ([85.25.151.105]:43748 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbZKVP6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 10:58:09 -0500
Received: from [10.0.1.101] (p57B7F129.dip.t-dialin.net [87.183.241.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 439DD2F8051;
	Sun, 22 Nov 2009 16:58:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v1vjvebem.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133435>

Junio C Hamano schrieb:
> Do we kill that environment variable when we call out to external grep in
> grep.c?  If not, we should.  An alternative is to teach our internal one
> to also honor it, but I personally do not find it too attractive to mimic
> the design mistake of GREP_OPTIONS myself.

We don't.  Here's a patch with a simple test case that makes git grep
unset GREP_OPTIONS before it calls the external grep.

While we're at it, also unset GREP_COLOR and GREP_COLORS in case
colouring is not enabled, to be on the safe side.  The presence of
these variables alone is not sufficient to trigger coloured output with
GNU grep, but other implementations may behave differently.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-grep.c  |    4 ++++
 t/t7002-grep.sh |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 01be9bf..9a9e3fc 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -433,7 +433,11 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 
 		if (opt->color_external && strlen(opt->color_external) > 0)
 			push_arg(opt->color_external);
+	} else {
+		unsetenv("GREP_COLOR");
+		unsetenv("GREP_COLORS");
 	}
+	unsetenv("GREP_OPTIONS");
 
 	hit = 0;
 	argc = nr;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ae5290a..dd0da6c 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -213,6 +213,11 @@ test_expect_success 'grep -e A --and --not -e B' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep should ignore GREP_OPTIONS' '
+	GREP_OPTIONS=-v git grep " mmap bar\$" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep -f, non-existent file' '
 	test_must_fail git grep -f patterns
 '
-- 
1.6.5.3
