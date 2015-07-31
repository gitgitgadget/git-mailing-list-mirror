From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] notes: add notes.merge option to select default strategy
Date: Fri, 31 Jul 2015 17:12:53 -0400
Message-ID: <CAPig+cT+-d25NeXaNXP6rk8WPEtHJB7dobme72aLF1JL8y9mVg@mail.gmail.com>
References: <1438370496-26433-1-git-send-email-jacob.e.keller@intel.com>
	<1438370496-26433-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:13:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLHcj-0003oa-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbbGaVNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:13:45 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36270 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbbGaVMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:12:54 -0400
Received: by ykay190 with SMTP id y190so69191119yka.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Oor8RH0QwhmsYYKFvo1ydBPA5VTNUkOvKmuRP7CdYGU=;
        b=J2315oeGXyAf7sL40ZpqIaBNGFRtlH3r/FBERvV6jnw+5mQdYQksWdjMkKQoM1n4Dr
         Upvm7pD14BmsGxtqd2abz7kXJZNlDHT3r50mwBr1Ky5NWyhyzaZPhkzVKQ7Zpuk0DW/A
         oQlaEI/8Y/ve8y4TXmj9bNLMRhlPBsppEKDoG92AzUTIb5nivHZV2sSE8QPoL8/JxlRn
         C0y0P8x5z1S8AJfRNsbF+EQPkeGVsDD6CyS8O57WhPL+eQuDe+x8+xkAo+3R7vErj6/a
         MP0qGNo0PPy4UXKf/b8bU5ncj8Mfw41pIWvnfsv89ActUw8Dw2JAQ8vCENU5JUED7ZXF
         /Iyg==
X-Received: by 10.170.138.134 with SMTP id f128mr6153426ykc.90.1438377173853;
 Fri, 31 Jul 2015 14:12:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 31 Jul 2015 14:12:53 -0700 (PDT)
In-Reply-To: <1438370496-26433-3-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: aGrNG4_8vsSUUd75PJXhxLKptiM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275076>

On Fri, Jul 31, 2015 at 3:21 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Teach git-notes about a new configuration option "notes.merge" for
> selecting the default notes merge strategy. Document the option in
> config.txt and git-notes.txt
>
> Add tests for the configuration option. Ensure that command line
> --strategy option overrides the configured value. Ensure that -s can't
> be passed with --commit or --abort. Ensure that --abort and --commit
> can't be used together.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 88fdafb32bc0..7123311b563e 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -741,6 +744,36 @@ static int merge_commit(struct notes_merge_options *o)
> +static int parse_notes_strategy(const char *var, const char *arg,
> +                               enum notes_merge_strategy *strategy)

What is the 'var' argument for? It's not used by the function.

> +{
> +       if (!strcmp(arg, "manual"))
> +               *strategy = NOTES_MERGE_RESOLVE_MANUAL;
> +       else if (!strcmp(arg, "ours"))
> +               *strategy = NOTES_MERGE_RESOLVE_OURS;
> +       else if (!strcmp(arg, "theirs"))
> +               *strategy = NOTES_MERGE_RESOLVE_THEIRS;
> +       else if (!strcmp(arg, "union"))
> +               *strategy = NOTES_MERGE_RESOLVE_UNION;
> +       else if (!strcmp(arg, "cat_sort_uniq"))
> +               *strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> +       else {
> +               return error("Unknown notes merge strategy: %s", arg);

Perhaps reporting of the error should be left to the callers so they
can tailor the message ("--strategy" vs. "notes.merge")? Doing so
would make it easier for the user to trace the source of a bogus
value.

> +       }
> +
> +       return 0;
> +}
> +
> +static int parse_opt_strategy(const struct option *opt, const char *arg, int unset)
> +{
> +       enum notes_merge_strategy *strategy = opt->value;
> +
> +       /* let merge() know we overrode the configured strategy */
> +       override_strategy = 1;
> +
> +       return parse_notes_strategy(NULL, arg, strategy);
> +}
> +
>  static int merge(int argc, const char **argv, const char *prefix)
>  {
>         struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
> @@ -749,14 +782,16 @@ static int merge(int argc, const char **argv, const char *prefix)
> -       const char *strategy = NULL;
>         struct option options[] = {
>                 OPT_GROUP(N_("General options")),
>                 OPT__VERBOSITY(&verbosity),
>                 OPT_GROUP(N_("Merge options")),
> -               OPT_STRING('s', "strategy", &strategy, N_("strategy"),
> -                          N_("resolve notes conflicts using the given strategy "
> -                             "(manual/ours/theirs/union/cat_sort_uniq)")),
> +               {
> +                       OPTION_CALLBACK, 's', "strategy", &strategy, N_("strategy"),
> +                       N_("resolve notes conflicts using the given strategy "
> +                          "(manual/ours/theirs/union/cat_sort_uniq)"),
> +                       PARSE_OPT_NONEG, parse_opt_strategy
> +               },

Why change this from an OPT_STRING to an OPTION_CALLBACK? Couldn't you
just as easily have called parse_notes_strategy() after
parse_options()?

>                 OPT_GROUP(N_("Committing unmerged notes")),
>                 { OPTION_SET_INT, 0, "commit", &do_commit, NULL,
>                         N_("finalize notes merge by committing unmerged notes"),
> @@ -771,7 +806,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                              git_notes_merge_usage, 0);
>
> -       if (strategy || do_commit + do_abort == 0)
> +       if (override_strategy || do_commit + do_abort == 0)
>                 do_merge = 1;
>         if (do_merge + do_commit + do_abort != 1) {
>                 error("cannot mix --commit, --abort or -s/--strategy");
> @@ -799,22 +834,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>         expand_notes_ref(&remote_ref);
>         o.remote_ref = remote_ref.buf;
>
> -       if (strategy) {
> -               if (!strcmp(strategy, "manual"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> -               else if (!strcmp(strategy, "ours"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_OURS;
> -               else if (!strcmp(strategy, "theirs"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> -               else if (!strcmp(strategy, "union"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_UNION;
> -               else if (!strcmp(strategy, "cat_sort_uniq"))
> -                       o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> -               else {
> -                       error("Unknown -s/--strategy: %s", strategy);
> -                       usage_with_options(git_notes_merge_usage, options);
> -               }
> -       }
> +       o.strategy = strategy;
