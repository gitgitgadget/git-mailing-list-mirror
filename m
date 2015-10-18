From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sat, 17 Oct 2015 21:10:13 -0400
Message-ID: <CAPig+cQAmp8QPoO8GDJEUU6T2uSZo465Q64-BcQ1o_DJNDAuAA@mail.gmail.com>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 03:10:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZncUt-00029N-GW
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 03:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbbJRBKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2015 21:10:16 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33616 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbJRBKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2015 21:10:14 -0400
Received: by vkaw128 with SMTP id w128so87302797vka.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=LnYVhGntIGznCpdLU361rvBSHQexc8b8m499mOi6RpE=;
        b=tCKPJy+ShZb6D0hFc/MqZOaiRJ3Iv/St5xezYRbZ8D1gB6437thsqSLHlxlJBfvYgI
         fWVkqU/IgiEaCZidi7QNsKd7c5aEQONwLD15K1Hn02I1vJXZwYwn82llKkBY67uBhZ27
         k42gc8tou5kuq8jRNJgDV0FS30xjDTlkHmBslRtypLZxn1FgFfdqe3RKMClOP5ho+yI7
         0B+9H3SWGDLkJWutsh6kAitYOGf+tMDnJQrzrNNoqzDMIFxwttrRo8yiE5nN1EtDbVQw
         anOUBn6N79Zn+rBHFViJePlWZpl4L8zQ/tx3bNwIf3BkCN5PjeDQYuB2WpRXiBXq/RCP
         62GA==
X-Received: by 10.31.11.209 with SMTP id 200mr15720011vkl.84.1445130613787;
 Sat, 17 Oct 2015 18:10:13 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sat, 17 Oct 2015 18:10:13 -0700 (PDT)
In-Reply-To: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
X-Google-Sender-Auth: KCJDwrSL8M-BnkAAEEEzR39EiSo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279797>

On Sat, Oct 17, 2015 at 4:18 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Make it possible to show the line endings of files.
> Files which are staged and/or files in the working tree:
>
> git ls-files --eol-staged
> git ls-files --eol-worktree
>
> Both will show an output like this:
>
> empty    empty_file
> bin      binary_file_or_with_cr_handled_as_binary
> txt-crlf text_file_with_crlf
> txt-mix  text_file_with_crlf_and_lf
> txt-lf   text_file_with_lf
> txt      text_file_with_no_eol_at_all
>
> Implementation details:
> Make struct text_stat, is_binary() and gather_stats() from convert.c
> public, add a new function get_convert_stats_ascii() and use it
> in and use them in ls-files.

s/and use it in and use them in/and use them in/

> git ls-files --eol-staged will give a line like this:

"... line like this:" what?

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -68,6 +70,11 @@ static void show_dir_entry(const char *tag, struct=
 dir_entry *ent)
>                 return;
>
>         fputs(tag, stdout);
> +       if (show_eol_wt) {
> +               printf("%s ", get_convert_stats_ascii(ent->name,
> +                                                                    =
                                                                       =
                            GET_CONVERT_STATS_ASCII_WT, 0));

Whitespace-damaged patch?

> +       }

Style: unnecessary braces

> +
>         write_name(ent->name);
> }
>
> @@ -170,6 +177,14 @@ static void show_ce_entry(const char *tag, const=
 struct cache_entry *ce)
>                        find_unique_abbrev(ce->sha1,abbrev),
>                        ce_stage(ce));
>         }
> +       if (show_eol_staged) {
> +               printf("%s ",
> +                                        get_convert_stats_ascii(ce->=
name, GET_CONVERT_STATS_ASCII_BLOB, 0));
> +       }
> +       if (show_eol_wt) {
> +               printf("%s ", get_convert_stats_ascii(ce->name,GET_CO=
NVERT_STATS_ASCII_WT,
> +                                                                    =
                                                                       =
                            ce->ce_stat_data.sd_size));
> +       }

Style: unnecessary braces (both cases)

>         write_name(ce->name);
>         if (debug_mode) {
>                 const struct stat_data *sd =3D &ce->ce_stat_data;
> @@ -206,6 +221,10 @@ static void show_ru_info(void)
>                         printf("%s%06o %s %d\t", tag_resolve_undo, ui=
->mode[i],
>                                find_unique_abbrev(ui->sha1[i], abbrev=
),
>                                i + 1);
> +                       if (show_eol_wt) {
> +                               printf("%s ",
> +                                                        get_convert_=
stats_ascii(path, GET_CONVERT_STATS_ASCII_WT, 0));
> +                       }

Style: unnecessary braces

>                         write_name(path);
>                 }
>         }
> @@ -433,6 +452,8 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
>                 OPT_BIT(0, "directory", &dir.flags,
>                         N_("show 'other' directories' names only"),
>                         DIR_SHOW_OTHER_DIRECTORIES),
> +               OPT_BOOL(0, "eol-staged", &show_eol_staged, N_("show =
line endings of the staged file")),
> +               OPT_BOOL(0, "eol-worktree", &show_eol_wt, N_("show li=
ne endings of the file in work tree")),
>                 OPT_NEGBIT(0, "empty-directory", &dir.flags,
>                         N_("don't show empty directories"),
>                         DIR_HIDE_EMPTY_DIRECTORIES),
> --- a/convert.c
> +++ b/convert.c
> @@ -95,6 +87,45 @@ static int is_binary(unsigned long size, struct te=
xt_stat *stats)
>         return 0;
> }
>
> +

Style: unnecessary blank line

> +const char *gather_stats_ascii(const char *data, unsigned long size)

Is this name too generic? This implementation is specialized for
summarizing EOL state, but it is conceivable that there may be other
meaningful textual representations of struct text_stat, as well, so
perhaps this name ought to better reflect the EOL-centric textual
representation of this implementation.

> +{
> +       struct text_stat stats;
> +       if (!data || !size)
> +               return("empty   ");

Would it make sense to distinguish between an empty file/blob and one
which was not found?

    if (!data)
        return "missing";
    if (!size)
        return "empy";

> +       gather_stats(data, size, &stats);
> +       if (is_binary(size, &stats))
> +               return("bin     ");

Style: unnecessary parentheses on 'return'

> +       else if (stats.cr !=3D stats.crlf)

Style (nit): unnecessary 'else'

> +               return("bin     ");
> +       else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
> +               return("txt-crlf");
> +       else if (stats.crlf && stats.lf)
> +               return("txt-mix ");
> +       else if (stats.lf)
> +               return("txt-lf  ");
> +       else
> +               return("txt     ");
> +}

Is it a good idea for this otherwise general purpose function to be
conflating presentation with EOL classification? I would have expected
this function to return the raw classification string without trailing
whitespace ("empty", "bin", "txt-mix", etc.), and leave it up to the
caller to pad the string if alignment is desired.

> +const char *get_convert_stats_ascii(const char *path, int flags, siz=
e_t hint)

Is 'flags' an appropriate name? Presently, it's more of a "mode" than
a flag. If it is a flag, then you typically would use an unsigned
type.

If you can't foresee any additional "flags", and this really is a
"mode", then it might be clearer to split this into two functions --
one for blobs and one for files -- and callers can invoke whichever is
appropriate.

> +{
> +       const char *ret =3D "";

Unnecessary initialization since all  branches assign 'ret' uncondition=
ally.

> +       if (flags & GET_CONVERT_STATS_ASCII_BLOB) {
> +               unsigned long sz;
> +               void *data =3D read_blob_data_from_cache(path, &sz);
> +               ret =3D gather_stats_ascii(data, sz);

gather_stats_ascii() deals gracefully with data=3D=3D NULL, so it can
safely be outside the 'if (data)' conditional. Okay.

> +               if (data)
> +                       free(data);

POSIX says that free(NULL) is safe, so the conditional is unnecessary.

> +       } else if (flags & GET_CONVERT_STATS_ASCII_WT){

Style: space before {

> +               struct strbuf sb =3D STRBUF_INIT;
> +               strbuf_read_file(&sb, path, hint);

If gather_stats_ascii() should distinguish error and empty-file cases,
then checking the return value of strbuf_read_file() would be
appropriate.

> +               ret =3D gather_stats_ascii(sb.buf, sb.len);
> +               strbuf_release(&sb);
> +       }
> +       return ret;
> +}
> +
> --- a/convert.h
> +++ b/convert.h
> @@ -31,6 +31,20 @@ enum eol {
> +struct text_stat {
> +       /* NUL, CR, LF and CRLF counts */
> +       unsigned nul, cr, lf, crlf;
> +
> +       /* These are just approximations! */
> +       unsigned printable, nonprintable;
> +};
> +void gather_stats(const char *buf, unsigned long size, struct text_s=
tat *stats);
> +int is_binary(unsigned long size, struct text_stat *stats);
> +const char *gather_stats_ascii(const char *buf, unsigned long size);
> +#define GET_CONVERT_STATS_ASCII_BLOB           (1<<0)
> +#define GET_CONVERT_STATS_ASCII_WT             (1<<1)
> +const char *get_convert_stats_ascii(const char *path, int isBlob, si=
ze_t hint);

s/isBlob/flags/ or s/isBlob/mode/ or something.

Having read the source code, I know what 'hint' is for, but its
purpose is not obvious when just reading this prototype. Also, do you
expect 'hint' to prove worthwhile or might it be a case of premature
optimization and interface complexity? (Genuine question.)
