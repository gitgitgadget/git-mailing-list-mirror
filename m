Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0148D1F576
	for <e@80x24.org>; Thu,  8 Feb 2018 08:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeBHIWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 03:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeBHIWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 03:22:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE79AAB49;
        Thu,  8 Feb 2018 08:22:20 +0000 (UTC)
Subject: Re: [PATCHv4] tag: add --edit option
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
References: <09e24322-7eee-6c83-1db0-318815155fac@suse.com>
Openpgp: preference=signencrypt
Message-ID: <7e44c238-6264-e9a5-b159-7cf2905c6a13@suse.com>
Date:   Thu, 8 Feb 2018 09:22:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <09e24322-7eee-6c83-1db0-318815155fac@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore !

v3 with the nits fixed was picked by Junio

Le 07/02/2018 à 17:55, Nicolas Morey-Chaisemartin a écrit :
> Add a --edit option whichs allows modifying the messages provided by -m or -F,
> the same way git commit --edit does.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
>
> Fixes since v3 ( https://public-inbox.org/git/88e7c122-599f-4ab1-6d65-c75f7a3ae8bb@suse.com/ ):
>  * Replace tab by space in t/t7004-tag.sh
>
>
>  Documentation/git-tag.txt |  8 +++++++-
>  builtin/tag.c             | 11 +++++++++--
>  t/t7004-tag.sh            | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 956fc019f984..1d17101bac39 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
>  SYNOPSIS
>  --------
>  [verse]
> -'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
> +'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
> @@ -167,6 +167,12 @@ This option is only applicable when listing tags without annotation lines.
>  	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
>  	is given.
>  
> +-e::
> +--edit::
> +	The message taken from file with `-F` and command line with
> +	`-m` are usually used as the tag message unmodified.
> +	This option lets you further edit the message taken from these sources.
> +
>  --cleanup=<mode>::
>  	This option sets how the tag message is cleaned up.
>  	The  '<mode>' can be one of 'verbatim', 'whitespace' and 'strip'.  The
> diff --git a/builtin/tag.c b/builtin/tag.c
> index a7e6a5b0f234..ce5cac3dd23f 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -194,6 +194,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
>  
>  struct create_tag_options {
>  	unsigned int message_given:1;
> +	unsigned int use_editor:1;
>  	unsigned int sign;
>  	enum {
>  		CLEANUP_NONE,
> @@ -224,7 +225,7 @@ static void create_tag(const struct object_id *object, const char *tag,
>  		    tag,
>  		    git_committer_info(IDENT_STRICT));
>  
> -	if (!opt->message_given) {
> +	if (!opt->message_given || opt->use_editor) {
>  		int fd;
>  
>  		/* write the template message before editing: */
> @@ -233,7 +234,10 @@ static void create_tag(const struct object_id *object, const char *tag,
>  		if (fd < 0)
>  			die_errno(_("could not create file '%s'"), path);
>  
> -		if (!is_null_oid(prev)) {
> +		if (opt->message_given) {
> +			write_or_die(fd, buf->buf, buf->len);
> +			strbuf_reset(buf);
> +		} else if (!is_null_oid(prev)) {
>  			write_tag_body(fd, prev);
>  		} else {
>  			struct strbuf buf = STRBUF_INIT;
> @@ -372,6 +376,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>  	struct ref_format format = REF_FORMAT_INIT;
>  	int icase = 0;
> +	int edit_flag = 0;
>  	struct option options[] = {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
> @@ -386,6 +391,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK('m', "message", &msg, N_("message"),
>  			     N_("tag message"), parse_msg_arg),
>  		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
> +		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
>  		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
>  		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
>  			N_("how to strip spaces and #comments from message")),
> @@ -524,6 +530,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		die(_("tag '%s' already exists"), tag);
>  
>  	opt.message_given = msg.given || msgfile;
> +	opt.use_editor = edit_flag;
>  
>  	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
>  		opt.cleanup_mode = CLEANUP_ALL;
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index a9af2de9960b..0630f2dee24b 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -452,6 +452,21 @@ test_expect_success \
>  	test_cmp expect actual
>  '
>  
> +get_tag_header annotated-tag-edit $commit commit $time >expect
> +echo "An edited message" >>expect
> +test_expect_success 'set up editor' '
> +	write_script fakeeditor <<-\EOF
> +	sed -e "s/A message/An edited message/g" <"$1" >"$1-"
> +	mv "$1-" "$1"
> +	EOF
> +'
> +test_expect_success \
> +	'creating an annotated tag with -m message --edit should succeed' '
> +	EDITOR=./fakeeditor git tag -m "A message" --edit annotated-tag-edit &&
> +	get_tag_msg annotated-tag-edit >actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >msgfile <<EOF
>  Another message
>  in a file.
> @@ -465,6 +480,21 @@ test_expect_success \
>  	test_cmp expect actual
>  '
>  
> +get_tag_header file-annotated-tag-edit $commit commit $time >expect
> +sed -e "s/Another message/Another edited message/g" msgfile >>expect
> +test_expect_success 'set up editor' '
> +	write_script fakeeditor <<-\EOF
> +	sed -e "s/Another message/Another edited message/g" <"$1" >"$1-"
> +	mv "$1-" "$1"
> +	EOF
> +'
> +test_expect_success \
> +	'creating an annotated tag with -F messagefile --edit should succeed' '
> +	EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
> +	get_tag_msg file-annotated-tag-edit >actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >inputmsg <<EOF
>  A message from the
>  standard input

