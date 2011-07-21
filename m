From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git exclusions
Date: Thu, 21 Jul 2011 09:25:19 +0200
Message-ID: <CAKPyHN3JT1xmJMnSYS2q=AYCjKnodM8iLRjdnU+FA8K_zSO0-Q@mail.gmail.com>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
	<7vzkk86577.fsf@alter.siamese.dyndns.org>
	<CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 09:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjndN-000604-2K
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 09:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab1GUHZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 03:25:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34270 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1GUHZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 03:25:20 -0400
Received: by vws1 with SMTP id 1so705772vws.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mkGGL7+P/C3yniBl6T4ZnVyX6mvUAJihM7QqE8mLLZ4=;
        b=tYMI+0pc67vcYBT3lddPDNU05diN7afRpJfv0tl6AqM6vkEU4XwOOOfrFhasBvht6l
         rOuT1KO77BaZ1SBhcfadzQNcXpfswMrzeqflAOk3vap+Y/DYpOcLUTr8UYv4fjlHN1KR
         Y3RFAz4EQSJxJoDvtQRHeBm0UMZoUVgl214l8=
Received: by 10.52.95.65 with SMTP id di1mr1098901vdb.61.1311233119738; Thu,
 21 Jul 2011 00:25:19 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 21 Jul 2011 00:25:19 -0700 (PDT)
In-Reply-To: <CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2011/7/21 Bert Wesarg <bert.wesarg@googlemail.com>:
>
> It should be. But I think that unveils one of the shortcomings of the
> (any) option parser: You wont get notified when an option was given,
> regardless of its value. To handle the above I would have to use
> OPTION_CALLBACK to set an addition flag exc_given (like it is done in
> git-ls-files) and test against this. The same problem is possible for
> a number option, if you want to know whether the option was actually
> given on the command line, one need to invent an invalid value (which
> isn't always possible) and use this as the initializer or use
> OPTION_CALLBACK again.

Here is a proof-of-concept patch (probably whitespace damaged) to make
it more clear what I meant:

--- >8 ---
Subject: [PoC/RFC/PATCH] parse-option: flag the presence of an option regardless
 of its value

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 parse-options.c |   15 +++++++++++++--
 parse-options.h |   20 ++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 73bd28a..df0f483 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -156,7 +156,10 @@ static int parse_short_opt(struct parse_opt_ctx_t
*p, const struct option *optio
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, OPT_SHORT);
+			if (options->given) {
+				*options->given = 1;
+				return get_value(p, options, OPT_SHORT);
+			}
 		}

 		/*
@@ -171,6 +174,9 @@ static int parse_short_opt(struct parse_opt_ctx_t
*p, const struct option *optio
 		char *arg;
 		int rc;

+		if (options->given)
+			*options->given = 1;
+
 		while (isdigit(p->opt[len]))
 			len++;
 		arg = xmemdupz(p->opt, len);
@@ -254,6 +260,8 @@ is_abbreviated:
 				continue;
 			p->opt = rest + 1;
 		}
+		if (options->given)
+			*options->given = 1;
 		return get_value(p, options, flags);
 	}

@@ -276,8 +284,11 @@ static int parse_nodash_opt(struct
parse_opt_ctx_t *p, const char *arg,
 	for (; options->type != OPTION_END; options++) {
 		if (!(options->flags & PARSE_OPT_NODASH))
 			continue;
-		if (options->short_name == arg[0] && arg[1] == '\0')
+		if (options->short_name == arg[0] && arg[1] == '\0') {
+			if (options->given)
+				*options->given = 1;
 			return get_value(p, options, OPT_SHORT);
+		}
 	}
 	return -2;
 }
diff --git a/parse-options.h b/parse-options.h
index d1b12fe..7fe3d49 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -100,6 +100,10 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   OPTION_{BIT,SET_INT,SET_PTR} store the {mask,integer,pointer} to put in
  *   the value when met.
  *   CALLBACKS can use it like they want.
+ *
+ * `given`::
+ *   Pointer to a flag variable which is set to 1 if this option was given.
+ *   The flag should be 0 initialized, to make sense.
  */
 struct option {
 	enum parse_opt_type type;
@@ -112,6 +116,7 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+	int *given;
 };

 #define OPT_END()                   { OPTION_END }
@@ -146,6 +151,21 @@ struct option {
 	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }

+/* same as above but with given flag pointer */
+#define OPT_BIT_GIVEN(s, l, v, h, b, g) \
+	{ OPTION_BIT,     (s), (l), (v), NULL, (h), PARSE_OPT_NOARG, NULL, (b), (g) }
+#define OPT_NEGBIT_GIVEN(s, l, v, h, b, g) \
+	{ OPTION_NEGBIT,  (s), (l), (v), NULL, (h), PARSE_OPT_NOARG, NULL, (b), (g) }
+#define OPT_BOOLEAN_GIVEN(s, l, v, h, g) \
+	{ OPTION_BOOLEAN, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG, NULL, 0, (g) }
+#define OPT_SET_INT_GIVEN(s, l, v, h, i, g) \
+	{ OPTION_SET_INT, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG, NULL, (i), (g) }
+#define OPT_SET_PTR_GIVEN(s, l, v, h, p, g) \
+	{ OPTION_SET_PTR, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG, NULL, (p), (g) }
+#define OPT_INTEGER_GIVEN(s, l, v, h, g) \
+	{ OPTION_INTEGER, (s), (l), (v), "n", (h), 0, NULL, 0, (g) }
+#define OPT_STRING_GIVEN(s, l, v, a, h, g) \
+	{ OPTION_STRING,  (s), (l), (v), (a), (h), 0, NULL, 0, (g) }

 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
-- 
1.7.6.588.g8d735
