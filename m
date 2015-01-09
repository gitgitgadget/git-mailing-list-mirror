From: Christoph Junghans <ottxor@gentoo.org>
Subject: Re: [PATCH] git-log: added --none-match option
Date: Fri, 9 Jan 2015 15:33:52 -0700
Message-ID: <CANgp9kxXzt7x9JnnxjrcRLse4m86eDAgWyC4FwKw2U48NjV=ew@mail.gmail.com>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com> <1420349268-13479-1-git-send-email-ottxor@gentoo.org>
 <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 23:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9i8Q-0007eV-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 23:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbbAIWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 17:34:21 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:42313 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbbAIWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 17:34:20 -0500
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com [209.85.218.49])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AF11234076F
	for <git@vger.kernel.org>; Fri,  9 Jan 2015 22:34:14 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id a141so13901890oig.8
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 14:34:12 -0800 (PST)
X-Received: by 10.202.2.73 with SMTP id 70mr10002411oic.69.1420842852691; Fri,
 09 Jan 2015 14:34:12 -0800 (PST)
Received: by 10.202.107.204 with HTTP; Fri, 9 Jan 2015 14:33:52 -0800 (PST)
In-Reply-To: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262246>

2015-01-06 16:02 GMT-07:00 Junio C Hamano <gitster@pobox.com>:
> Christoph Junghans <ottxor@gentoo.org> writes:
>
>> Implements a inverted match for "git log", like in the case of
>> "git grep -v", which is useful from time to time to e.g. filter
>> FIXUP message out of "git log".
>>
>> Internally, a new bol 'none_match' has been introduces as
>> revs->grep_filter.invert inverts the match line-wise, which cannot
>> work as i.e. empty line always not match the pattern given.
>>
>> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
>> ---
>
> The patch itself looks like a good start, except that the above
> description no longer matches the implementation.
>
> I further suspect it would be better to rename all_match to
> all_or_none and then you can lose the "these two are mutually
> incompatible" check that is placed together with a wrong existing
> comment.  I also notice that you forgot to update the "git grep"
> where the original "--all-match" came from.
That was on purpose. I am not quite sure what would be the point of
"showing only matches from files that match no patterns" (option
description from your patch below).
If a file matches none of the patterns, what matches are there to show?

The only useful thing I could image is using it in conjunction with
--files-with-matches, but that is what --files-without-match is for.

>
> A partial fix-up may start like this on top of your version.  By
> renaming the variable used in the existing code, the compiler will
> remind you that there are a few more places that your patch did not
> touch that does something special for --all-match, which are a good
> candidates you need to think if doing something similarly special
> for the --none-match case is necessary.
>
> Thanks.
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4063882..9ba4254 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -727,8 +727,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                   close_callback },
>                 OPT__QUIET(&opt.status_only,
>                            N_("indicate hit with exit status without output")),
> -               OPT_BOOL(0, "all-match", &opt.all_match,
> -                       N_("show only matches from files that match all patterns")),
> +               OPT_SET_INT(0, "all-match", &opt.all_or_none,
> +                           N_("show only matches from files that match all patterns"),
> +                           GREP_ALL_MATCH),
> +               OPT_SET_INT(0, "none-match", &opt.all_or_none,
> +                           N_("show only matches from files that match no patterns"),
> +                           GREP_NONE_MATCH),
>                 { OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
>                   N_("show parse tree for grep expression"),
>                   PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
> diff --git a/grep.c b/grep.c
> index f486ee5..1ff5dea 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1622,14 +1622,18 @@ static int chk_hit_marker(struct grep_expr *x)
>
>  int grep_source(struct grep_opt *opt, struct grep_source *gs)
>  {
> -       if(opt->none_match)
> -               return !grep_source_1(opt, gs, 0);
>         /*
>          * we do not have to do the two-pass grep when we do not check
> -        * buffer-wide "all-match".
> +        * buffer-wide "all-match" or "none-match".
>          */
> -       if (!opt->all_match)
> +       switch (opt->all_or_none) {
> +       case GREP_ALL_MATCH:
>                 return grep_source_1(opt, gs, 0);
> +       case GREP_NONE_MATCH:
> +               return !grep_source_1(opt, gs, 0);
> +       default:
> +               break;
> +       }
>
>         /* Otherwise the toplevel "or" terms hit a bit differently.
>          * We first clear hit markers from them.
> diff --git a/grep.h b/grep.h
> index 8e50c95..2cdabf2 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -101,8 +101,9 @@ struct grep_opt {
>         int count;
>         int word_regexp;
>         int fixed;
> -       int all_match;
> -       int none_match;
> +#define GREP_ALL_MATCH 1
> +#define GREP_NONE_MATCH 2
> +       int all_or_none;
>         int debug;
>  #define GREP_BINARY_DEFAULT    0
>  #define GREP_BINARY_NOMATCH    1
> diff --git a/revision.c b/revision.c
> index d43779e..b955848 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2010,9 +2010,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>         } else if (!strcmp(arg, "--perl-regexp")) {
>                 grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
>         } else if (!strcmp(arg, "--all-match")) {
> -               revs->grep_filter.all_match = 1;
> +               revs->grep_filter.all_or_none = GREP_ALL_MATCH;
>         } else if (!strcmp(arg, "--none-match")) {
> -               revs->grep_filter.none_match = 1;
> +               revs->grep_filter.all_or_none = GREP_NONE_MATCH;
>         } else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
>                 if (strcmp(optarg, "none"))
>                         git_log_output_encoding = xstrdup(optarg);
> @@ -2335,8 +2335,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>                 die("cannot combine --walk-reflogs with --graph");
>         if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>                 die("cannot use --grep-reflog without --walk-reflogs");
> -       if (revs->grep_filter.all_match && revs->grep_filter.none_match)
> -               die("cannot combine --all-match with --none-match");
>
>         return left;
>  }
>
>
>



-- 
Christoph Junghans
http://dev.gentoo.org/~ottxor/
