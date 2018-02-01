Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750881F404
	for <e@80x24.org>; Thu,  1 Feb 2018 15:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeBAPZy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 10:25:54 -0500
Received: from avasout01.plus.net ([84.93.230.227]:49818 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBAPZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 10:25:53 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id hGkIeTHFILYfwhGkJeA0DH; Thu, 01 Feb 2018 15:25:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrFsBH9C c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=N659UExz7-8A:10 a=iox4zFpeAAAA:8 a=oVgDDlOFp-8hAGdRSYQA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=pILNOxqGKmIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        git@vger.kernel.org
References: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0157dde9-4450-6528-31a5-2a3f95e2afec@ramsayjones.plus.com>
Date:   Thu, 1 Feb 2018 15:25:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDGjFk1omjRDSAhj+AL8JarLm+2thU/sCruMpdbpQH9OdqgW1q8mtuQ/9XHqsjlleddW5W3GxOlo8PDfwuJll5xjb1Vl4+oiPntK9Sf7Of/GWsp83ZQ7
 4iFOdfqlc+BEfIiX32AdTMQzmDIx6be3jcQTbDZmqmzSR8iaIxa63aA8XMYiF/GcghHlsY2JierWKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/02/18 09:49, Nicolas Morey-Chaisemartin wrote:
> Add a --edit option whichs allows modifying the messages provided by -m or -F,
> the same way git commit --edit does.
> 
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
>  Documentation/git-tag.txt |  6 ++++++
>  builtin/tag.c             | 11 +++++++++--
>  t/t7004-tag.sh            | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 956fc019f984..b9e5a993bea0 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
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
> index a7e6a5b0f234..91c60829d5f9 100644
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
> +		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),

s/commit/tag message/ ?

ATB,
Ramsay Jones

