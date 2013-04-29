From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Mon, 29 Apr 2013 08:04:56 -0700
Message-ID: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	<7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
	<5177AE7F.1040400@drmicha.warpmail.net>
	<7vehdzesr9.fsf@alter.siamese.dyndns.org>
	<vpqwqrrolpl.fsf@grenoble-inp.fr>
	<7v38ufdaih.fsf@alter.siamese.dyndns.org>
	<517A6C0C.1020506@drmicha.warpmail.net>
	<vpqk3npctn8.fsf@grenoble-inp.fr>
	<517E37A9.8040609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 29 17:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWpdd-0001Ij-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 17:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3D2PFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 11:05:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab3D2PFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 11:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B14F1A418;
	Mon, 29 Apr 2013 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4vr/8dOaHMT2+bd670VZtB7TCQ=; b=Pv/FUL
	OKl79510w1n83Gx8HmVz3UJbk2I0wvDLQ5ySM/tfgjIRWTAtOPro05FtJksMg7mI
	M/qnBJ1y3azx3fc75Tdluu/wJcGq46ccETSlrqoCNjUpPzjmSUlc8IW1PhClisPB
	uJRGLSIpKwXzj+McvFOXa/EA3DeBNDGd2oVjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FouatH3eAakI41m+UQ+4RrTkU9CataDU
	E1vVICMr2yGwbBUSIXx0QId4dGlb2CCKHjBa1hJJCHcvLruRL5INm8dbZMteO1CN
	yl0FZug91tXIqXtmzOMcj6TTmKx5HIoqE7KewDX9z9gjntHx+EYwrm38gG7T3xTG
	FtMtiacqwTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F22B1A417;
	Mon, 29 Apr 2013 15:04:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 722611A414;
	Mon, 29 Apr 2013 15:04:58 +0000 (UTC)
In-Reply-To: <517E37A9.8040609@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 29 Apr 2013 11:04:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28973D9E-B0DE-11E2-ABF0-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222799>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> It should be possible to have a tri-state for the --[no-]textconv
>> option: unset, set to true or set to false. But the code sharing between
>> log, show and diff might make that non-trivial.
>
> Right now it's a diffopt bit...

I wonder if you can do something along the lines of the attached
patch.  The following discussion assumes that your default wants
textconv for generating patches, and no textconv for showing blobs,
which is the case your "it is a bit" becomes an issue.

The basic structure is that:

 * There is an extra "opt->touched_flags" that keeps track of all
   the fields that have been touched by DIFF_OPT_SET and
   DIFF_OPT_CLR;

 * You may continue setting the default values to the flags, like
   commands in the "log" family do in cmd_log_init_defaults(), but
   after you finished setting the defaults, you clear the
   touched_flags field;

 * And then you let the usual callchain to call diff_opt_parse(),
   allowing the opt->flags be set or unset, while keeping track of
   which bits the user touched;

 * There is an optional callback "opt->set_default" that is called
   at the very beginning to lets you inspect touched_flags and
   update opt->flags appropriately, before the remainder of the
   diffcore machinery is set up, taking the opt->flags value into
   account.

Your "git show" could start out with ALLOW_TEXTCONV set, but notice
explicit requests to --[no-]textconv from the command line in your
set_default() callback.  And then when it deals with a blob, check
if the user touched ALLOW_TEXTCONV and appropriately act on that
knowledge.

There would be three cases in your set_default callback:

 * flags has ALLOW_TEXTCONV set, and the bit was touched: the user
   explicitly said --textconv because she wants blobs to be mangled;

 * flags has ALLOW_TEXTCONV set, and the bit was not touched: the
   user did not say --textconv; do not mangle blobs;

 * flags has ALLOW_TEXTCONV unset; the user did not say --textconv,
   or explicitly said --no-textconv; do not mangle blobs.

The set_default callback can also be used to adjust defaults for
fields that are not handled by the DIFF_OPT_SET/CLR/TST, by the way.
You can remember the address of the default value you fed to a
string field before entering the callchain to diff_opt_parse(), and
in your set_default callback see if the value is still pointing at
the same piece of memory (in which case the user did not touch it).

 builtin/log.c | 1 +
 diff.c        | 3 +++
 diff.h        | 7 +++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6e56a50..c62ecd1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -91,6 +91,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
+	rev->diffopt.touched_flags = 0;
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff.c b/diff.c
index f0b3e7c..7c24872 100644
--- a/diff.c
+++ b/diff.c
@@ -3213,6 +3213,9 @@ void diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
 
+	if (options->set_default)
+		options->set_default(options);
+
 	if (options->output_format & DIFF_FORMAT_NAME)
 		count++;
 	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
diff --git a/diff.h b/diff.h
index 78b4091..5c2f878 100644
--- a/diff.h
+++ b/diff.h
@@ -87,8 +87,8 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
+#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
@@ -109,6 +109,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	unsigned touched_flags;
 	int use_color;
 	int context;
 	int interhunkcontext;
@@ -145,6 +146,8 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	void (*set_default)(struct diff_options *);
+
 	FILE *file;
 	int close_file;
 
