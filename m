From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Mon, 23 May 2016 12:16:43 -0700
Message-ID: <xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com, peff@peff.net
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 21:16:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vLP-0004zS-8I
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcEWTQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:16:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752864AbcEWTQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:16:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 745BC1D033;
	Mon, 23 May 2016 15:16:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VEQ/HX4ULM3P8mmskRcIb1WweB8=; b=KVkhwY
	tuICUIv9fysWi/IydvAo+xANkvsrDmex3d7v07MmiMoq91IuRESEVSA/s06P3rEh
	BxapuIEQFZ1pYfO7mzHBeX72CGbwUB7B+1JmHrMZ6pMtiM8ltMJJH8t39E3d086u
	y1fjkfisHq08BERlC50xrB+4ogvnLXZHUcfHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykPH2XqpqoMICSbFEErVsgHG22Q2e527
	iKCBF2VSoF1n5xnTQzCpe4xrdQGfwqPS5bCh4xuDMJAY/WVlW542N6eeOKlv8Z9p
	tqa7Qeugd2RzxQg5aD6HR3OY7uBO7pyUh0IV3TuZrZwy+pOfUXtYcCVEsGa+zFpg
	wxxYO5iXXDo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AF9B1D032;
	Mon, 23 May 2016 15:16:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA4941D031;
	Mon, 23 May 2016 15:16:44 -0400 (EDT)
In-Reply-To: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com> (Pranit
	Bauva's message of "Mon, 23 May 2016 23:46:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E36BC9F0-211A-11E6-88C8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295352>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> This is a follow up commit for f932729c (memoize common git-path
> "constant" files, 10-Aug-2015).
>
> It serves two purposes:
>   1. It reduces the number of calls to git_path() .
>
>   2. It serves the benefits of using GIT_PATH_FUNC as mentioned in the
>      commit message of f932729c.

All of that is a good idea, but I have huge doubts about its use.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 391126e..ffa242c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -92,8 +92,10 @@ N_("If you wish to skip this commit, use:\n"
>  "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
>  "the remaining commits.\n");
>  
> +static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
> +
>  static const char *use_message_buffer;
> -static const char commit_editmsg[] = "COMMIT_EDITMSG";
> +static const char commit_editmsg_path[] = git_path_commit_editmsg();

The function defined with the macro looks like

	const char *git_path_commit_editmsg(void)
        {
		static char *ret;
                if (!ret)
                	ret = git_pathdup("COMMIT_EDITMSG");
		return ret;
	}

so receiving its result to "const char v[]" looks somewhat
suspicious.

More importantly, when is this function evaluated and returned value
used to fill commit_editmsg_path[]?  In order for git_pathdup() to
produce a meaningful result, it needs to know where .git/ directory
is, which (roughly) means setup_git_dir() must have been called from
a callchain from main() somewhere already.

But I do not think the linker knows that fact.

> @@ -771,9 +773,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg2 = "";
>  	}
>  

Instead, what you could do is to call git_path_commit_editmsg() when
you refer to that global variable whose initialization is suspect.

> -	s->fp = fopen_for_writing(git_path(commit_editmsg));
> +	s->fp = fopen_for_writing(commit_editmsg_path);

i.e.

	s->fp = fopen_for_writing(git_path_commit_editmsg());

As you can see in its definition, when the original code used to
call git_path(), it is safe to call git_path_commit_editmsg(),
because for the original git_path() to be correct, the code should
already have established where $GIT_DIR is, so it is safe to call
git_pathdup(), too.  Also, as you can see in its definition, calling
the function many times would not cause git_path() called many
times.  The first invocation will keep its value that is constant
within the program that works with a constant $GIT_DIR.

And you do not free its return value.
