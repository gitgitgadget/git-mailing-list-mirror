From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 16:05:30 -0700
Message-ID: <CA+P7+xq-njse8TKWExwKWx=6ynVNwM1ODHnTij6pdQNejvKT=g@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com> <1460761306-18794-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCoF-0008Eq-Ie
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcDOXFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:05:51 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36510 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcDOXFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:05:50 -0400
Received: by mail-ig0-f178.google.com with SMTP id f1so31821304igr.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5MbNVd3j8oEYMjV4ajA/n/F/4CFHXfZ9zsm2T2pwHqk=;
        b=qUcjX48knSFp50Ab+Eu8qgCdZ8eA1e09B4uoZqA3ap42PV426d2SqYKikItxy8t3l/
         Vq8PnGsnuD7pY5oaidy0wHCa1qXcIoXRQkv+gBvWOb0s5QZ4FojXvqwRPgy771iPvxSV
         WCfcY9PPT0BF6gXcjwCPbd0s9qp5jcbXMnMRFWTRWwB3yTC0dVUxB62Jsobg/Pf9L9H5
         UtkimNowTV5/FRwgPAiaSwFRxcyIxcBV6J9ijLsirgjuruIMGEJSRLjolIHvp/SmjEpw
         XvRDA7kyVZ5pr1C4RewUsroWYOW3GX7+NwRijoN/STQWc/bE1aMG6YAuJCeonLZRdMF2
         GKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5MbNVd3j8oEYMjV4ajA/n/F/4CFHXfZ9zsm2T2pwHqk=;
        b=fdBNyJxBixuTohAgtAhbMqx68+5NqhNoC/HX35C/GGuQqSdv1f9Y0hsund+COsKE9+
         RaVG3SIZ1lAyZsRO6N2KYGZhohNnaCz/xxkmOEFdBaoX4isAMDzqoLICdhqYzrK4ic7D
         gUrtSNVzku9DCT1+CPeYnMLFcBjhD4bZdJA+p1tw/WHlYjcdMvTGI6jvsW05SELpyCuc
         /GOMPMCA66rwdoH5uDF181Scd++bCD2YRLNqy3cjpFjbdg0buCVUN41HAYkyN1uMx4yJ
         aBNB4Jpf5LelN8+9La6c+qaU4qMvJBTQYD58deC+75u7M7U7utHsXR6QOfLBfx+eUvx4
         cctg==
X-Gm-Message-State: AOPr4FWkWS42YX/ikcIe4pL9m1ozWq/r6gUJdmQq3U/hIqEQNPiqKRTH2O9QPVWed+B4Xjb2k7FIRs97ZW7tLA==
X-Received: by 10.50.112.169 with SMTP id ir9mr7846198igb.92.1460761549480;
 Fri, 15 Apr 2016 16:05:49 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 16:05:30 -0700 (PDT)
In-Reply-To: <1460761306-18794-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291697>

On Fri, Apr 15, 2016 at 4:01 PM, Stefan Beller <sbeller@google.com> wrote:
> In order to produce the smallest possible diff and combine several diff
> hunks together, we implement a heuristic from GNU Diff which moves diff
> hunks forward as far as possible when we find common context above and
> below a diff hunk. This sometimes produces less readable diffs when
> writing C, Shell, or other programming languages, ie:
>
> ...
>  /*
> + *
> + *
> + */
> +
> +/*
> ...
>
> instead of the more readable equivalent of
>
> ...
> +/*
> + *
> + *
> + */
> +
>  /*
> ...
>
> Original discussion and testing found the following heuristic to be
> producing the desired output:
>
>   If there are diff chunks which can be shifted around, shift each hunk
>   such that the last common empty line is below the chunk with the rest
>   of the context above.
>
> This heuristic appears to resolve the above example and several other
> common issues without producing significantly weird results. When
> implementing this heuristic the handling of empty lines was awkward as
> it is unclear what an empty line is. ('\n' or do we include "\r\n" as it
> is common on Windows?) Instead we implement a slightly different heuristic:
>
>   If there are diff chunks which can be shifted around, find the shortest
>   line in the overlapping parts. Use the line with the shortest length that
>   occurs last as the last line of the chunk with the rest
>   of the context above.
>
> However, as with any heuristic it is not really known whether this will
> always be more optimal. Thus, leave the heuristic disabled by default.
>
> Add an XDIFF flag to enable this heuristic only conditionally. Add
> a diff command line option and diff configuration option to allow users
> to enable this option when desired.
>
> TODO:
> * Add tests
> * Add better/more documentation explaining the heuristic, possibly with
>   examples(?)
> * better name(?)
>

There's a few places that will need cleaning up (comments and such)
that mention empty line still, but that's not surprising. I am going
to test this for a bit on my local repos, and see if it makes any
difference to the old heuristic as well.

Thanks,
Jake

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/diff-config.txt  |  6 ++++++
>  Documentation/diff-options.txt |  6 ++++++
>  diff.c                         | 11 +++++++++++
>  xdiff/xdiff.h                  |  2 ++
>  xdiff/xdiffi.c                 | 29 +++++++++++++++++++++++++++++
>  5 files changed, 54 insertions(+)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index edba565..3d99a90 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -170,6 +170,12 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> +diff.shortestLineHeuristic::
> +       Set this option to true to enable the shortest line chunk heuristic when
> +       producing diff output. This heuristic will attempt to shift hunks such
> +       that the last shortest common line occurs below the hunk with the rest of
> +       the context above it.
> +
>  diff.algorithm::
>         Choose a diff algorithm.  The variants are as follows:
>  +
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 4b0318e..b1ca83d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -63,6 +63,12 @@ ifndef::git-format-patch[]
>         Synonym for `-p --raw`.
>  endif::git-format-patch[]
>
> +--shortest-line-heuristic::
> +--no-shortest-line-heuristic::
> +       When possible, shift common shortest line in diff hunks below the hunk
> +       such that the last common shortest line for each hunk is below, with the
> +       rest of the context above the hunk.
> +
>  --minimal::
>         Spend extra time to make sure the smallest possible
>         diff is produced.
> diff --git a/diff.c b/diff.c
> index 4dfe660..a02aff9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -26,6 +26,7 @@
>  #endif
>
>  static int diff_detect_rename_default;
> +static int diff_shortest_line_heuristic = 0;
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> @@ -189,6 +190,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>                 diff_detect_rename_default = git_config_rename(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "diff.shortestlineheuristic")) {
> +               diff_shortest_line_heuristic = git_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "diff.autorefreshindex")) {
>                 diff_auto_refresh_index = git_config_bool(var, value);
>                 return 0;
> @@ -3278,6 +3283,8 @@ void diff_setup(struct diff_options *options)
>         options->use_color = diff_use_color_default;
>         options->detect_rename = diff_detect_rename_default;
>         options->xdl_opts |= diff_algorithm;
> +       if (diff_shortest_line_heuristic)
> +               DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
>
>         options->orderfile = diff_order_file_cfg;
>
> @@ -3798,6 +3805,10 @@ int diff_opt_parse(struct diff_options *options,
>                 DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
>         else if (!strcmp(arg, "--ignore-blank-lines"))
>                 DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
> +       else if (!strcmp(arg, "--shortest-line-heuristic"))
> +               DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
> +       else if (!strcmp(arg, "--no-shortest-line-heuristic"))
> +               DIFF_XDL_CLR(options, SHORTEST_LINE_HEURISTIC);
>         else if (!strcmp(arg, "--patience"))
>                 options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>         else if (!strcmp(arg, "--histogram"))
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 4fb7e79..e1f8ec0 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -41,6 +41,8 @@ extern "C" {
>
>  #define XDF_IGNORE_BLANK_LINES (1 << 7)
>
> +#define XDF_SHORTEST_LINE_HEURISTIC (1 << 8)
> +
>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 748eeb9..7d15b26 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -400,6 +400,12 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>  }
>
>
> +static int line_length(const char *recs)
> +{
> +       char *s = strchr(recs, '\n');
> +       return s ? s - recs : strlen(recs);
> +}
> +
>  static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
>  {
>         return (recs[ixs]->ha == recs[ix]->ha &&
> @@ -411,6 +417,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>         long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>         char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
> +       unsigned int shortest_line;
>         xrecord_t **recs = xdf->recs;
>
>         /*
> @@ -444,6 +451,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>
>                 do {
>                         grpsiz = ix - ixs;
> +                       shortest_line = UINT_MAX;
>
>                         /*
>                          * If the line before the current change group, is equal to
> @@ -478,6 +486,10 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                          * the group.
>                          */
>                         while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
> +                               int l = line_length(recs[ix]->ptr);
> +                               if (l < shortest_line)
> +                                       shortest_line = l;
> +
>                                 rchg[ixs++] = 0;
>                                 rchg[ix++] = 1;
>
> @@ -504,6 +516,23 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                         rchg[--ix] = 0;
>                         while (rchgo[--ixo]);
>                 }
> +
> +               /*
> +                * If a group can be moved back and forth, see if there is an
> +                * empty line in the moving space. If there is an empty line,
> +                * make sure the last empty line is the end of the group.
> +                *
> +                * As we shifted the group forward as far as possible, we only
> +                * need to shift it back if at all.
> +                */
> +               if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
> +                       while (ixs > 0 &&
> +                              line_length(recs[ix - 1]->ptr) > shortest_line &&
> +                              recs_match(recs, ixs - 1, ix - 1, flags)) {
> +                               rchg[--ixs] = 1;
> +                               rchg[--ix] = 0;
> +                       }
> +               }
>         }
>
>         return 0;
> --
> 2.8.1.189.gd13d43c
>
