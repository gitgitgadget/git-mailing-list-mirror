From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: diagnose empty HEAD more clearly
Date: Wed, 03 Jun 2015 10:24:02 -0700
Message-ID: <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
	<20150603062005.GA20580@peff.net>
	<CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
	<20150603081432.GA32000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0COz-0008IO-71
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbbFCRYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:24:17 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36619 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbbFCRYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:24:06 -0400
Received: by igbpi8 with SMTP id pi8so117931227igb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=haTu+ImFenPAoEgm/DsOKNViuP75O/8efNiS/PZVozA=;
        b=nctgPXFzs/a9I3cqtQ2hLgAJMZd1/MRDZDNotVc+z8YGw80WFSCw1RbEsTVkPQli7/
         lYASsfzIukqsmaMzvTyQK/XKunEg9lUuSI0m+Wx2h3hgwO4q97iK+jyFaDTHBotDJe+F
         99GGhSu7BAYGhIUD768DGtdJtt/8FCWIdz3DvioSOHNsszCcmcYC+1XUVXh0MvSEeQRr
         jJNht77sStW319qLBHJLDRnvG4tXEbZ4oduzzUDBpxrDGBj9An5B2FutNKE+Ozk4kNkO
         qa190aVpt9MddW5v/4tfe+5XvcTqrK7kVza3j9DDv8AS2Y6ShIW14KQLihsG9RdKWHlx
         0Rmg==
X-Received: by 10.107.158.15 with SMTP id h15mr43168629ioe.14.1433352245380;
        Wed, 03 Jun 2015 10:24:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id c63sm8122731ioe.42.2015.06.03.10.24.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 10:24:04 -0700 (PDT)
In-Reply-To: <20150603081432.GA32000@peff.net> (Jeff King's message of "Wed, 3
	Jun 2015 04:14:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270703>

Jeff King <peff@peff.net> writes:

> My concern there would be risk of regression. I.e., that we would take
> some case which used to error out and turn it into a silent noop. So I'd
> prefer to keep the behavior the same, and just modify the error code
> path. The end result is pretty similar to the user, because we obviously
> cannot produce any actual output either way.

Okay.

> Something like:
>
> -- >8 --
> Subject: log: diagnose empty HEAD more clearly
>
> If you init or clone an empty repository, the initial
> message from running "git log" is not very friendly:
>
>   $ git init
>   Initialized empty Git repository in /home/peff/foo/.git/
>   $ git log
>   fatal: bad default revision 'HEAD'
>
> Let's detect this situation and write a more friendly
> message:
>
>   $ git log
>   fatal: default revision 'HEAD' points to an unborn branch 'master'
>
> We also detect the case that 'HEAD' points to a broken ref;
> this should be even less common, but is easy to see. Note
> that we do not diagnose all possible cases. We rely on
> resolve_ref, which means we do not get information about
> complex cases. E.g., "--default master" would use dwim_ref
> to find "refs/heads/master", but we notice only that
> "master" does not exist. Similarly, a complex sha1
> expression like "--default HEAD^2" will not resolve as a
> ref.
>
> But that's OK. We fall back to the existing error message in
> those cases, and they are unlikely to be used anyway.
> Catching an empty or broken "HEAD" improves the common case,
> and the other cases are not regressed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm not a big fan of the new error message, either, just because the
> term "unborn" is also likely to be confusing to new users.
>
> We can also probably get rid of mentioning "HEAD" completely. It is
> always the default unless the user has overridden it explicitly.

I think that still mentioning "HEAD" goes directly against the
reasoning you made in an earlier part of your message:

> I think it is one of those cases where the message makes sense when you
> know how git works. But a new user who does not even know what "HEAD" or
> a ref actually is may find it a bit confusing. Saying "we can't run
> git-log, your repository empty!" may seem redundantly obvious even to
> such a new user. But saying "bad revision 'HEAD'" may leave them saying
> "eh, what is HEAD and why is it bad?".

and I agree with that reasoning: the user didn't say anything about
"HEAD", so why complain about it?

Which is what led me to say "Why are we defaulting to HEAD before
checking if it even exists?  Isn't that the root cause of this
confusion?  What happens if we stopped doing it?"

And I think the "diagnose after finding that pending is empty and we
were given 'def'" approach almost gives us the equivalent, which is
why I said "Okay" above.

If we can make it possible to tell if that "def" was given by the
user (i.e. --default parameter) or by the machinery (e.g. "git log"
and friends), then we can remove "almost" from the above sentence.

> So we
> could go with something like:
>
>   fatal: your default branch 'master' does not contain any commits
>
> or something. I dunno. Bikeshed colors welcome. Adding:
>
>   advise("try running 'git commit'");
>
> is probably too pedantic. ;)

;-)

I am wondering if the attached is better, if only because it is of
less impact.  I have die() there to avoid the behaviour change, but
if we are going to have another future version where we are willing
to take incompatiblity for better end-user experience like we did at
2.0, I suspect turning it to warning() or even removing it might be
a candidate for such a version.  If you have one commit and ask
"log", you get one commit back. If you have no commit and ask "log",
I think it is OK to say that you should get nothing back without
fuss.

 builtin/log.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4c4e6be..3b568a1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -148,6 +148,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
 	argc = setup_revisions(argc, argv, rev, opt);
 
+	if (!rev->pending.nr && !opt->def)
+		die("you do not have a commit yet on your branch");
+
 	/* Any arguments at this point are not recognized */
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
@@ -404,6 +407,14 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	return git_diff_ui_config(var, value, cb);
 }
 
+static void default_to_head_if_exists(struct setup_revision_opt *opt)
+{
+	unsigned char unused[20];
+
+	if (resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, unused, NULL))
+		opt->def = "HEAD";
+}
+
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -416,7 +427,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	default_to_head_if_exists(&opt);
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
@@ -530,7 +541,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.diffopt.stat_width = -1; 	/* Scale to real terminal size */
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	default_to_head_if_exists(&opt);
 	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
@@ -607,7 +618,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	default_to_head_if_exists(&opt);
 	cmd_log_init_defaults(&rev);
 	rev.abbrev_commit = 1;
 	rev.commit_format = CMIT_FMT_ONELINE;
@@ -629,7 +640,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	default_to_head_if_exists(&opt);
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
