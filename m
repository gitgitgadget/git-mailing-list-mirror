From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v7] ls-files: Add eol diagnostics
Date: Mon, 7 Dec 2015 20:12:30 -0000
Organization: OPDS
Message-ID: <E2D76919B3F548E9864D12425A4C0EF6@PhilipOakley>
References: <5665BD39.1040403@web.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <tboegi@web.de>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a629G-0000TC-NM
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbbLGUMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 15:12:34 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:10586 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932542AbbLGUMd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 15:12:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A6GADw5mVWPN3LYAJeGQEBAg8BAQEBgwpTbodMs0uDOgRYI4IWAYNOBAKBR00BAQEBAQEHAQEBAUE/QQEBAwsCg1wFAQEBAQIBCAEBGQQLAQUeAQEcBQUGAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiAkDCgwJsCqGVYUrIoQ6CwEBAR+BAYVThH2BQAGGNi+BFQWNKYk4AYEphAOIFIIfmkmCdA0QgVY+NIFGgQ+DGgEBAQ
X-IPAS-Result: A2A6GADw5mVWPN3LYAJeGQEBAg8BAQEBgwpTbodMs0uDOgRYI4IWAYNOBAKBR00BAQEBAQEHAQEBAUE/QQEBAwsCg1wFAQEBAQIBCAEBGQQLAQUeAQEcBQUGAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiAkDCgwJsCqGVYUrIoQ6CwEBAR+BAYVThH2BQAGGNi+BFQWNKYk4AYEphAOIFIIfmkmCdA0QgVY+NIFGgQ+DGgEBAQ
X-IronPort-AV: E=Sophos;i="5.20,396,1444690800"; 
   d="scan'208";a="618896106"
Received: from host-2-96-203-221.as13285.net (HELO PhilipOakley) ([2.96.203.221])
  by out1.ip04ir2.opaltelecom.net with SMTP; 07 Dec 2015 20:29:42 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282114>

=46rom: "Torsten B=C3=B6gershausen" <tboegi@web.de>
> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.
>

The need for this came up again on the Git Users list=20
(https://groups.google.com/d/msg/git-users/jC-mngwVYo4/Sr4JXgpGJVYJ). I=
t=20
will definitely be useful in mixed environments wher users can get rath=
er=20
confused.

I've added a couple of bikeshed comments on some of the wider issues th=
is=20
bumps into.

> Make it possible to let Git show the line endings in the index and
> in the working tree and the effective text/eol attributes.
>
> The end of line ("eolinfo") are shown like this:
> "binary"       binary file
> "text-no-eol"  text file without any EOL
> "text-lf"      text file with LF
> "text-crlf"    text file with CRLF
> "text-crlf-lf" text file with mixed line endings.

<bikeshed> This "text-crlf-lf" can easily occur for eol=3Dcrlf files wh=
ich=20
have merge conflict markers, which are always eol=3Dlf. It may be that =
the=20
conflict markers should use the eol setting that is in place for the fi=
le=20
being merged. e.g.=20
http://stackoverflow.com/questions/17832616/make-git-use-crlf-on-its-he=
ad-merge-lines=20
(which links to https://github.com/git/git/blob/master/xdiff/xmerge.c#L=
173,=20
and 3 other places in fill_conflict_hunk). The issue of how to mark EOL=
=20
conflicts in-text is tricky as it's a non-obvious white space issue - i=
t=20
doesn't fit well with the normal >>> =3D=3D=3D <<< conflict markers.

>
> The effective text/eol attribute is one of these:
> "", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcrlf"

<bikeshed> the "-text" attribute isn't explained in the gitattributes(5=
)=20
page, except by implication  from one of the examples.
>
> git ls-files --eol gives an output like this:
>
> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
> i/binary        w/binary        attr/-text     t/test-binary-2.png
> i/text-lf       w/text-lf       attr/eol=3Dlf    t/t5100/rfc2047-info=
-0007
> i/text-lf       w/text-crlf     attr/eol=3Dcrlf  doit.bat
> i/text-crlf-lf  w/text-crlf-lf  attr/          locale/XX.po
>
> Note that the output is meant to be human-readable and may change.
>
> Helped-By: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since v6:
> - Fixed potential memory leak in convert.c, when strbuf_read_file()
>  fails.
> - t0027:
>  Cleanups (empty lines, egrep, un-needed quoting)
>  test_when_finished 'rm e expect actual'
>  There doesn't seem to be 100% consistency when and how to remove fil=
es.
>  (I think if we create files, we should be able to remove them:
>  use "rm" rather than "rm -f")
>  Add comment about the "last test case", which removes file to run
>  'git ls-files -d"
>
> Documentation/git-ls-files.txt |  22 +++++++++
> builtin/ls-files.c             |  19 ++++++++
> convert.c                      |  85 ++++++++++++++++++++++++++++++++
> convert.h                      |   3 ++
> t/t0027-auto-crlf.sh           | 108=20
> ++++++++++++++++++++++++++++++++++++-----
> 5 files changed, 226 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt=20
> b/Documentation/git-ls-files.txt
> index e26f01f..8f29c99 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
> 'git ls-files' [-z] [-t] [-v]
>  (--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
>  (-[c|d|o|i|s|u|k|m])*
> + [--eol]
>  [-x <pattern>|--exclude=3D<pattern>]
>  [-X <file>|--exclude-from=3D<file>]
>  [--exclude-per-directory=3D<file>]
> @@ -147,6 +148,18 @@ a space) at the start of each line:
>  possible for manual inspection; the exact format may change at
>  any time.
>
> +--eol::
> + Show line endings ("eolinfo") and the text/eol attributes=20
> ("texteolattr") of files.
> + "eolinfo" is the file content identification used by Git when
> + the "text" attribute is "auto", or core.autocrlf !=3D false.
> +
> + "eolinfo" is either "" (when the the info is not available"), or on=
e of=20
> "binary",
> + "text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
> + The "texteolattr" can be "", "-text", "text", "text=3Dauto", "eol=3D=
lf",=20
> "eol=3Dcrlf".

perhaps add  'see also linkgit:gitattributes[5] .' though it may be too=
=20
tangential.

> +
> + Both the content in the index ("i/") and the content in the working=
 tree=20
> ("w/")
> + are shown for regular files, followed by the "texteolattr ("attr/")=
=2E
> +
> \--::
>  Do not interpret any more arguments as options.
>
> @@ -161,6 +174,15 @@ which case it outputs:
>
>         [<tag> ]<mode> <object> <stage> <file>
>
> +'git ls-files --eol' will show
> + i/<eolinfo> w/<eolinfo> attr/<eolattr> <file>
> +
> +'git ls-files --eol -o' will show
> + i/          w/<eolinfo> attr/<eolattr> <file>
> +
> +'git ls-files --eol -s' will show
> +[<tag> ]<mode> <object> <stage> i/<eolinfo> w/<eolinfo> attr/<eolatt=
r>=20
> <file>
> +
> 'git ls-files --unmerged' and 'git ls-files --stage' can be used to=20
> examine
> detailed information on unmerged paths.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b6a7cb0..ef892bc 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -27,6 +27,7 @@ static int show_killed;
> static int show_valid_bit;
> static int line_terminator =3D '\n';
> static int debug_mode;
> +static int show_eol;
>
> static const char *prefix;
> static int max_prefix_len;
> @@ -47,6 +48,21 @@ static const char *tag_modified =3D "";
> static const char *tag_skip_worktree =3D "";
> static const char *tag_resolve_undo =3D "";
>
> +static void write_eolinfo(const struct cache_entry *ce, const char *=
path)
> +{
> + struct stat st;
> + const char *i_txt =3D "";
> + const char *w_txt =3D "";
> + if (!show_eol)
> + return;
> + if (ce && S_ISREG(ce->ce_mode))
> + i_txt =3D get_cached_convert_stats_ascii(ce->name);
> + if (!lstat(path, &st) && (S_ISREG(st.st_mode)))
> + w_txt =3D get_wt_convert_stats_ascii(path);
> + printf("i/%-13s w/%-13s attr/%-9s ", i_txt, w_txt,
> + get_convert_attr_ascii(path));
> +}
> +
> static void write_name(const char *name)
> {
>  /*
> @@ -68,6 +84,7 @@ static void show_dir_entry(const char *tag, struct=20
> dir_entry *ent)
>  return;
>
>  fputs(tag, stdout);
> + write_eolinfo(NULL, ent->name);
>  write_name(ent->name);
> }
>
> @@ -170,6 +187,7 @@ static void show_ce_entry(const char *tag, const=20
> struct cache_entry *ce)
>         find_unique_abbrev(ce->sha1,abbrev),
>         ce_stage(ce));
>  }
> + write_eolinfo(ce, ce->name);
>  write_name(ce->name);
>  if (debug_mode) {
>  const struct stat_data *sd =3D &ce->ce_stat_data;
> @@ -433,6 +451,7 @@ int cmd_ls_files(int argc, const char **argv, con=
st=20
> char *cmd_prefix)
>  OPT_BIT(0, "directory", &dir.flags,
>  N_("show 'other' directories' names only"),
>  DIR_SHOW_OTHER_DIRECTORIES),
> + OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
>  OPT_NEGBIT(0, "empty-directory", &dir.flags,
>  N_("don't show empty directories"),
>  DIR_HIDE_EMPTY_DIRECTORIES),
> diff --git a/convert.c b/convert.c
> index 814e814..61d6757 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -13,6 +13,11 @@
>  * translation when the "text" attribute or "auto_crlf" option is set=
=2E
>  */
>
> +/* Stat bits: When BIN is set, the txt bits are unset */
> +#define CONVERT_STAT_BITS_TXT_LF   (1)
> +#define CONVERT_STAT_BITS_TXT_CRLF (2)
> +#define CONVERT_STAT_BITS_BIN      (4)
> +
> enum crlf_action {
>  CRLF_GUESS =3D -1,
>  CRLF_BINARY =3D 0,
> @@ -95,6 +100,62 @@ static int is_binary(unsigned long size, struct=20
> text_stat *stats)
>  return 0;
> }
>
> +static unsigned int gather_convert_stats(const char *data, unsigned =
long=20
> size)
> +{
> + struct text_stat stats;
> + if (!data || !size)
> + return 0;
> + gather_stats(data, size, &stats);
> + if (is_binary(size, &stats) || stats.cr !=3D stats.crlf)
> + return CONVERT_STAT_BITS_BIN;
> + else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
> + return CONVERT_STAT_BITS_TXT_CRLF;
> + else if (stats.crlf && stats.lf)
> + return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
> + else if (stats.lf)
> + return CONVERT_STAT_BITS_TXT_LF;
> + else
> + return 0;
> +}
> +
> +static const char *gather_convert_stats_ascii(const char *data, unsi=
gned=20
> long size)
> +{
> + unsigned int convert_stats =3D gather_convert_stats(data, size);
> +
> + if (convert_stats & CONVERT_STAT_BITS_BIN)
> + return "binary";
> + switch (convert_stats) {
> + case CONVERT_STAT_BITS_TXT_LF:
> + return("text-lf");
> + case CONVERT_STAT_BITS_TXT_CRLF:
> + return("text-crlf");
> + case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT_CRLF:
> + return("text-crlf-lf");
> + default:
> + return ("text-no-eol");
> + }
> +}
> +
> +const char *get_cached_convert_stats_ascii(const char *path)
> +{
> + const char *ret;
> + unsigned long sz;
> + void *data =3D read_blob_data_from_cache(path, &sz);
> + ret =3D gather_convert_stats_ascii(data, sz);
> + free(data);
> + return ret;
> +}
> +
> +const char *get_wt_convert_stats_ascii(const char *path)
> +{
> + const char *ret =3D "";
> + struct strbuf sb =3D STRBUF_INIT;
> + if (strbuf_read_file(&sb, path, 0) >=3D 0)
> + ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
> + strbuf_release(&sb);
> + return ret;
> +}
> +
> static enum eol output_eol(enum crlf_action crlf_action)
> {
>  switch (crlf_action) {
> @@ -777,6 +838,30 @@ int would_convert_to_git_filter_fd(const char *p=
ath)
>  return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> }
>
> +const char *get_convert_attr_ascii(const char *path)
> +{
> + struct conv_attrs ca;
> + enum crlf_action crlf_action;
> +
> + convert_attrs(&ca, path);
> + crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
> + switch (crlf_action) {
> + case CRLF_GUESS:
> + return "";
> + case CRLF_BINARY:
> + return "-text";
> + case CRLF_TEXT:
> + return "text";
> + case CRLF_INPUT:
> + return "eol=3Dlf";
> + case CRLF_CRLF:
> + return "eol=3Dcrlf";
> + case CRLF_AUTO:
> + return "text=3Dauto";
> + }
> + return "";
> +}
> +
> int convert_to_git(const char *path, const char *src, size_t len,
>                    struct strbuf *dst, enum safe_crlf checksafe)
> {
> diff --git a/convert.h b/convert.h
> index d9d853c..ccf436b 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -32,6 +32,9 @@ enum eol {
> };
>
> extern enum eol core_eol;
> +extern const char *get_cached_convert_stats_ascii(const char *path);
> +extern const char *get_wt_convert_stats_ascii(const char *path);
> +extern const char *get_convert_attr_ascii(const char *path);
>
> /* returns 1 if *dst was used */
> extern int convert_to_git(const char *path, const char *src, size_t l=
en,
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index b343651..a89f2ba 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -56,21 +56,16 @@ create_gitattributes () {
> }
>
> create_NNO_files () {
> - lfname=3D$1
> - crlfname=3D$2
> - lfmixcrlf=3D$3
> - lfmixcr=3D$4
> - crlfnul=3D$5
>  for crlf in false true input
>  do
>  for attr in "" auto text -text lf crlf
>  do
>  pfx=3DNNO_${crlf}_attr_${attr} &&
> - cp $lfname    ${pfx}_LF.txt &&
> - cp $crlfname  ${pfx}_CRLF.txt &&
> - cp $lfmixcrlf ${pfx}_CRLF_mix_LF.txt &&
> - cp $lfmixcr   ${pfx}_LF_mix_CR.txt &&
> - cp $crlfnul   ${pfx}_CRLF_nul.txt
> + cp CRLF_mix_LF ${pfx}_LF.txt &&
> + cp CRLF_mix_LF ${pfx}_CRLF.txt &&
> + cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
> + cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
> + cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
>  done
>  done
> }
> @@ -96,7 +91,7 @@ commit_check_warn () {
>  crlfnul=3D$7
>  pfx=3Dcrlf_${crlf}_attr_${attr}
>  create_gitattributes "$attr" &&
> - for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
> + for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
>  do
>  fname=3D${pfx}_$f.txt &&
>  cp $f $fname &&
> @@ -149,6 +144,36 @@ commit_chk_wrnNNO () {
>  '
> }
>
> +stats_ascii () {
> + case "$1" in
> + LF)
> + echo text-lf
> + ;;
> + CRLF)
> + echo text-crlf
> + ;;
> + CRLF_mix_LF)
> + echo text-crlf-lf
> + ;;
> + LF_mix_CR)
> + echo binary
> + ;;
> + CRLF_nul)
> + echo binary
> + ;;
> + LF_nul)
> + echo binary
> + ;;
> + CRLF_mix_CR)
> + echo binary
> + ;;
> + *)
> + echo error_invalid $1
> + ;;
> + esac
> +
> +}
> +
> check_files_in_repo () {
>  crlf=3D$1
>  attr=3D$2
> @@ -214,6 +239,20 @@ checkout_files () {
>  fi
>  done
>
> + test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +   test_when_finished 'rm e expect actual' &&
> + cat >e <<-EOF &&
> + i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
> + i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
> + i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt
> + i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
> + i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
> + i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
> + EOF
> + sort <e >expect &&
> + git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */=
 /g' |=20
> sort >actual &&
> + test_cmp expect actual
> + "
>  test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf=20
> gitattributes=3D$attr file=3DLF" "
>  compare_ws_file $pfx $lfname    ${src}LF.txt
>  "
> @@ -231,6 +270,37 @@ checkout_files () {
>  "
> }
>
> +# Test control characters
> +# NUL SOH CR EOF=3D=3D^Z
> +test_expect_success 'ls-files --eol -o Text/Binary' '
> + test_when_finished "rm e expect actual TeBi_*" &&
> + STRT=3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA &&
> + STR=3D$STRT$STRT$STRT$STRT &&
> + printf "${STR}BBB\001" >TeBi_127_S &&
> + printf "${STR}BBBB\001">TeBi_128_S &&
> + printf "${STR}BBB\032" >TeBi_127_E &&
> + printf "\032${STR}BBB" >TeBi_E_127 &&
> + printf "${STR}BBBB\000">TeBi_128_N &&
> + printf "${STR}BBB\012">TeBi_128_L &&
> + printf "${STR}BBB\015">TeBi_127_C &&
> + printf "${STR}BB\015\012" >TeBi_126_CL &&
> + printf "${STR}BB\015\012\015" >TeBi_126_CLC &&
> + cat >e <<-\EOF &&
> + i/ w/binary TeBi_127_S
> + i/ w/text-no-eol TeBi_128_S
> + i/ w/text-no-eol TeBi_127_E
> + i/ w/binary TeBi_E_127
> + i/ w/binary TeBi_128_N
> + i/ w/text-lf TeBi_128_L
> + i/ w/binary TeBi_127_C
> + i/ w/text-crlf TeBi_126_CL
> + i/ w/binary TeBi_126_CLC
> + EOF
> + sort <e >expect &&
> + git ls-files --eol -o | grep TeBi_ | sed -e 's!attr/[=3Da-z-]*!!g' =
-e "s/=20
> */ /g" | sort >actual &&
> + test_cmp expect actual
> +'
> +
> #######
> test_expect_success 'setup master' '
>  echo >.gitattributes &&
> @@ -480,4 +550,20 @@ checkout_files    native  true  "lf"      LF    =
CRLF=20
> CRLF_mix_LF  LF_mix_CR
> checkout_files    native  false "crlf"    CRLF  CRLF  CRLF=20
> CRLF_mix_CR  CRLF_nul
> checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF=20
> CRLF_mix_CR  CRLF_nul
>
> +
> +# Should be the last test case: remove some files from the worktree
> +# run 'git ls-files -d'
> +test_expect_success 'ls-files --eol -d' "
> + rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt=20
> crlf_false_attr__LF.txt .gitattributes &&
> + cat >expect <<-\EOF &&
> + i/text-crlf w/ crlf_false_attr__CRLF.txt
> + i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt
> + i/text-lf w/ .gitattributes
> + i/text-lf w/ crlf_false_attr__LF.txt
> + EOF
> + git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ /g=
' |=20
> sort >actual &&
> + test_cmp expect actual &&
> + rm expect actual
> +"
> +
> test_done
> --=20
> 2.6.2.403.gd7a84e3
>
--
Philip=20
