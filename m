From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sun, 18 Oct 2015 11:03:37 +0100
Organization: OPDS
Message-ID: <3D2D9DFC85644BD1A6A39E819D90ACAA@PhilipOakley>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <tboegi@web.de>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 18 12:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znkob-00045o-2c
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 12:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbbJRKDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2015 06:03:39 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:21171 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752331AbbJRKDi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2015 06:03:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B7EAC4bSNWPEcgBlxeGQEBAgYFAQIBAYMJVG+GWm2yEoYJGYV/BAKBEk0BAQEBAQEHAQEBAUEkG0ELAYNbBQEBAQECAQgBAR0LAQUeAQEcBQsCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgKAwoMtlqHGSKFFIZ3hH6BPQGDT4MhgRQFhz6FVDmIWAGBHoN6iVxIkS+ISYJ0DRCBVj00g2qBfQEBAQ
X-IPAS-Result: A2B7EAC4bSNWPEcgBlxeGQEBAgYFAQIBAYMJVG+GWm2yEoYJGYV/BAKBEk0BAQEBAQEHAQEBAUEkG0ELAYNbBQEBAQECAQgBAR0LAQUeAQEcBQsCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgKAwoMtlqHGSKFFIZ3hH6BPQGDT4MhgRQFhz6FVDmIWAGBHoN6iVxIkS+ISYJ0DRCBVj00g2qBfQEBAQ
X-IronPort-AV: E=Sophos;i="5.17,696,1437433200"; 
   d="scan'208";a="622467467"
Received: from host-92-6-32-71.as43234.net (HELO PhilipOakley) ([92.6.32.71])
  by out1.ip05ir2.opaltelecom.net with SMTP; 18 Oct 2015 11:03:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279802>

=46rom: "Torsten B=F6gershausen" <tboegi@web.de>
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

I think that this last generic 'txt' should be explicit, e.g. 'txt-no-e=
ols',=20
so that the categories are explicit and mutually exclusive.

Also, does this need a documentation update for the options, and can th=
e=20
distinction between txt and bin be documented /referenced.

>
> Implementation details:
> Make struct text_stat, is_binary() and gather_stats() from convert.c
> public, add a new function get_convert_stats_ascii() and use it
> in and use them in ls-files.
> git ls-files --eol-staged will give a line like this:
>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> ---
> This needs to go on top of tb/t0027-crlf
>
> builtin/ls-files.c | 21 +++++++++++++++++++++
> convert.c          | 51=20
> +++++++++++++++++++++++++++++++++++++++++----------
> convert.h          | 14 ++++++++++++++
> 3 files changed, 76 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b6a7cb0..c989e94 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -27,6 +27,8 @@ static int show_killed;
> static int show_valid_bit;
> static int line_terminator =3D '\n';
> static int debug_mode;
> +static int show_eol_staged;
> +static int show_eol_wt;
>
> static const char *prefix;
> static int max_prefix_len;
> @@ -68,6 +70,11 @@ static void show_dir_entry(const char *tag, struct=
=20
> dir_entry *ent)
> return;
>
> fputs(tag, stdout);
> + if (show_eol_wt) {
> + printf("%s ", get_convert_stats_ascii(ent->name,
> + GET_CONVERT_STATS_ASCII_WT, 0));
> + }
> +
> write_name(ent->name);
> }
>
> @@ -170,6 +177,14 @@ static void show_ce_entry(const char *tag, const=
=20
> struct cache_entry *ce)
>        find_unique_abbrev(ce->sha1,abbrev),
>        ce_stage(ce));
> }
> + if (show_eol_staged) {
> + printf("%s ",
> + get_convert_stats_ascii(ce->name, GET_CONVERT_STATS_ASCII_BLOB, 0))=
;
> + }
> + if (show_eol_wt) {
> + printf("%s ",=20
> get_convert_stats_ascii(ce->name,GET_CONVERT_STATS_ASCII_WT,
> + ce->ce_stat_data.sd_size));
> + }
> write_name(ce->name);
> if (debug_mode) {
> const struct stat_data *sd =3D &ce->ce_stat_data;
> @@ -206,6 +221,10 @@ static void show_ru_info(void)
> printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
>        find_unique_abbrev(ui->sha1[i], abbrev),
>        i + 1);
> + if (show_eol_wt) {
> + printf("%s ",
> + get_convert_stats_ascii(path, GET_CONVERT_STATS_ASCII_WT, 0));
> + }
> write_name(path);
> }
> }
> @@ -433,6 +452,8 @@ int cmd_ls_files(int argc, const char **argv, con=
st=20
> char *cmd_prefix)
> OPT_BIT(0, "directory", &dir.flags,
> N_("show 'other' directories' names only"),
> DIR_SHOW_OTHER_DIRECTORIES),
> + OPT_BOOL(0, "eol-staged", &show_eol_staged, N_("show line endings o=
f the=20
> staged file")),
> + OPT_BOOL(0, "eol-worktree", &show_eol_wt, N_("show line endings of =
the=20
> file in work tree")),
> OPT_NEGBIT(0, "empty-directory", &dir.flags,
> N_("don't show empty directories"),
> DIR_HIDE_EMPTY_DIRECTORIES),
> diff --git a/convert.c b/convert.c
> index 814e814..a1c24cd 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -22,15 +22,7 @@ enum crlf_action {
> CRLF_AUTO
> };
>
> -struct text_stat {
> - /* NUL, CR, LF and CRLF counts */
> - unsigned nul, cr, lf, crlf;
> -
> - /* These are just approximations! */
> - unsigned printable, nonprintable;
> -};
> -
> -static void gather_stats(const char *buf, unsigned long size, struct=
=20
> text_stat *stats)
> +void gather_stats(const char *buf, unsigned long size, struct text_s=
tat=20
> *stats)
> {
> unsigned long i;
>
> @@ -76,7 +68,7 @@ static void gather_stats(const char *buf, unsigned =
long=20
> size, struct text_stat *
> /*
> * The same heuristics as diff.c::mmfile_is_binary()
> */
> -static int is_binary(unsigned long size, struct text_stat *stats)
> +int is_binary(unsigned long size, struct text_stat *stats)
> {
>
> if (stats->nul)
> @@ -95,6 +87,45 @@ static int is_binary(unsigned long size, struct=20
> text_stat *stats)
> return 0;
> }
>
> +
> +const char *gather_stats_ascii(const char *data, unsigned long size)
> +{
> + struct text_stat stats;
> + if (!data || !size)
> + return("empty   ");
> + gather_stats(data, size, &stats);
> + if (is_binary(size, &stats))
> + return("bin     ");
> + else if (stats.cr !=3D stats.crlf)
> + return("bin     ");
> + else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
> + return("txt-crlf");
> + else if (stats.crlf && stats.lf)
> + return("txt-mix ");
> + else if (stats.lf)
> + return("txt-lf  ");
> + else
> + return("txt     ");
> +}
> +
> +const char *get_convert_stats_ascii(const char *path, int flags, siz=
e_t=20
> hint)
> +{
> + const char *ret =3D "";
> + if (flags & GET_CONVERT_STATS_ASCII_BLOB) {
> + unsigned long sz;
> + void *data =3D read_blob_data_from_cache(path, &sz);
> + ret =3D gather_stats_ascii(data, sz);
> + if (data)
> + free(data);
> + } else if (flags & GET_CONVERT_STATS_ASCII_WT){
> + struct strbuf sb =3D STRBUF_INIT;
> + strbuf_read_file(&sb, path, hint);
> + ret =3D gather_stats_ascii(sb.buf, sb.len);
> + strbuf_release(&sb);
> + }
> + return ret;
> +}
> +
> static enum eol output_eol(enum crlf_action crlf_action)
> {
> switch (crlf_action) {
> diff --git a/convert.h b/convert.h
> index d9d853c..566cf0e 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -31,6 +31,20 @@ enum eol {
> #endif
> };
>
> +struct text_stat {
> + /* NUL, CR, LF and CRLF counts */
> + unsigned nul, cr, lf, crlf;
> +
> + /* These are just approximations! */
> + unsigned printable, nonprintable;
> +};
> +void gather_stats(const char *buf, unsigned long size, struct text_s=
tat=20
> *stats);
> +int is_binary(unsigned long size, struct text_stat *stats);
> +const char *gather_stats_ascii(const char *buf, unsigned long size);
> +#define GET_CONVERT_STATS_ASCII_BLOB           (1<<0)
> +#define GET_CONVERT_STATS_ASCII_WT             (1<<1)
> +const char *get_convert_stats_ascii(const char *path, int isBlob, si=
ze_t=20
> hint);
> +
> extern enum eol core_eol;
>
> /* returns 1 if *dst was used */
> --=20
> 2.6.1.443.g36d7748
>
> --
Philip=20
