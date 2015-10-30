From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 11:48:36 -0700
Message-ID: <xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:48:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEjH-0001av-B3
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759864AbbJ3Ssn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:48:43 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755177AbbJ3Ssl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:48:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 885B3250CD;
	Fri, 30 Oct 2015 14:48:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fnb1dFuCJtxFVs67ilXLsUrHwW4=; b=gqCNd/
	OK0IuBdZewKIbfAlxAqYNkerDmBWclBT4egWvFl3Hc4z/2mq8fCxebdaQOZUS0TT
	BarjpXugl+aoeub4jo6Uj3CN2Y2E4/HbUzPTCpQjQuAnExulevnvHUYA7CEC9d+M
	4z9AfNPV1KVexbKBmQJ/1bZ8so4x3PJTGk8PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=msOFcpblvyySniDuhukBFqsv5CNxY0aQ
	E1cuG1/C/N6RA4zFaEv+sVAVI+B4eqknn8OsSfChHf2aR8Ye3TvT7g7apUhFoKSN
	NHhPTK17LLMPB2QKplbIiaQ4lswOssjeO4iJiOWzJib32h0aSkhLGnhUQaSEv0ED
	l1f7C2TUYsc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FCE4250CC;
	Fri, 30 Oct 2015 14:48:40 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07647250C9;
	Fri, 30 Oct 2015 14:48:39 -0400 (EDT)
In-Reply-To: <CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 30 Oct 2015 14:12:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D607B37C-7F36-11E5-95B3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280519>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 29, 2015 at 9:23 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> Under normal circumstances, and like other git commands,
>> git checkout will write progress info to stderr if
>> attached to a terminal. This option allows progress
>> to be forced even if not using a terminal. Also,
>> progress can be skipped if using option --no-progress.
>>
>> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
>> ---
>> -       opts.verbose_update = !o->quiet && isatty(2);
>> +       /**
>> +        * Rules to display progress:
>> +        * -q is selected
>> +        *      no verbiage
>> +        * -q is _not_ selected and --no-progress _is_ selected,
>> +        *      progress will be skipped
>> +        * -q is _not_ selected and --progress _is_ selected,
>> +        *      progress will be printed to stderr
>> +        * -q is _not_ selected and --progress is 'undefined'
>> +        *      progress will be printed to stderr _if_ working on a terminal
>> +        */
>> +       opts.verbose_update = !o->quiet && (option_progress > 0 ||
>> +                                          (option_progress < 0 && isatty(2)));
>
> Does this logic also need to be applied to the other instance where
> isatty() is consulted in merge_working_tree()?

This makes me wonder if option_progress and o->quiet change once
parse_options() finished doing its job.  If we know that these two
will never change once parse_options() is done, then we can
introduce a variable "show_progress", assign the value of that
variable to opts.verbose_update in these places and then arrange
that variable is set to the combination of quiet, option_progress
and isatty(2) just once after parse_options().

That is, something like this on top of Edmundo's patch.

 builtin/checkout.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e28c36b..53d7c49 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,7 +27,7 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
-static int option_progress = -1;
+static int show_progress = 1;
 
 struct checkout_opts {
 	int patch_mode;
@@ -430,8 +430,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	 * -q is _not_ selected and --progress is 'undefined'
 	 *      progress will be printed to stderr _if_ working on a terminal
 	 */
-	opts.verbose_update = !o->quiet && (option_progress > 0 ||
-					   (option_progress < 0 && isatty(2)));
+	opts.verbose_update = show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -515,7 +514,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet && isatty(2);
+		topts.verbose_update = show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1143,6 +1142,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct branch_info new;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
+	int option_progress = -1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1187,6 +1187,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	show_progress = (!opts.quiet &&
+			 (0 < option_progress || (option_progress < 0 && isatty(2))));
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
