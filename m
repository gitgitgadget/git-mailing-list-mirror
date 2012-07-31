From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] grep: rename "grep.extendedRegexp" option to
 "grep.patternType"
Date: Tue, 31 Jul 2012 16:22:54 -0700
Message-ID: <7vpq7bh5wx.fsf@alter.siamese.dyndns.org>
References: <1343775209-56505-1-git-send-email-dark.panda@gmail.com>
 <1343775209-56505-2-git-send-email-dark.panda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Smith <dark.panda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 01:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLmK-0002RR-MH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 01:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab2GaXW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 19:22:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756239Ab2GaXW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 19:22:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81989365;
	Tue, 31 Jul 2012 19:22:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zEOfO7VuJ6F8kWc1ENZR58mOIFc=; b=DgFraK
	VWrnxbqxZASm4Y7DR9jpKU/0OcmVJVpqFGkgPEcj+RBqxJBDFyw9gHTucvucrKCG
	gNQjJTAVXawtS53mXM4nTpDHbCVGq/nQ76fEW28q2k4N4YELwMSodezAV/8TBgwX
	zWpctp9ULahOa4T4MQt7dr5XVKAHg36yt3P9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tJrtdgmqWtgVfyVWiB0O8S7en/ZhqLZZ
	wN3G4GcG9+GU+SZ8n5vfGzjWDLi5ehVxV8fNhxFI+cHya84yqpHFektE9lSrGrmg
	hT6pz54Nwh4xvveFsmqsrWhl4w+7t5DUzHqd1SkNllBCSV8mwlkhFeQnpb3JTCV9
	QiduTkeqO04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D51149364;
	Tue, 31 Jul 2012 19:22:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2097B9363; Tue, 31 Jul 2012
 19:22:56 -0400 (EDT)
In-Reply-To: <1343775209-56505-2-git-send-email-dark.panda@gmail.com> (J.
 Smith's message of "Tue, 31 Jul 2012 18:53:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8B51922-DB66-11E1-A69B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202694>

J Smith <dark.panda@gmail.com> writes:

> With the addition of the "basic", "extended", "fixed", and "perl"
> values for the "grep.extendedRegexp" option the name "grep.patternType"
> better represents the option's functionality. "grep.extendedRegexp"
> remains available as an alias to "grep.patternType" for the purposes of
> backwards compatibility.
> ---

Sorry for not bringing this up earlier when we discussed grep.patternType,
but my preference would be to introduce grep.patternType with these
type names (including basic and perl) from the beginning, and then
ignore grep.extendedRegexp if grep.patternType is set.

The core part of the change may look something like this...

diff --git a/builtin/grep.c b/builtin/grep.c
index 29adb0a..260a7db 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -260,6 +260,57 @@ static int wait_all(void)
 }
 #endif
 
+static int parse_pattern_type_arg(const char *opt, const char *arg)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return GREP_PATTERN_TYPE_ERE;
+	case 0:
+		return GREP_PATTERN_TYPE_UNSPECIFIED;
+	default:
+		if (!strcmp(arg, "basic"))
+			return GREP_PATTERN_TYPE_BRE;
+		else if (!strcmp(arg, "extended"))
+			return GREP_PATTERN_TYPE_ERE;
+		else if (!strcmp(arg, "fixed"))
+			return GREP_PATTERN_TYPE_FIXED;
+		else if (!strcmp(arg, "perl"))
+			return GREP_PATTERN_TYPE_PCRE;
+		die("bad %s argument: %s", opt, arg);
+	}
+}
+
+static void grep_pattern_type_options(const int pattern_type, void *cb)
+{
+	struct grep_opt *opt = cb;
+
+	switch (pattern_type) {
+	case GREP_PATTERN_TYPE_BRE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_ERE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags |= REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_FIXED:
+		opt->fixed = 1;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		opt->pcre = 1;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+	}
+}
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -269,10 +320,18 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
-		if (git_config_bool(var, value))
-			opt->regflags |= REG_EXTENDED;
-		else
-			opt->regflags &= ~REG_EXTENDED;
+		if (!opt->pattern_type_used) {
+			if (git_config_bool(var, value))
+				opt->regflags |= REG_EXTENDED;
+			else
+				opt->regflags &= ~REG_EXTENDED;
+		}
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.patterntype")) {
+		grep_pattern_type_options(parse_pattern_type_arg(var, value), opt);
+		opt->pattern_type_used = 1;
 		return 0;
 	}
 
@@ -669,14 +728,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int use_index = 1;
-	enum {
-		pattern_type_unspecified = 0,
-		pattern_type_bre,
-		pattern_type_ere,
-		pattern_type_fixed,
-		pattern_type_pcre,
-	};
-	int pattern_type = pattern_type_unspecified;
+	int pattern_type = GREP_PATTERN_TYPE_UNSPECIFIED;
 
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
@@ -705,16 +757,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_SET_INT('E', "extended-regexp", &pattern_type,
 			    "use extended POSIX regular expressions",
-			    pattern_type_ere),
+			    GREP_PATTERN_TYPE_ERE),
 		OPT_SET_INT('G', "basic-regexp", &pattern_type,
 			    "use basic POSIX regular expressions (default)",
-			    pattern_type_bre),
+			    GREP_PATTERN_TYPE_BRE),
 		OPT_SET_INT('F', "fixed-strings", &pattern_type,
 			    "interpret patterns as fixed strings",
-			    pattern_type_fixed),
+			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type,
 			    "use Perl-compatible regular expressions",
-			    pattern_type_pcre),
+			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
@@ -824,28 +876,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
-	switch (pattern_type) {
-	case pattern_type_fixed:
-		opt.fixed = 1;
-		opt.pcre = 0;
-		break;
-	case pattern_type_bre:
-		opt.fixed = 0;
-		opt.pcre = 0;
-		opt.regflags &= ~REG_EXTENDED;
-		break;
-	case pattern_type_ere:
-		opt.fixed = 0;
-		opt.pcre = 0;
-		opt.regflags |= REG_EXTENDED;
-		break;
-	case pattern_type_pcre:
-		opt.fixed = 0;
-		opt.pcre = 1;
-		break;
-	default:
-		break; /* nothing */
-	}
+
+	grep_pattern_type_options(pattern_type, &opt);
 
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
