From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] parse-options: typo check for unknown switches
Date: Sat, 03 Mar 2012 12:00:29 +0100
Message-ID: <4F51F9CD.9010904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 12:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3mhd-0006F0-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 12:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab2CCLAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 06:00:37 -0500
Received: from india601.server4you.de ([85.25.151.105]:38672 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab2CCLAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 06:00:36 -0500
Received: from [192.168.2.105] (p579BED61.dip.t-dialin.net [87.155.237.97])
	by india601.server4you.de (Postfix) with ESMTPSA id 308AB2F8030
	for <git@vger.kernel.org>; Sat,  3 Mar 2012 12:00:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192104>

The user specifies a long option but forgets to type the second
leading dash, we currently detect and report that fact if its first
letter is a valid short option. This is done for safety, to avoid
ambiguity between short options (and their arguments) and a long
option with a missing dash.

This diagnostic message is also helpful for long options whose first
letter is not a valid short option, however. Print it in that case,
too, as a courtesy.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c          |    2 ++
 t/t0040-parse-options.sh |   10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 1908996..850cfa7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -393,6 +393,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			case -1:
 				return parse_options_usage(ctx, usagestr, options, 1);
 			case -2:
+				if (ctx->opt)
+					check_typos(arg + 1, options);
 				goto unknown;
 			}
 			if (ctx->opt)
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a44bcb9..e3f354a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -236,6 +236,16 @@ test_expect_success 'detect possible typos' '
 	test_cmp typo.err output.err
 '
 
+cat > typo.err << EOF
+error: did you mean \`--ambiguous\` (with two dashes ?)
+EOF
+
+test_expect_success 'detect possible typos' '
+	test_must_fail test-parse-options -ambiguous > output 2> output.err &&
+	test ! -s output &&
+	test_cmp typo.err output.err
+'
+
 cat > expect <<EOF
 boolean: 0
 integer: 0
-- 
1.7.9.2
