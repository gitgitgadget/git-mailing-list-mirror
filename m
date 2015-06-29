From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 38/44] builtin-am: support and auto-detect StGit patches
Date: Mon, 29 Jun 2015 13:42:42 -0700
Message-ID: <CAGZ79kbzb4E8D87nQi+dat6szOdnp56ta3bEwsUwieX=3SiJqw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-39-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:42:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9ftA-0006Ed-K5
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbbF2Ump (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:42:45 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33429 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbF2Umm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:42:42 -0400
Received: by ykdt186 with SMTP id t186so125827013ykd.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pCczHqggyyOee/s9zqf3GNJ6TAaHhy0yLKbfefkyvQw=;
        b=UsvjBnx8F7tYGEgANs+cK+BeYqhrmZJonsiAlw3YkMpSjfBMCYyQxg0NTn/yap4boF
         f8QkvU6PF6rioDmM5x1030DnHhaqjkxBoZD78DN0dIgc9dD2D3i7yoETEYUjVAxX+11j
         A2shm0cUNSsLqSQexatmw9cOFnEexuOC+hsRpzdgv9doIfpXS4zANeoqQ4uqzMgw2SCJ
         wuHAnWZNRCULW7ZkXZGhMRKHRjbiu79rNYC3oQbCN/ZWMxGrvO3TmCRwGJkdDNNXnkvX
         CelaAAb6mdDaV2Sf8z4o7QOHhEusk2SbfHbFcOKGrgi1DnmHpgUZ+Zr4R3mQ/wLkYbON
         3ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pCczHqggyyOee/s9zqf3GNJ6TAaHhy0yLKbfefkyvQw=;
        b=VrA6hFIFGCcI+IRG5Sy4iPirkPNF59frpwtwpk87ll2BNE8uKjF6G0QB8PWYLpjg3r
         QHor8WY3AqkLrQYa3xV9TwJBXOaSMD1jS2RQaLSN7bCEoBYK5mbLPqQYPzKpUxyaoq1A
         prUnn4GHdlMG03ib0Qa6yJvgcuzu0v+BUCWYwasjV5SnquG0XHykuQQFV13l42UHQgj5
         DQakemeACiENZFmZzq6L8WYcZlolzgdrGdg+W7LCN2uyXCMX+xmqx4czefXB4PNrHlK4
         iNm7Zd8N5I69c8WwtMlJdofdOuk6fMUuR3ZgypaBQTwytDXcwAQFIJT+z5lVcDY4AYAY
         fWMA==
X-Gm-Message-State: ALoCoQm9TvjQT5rCmbz8Ef5DRImiuU9smr+oTwGTM7q5nQbHdDBNhwhzU6S4/XU4QApg5NK2ZL5+
X-Received: by 10.170.59.16 with SMTP id b16mr19507731ykb.10.1435610562078;
 Mon, 29 Jun 2015 13:42:42 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 13:42:42 -0700 (PDT)
In-Reply-To: <1435500366-31700-39-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273017>

On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since c574e68 (git-am foreign patch support: StGIT support, 2009-05-27),
> git-am.sh supported converting StGit patches into RFC2822 mail patches
> that can be parsed with git-mailinfo.
>
> Implement this by introducing two functions in builtin/am.c:
> stgit_patch_to_mail() and split_mail_conv().
>
> stgit_patch_to_mail() is a callback function for split_mail_conv(), and
> contains the logic for converting an StGit patch into an RFC2822 mail
> patch.
>
> split_mail_conv() implements the logic to go through each file in the
> `paths` list, reading from stdin where specified, and calls the callback
> function to write the converted patch to the corresponding output file
> in the state directory. This interface should be generic enough to
> support other foreign patch formats in the future.
>
> Since 15ced75 (git-am foreign patch support: autodetect some patch
> formats, 2009-05-27), git-am.sh is able to auto-detect StGit patches.
> Re-implement this in builtin/am.c.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 131 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index b54fdbd..b73498e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -65,9 +65,22 @@ static int linelen(const char *msg)
>         return strchrnul(msg, '\n') - msg;
>  }
>
> +/**
> + * Returns true if `str` consists of only whitespace, false otherwise.
> + */
> +static int str_isspace(const char *str)
> +{
> +       while (*str)
> +               if (!isspace(*(str)++))
> +                       return 0;

(nit:)
This looks a bit weird when first reading it, maybe combine the 2 conditions?

    while (*str && !isspace(*(str)++))
        return 0;

The isspace checks for both tabs and whitespaces IIRC, so SP TAB SP
would be valid here
(returning 1).


> +
> +       return 1;
> +}
> +
>  enum patch_format {
>         PATCH_FORMAT_UNKNOWN = 0,
> -       PATCH_FORMAT_MBOX
> +       PATCH_FORMAT_MBOX,
> +       PATCH_FORMAT_STGIT
>  };
>
>  enum keep_type {
> @@ -651,6 +664,8 @@ static int detect_patch_format(const char **paths)
>  {
>         enum patch_format ret = PATCH_FORMAT_UNKNOWN;
>         struct strbuf l1 = STRBUF_INIT;
> +       struct strbuf l2 = STRBUF_INIT;
> +       struct strbuf l3 = STRBUF_INIT;
>         FILE *fp;
>
>         /*
> @@ -676,6 +691,23 @@ static int detect_patch_format(const char **paths)
>                 goto done;
>         }
>
> +       strbuf_reset(&l2);
> +       strbuf_getline_crlf(&l2, fp);
> +       strbuf_reset(&l3);
> +       strbuf_getline_crlf(&l3, fp);
> +
> +       /*
> +        * If the second line is empty and the third is a From, Author or Date
> +        * entry, this is likely an StGit patch.
> +        */
> +       if (l1.len && !l2.len &&
> +               (starts_with(l3.buf, "From:") ||
> +                starts_with(l3.buf, "Author:") ||
> +                starts_with(l3.buf, "Date:"))) {
> +               ret = PATCH_FORMAT_STGIT;
> +               goto done;
> +       }
> +
>         if (l1.len && is_mail(fp)) {
>                 ret = PATCH_FORMAT_MBOX;
>                 goto done;
> @@ -716,6 +748,100 @@ static int split_mail_mbox(struct am_state *state, const char **paths, int keep_
>  }
>
>  /**
> + * Callback signature for split_mail_conv(). The foreign patch should be
> + * read from `in`, and the converted patch (in RFC2822 mail format) should be
> + * written to `out`. Return 0 on success, or -1 on failure.
> + */
> +typedef int (*mail_conv_fn)(FILE *out, FILE *in, int keep_cr);
> +
> +/**
> + * Calls `fn` for each file in `paths` to convert the foreign patch to the
> + * RFC2822 mail format suitable for parsing with git-mailinfo.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
> +                       const char **paths, int keep_cr)
> +{
> +       static const char *stdin_only[] = {"-", NULL};
> +       int i;
> +
> +       if (!*paths)
> +               paths = stdin_only;
> +
> +       for (i = 0; *paths; paths++, i++) {
> +               FILE *in, *out;
> +               const char *mail;
> +               int ret;
> +
> +               if (!strcmp(*paths, "-"))
> +                       in = stdin;
> +               else
> +                       in = fopen(*paths, "r");
> +
> +               if (!in)
> +                       return error(_("could not open '%s' for reading: %s"),
> +                                       *paths, strerror(errno));
> +
> +               mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
> +
> +               out = fopen(mail, "w");
> +               if (!out)
> +                       return error(_("could not open '%s' for writing: %s"),
> +                                       mail, strerror(errno));
> +
> +               ret = fn(out, in, keep_cr);
> +
> +               fclose(out);
> +               fclose(in);
> +
> +               if (ret)
> +                       return error(_("could not parse patch '%s'"), *paths);
> +       }
> +
> +       state->cur = 1;
> +       state->last = i;
> +       return 0;
> +}
> +
> +/**
> + * A split_mail_conv() callback that converts an StGit patch to an RFC2822
> + * message suitable for parsing with git-mailinfo.
> + */
> +static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       int subject_printed = 0;
> +
> +       while (!strbuf_getline(&sb, in, '\n')) {
> +               const char *str;
> +
> +               if (str_isspace(sb.buf))
> +                       continue;
> +               else if (skip_prefix(sb.buf, "Author:", &str))
> +                       fprintf(out, "From:%s\n", str);
> +               else if (starts_with(sb.buf, "From") || starts_with(sb.buf, "Date"))
> +                       fprintf(out, "%s\n", sb.buf);
> +               else if (!subject_printed) {
> +                       fprintf(out, "Subject: %s\n", sb.buf);
> +                       subject_printed = 1;
> +               } else {
> +                       fprintf(out, "\n%s\n", sb.buf);
> +                       break;
> +               }
> +       }
> +
> +       strbuf_reset(&sb);
> +       while (strbuf_fread(&sb, 8192, in) > 0) {
> +               fwrite(sb.buf, 1, sb.len, out);
> +               strbuf_reset(&sb);
> +       }
> +
> +       strbuf_release(&sb);
> +       return 0;
> +}
> +
> +/**
>   * Splits a list of files/directories into individual email patches. Each path
>   * in `paths` must be a file/directory that is formatted according to
>   * `patch_format`.
> @@ -743,6 +869,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
>         switch (patch_format) {
>         case PATCH_FORMAT_MBOX:
>                 return split_mail_mbox(state, paths, keep_cr);
> +       case PATCH_FORMAT_STGIT:
> +               return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
>         default:
>                 die("BUG: invalid patch_format");
>         }
> @@ -1773,6 +1901,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>
>         if (!strcmp(arg, "mbox"))
>                 *opt_value = PATCH_FORMAT_MBOX;
> +       else if (!strcmp(arg, "stgit"))
> +               *opt_value = PATCH_FORMAT_STGIT;
>         else
>                 return error(_("Invalid value for --patch-format: %s"), arg);
>         return 0;
> --
> 2.5.0.rc0.76.gb2c6e93
>
