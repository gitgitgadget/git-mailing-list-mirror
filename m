From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 15:02:21 +0100
Message-ID: <200803241502.21465.barra_cuda@katamail.com>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241331.17986.barra_cuda@katamail.com> <alpine.LSU.1.00.0803241409400.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdn6I-0002He-W4
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422AbYCXNvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758406AbYCXNvw
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:51:52 -0400
Received: from smtp.katamail.com ([62.149.157.154]:35473 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758374AbYCXNvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:51:51 -0400
Received: (qmail 14260 invoked by uid 89); 24 Mar 2008 13:48:12 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host45-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.45)
  by smtp2-pc with SMTP; 24 Mar 2008 13:48:11 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0803241409400.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78035>

There are quite a few places that will need to call approxidate(),
when they'll adopt the parse-options system, so this patch adds the
function parse_opt_approxidate_cb(), used by OPT_DATE, and converts
the only user so far.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Monday 24 March 2008, Johannes Schindelin wrote:
> And maybe a
> 
> #define OPT_DATE(s, l, v, h)    { OPTION_CALLBACK, (s), (l), (v), "time", 
> (h), 0, parse_opt_approxidate_cb }

Oh, right. Somehow I thought it was simpler not to do this.

Thank you for your review and suggestions.

This is on top of
[PATCH 2/2] builtin-prune.c: fix object parsing and use parse_options()

 builtin-prune.c |   12 ++----------
 parse-options.c |    7 +++++++
 parse-options.h |    5 +++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 7b3e15d..40581df 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -125,13 +125,6 @@ static void remove_temporary_files(void)
 	closedir(dir);
 }
 
-static int parse_opt_expire(const struct option *opt, const char *arg,
-		int unset)
-{
-	expire = approxidate(arg);
-	return 0;
-}
-
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -139,9 +132,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_BOOLEAN('n', NULL, &show_only,
 				"do not remove, show only"),
-		OPT_CALLBACK(0, "expire", &expire, "time",
-				"expire objects older than <time>",
-				parse_opt_expire),
+		OPT_DATE(0, "expire", &expire,
+				"expire objects older than <time>"),
 		OPT_END()
 	};
 
diff --git a/parse-options.c b/parse-options.c
index 8e64316..6ec7fe8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -409,3 +409,10 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	*(int *)(opt->value) = v;
 	return 0;
 }
+
+int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
+		int unset)
+{
+	*(unsigned int *)(opt->value) = approxidate(arg);
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 1af62b0..c98f89e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -110,6 +110,8 @@ extern NORETURN void usage_with_options(const char * const *usagestr,
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
+extern int parse_opt_approxidate_cb(const struct option *, const char *,
+		int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
@@ -118,5 +120,8 @@ extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
 	  "use <n> digits to display SHA-1s", \
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
+#define OPT_DATE(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
+	  parse_opt_approxidate_cb }
 
 #endif
-- 
1.5.4.3
