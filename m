From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] submodule--helper: use relative path if possible
Date: Thu, 31 Mar 2016 09:59:17 -0700
Message-ID: <xmqqd1qapore.fsf@gitster.mtv.corp.google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfwL-0006VQ-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbcCaQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:59:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbcCaQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E01465153C;
	Thu, 31 Mar 2016 12:59:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1evKxLV2qa+XnoptSoXPe6Fb7E=; b=RuaAxI
	g9bN/9d6UTsLXv320+hCXtbciX4/yCUXH+R3HITd0mrLDE5NtE83RxlEpezdWKoH
	S552eMb3w6IN5GuXVzPGdCBsa9TkqEgAkyEXpcZwTKj666Ddf/kofs/l54F0aqIZ
	P1XU8CFPj+a1cZvPL6o8b4Kb1NZI+Gd3hTrYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/mg9K5cN4pBfdnWv5z9B+TOTomGNksd
	Sca+Wn5Ti9mo/1cVR2H3XfKzkqw4nVCwMTaHyWtRNvGhrFKopcMJdphVp8uRt6g2
	+RWAZV+fusXTEYhm0KzKcysbxuLYM0YPEvOOSgbq8qk/redClIMMIvmPd+yddhKq
	lp5NhD51P0Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCF955153B;
	Thu, 31 Mar 2016 12:59:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E411551537;
	Thu, 31 Mar 2016 12:59:18 -0400 (EDT)
In-Reply-To: <1459383457-6848-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Mar 2016 17:17:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8838C12-F761-11E5-A19A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290419>

Stefan Beller <sbeller@google.com> writes:

> As submodules have working directory and their git directory far apart
> relative_path(gitdir, work_dir) will not produce a relative path when
> git_dir is absolute. When the gitdir is absolute, we need to convert
> the workdir to an absolute path as well to compute the relative path.
>
> (e.g. gitdir=/home/user/project/.git/modules/submodule,
> workdir=submodule/, relative_dir doesn't take the current working directory
> into account, so there is no way for it to know that the correct answer
> is indeed "../.git/modules/submodule", if the workdir was given as
> /home/user/project/submodule, the answer is obvious.)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 7 +++++++
>  t/t7400-submodule-basic.sh  | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 914e561..0b0fad3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -159,6 +159,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	FILE *submodule_dot_git;
>  	char *sm_gitdir, *cwd, *p;
>  	struct strbuf rel_path = STRBUF_INIT;
> +	struct strbuf abs_path = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	struct option module_clone_options[] = {
> @@ -219,7 +220,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	if (!submodule_dot_git)
>  		die_errno(_("cannot open file '%s'"), sb.buf);
>  
> +	strbuf_addf(&abs_path, "%s/%s",
> +		    get_git_work_tree(),
> +		    path);

The "path" is assumed to be _always_ relative to work tree?

I am wondering if it would be prudent to have an assert for that
before doing this, just like I suggested assert(path) for [2/4]
earlier [*1*].

On the other hand, if we allow path to be absolute, this would need
to become something like:

	if (is_absolute_path(path))
        	strbuf_addstr(&abs_path, path);
	else
        	strbuf_addf(&abs_path, "%s/%s", get_git_work_tree(), path);

>  	fprintf(submodule_dot_git, "gitdir: %s\n",
> +		is_absolute_path(sm_gitdir) ?
> +		relative_path(sm_gitdir, abs_path.buf, &rel_path) :
>  		relative_path(sm_gitdir, path, &rel_path));

It seems that the abs_path computation is not needed at all if
sm_gitdir is relative to begin with.  I wonder if the code gets
easier to read and can avoid unnecessary strbuf manipulation
if this entire hunk is structured more like so:

	if (is_absolute_path(sm_gitdir)) {
		...
	} else {
        	...
	}
	fprintf(submodule_dot_git, "gitdir: %s\n",
        	relative_path(sm_gitdir, base_path, &rel_path));

>  	if (fclose(submodule_dot_git))
>  		die(_("could not close file %s"), sb.buf);

[Footnote]

*1* BTW, I tightened the assert for 2/4 to "assert(path && *path)"
to match the assumption in its log message, i.e. "The calling shell
code makes sure that path is non-NULL and non empty".
