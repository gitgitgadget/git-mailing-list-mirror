From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Add a new config. option for skipping merges in git-log
Date: Mon, 16 Mar 2015 14:58:34 -0700
Message-ID: <xmqqlhiwppth.fsf@gitster.dls.corp.google.com>
References: <5506E751.8010506@posteo.de>
	<xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>
	<5507301B.2060401@posteo.de>
	<xmqqy4mwpsyn.fsf@gitster.dls.corp.google.com>
	<55074440.90709@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXd23-0007Rv-9b
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 22:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934234AbbCPV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 17:58:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933728AbbCPV6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 17:58:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 676E540DB9;
	Mon, 16 Mar 2015 17:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFCk9nzhJCwQHOv/2UMEA8BGkSg=; b=XOh+Qs
	A9awZC26sZNCd1cmtT4fUwbD7ISSWEllRNaskllGHbhWjwdpW7FLnm8x0ZyZCRHU
	BdtEt+NycGs6NmTm9BkW+JXluRM1943l744ZNM2aEBcOsHm/Ig2lHUytjjaI9l+6
	2myGgnC83XtQUz42AvS6vnCyKo5NriE8E+JPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BJ/wmU7CFqYnyopl+WjMaNhLRgiLHgHw
	wECZVzzcgN+G8FvVDQBGWT5L+2GI8/gj/S6JgR0cifQXQoRMdCtgg+RWeYbDao9G
	oshqFdPKmbUXZyv9Vfb6/OOKwboyY3v2nmJ9E2bZnaqtecWqdjpq7OM+CttV2hQG
	fT1X4IYw94c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FD0B40DB8;
	Mon, 16 Mar 2015 17:58:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7F7240DB7;
	Mon, 16 Mar 2015 17:58:35 -0400 (EDT)
In-Reply-To: <55074440.90709@posteo.de> (Koosha Khajehmoogahi's message of
	"Mon, 16 Mar 2015 21:59:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9839F57C-CC27-11E4-83CE-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265597>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> On 03/16/2015 09:50 PM, Junio C Hamano wrote:
>> The command line overrides the config, no?  If you set up what the
>> command line defaults to from the config, let the command line
>> parser do whatever it wants to do, and do nothing else after the
>> command line parser returns, wouldn't that be sufficient?
>> 
>> Puzzled...
>> 
>
> Yes, the command line overrides the config. But, the config and command
> line parameters are parsed in two different files. The question is how
> you would read the config in revision.c while parsing the command line
> when there is no function in revision.c for that?

What I had in mind was along the line of the attached diff.

If I were doing this new feature, it would be in two-patch series,
whose first patch [1/2] would be just the revision.[ch] to give
these three "canned" selection options (we obviously need to update
the documentation and also add tests to make sure the new option
behaves sensibly when used alone, and in conjunction with existing
"--merges" and "--no-merges" options).  The second patch [2/2] would
teach git_log_config() to read the new configuration value and keep
it in a file-scope static variable in builtin/log.c, and then call
parse_merges_opt() with that value in the codepath somewhere after
init_revisions() is called on &rev and before setup_revisions() is
called.

Note that the addition I made to cmd_log() below is for illustration
purposes only; I have no strong opinion on whether it is at the
right place in the codepath (it is one place that is "between
init_revisions() and setup_revisions()", but it may not be the best
such place).  The call may want to be made a lot later in the
codepath, possibly inside cmd_log_init() instead of cmd_log(), for
example.  The choice depends on how widely you would want this new
configuration be honored, which I didn't think too deeply.  The
questions you would need to answer before deciding where is the best
place to make the call include:

 - Should "git whatchanged" also pay attention to it?
 - What about "git show"?

etc.


 builtin/log.c |  5 +++++
 revision.c    | 20 ++++++++++++++++++++
 revision.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..11a191d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -36,6 +36,7 @@ static int decoration_given;
 static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
+static const char *log_merges;
 
 static const char * const builtin_log_usage[] = {
 	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
@@ -397,6 +398,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "log.merges"))
+		return git_config_string(&log_merges, var, value);
 	if (grep_config(var, value, cb) < 0)
 		return -1;
 	if (git_gpg_config(var, value, cb) < 0)
@@ -628,6 +631,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
+	if (log_merges && parse_merges_opt(&rev, log_merges))
+		die("unknown config value for log.merges: %s", log_merges);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
diff --git a/revision.c b/revision.c
index dbee26b..2fa37b0 100644
--- a/revision.c
+++ b/revision.c
@@ -1678,6 +1678,23 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+int parse_merges_opt(struct rev_info *revs, const char *param)
+{
+	if (!strcmp(param, "both")) {
+		revs->min_parents = 0;
+		revs->max_parents = -1;
+	} else if (!strcmp(param, "only")) {
+		revs->min_parents = 2;
+		revs->max_parents = -1;
+	} else if (!strcmp(param, "skip")) {
+		revs->min_parents = 0;
+		revs->max_parents = 1;
+	} else {
+		return -1;
+	}
+	return 0;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv)
 {
@@ -1812,6 +1829,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_parents = atoi(arg+14);
 	} else if (starts_with(arg, "--no-max-parents")) {
 		revs->max_parents = -1;
+	} else if (starts_with(arg, "--merges=")) {
+		if (parse_merges_opt(revs, arg + 9))
+			die("unknown option: %s", arg);
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
diff --git a/revision.h b/revision.h
index 0ea8b4e..640589c 100644
--- a/revision.h
+++ b/revision.h
@@ -240,6 +240,8 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			       const struct option *options,
 			       const char * const usagestr[]);
+extern int parse_merges_opt(struct rev_info *, const char *);
+
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,
