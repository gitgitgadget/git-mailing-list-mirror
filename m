From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] parseopt: add OPT_NOOP_NOARG
Date: Wed, 28 Sep 2011 19:44:30 +0200
Message-ID: <4E835CFE.7020501@lsrfire.ath.cx>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yBo-0005c3-Jf
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab1I1Rop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:44:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:55224 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab1I1Roo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:44:44 -0400
Received: from [192.168.2.104] (p579BE384.dip.t-dialin.net [87.155.227.132])
	by india601.server4you.de (Postfix) with ESMTPSA id 9E3EB2F8040;
	Wed, 28 Sep 2011 19:44:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182349>

Add OPT_NOOP_NOARG, a helper macro to define deprecated options in a
standard way.  The help text is taken from the no-op option -r of
git revert.

The callback could be made to emit a (conditional?) warning later.  And
we could also add OPT_NOOP (requiring an argument) etc. as needed.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Two follow-up patches use the new macro to replace OPTION_BOOLEAN in
three cases.  Could be squashed in.

 Documentation/technical/api-parse-options.txt |    5 +++++
 parse-options-cb.c                            |    5 +++++
 parse-options.h                               |    6 +++++-
 t/t0040-parse-options.sh                      |    2 +-
 test-parse-options.c                          |    1 +
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index f6a4a36..c209046 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -198,6 +198,11 @@ There are some macros to easily define options:
 	"auto", set `int_var` to 1 if stdout is a tty or a pager,
 	0 otherwise.
 
+`OPT_NOOP_NOARG(short, long)`::
+	Introduce an option that has no effect and takes no arguments.
+	Use it to hide deprecated options that are still to be recognized
+	and ignored silently.
+
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 6db0921..0de5fb1 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -123,3 +123,8 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	string_list_append(v, xstrdup(arg));
 	return 0;
 }
+
+int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
+{
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 59e0b52..47c11f3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -148,7 +148,10 @@ struct option {
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
-
+#define OPT_NOOP_NOARG(s, l) \
+	{ OPTION_CALLBACK, (s), (l), NULL, NULL, \
+	  "no-op (backward compatibility)", \
+	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
 
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
@@ -210,6 +213,7 @@ extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
+extern int parse_opt_noop_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 007f39d..a1e4616 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -87,7 +87,7 @@ EOF
 test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
-		> output 2> output.err &&
+		--obsolete > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
diff --git a/test-parse-options.c b/test-parse-options.c
index 91a5701..36487c4 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -54,6 +54,7 @@ int main(int argc, const char **argv)
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
+		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
 			"set string to default", (unsigned long)"default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
-- 
1.7.7.rc2
