From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/4] parseopt: prevent KEEP_UNKNOWN and STOP_AT_NON_OPTION
 from being used together
Date: Mon, 09 Mar 2009 21:57:38 +0100
Message-ID: <49B582C2.2080803@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx> <49B40A9F.7050408@lsrfire.ath.cx> <7vvdqjkbka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgmZ8-00016B-5N
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbZCIU5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 16:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbZCIU5n
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:57:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:53271 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbZCIU5n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:57:43 -0400
Received: from [10.0.1.101] (p57B7F24E.dip.t-dialin.net [87.183.242.78])
	by india601.server4you.de (Postfix) with ESMTPSA id 7DA5E2F8063;
	Mon,  9 Mar 2009 21:57:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vvdqjkbka.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112740>

As suggested by Junio, disallow the flags PARSE_OPT_KEEP_UNKNOWN and
PARSE_OPT_STOP_AT_NON_OPTION to be turned on at the same time, as a
value of an unknown option could be mistakenly classified as a
non-option, stopping the parser early.  E.g.:

	git cmd --known --unknown value arg0 arg1

The parser should have stopped at "arg0", but it already stops at
"value".

This patch makes parse_options() die if the two flags are used in
combination.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    3 ++-
 parse-options.c                               |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index dc72987..f5d4ac1 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -96,7 +96,8 @@ Flags are the bitwise-or of:
 	`PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
 	`--unknown value` will be mistakenly interpreted as a
 	non-option, not as a value belonging to the option, stopping
-	the parser early.
+	the parser early.  That's why parse_options() errors out if
+	both options are set.
 
 `PARSE_OPT_NO_INTERNAL_HELP`::
 	By default, parse_options() handles `-h`, `--help` and
diff --git a/parse-options.c b/parse-options.c
index 51e804b..cf71bcf 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -244,6 +244,9 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->out  = argv;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
+	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
+	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
+		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 }
 
 static int usage_with_options_internal(const char * const *,
-- 
1.6.2
