From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack --max-pack-size broken in git-next
Date: Tue, 21 Jan 2014 15:26:23 -0800
Message-ID: <xmqqsisgsyqo.fsf@gitster.dls.corp.google.com>
References: <52DEF927.7090005@fb.com>
	<xmqqzjmprlbq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 00:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kiJ-0004gS-M3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbaAUX0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:26:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaAUX0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:26:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 072B26609E;
	Tue, 21 Jan 2014 18:26:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o60wiOL6jEOngitADuGqXVdjE1A=; b=vUfVy+
	8kVHuijOMrMQu4LjEHlmZmbIA3gpvWeSPvTRtxsdn9aGkUu+w5z0GR9rRnAc2qyP
	87ryqQwqCKwJQKLg1jxmICYT8Xl66ifd6QtAOM2SVffDSbWa0ZDbIZkSBAVZVn+g
	yhniuA2M6TnpNrA01Z0v5xMIbZdPxLm0p7nsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6GHXYD5NyR4ghjgUHvfB1cJgKmuFQwn
	ZrQ22H/wpJFPAW2cUvyPbztOcjmZU3eIKDidozlgcEfZ/DhegyTfVyVFoy1mShah
	EX4YjZts7TD7qy/HDHz+NA9efV0I3VtYj0j7YUrqrdk6A8vd2a8T5A6TzX40g+lo
	Qqtxm5dTGfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C006609D;
	Tue, 21 Jan 2014 18:26:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6F8B6609C;
	Tue, 21 Jan 2014 18:26:28 -0500 (EST)
In-Reply-To: <xmqqzjmprlbq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jan 2014 15:01:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 742AFAEC-82F3-11E3-B5D6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240802>

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Agarwal <sid0@fb.com> writes:
>
>> With git-next, the --max-pack-size option to git repack doesn't work.
>>
>> With git at b139ac2, `git repack --max-pack-size=1g` says
>>
>> error: option `max-pack-size' expects a numerical value
>
> Thanks, Siddharth.
>
> It seems that we have a hand-crafted parser outside parse-options
> framework in pack-objects, and the scripted git-repack used to pass
> this option without interpreting itself.
>
> We probably should lift the OPT_ULONG() implementation out of
> builtin/pack-objects.c and move it to parse-options.[ch] and use it
> in the reimplementation of repack.
>
> And probably use it in other places where these "integers in
> human-friendly units" may make sense, but that is a separate topic.

The first step may look something like this (totally untested)..

 builtin/pack-objects.c | 22 +++-------------------
 parse-options.c        | 17 +++++++++++++++++
 parse-options.h        |  3 +++
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 541667f..b264f1f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2416,23 +2416,6 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_ulong(const struct option *opt,
-			      const char *arg, int unset)
-{
-	if (unset)
-		die(_("option %s does not accept negative form"),
-		    opt->long_name);
-
-	if (!git_parse_ulong(arg, opt->value))
-		die(_("unable to parse value '%s' for option %s"),
-		    arg, opt->long_name);
-	return 0;
-}
-
-#define OPT_ULONG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "n", (h),	\
-	  PARSE_OPT_NONEG, option_parse_ulong }
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -2462,8 +2445,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("ignore packed objects")),
 		OPT_INTEGER(0, "window", &window,
 			    N_("limit pack window by objects")),
-		OPT_ULONG(0, "window-memory", &window_memory_limit,
-			  N_("limit pack window by memory in addition to object limit")),
+		{ OPTION_ULONG, 0, "window-memory", &window_memory_limit, N_("n"),
+		  N_("limit pack window by memory in addition to object limit"),
+		  PARSE_OPT_HUMAN_NUMBER },
 		OPT_INTEGER(0, "depth", &depth,
 			    N_("maximum length of delta chain allowed in the resulting pack")),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..3a47538 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -180,6 +180,23 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
+			return -1;
+		} else if (opt->flags & PARSE_OPT_HUMAN_NUMBER) {
+			if (!git_parse_ulong(arg, (unsigned long *)opt->value))
+				return opterror(opt, "expects a numerical value", flags);
+		} else {
+			*(unsigned long *)opt->value = strtoul(arg, (char **)&s, 10);
+			if (*s)
+				return opterror(opt, "expects a numerical value", flags);
+		}
+		return 0;
+
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
diff --git a/parse-options.h b/parse-options.h
index d670cb9..6a3cce0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -17,6 +17,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
+	OPTION_ULONG,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
@@ -38,6 +39,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
+	PARSE_OPT_HUMAN_NUMBER = 128,
 	PARSE_OPT_SHELL_EVAL = 256
 };
 
@@ -133,6 +135,7 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_ULONG(s, l, v, h)       { OPTION_ULONG, (s), (l), (v), N_("n"), (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
