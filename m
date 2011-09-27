From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] parse-options: deprecate OPT_BOOLEAN
Date: Tue, 27 Sep 2011 16:56:49 -0700
Message-ID: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 01:56:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hWD-0007aM-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1I0X4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 19:56:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab1I0X4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 19:56:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B74D45766;
	Tue, 27 Sep 2011 19:56:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	Nh8B0WKJt4IGK6QUbFYvCTGuY4=; b=oOJEt2o1P8aBZp0i6d/sF6hffKSncQOOe
	Bg1uybU5okefCGyemTyhjuqP3YDQEmQFcYNgZrVWhR8frmCJLjrxPkpnf0ozlux+
	Y5ZAwlFM6sUs6VAiqHhVAEtJlNVTARmzfwDqUsRAmjEszXMP/2qEjXLxC2YYffO6
	Knxjr+9OHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=I6R1u8AZVPpZdmb+k8vVfkX8o+EzuEb2O3vrFMeVaRo7JzleFCETeNy8
	zPipI06SFzM9zVldodu6yae9odOQdQYSHyM+FeKG05uhVevaoXVoL8nUPGkqLIYe
	WQFGxUctH6oSt5oj7GmY28aOPiMK45WOZ13ZbHCkq1mcbWhZ4Rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC575765;
	Tue, 27 Sep 2011 19:56:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98E735763; Tue, 27 Sep 2011
 19:56:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E216C48-E964-11E0-8675-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182278>

It is natural to expect that an option defined with OPT_BOOLEAN() could be
used in this way:

	int option = -1; /* unspecified */

	struct option options[] = {
		OPT_BOOLEAN(0, "option", &option, "set option"),
                OPT_END()
	};
	parse_options(ac, av, prefix, options, usage, 0);

        if (option < 0)
        	... do the default thing ...
	else if (!option)
		... --no-option was given ...
	else
		... --option was given ...

to easily tell three cases apart:

 - There is no mention of the `--option` on the command line;
 - The variable is positively set with `--option`; or
 - The variable is explicitly negated with `--no-option`.

Unfortunately, this is not the case. OPT_BOOLEAN() increments the variable
every time `--option` is given, and resets it to zero when `--no-option`
is given.

As a first step to remedy this, introduce a true boolean OPT_BOOL(), and
rename OPT_BOOLEAN() to OPT_COUNTUP(). To help transitioning, OPT_BOOLEAN
and OPTION_BOOLEAN are defined as deprecated synonyms to OPT_COUNTUP and
OPTION_COUNTUP respectively.

This is what db7244b (parse-options new features., 2007-11-07) from four
years ago started by marking OPTION_BOOLEAN as "INCR would have been a
better name".

Some existing users do depend on the count-up semantics; for example,
users of OPT__VERBOSE() could use it to raise the verbosity level with
repeated use of `-v` on the command line, but they probably should be
rewritten to use OPT__VERBOSITY() instead these days.  I suspect that some
users of OPT__FORCE() may also use it to implement different level of
forcibleness but I didn't check.

On top of this patch, here are the remaining clean-up tasks that other
people can help:

 - Look at each hit in "git grep -e OPT_BOOLEAN"; trace all uses of the
   value that is set to the underlying variable, and if it can proven that
   the variable is only used as a boolean, replace it with OPT_BOOL(). If
   the caller does depend on the count-up semantics, replace it with
   OPT_COUNTUP() instead.

 - Same for OPTION_BOOLEAN; replace it with OPTION_SET_INT and arrange to
   set 1 to the variable for a true boolean, and otherwise replace it with
   OPTION_COUNTUP.

 - Look at each hit in "git grep -e OPT__VERBOSE -e OPT__QUIET" and see if
   they can be replaced with OPT__VERBOSITY().

I'll follow this message up with a separate patch as an example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-parse-options.txt |   16 +++++++++++-----
 parse-options.c                               |    4 ++--
 parse-options.h                               |   10 ++++++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index f6a4a36..acf1760 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -135,9 +135,14 @@ There are some macros to easily define options:
 	describes the group or an empty string.
 	Start the description with an upper-case letter.
 
-`OPT_BOOLEAN(short, long, &int_var, description)`::
-	Introduce a boolean option.
-	`int_var` is incremented on each use.
+`OPT_BOOL(short, long, &int_var, description)`::
+	Introduce a boolean option. `int_var` is set to one with
+	`--option` and set to zero with `--no-option`.
+
+`OPT_COUNTUP(short, long, &int_var, description)`::
+	Introduce a count-up option.
+	`int_var` is incremented on each use of `--option`, and
+	reset to zero with `--no-option`.
 
 `OPT_BIT(short, long, &int_var, description, mask)`::
 	Introduce a boolean option.
@@ -148,8 +153,9 @@ There are some macros to easily define options:
 	If used, `int_var` is bitwise-anded with the inverted `mask`.
 
 `OPT_SET_INT(short, long, &int_var, description, integer)`::
-	Introduce a boolean option.
-	If used, set `int_var` to `integer`.
+	Introduce an integer option.
+	`int_var` is set to `integer` with `--option`, and
+	reset to zero with `--no-option`.
 
 `OPT_SET_PTR(short, long, &ptr_var, description, ptr)`::
 	Introduce a boolean option.
diff --git a/parse-options.c b/parse-options.c
index 503ab5d..f0098eb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -83,7 +83,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value &= ~opt->defval;
 		return 0;
 
-	case OPTION_BOOLEAN:
+	case OPTION_COUNTUP:
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
 
@@ -319,7 +319,7 @@ static void parse_options_check(const struct option *opts)
 			err |= optbug(opts, "uses feature "
 					"not supported for dashless options");
 		switch (opts->type) {
-		case OPTION_BOOLEAN:
+		case OPTION_COUNTUP:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_SET_INT:
diff --git a/parse-options.h b/parse-options.h
index 59e0b52..22c0273 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -10,7 +10,7 @@ enum parse_opt_type {
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
-	OPTION_BOOLEAN, /* _INCR would have been a better name */
+	OPTION_COUNTUP,
 	OPTION_SET_INT,
 	OPTION_SET_PTR,
 	/* options with arguments (usually) */
@@ -21,6 +21,9 @@ enum parse_opt_type {
 	OPTION_FILENAME
 };
 
+/* Deprecated synonym */
+#define OPTION_BOOLEAN OPTION_COUNTUP
+
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
@@ -122,10 +125,11 @@ struct option {
 				      PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
-#define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, \
+#define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
@@ -149,6 +153,8 @@ struct option {
 	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
 
+/* Deprecated synonym */
+#define OPT_BOOLEAN OPT_COUNTUP
 
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
