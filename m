From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Refactor --dirstat parsing; deprecate --cumulative
 and --dirstat-by-file
Date: Wed, 27 Apr 2011 13:51:52 -0700
Message-ID: <7vaafb76zb.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-4-git-send-email-johan@herland.net>
 <7vy62xezqy.fsf@alter.siamese.dyndns.org>
 <201104270402.10658.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBiX-0000ia-Fe
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab1D0UwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 16:52:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab1D0UwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:52:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F97A45AC;
	Wed, 27 Apr 2011 16:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pp55JczqTS2dwEhexBUU1l+8IFc=; b=sYF5rh
	Z+4ITDIIcMSTOMKV0n4TIjC+btiJVYYn9LtZ5ErMekdsDWuK2YEBNlDMP43bsgSX
	iazjep7FbTOdickhLDygHVCf6LgQEHgWp94dFe1/HQpybpYkzPaanHlTFKKWBBnT
	4hjbc7w26buVGh+2YiEhKaQfZ6TviC7XxVkn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SgHQdumlN4E9Dz0rngSEu02Z8D8ErBTc
	zSOHFVW/s8kxU1OdVkQ9a/XleREBcHqL2ONzxOpzXhmU6bBjnGzCVBlxlZE2hEu2
	RgYUcgk/g54nQ/7hH/EcLqt0PMBabBsUAgLNYtfxE0yL746IeZOgYWWyKpmFFEY4
	MPj5wBnc/BQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC8B145AB;
	Wed, 27 Apr 2011 16:54:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2381045A9; Wed, 27 Apr 2011
 16:53:57 -0400 (EDT)
In-Reply-To: <201104270402.10658.johan@herland.net> (Johan Herland's message
 of "Wed, 27 Apr 2011 04:02:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B813C36-7110-11E0-B360-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172272>

Johan Herland <johan@herland.net> writes:

>> Even better, probably they can be left to diff_opt_parse() without
>> calling this function, as you are deprecating them and do not have to
>> allow them to take the opt1,opt2,... form of parameter.
>
> I understand, but politely disagree: Patch 6/6 complicates the logic
> that DIFF_OPT_SET()/CLR() various bits in the diff options. I'd rather
> keep that logic in one place, than duplicate it into diff_opt_parse().

I've given a brief look at the v3.  Looks better than the previous one;
not using double is especailly a big and good thing.

There still are a few things I noticed, two of which I'd attempt to show
how to fix in the attached patch (on top of the whole 6 patch series, as I
don't have time to break it down and I know you are capable enough to do
so yourself).

 * We eradicated the use of C99_FORMAT at 28bd70d (unbreak and eliminate
   NO_C99_FORMAT, 2011-03-16) and "%td" at 31d713d (mktag: avoid %td in
   format string, 2011-03-16).

 * parse_dirstat_params() can die when it sees an input that it does not
   understand, instead of silently returning and indicating an error by
   its return value, even when it is called from the codepath to read the
   configuration files.  Dying upon an erroneous command line argument is
   fine and diagnosing it is preferred, but the configuration parser
   should ignore values that it does not understand (may want to warn) so
   that you can keep using older git (i.e. the version resulting from your
   patch) in a repository you usually use newer git that supports even
   more features with its --dirstat option.

 * Temporary memory allocation in your dirstat_opt() to handle commonly
   used shorthand stands out as a sore thumb.

 * The parsing implemented in dirstat_opt() is a bit too loose.  For
   example, we never accepted "-X=3" nor "--dirstat40" but I suspect your
   parser would.  Accepting the former might not be such a big deal, but
   not the latter.

The attached is not a complete fix-up, but addresses the last two issues,
and it also should be a good starting point for the second issue.

I tried not to fix style issues, but parse_dirstat_params() should follow

	if (...) {
            ... compound ...
	} else if (...) {
            ... compound ...
	} else if (...) {
	    ...

i.e. close brace just before the "else if" on the same line.

 diff.c |   94 +++++++++++++++++++++++++++++----------------------------------
 1 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/diff.c b/diff.c
index 9008e88..7c6a8d1 100644
--- a/diff.c
+++ b/diff.c
@@ -73,9 +73,14 @@ static int parse_diff_color_slot(const char *var, int ofs)
 #define PD_FMT "%td"
 #endif
 
-static void parse_dirstat_params(struct diff_options *options, const char *params)
+static int parse_dirstat_params(struct diff_options *options, const char *params,
+				int die_on_error)
 {
 	const char *p = params;
+	const char *unknown_param_error = "Unknown --dirstat parameter '%s'";
+	const char *missing_comma_error = "Missing comma separator at char " PD_FMT
+		" of '%s'";
+
 	while (*p) {
 		if (!prefixcmp(p, "changes")) {
 			p += 7;
@@ -109,19 +114,27 @@ static void parse_dirstat_params(struct diff_options *options, const char *param
 				options->dirstat_permille += *p - '0';
 				/* .. and ignore any further digits */
 				while (isdigit(*++p))
-					/* nothing */;
+					; /* nothing */
 			}
+		} else if (die_on_error) {
+			die(unknown_param_error, p);
+		} else {
+			return error(unknown_param_error, p);
 		}
-		else
-			die("Unknown --dirstat parameter '%s'", p);
 
-		if (*p) { /* more parameters, swallow separator */
-			if (*p != ',')
-				die("Missing comma separator at char " PD_FMT
-				    " of '%s'", p - params, params);
-			p++;
+		if (*p) {
+			/* more parameters, swallow separator */
+			if (*p == ',') {
+				p++;
+				continue;
+			}
+			if (die_on_error)
+				die(missing_comma_error, p - params, params);
+			else
+				return error(missing_comma_error, p - params, params);
 		}
 	}
+	return 0;
 }
 
 static int git_config_rename(const char *var, const char *value)
@@ -205,7 +218,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "diff.dirstat")) {
 		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
-		parse_dirstat_params(&default_diff_options, value);
+		(void) parse_dirstat_params(&default_diff_options, value, 0);
 		diff_dirstat_permille_default = default_diff_options.dirstat_permille;
 		return 0;
 	}
@@ -3252,45 +3265,14 @@ static int stat_opt(struct diff_options *options, const char **av)
 	return argcount;
 }
 
-/*
- * Parse dirstat-related options and any parameters given to those options.
- * Returns 1 if the option in 'arg' is a recognized dirstat-related option;
- * otherwise returns 0.
- */
-static int dirstat_opt(struct diff_options *options, const char *arg)
+static int parse_dirstat_opt(struct diff_options *options, const char *params)
 {
-	const char *p;
-	char *mangled = NULL;
-
-	if (!strcmp(arg, "--cumulative")) /* deprecated */
-		/* handle '--cumulative' like '--dirstat=cumulative' */
-		p = "cumulative";
-	else if (!strcmp(arg, "--dirstat-by-file") ||
-		 !prefixcmp(arg, "--dirstat-by-file=")) { /* deprecated */
-		/* handle '--dirstat-by-file=*' like '--dirstat=files,*' */
-		mangled = xstrdup(arg + 12);
-		memcpy(mangled, "files", 5);
-		if (mangled[5]) {
-			assert(mangled[5] == '=');
-			mangled[5] = ',';
-		}
-		p = mangled;
-	}
-	else if (!prefixcmp(arg, "-X"))
-		p = arg + 2;
-	else if (!prefixcmp(arg, "--dirstat"))
-		p = arg + 9;
-	else
-		return 0;
-
+	parse_dirstat_params(options, params, 1);
+	/*
+	 * The caller knows a dirstat-related option is given from the command
+	 * line; allow it to say "return this_function();"
+	 */
 	options->output_format |= DIFF_FORMAT_DIRSTAT;
-
-	if (*p)
-		if (*p == '=')
-			p++;
-		parse_dirstat_params(options, p);
-
-	free(mangled);
 	return 1;
 }
 
@@ -3313,10 +3295,20 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (!prefixcmp(arg, "-X") || !prefixcmp(arg, "--dirstat") ||
-		 !strcmp(arg, "--cumulative"))
-		/* -X, --dirstat[=<args>], --dirstat-by-file, or --cumulative */
-		return dirstat_opt(options, arg);
+	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
+		return parse_dirstat_opt(options, "");
+	else if (!prefixcmp(arg, "-X"))
+		return parse_dirstat_opt(options, arg + 2);
+	else if (!prefixcmp(arg, "--dirstat="))
+		return parse_dirstat_opt(options, arg + 10);
+	else if (!strcmp(arg, "--cumulative"))
+		return parse_dirstat_opt(options, "cumulative");
+	else if (!strcmp(arg, "--dirstat-by-file"))
+		return parse_dirstat_opt(options, "files");
+	else if (!prefixcmp(arg, "--dirstat-by-file=")) {
+		parse_dirstat_opt(options, "files");
+		return parse_dirstat_opt(options, arg + 18);
+	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
