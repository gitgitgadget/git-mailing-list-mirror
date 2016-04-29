From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 15:18:08 -0700
Message-ID: <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
	<xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:18:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awGjo-000754-0V
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcD2WSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 18:18:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751679AbcD2WSL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 18:18:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C1018AF1;
	Fri, 29 Apr 2016 18:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MugMPnX0ek9EaiSgK2r6mC6XSZ4=; b=nkmGj4
	hXjAJYMnfmqen8bOJmMdpQkbUo0iTUmEtQp0GRo/D29NXrehoCchJ00JCFNcMj5M
	AqSN1R5YYjJ7MMoJRm4cHKVE5pBaadc0BCNsji0Y9EltnlgHpfhx+FWDrLx5E6I+
	Wphf7K6wVB0aqQmmxHi3XYeeGdRXssSj4UCkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sT1rxt0G8aCHytZMvhyIPVra45Lk2Kb1
	CO6IoWz7vPMAyQfLgJooMzXPCuxaWSR0AzvglerygIB6iFCxUOINOyGXw7/xC2iO
	ji7uk/OIvEYQf/u8wuhcfPjDZcx8oeZrBLIy13r+mpgqKTnqmwoYcwrds99Pj0kO
	Y4SbgGlMLeQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D60E18AF0;
	Fri, 29 Apr 2016 18:18:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90D4618AEF;
	Fri, 29 Apr 2016 18:18:09 -0400 (EDT)
In-Reply-To: <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	(Jacob Keller's message of "Fri, 29 Apr 2016 13:59:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 414118A8-0E58-11E6-A4F9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293061>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Apr 29, 2016 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> ... Having the two directly next to each other reads
>>> better to me. This is a pretty unusual diff, though, in that it did
>>> change the surrounding whitespace (and if you look further in the diff,
>>> the identical change is made elsewhere _without_ touching the
>>> whitespace). So this is kind of an anomaly. And IMHO the weirdness here
>>> is outweighed by the vast number of improvements elsewhere.
>>
>> So... is everybody happy with the result and now we can drop the
>> tweaking knob added to help experimentation before merging the
>> result to 'master'?
>>
>> I am pretty happy with the end result myself.
>
> I am very happy with it. I haven't had any issues, and I think we'll
> find better traction by enabling it at this point and seeing when/if
> someone complains.
>
> I think for most it won't be noticed and for those that do it will
> likely be positive.

I am doing this only to prepare in case we have a concensus,
i.e. this is not to declare that I do not care what other people
say.  Here is a patch to remove the experimentation knob.

Let's say we keep this patch out of tree for now and keep the topic
in 'next' so that people can further play with it for several more
weeks, and then apply this on top and merge the result to 'master'
early in the next cycle.

-- >8 --
diff: enable "compaction heuristics" and lose experimentation knob

It seems that the new "find a good hunk boundary by locating a blank
line" heuristics gives much more pleasant result without much
noticeable downsides.  Let's make it the new algorithm for real,
without the opt-out knob we added while experimenting with it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt  |  5 -----
 Documentation/diff-options.txt |  6 ------
 diff.c                         | 11 -----------
 xdiff/xdiff.h                  |  2 --
 xdiff/xdiffi.c                 |  2 +-
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 9bf3e92..6eaa452 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -166,11 +166,6 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
-diff.compactionHeuristic::
-	Set this option to enable an experimental heuristic that
-	shifts the hunk boundary in an attempt to make the resulting
-	patch easier to read.
-
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b513023..3ad6404 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,12 +63,6 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
---compaction-heuristic::
---no-compaction-heuristic::
-	These are to help debugging and tuning an experimental
-	heuristic that shifts the hunk boundary in an attempt to
-	make the resulting patch easier to read.
-
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
diff --git a/diff.c b/diff.c
index 05ca3ce..f62b7f7 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,6 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_compaction_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -184,10 +183,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
-		diff_compaction_heuristic = git_config_bool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
@@ -3240,8 +3235,6 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
-	if (diff_compaction_heuristic)
-		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3719,10 +3712,6 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--compaction-heuristic"))
-		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
-	else if (!strcmp(arg, "--no-compaction-heuristic"))
-		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index d1dbb27..c033991 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,8 +41,6 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
-#define XDF_COMPACTION_HEURISTIC (1 << 8)
-
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b3c6848..574f83c 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -522,7 +522,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * As we already shifted the group forward as far as possible
 		 * in the earlier loop, we need to shift it back only if at all.
 		 */
-		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+		if (blank_lines) {
 			while (ixs > 0 &&
 			       !is_blank_line(recs, ix - 1, flags) &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
