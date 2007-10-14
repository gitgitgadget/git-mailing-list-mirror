From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 17:54:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141751530.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6jP-0005eh-JR
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538AbXJNQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbXJNQyN
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:54:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:48467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756340AbXJNQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:54:12 -0400
Received: (qmail invoked by alias); 14 Oct 2007 16:54:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 14 Oct 2007 18:54:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6VJVuufr6UFLT60AycIhaHnJVJk/r2d+ForAv85
	O5asD7MB5KxLfQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014095755.GF1198@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60869>


When there is an option "--amend", the option parser now recognizes
"--am" for that option, provided that there is no other option beginning
with "--am".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 14 Oct 2007, Pierre Habouzit wrote:

	> On Sun, Oct 14, 2007 at 09:18:55AM +0000, Eric Wong wrote:
	> > 
	> > One feature I really like is automatically handling of long 
	> > option abbreviations.  gitopt supported this at the expense of 
	> > complexity and the aforementioned intrusivenes.  This allows 
	> > automatic handling of the abbreviation style seen commonly in 
	> > git shell scripts:
	> > 
	> >    --a|--am|--ame|--amen|--amend)  (from git-commit.sh)
	> 
	> Yes, but if you do that, you can't order options in the order 
	> you want (because of first match issues), making the help dumps 
	> hopelessly random.

I think this patch proves that you do not need to order the options...

;-)

 parse-options.c          |   32 ++++++++++++++++++++++++++++++++
 t/t0040-parse-options.sh |   22 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 72656a8..afc6c89 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -102,6 +102,13 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 static int parse_long_opt(struct optparse_t *p, const char *arg,
                           const struct option *options)
 {
+	const char *arg_end = strchr(arg, '=');
+	const struct option *abbrev_option = NULL;
+	int abbrev_flags = 0;
+
+	if (!arg_end)
+		arg_end = arg + strlen(arg);
+
 	for (; options->type != OPTION_END; options++) {
 		const char *rest;
 		int flags = 0;
@@ -111,10 +118,33 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 
 		rest = skip_prefix(arg, options->long_name);
 		if (!rest) {
+			/* abbreviated? */
+			if (!strncmp(options->long_name, arg, arg_end - arg)) {
+is_abbreviated:
+				if (abbrev_option)
+					die ("Ambiguous option: %s "
+						"(could be --%s%s or --%s%s)",
+						arg,
+						(flags & OPT_UNSET) ?
+							"no-" : "",
+						options->long_name,
+						(abbrev_flags & OPT_UNSET) ?
+							"no-" : "",
+						abbrev_option->long_name);
+				if (!(flags & OPT_UNSET) && *arg_end)
+					p->opt = arg_end + 1;
+				abbrev_option = options;
+				abbrev_flags = flags;
+				continue;
+			}
+			/* negated? */
 			if (strncmp(arg, "no-", 3))
 				continue;
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, options->long_name);
+			/* abbreviated and negated? */
+			if (!rest && !prefixcmp(options->long_name, arg + 3))
+				goto is_abbreviated;
 			if (!rest)
 				continue;
 		}
@@ -125,6 +155,8 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 		}
 		return get_value(p, options, flags);
 	}
+	if (abbrev_option)
+		return get_value(p, abbrev_option, abbrev_flags);
 	return error("unknown option `%s'", arg);
 }
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 09b3230..e4dd86f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -66,4 +66,26 @@ test_expect_success 'intermingled arguments' '
 	git diff expect output
 '
 
+cat > expect << EOF
+boolean: 0
+integer: 2
+string: (not set)
+EOF
+
+test_expect_success 'unambiguously abbreviated option' '
+	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
+test_expect_success 'unambiguously abbreviated option with "="' '
+	test-parse-options --int=2 > output 2> output.err &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
+test_expect_failure 'ambiguously abbreviated option' '
+	test-parse-options --strin 123
+'
+
 test_done
-- 
1.5.3.4.1174.gcd0d6-dirty
