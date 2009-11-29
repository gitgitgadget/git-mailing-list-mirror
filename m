From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Mention of 1.7.0 transition plans in Release Notes to
 1.6.6
Date: Sat, 28 Nov 2009 23:24:26 -0800
Message-ID: <7vmy25dc9h.fsf@alter.siamese.dyndns.org>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 08:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEe99-0000IR-5R
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbZK2HY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZK2HY1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:24:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK2HY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:24:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E5228358A;
	Sun, 29 Nov 2009 02:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2JcNnjbGIR6Bne9r/jIsBsyLtJs=; b=DeqUOsd6Pu/qG+aBEF2huro
	xlI3YvXzj5rClMwPvof+G5N+4YTw8SRMXUT0tmGa7p/XCFR/DdCHWGuP/LqRlZq6
	b9MyCh/I6lOaQtKveL4iMlOJO4ovG3xWR86DXMSBysc5ek7pyrNVSHV2B1CFo0Cc
	wEu0/f9Srw3o+tLtzfVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=q7mtuitM/+N1XS5fqF7XfS5nM4OGJvXMZmR0IJYruGFFPN0wv
	yKXZEunD7S7jb8wioC6mHdJNDOkdo+R8hnpjPvq0sfl6GbD8bRJ3abEfvq/HiG14
	D7qxFkzflr2mWp2TldpTAt2YYrCGK5I1cL1yhFVeZdHBhYuej2FpWOiJDE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F07F083589;
	Sun, 29 Nov 2009 02:24:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4919083588; Sun, 29 Nov
 2009 02:24:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B96BB2A-DCB8-11DE-8969-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133996>

Junio C Hamano <gitster@pobox.com> writes:

>  - I do not think of a sane way to cover "diff -b/-w" changes, as this is
>    a "bugfix --- but there may be some scripts that have been relying on
>    the bug", and a configuration option that retains the buggy behaviour
>    does not make much sense.  But I may be mistaken and somebody can come
>    up with an easy patch to allow both behaviour, in which case we should
>    add similar anti-procrastination measure to this change.

The patch to enable/disable this feature would look like the attached,
which doesn't look too bad.  This apply to a merge between two topics:

    jc/1.7.0-diff-whitespace-only-status (97bf2a0)
    gb/1.7.0-diff-whitespace-only-output (3e97c7c)

An anti-procrastination measure must be done in at least two, but probably
in three steps on top of this patch:

 #1. Flip the default in this patch back to 1, as the traditional
     behaviour is to treat ignore-whitespace options as purely affecting
     output of patch text, not affecting status nor the header;

 #2. Add extra logic to detect if a particular invocation may trigger a
     different behaviour once the default is changed to 0, and issue an
     warning if there is no configuration explicitly set;

 #3. Flip the default to 0, perhaps still keeping the warning when there
     is no configuration.

Make a major release after the second step is done, and wait for at least
one but preferrably two releases, and then ship the result of the third
step in the "flag day" release.  In a much later version we would remove
the "no configuration warning".

Do we need an anti-procrastination measure for this?  If so, I think we
probably need to postpone the "diff" semantics changes after 1.7.0, as I
am not very confident that we can solidly finish the second step before
the 1.6.6 final.

Also, I am not very keen on having this configuration, as its only purpose
is to ask for a broken semantics from "diff", even though it has been the
traditional behaviour for the past four years.

Comments?

---
 diff.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index da90e6e..6e7c47c 100644
--- a/diff.c
+++ b/diff.c
@@ -29,6 +29,7 @@ static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
+static int diff_b_w_output_only;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -133,6 +134,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.bwoutputonly")) {
+		diff_b_w_output_only = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_color_default_config(var, value, cb);
 }
 
@@ -1668,7 +1674,7 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS)) {
+		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS) || diff_b_w_output_only) {
 			fprintf(o->file, "%s", header.buf);
 			strbuf_reset(&header);
 		}
@@ -2537,9 +2543,10 @@ int diff_setup_done(struct diff_options *options)
 	 * inside contents.
 	 */
 
-	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
+	if (!diff_b_w_output_only &&
+	    (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
+	     DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
+	     DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL)))
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
-- 
1.6.6.rc0.61.g41d5b.dirty
