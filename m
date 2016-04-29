From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 15:35:54 -0700
Message-ID: <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
	<xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	<xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:36:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awH0y-0007Bw-9B
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcD2Wf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 18:35:56 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36335 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcD2Wfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 18:35:55 -0400
Received: by mail-ig0-f169.google.com with SMTP id u10so36554748igr.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=l58IFV5id9ANZnwTeNmOngn2LfhjmAmZ/sYD3PYdOoo=;
        b=Ec56W+a35jMZa9NjLVsGpsL0UYguJRxJFiuZGI5t6HfuSZLHUzub73VLovyr/iBhIr
         rZZWHKkRCjwgEro3eRlphJZrTja6EEtnk7NJFQpWo1snQPfYIObytEoDH+AMRoVwRnh2
         F2RURmLBx2+AsJWEc0rf+0WtN3pLTYUyhL3zUP1Llbww+Qd27CiDFQnmlPLC9EZFHziL
         BZgCTogOI/RXVDeCbHl3aCUFqAoDX68R3xc0of4tSA2p23V04Aqf54l4X2bRniAG6bUf
         cnKCgjkRG1hWA43q7P71WKv9FaR0GkmsZW7qJWeAH0X2D09Ts4rVARFKJ+CBSDAQfPDG
         9ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=l58IFV5id9ANZnwTeNmOngn2LfhjmAmZ/sYD3PYdOoo=;
        b=nCQNK2CGxLTLMhh2w10HuFrpufPd7No6laEhymvUhb0aH3ABFee6CnSzBtKjy1Vhh/
         7+ZlYF59frzrEYAqO45n/7g9PQVdtVwuZ9NkJ0aR6SanZN/gO39i/5zqKZpNPyk+lAff
         opl+nv/HOxjpDKabz8hJ9XjunapZrtyLEGXaHRkGbz/WbEtpZFydDTBz6ERp2WsviYUb
         qR8eqK1NejjAj8lTuTXhS25iZsVtdkXqoRMVtbNE/Epp35FWPtotZw7CyEAJkAtK0wV5
         oOxJpJinVgnIcPQjG1XpKshxe3sT5+5+PFO1kpNlDYkWMBa9218a78mVLsA7iMJg4Wv9
         X5Gg==
X-Gm-Message-State: AOPr4FVgJZ4wby4JQJntYrOGMkExIhzCnfjo16RBjoXJjFHX7NEQh2c8uZidql5RdMjLiR5N4Ho89oBw5aaKVvb+
X-Received: by 10.50.98.195 with SMTP id ek3mr7489154igb.85.1461969354815;
 Fri, 29 Apr 2016 15:35:54 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 15:35:54 -0700 (PDT)
In-Reply-To: <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293062>

On Fri, Apr 29, 2016 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Fri, Apr 29, 2016 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> ... Having the two directly next to each other reads
>>>> better to me. This is a pretty unusual diff, though, in that it did
>>>> change the surrounding whitespace (and if you look further in the diff,
>>>> the identical change is made elsewhere _without_ touching the
>>>> whitespace). So this is kind of an anomaly. And IMHO the weirdness here
>>>> is outweighed by the vast number of improvements elsewhere.
>>>
>>> So... is everybody happy with the result and now we can drop the
>>> tweaking knob added to help experimentation before merging the
>>> result to 'master'?
>>>
>>> I am pretty happy with the end result myself.
>>
>> I am very happy with it. I haven't had any issues, and I think we'll
>> find better traction by enabling it at this point and seeing when/if
>> someone complains.
>>
>> I think for most it won't be noticed and for those that do it will
>> likely be positive.
>
> I am doing this only to prepare in case we have a concensus,
> i.e. this is not to declare that I do not care what other people
> say.  Here is a patch to remove the experimentation knob.
>
> Let's say we keep this patch out of tree for now and keep the topic
> in 'next' so that people can further play with it for several more
> weeks, and then apply this on top and merge the result to 'master'
> early in the next cycle.
>
> -- >8 --
> diff: enable "compaction heuristics" and lose experimentation knob
>
> It seems that the new "find a good hunk boundary by locating a blank
> line" heuristics gives much more pleasant result without much
> noticeable downsides.  Let's make it the new algorithm for real,
> without the opt-out knob we added while experimenting with it.

I would remove the opt-out knob much later in the game, i.e.

    1) make a patch that removes the documentation only
       before the next release (i.e. before 2.9)
    2) make a patch to remove the actual (unlabeled) knobs,
        merge into master before 2.10 (i.e. just after the 2.9 release)

Then we get the most of the community to test it with the 2.9 release
and still have an emergency knob in case some major headaches
show up. After one release cycle we'll be much more confident
about its usage and its short comings and do not need the
emergency turn off. If the community doesn't like it for some reason
we can document it and debate the default setting?

I agree we want the knob gone eventually.
Making it an undocumented feature is as good as that from
a users point of view?

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-config.txt  |  5 -----
>  Documentation/diff-options.txt |  6 ------
>  diff.c                         | 11 -----------
>  xdiff/xdiff.h                  |  2 --
>  xdiff/xdiffi.c                 |  2 +-
>  5 files changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 9bf3e92..6eaa452 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -166,11 +166,6 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> -diff.compactionHeuristic::
> -       Set this option to enable an experimental heuristic that
> -       shifts the hunk boundary in an attempt to make the resulting
> -       patch easier to read.
> -
>  diff.algorithm::
>         Choose a diff algorithm.  The variants are as follows:
>  +
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index b513023..3ad6404 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -63,12 +63,6 @@ ifndef::git-format-patch[]
>         Synonym for `-p --raw`.
>  endif::git-format-patch[]
>
> ---compaction-heuristic::
> ---no-compaction-heuristic::
> -       These are to help debugging and tuning an experimental
> -       heuristic that shifts the hunk boundary in an attempt to
> -       make the resulting patch easier to read.
> -
>  --minimal::
>         Spend extra time to make sure the smallest possible
>         diff is produced.
> diff --git a/diff.c b/diff.c
> index 05ca3ce..f62b7f7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -25,7 +25,6 @@
>  #endif
>
>  static int diff_detect_rename_default;
> -static int diff_compaction_heuristic = 1;
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> @@ -184,10 +183,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>                 diff_detect_rename_default = git_config_rename(var, value);
>                 return 0;
>         }
> -       if (!strcmp(var, "diff.compactionheuristic")) {
> -               diff_compaction_heuristic = git_config_bool(var, value);
> -               return 0;
> -       }
>         if (!strcmp(var, "diff.autorefreshindex")) {
>                 diff_auto_refresh_index = git_config_bool(var, value);
>                 return 0;
> @@ -3240,8 +3235,6 @@ void diff_setup(struct diff_options *options)
>         options->use_color = diff_use_color_default;
>         options->detect_rename = diff_detect_rename_default;
>         options->xdl_opts |= diff_algorithm;
> -       if (diff_compaction_heuristic)
> -               DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
>
>         options->orderfile = diff_order_file_cfg;
>
> @@ -3719,10 +3712,6 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>                 DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
>         else if (!strcmp(arg, "--ignore-blank-lines"))
>                 DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
> -       else if (!strcmp(arg, "--compaction-heuristic"))
> -               DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
> -       else if (!strcmp(arg, "--no-compaction-heuristic"))
> -               DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
>         else if (!strcmp(arg, "--patience"))
>                 options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>         else if (!strcmp(arg, "--histogram"))
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index d1dbb27..c033991 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -41,8 +41,6 @@ extern "C" {
>
>  #define XDF_IGNORE_BLANK_LINES (1 << 7)
>
> -#define XDF_COMPACTION_HEURISTIC (1 << 8)
> -
>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>  #define XDL_EMIT_COMMON (1 << 1)
>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index b3c6848..574f83c 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -522,7 +522,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                  * As we already shifted the group forward as far as possible
>                  * in the earlier loop, we need to shift it back only if at all.
>                  */
> -               if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
> +               if (blank_lines) {
>                         while (ixs > 0 &&
>                                !is_blank_line(recs, ix - 1, flags) &&
>                                recs_match(recs, ixs - 1, ix - 1, flags)) {
