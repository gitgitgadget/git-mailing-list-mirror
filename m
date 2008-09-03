From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Add --filedirstat diff option
Date: Tue, 02 Sep 2008 17:28:59 -0700
Message-ID: <7vbpz6dqd0.fsf_-_@gitster.siamese.dyndns.org>
References: <20080901011259.GA31696@zakalwe.fi>
 <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
 <20080902115848.GA1252@jolt.modeemi.cs.tut.fi>
 <7vwshuglq1.fsf@gitster.siamese.dyndns.org>
 <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
 <20080903000827.GB1252@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <shd@modeemi.fi>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:30:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KagGQ-0003O5-Tz
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYICA3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbYICA3I
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:29:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbYICA3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:29:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0770871247;
	Tue,  2 Sep 2008 20:29:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE48F71245; Tue,  2 Sep 2008 20:29:01 -0400 (EDT)
In-Reply-To: <20080903000827.GB1252@jolt.modeemi.cs.tut.fi> (Heikki Orsila's
 message of "Wed, 3 Sep 2008 03:08:27 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50701384-794F-11DD-9516-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94749>

Heikki Orsila <shd@modeemi.fi> writes:

> I wouldn't add new semantics for --dirstat=x since it's easy to add 
> new options. We already have --cumulative, so adding options is not 
> new. How about "--dirstat --filemode"? It's long, but it is obvious. I 
> don't think length is relevant here. A shorter but obscure syntax would 
> be "--dirstat2" :-) 

I wouldn't actually buy "easy to add" argument.  Following the
easiest-to-implement path down often result in inconsistent and messy UI.

IOW, I may use that expression from time to time like: "while it may be
easy to add another option, that would lead to many options that depend on
other options, with a messy end result", in a negative sense.

But you are right to point out that --cumulative is an option that affects
how --dirstat operates.  And I think the option parsing of that code is
buggy.  It should imply --dirstat, shouldn't it?

So I do not mind --filemode or whatever option that is expressed as a
word on the command line separate from --dirstat, but we really should
consider this and --cumulative conceptually a sub-option to --dirstat.

Here is a sample patch to fix --cumulative (but of course it is untested);
I think your --filemode (or whatever its final name is) should hook into
the same place as this patch touches, as far as command line parsing is
concerned.

-- >8 --
diff --cumulative is a sub-option of --dirstat

The option used to be implemented as if it is a totally independent one,
but "git diff --cumulative" would not mean anything without "--dirstat".

This makes --cumulative imply --dirstat.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |    9 ++++++---
 diff.h |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git c/diff.c w/diff.c
index 135dec4..cbd151b 100644
--- c/diff.c
+++ w/diff.c
@@ -1078,7 +1078,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.percent = options->dirstat_percent;
-	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
+	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
 
 	changed = 0;
 	for (i = 0; i < q->nr; i++) {
@@ -2300,6 +2300,7 @@ void diff_setup(struct diff_options *options)
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_percent = 3;
+	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
 	options->context = 3;
 
 	options->change = diff_change;
@@ -2472,8 +2473,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
-	else if (!strcmp(arg, "--cumulative"))
-		options->output_format |= DIFF_FORMAT_CUMULATIVE;
+	else if (!strcmp(arg, "--cumulative")) {
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+		DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
diff --git c/diff.h w/diff.h
index 50fb5dd..7f53beb 100644
--- c/diff.h
+++ w/diff.h
@@ -31,7 +31,6 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
 #define DIFF_FORMAT_DIRSTAT	0x0040
-#define DIFF_FORMAT_CUMULATIVE	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
@@ -64,6 +63,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_CHECK_FAILED        (1 << 16)
 #define DIFF_OPT_RELATIVE_NAME       (1 << 17)
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
+#define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
