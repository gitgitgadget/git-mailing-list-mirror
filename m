Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D4B1F488
	for <e@80x24.org>; Wed,  8 May 2019 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfEHRS3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:18:29 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47232 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfEHRS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 13:18:29 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hOQD3-0000E6-9y
        for git@vger.kernel.org; Wed, 08 May 2019 19:18:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/2] format-patch: teach format.notes config option
Date:   Wed, 8 May 2019 19:18:18 +0200
Message-ID: <dbd01507-d56e-4353-c953-f0b05dfdf510@drbeat.li>
References: <cover.1556388260.git.liu.denton@gmail.com>
 <cover.1557327652.git.liu.denton@gmail.com>
 <fe674bf63e8d5b8a06a3f880db4dc4bcfd2183f6.1557327652.git.liu.denton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
In-Reply-To: <fe674bf63e8d5b8a06a3f880db4dc4bcfd2183f6.1557327652.git.liu.denton@gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.05.19 17:02, Denton Liu wrote:
> In git-format-patch, notes can be appended with the `--notes` option.
> However, this must be specified by the user on an
> invocation-by-invocation basis. If a user is not careful, it's possible
> that they may forget to include it and generate a patch series without
> notes.
> 
> Teach git-format-patch the `format.notes` config option its value is a

s/its/. Its/

> notes ref that will be automatically be appended. The special value of

Drop the second "be ".

> "standard" can be used to specify the standard notes. This option is
> overridable with the `--no-notes` option in case a user wishes not to
> append notes.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> One thing I'm worried about is that I'm not really sure using "standard"
> as the special value is a good idea. Would "auto" be a better special
> value?
> 
>  Documentation/config/format.txt    | 13 ++++++
>  Documentation/git-format-patch.txt |  3 ++
>  builtin/log.c                      | 18 +++++++-
>  t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
>  4 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index dc77941c48..e25f9cfc61 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -85,3 +85,16 @@ format.outputDirectory::
>  format.useAutoBase::
>  	A boolean value which lets you enable the `--base=auto` option of
>  	format-patch by default.
> +
> +format.notes::
> +	A ref which specifies where to get the notes (see
> +	linkgit:git-notes[1]) that are appended for the commit after the
> +	three-dash line.
> ++
> +If the special value of "standard" is specified, then the standard notes
> +ref is used (i.e. the notes ref used by `git notes` when no `--ref`
> +argument is specified). If one wishes to use the ref
> +`ref/notes/standard`, please use that literal instead.
> ++
> +This configuration can be specified multiple times in order to allow
> +multiple notes refs to be included.
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 2c3971390e..9ce5b8aaee 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
>  keeping them as Git notes allows them to be maintained between versions
>  of the patch series (but see the discussion of the `notes.rewrite`
>  configuration options in linkgit:git-notes[1] to use this workflow).
> ++
> +The default is `--no-notes`, unless the `format.notes` configuration is
> +set.
>  
>  --[no-]signature=<signature>::
>  	Add a signature to each message produced. Per RFC 3676 the signature
> diff --git a/builtin/log.c b/builtin/log.c
> index e43ee12fb1..24954e42b0 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -779,6 +779,8 @@ enum {
>  
>  static int git_format_config(const char *var, const char *value, void *cb)
>  {
> +	struct rev_info *rev = cb;
> +
>  	if (!strcmp(var, "format.headers")) {
>  		if (!value)
>  			die(_("format.headers without value"));
> @@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  			from = NULL;
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.notes")) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		rev->show_notes = 1;
> +		if (!strcmp(value, "standard"))
> +			rev->notes_opt.use_default_notes = 1;
> +		else {

Use braces on both parts of the "if", if one part needs them.

> +			strbuf_addstr(&buf, value);
> +			expand_notes_ref(&buf);
> +			string_list_append(&rev->notes_opt.extra_notes_refs,
> +					strbuf_detach(&buf, NULL));
> +		}
> +		return 0;
> +	}
>  
>  	return git_log_config(var, value, cb);
>  }
> @@ -1617,8 +1633,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	extra_to.strdup_strings = 1;
>  	extra_cc.strdup_strings = 1;
>  	init_log_defaults();
> -	git_config(git_format_config, NULL);
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(git_format_config, &rev);
>  	rev.commit_format = CMIT_FMT_EMAIL;
>  	rev.expand_tabs_in_log_default = 0;
>  	rev.verbose_header = 1;
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b6e2fdbc44..e0127282ba 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -738,6 +738,76 @@ test_expect_success 'format-patch --notes --signoff' '
>  	sed "1,/^---$/d" out | grep "test message"
>  '
>  
> +test_expect_success 'format-patch notes output control' '
> +	git notes add -m "notes config message" HEAD &&
> +	test_when_finished git notes remove HEAD &&
> +
> +	git format-patch -1 --stdout >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out &&
> +
> +	test_config format.notes standard &&
> +	git format-patch -1 --stdout >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes >out &&
> +	grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --notes --no-notes >out &&
> +	! grep "notes config message" out &&
> +	git format-patch -1 --stdout --no-notes --notes >out &&
> +	grep "notes config message" out
> +'
> +
> +test_expect_success 'format-patch with multiple notes refs' '
> +	git notes --ref note1 add -m "this is note 1" HEAD &&
> +	test_when_finished git notes --ref note1 remove HEAD &&
> +	git notes --ref note2 add -m "this is note 2" HEAD &&
> +	test_when_finished git notes --ref note2 remove HEAD &&
> +
> +	git format-patch -1 --stdout >out &&
> +	! grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --notes=note1 >out &&
> +	grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --notes=note2 >out &&
> +	! grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +
> +	test_config format.notes note1 &&
> +	git format-patch -1 --stdout >out &&
> +	grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "this is note 1" out &&
> +	! grep "this is note 2" out &&
> +	git format-patch -1 --stdout --notes=note2 >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
> +	! grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +
> +	git config --add format.notes note2 &&
> +	git format-patch -1 --stdout >out &&
> +	grep "this is note 1" out &&
> +	grep "this is note 2" out &&
> +	git format-patch -1 --stdout --no-notes >out &&
> +	! grep "this is note 1" out &&
> +	! grep "this is note 2" out
> +'
> +
>  echo "fatal: --name-only does not make sense" > expect.name-only
>  echo "fatal: --name-status does not make sense" > expect.name-status
>  echo "fatal: --check does not make sense" > expect.check
> 

Cheers, Beat

