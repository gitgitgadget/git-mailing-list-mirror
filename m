From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] submodule--helper, module_clone: always operate on absolute paths
Date: Thu, 31 Mar 2016 15:26:04 -0700
Message-ID: <xmqqfuv6l1xf.fsf@gitster.mtv.corp.google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:26:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1all2b-0003EE-S6
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbcCaW0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:26:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753140AbcCaW0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:26:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE1CC52319;
	Thu, 31 Mar 2016 18:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dzWuf5oM6dSjLB4ZHHujMgVSrsY=; b=nIVEiH
	lXSYPX8UZHo597BTlfiXkGmu7dW6cxCrbtwcM+NzAmLk1kSZKp7N+R+LlXBT3vnC
	fXbDI+nNujNnHa0eFw/4wEV4KnpK17bCUcMzMtUd4x5lC2XzqyHvnyBxTWM13ELs
	T5/nD0uPdyEpZIAOan9WFVRp5m5tPtPUtRu88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chlu7aOtXZtRa+09+YOzfqvy04sVFWad
	8b0BKXMmeEOvsgfUaE8ZKwLPvlipg9ct6+WIfJuKVy31LqaZE4GLKxgLwYbq8Z1F
	3AQIohgVuUsgDXkPgTuqdWqS89YaGqHZT47ECOb5EBJEWk5oD99S+7WypkuAb/fS
	6DSYrgrn5Q4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D622852317;
	Thu, 31 Mar 2016 18:26:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5539C52314;
	Thu, 31 Mar 2016 18:26:06 -0400 (EDT)
In-Reply-To: <1459458280-17619-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 31 Mar 2016 14:04:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F71A3A6-F78F-11E5-A777-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290479>

Stefan Beller <sbeller@google.com> writes:

> +	if (!is_absolute_path(sm_gitdir)) {
> +		char *cwd = xgetcwd();
> +		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
> +		sm_gitdir = strbuf_detach(&sb, 0);
> +		free(cwd);

It would be surprising that this would be the first codepath that
needs to get an absolute pathname in the codebase that is more than
10 years old, wouldn't it?  Don't we have a reasonable API helper
function to do this kind of thing already?

    ... goes and looks ...

Doesn't absolute_path() work here?

> @@ -221,7 +240,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	submodule_dot_git = fopen(sb.buf, "w");
>  	if (!submodule_dot_git)
>  		die_errno(_("cannot open file '%s'"), sb.buf);
> -
>  	fprintf(submodule_dot_git, "gitdir: %s\n",
>  		relative_path(sm_gitdir, path, &rel_path));
>  	if (fclose(submodule_dot_git))

Looks like an unrelated change to me.

> @@ -229,24 +247,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_reset(&sb);
>  	strbuf_reset(&rel_path);
>  
> -	cwd = xgetcwd();
>  	/* Redirect the worktree of the submodule in the superproject's config */
> -	if (!is_absolute_path(sm_gitdir)) {
> -		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
> -		free(sm_gitdir);
> -		sm_gitdir = strbuf_detach(&sb, NULL);
> -	}
> -
> -	strbuf_addf(&sb, "%s/%s", cwd, path);
>  	p = git_pathdup_submodule(path, "config");
>  	if (!p)
>  		die(_("could not get submodule directory for '%s'"), path);
>  	git_config_set_in_file(p, "core.worktree",
> -			       relative_path(sb.buf, sm_gitdir, &rel_path));
> +			       relative_path(path, sm_gitdir, &rel_path));
>  	strbuf_release(&sb);
>  	strbuf_release(&rel_path);
>  	free(sm_gitdir);
> -	free(cwd);
> +

This addition of blank, too.

>  	free(p);
>  	return 0;
>  }
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fc11809..ea3fabb 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -818,7 +818,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
>  	)
>  '
>  
> -test_expect_failure 'recursive relative submodules stay relative' '
> +test_expect_success 'recursive relative submodules stay relative' '
>  	test_when_finished "rm -rf super clone2 subsub sub3" &&
>  	mkdir subsub &&
>  	(
