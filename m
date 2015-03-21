From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/15] commit.c: fix a memory leak
Date: Fri, 20 Mar 2015 20:59:18 -0700
Message-ID: <xmqqk2ybatm1.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 05:02:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZAc3-00027m-CA
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 05:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbCUD7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:59:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751571AbbCUD7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2388F42E15;
	Fri, 20 Mar 2015 23:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=geWTzF/shq3BCYk8jssojctnp7g=; b=pioy9m
	Lqqn4zT03la8bCz2HdnLJQU2kXtJyNTgkF51WCoFD+zGR6br33h0/vwS4bZyQajX
	D/zLYlUKWOwUsAfE/PXubDrHOD/i5/9qxQlpLkW03PY4lx/5nBr+jykRpwHNdcMD
	NJTjHyfdlZLvrMmaD6V3CHXTaU3D1kEqzPM6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olPVHi8FsvZS19QUJPbwi4DnG3wrId0U
	TKl9lpPtwLPmbooknRwHCU0/tb684u4TstFywwvlHUVUYTmpoIKJ+Y+yiuLfVgpe
	4q710Cm7oupxNNNV9NkehX4u7d1ftaxWURjGwRX8enTvG63ncYmPTkrACAGRm+KC
	E4v7/BjSOCI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BD3342E14;
	Fri, 20 Mar 2015 23:59:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61F6D42E13;
	Fri, 20 Mar 2015 23:59:19 -0400 (EDT)
In-Reply-To: <1426897692-18322-11-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6804CF8-CF7E-11E4-8A39-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266005>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/commit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 961e467..da79ac4 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -229,7 +229,7 @@ static int commit_index_files(void)
>  static int list_paths(struct string_list *list, const char *with_tree,
>  		      const char *prefix, const struct pathspec *pattern)
>  {
> -	int i;
> +	int i, ret;
>  	char *m;
>  
>  	if (!pattern->nr)
> @@ -256,7 +256,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
>  			item->util = item; /* better a valid pointer than a fake one */
>  	}
>  
> -	return report_path_error(m, pattern, prefix);
> +	ret = report_path_error(m, pattern, prefix);
> +	free(m);
> +	return ret;
>  }

Looks correct.

A tangent.  We may want to move report_path_error() to somewhere
more "common"-ish, like dir.c which is where we have bulk of
pathspec matching infrastructure.  Seeing the function used from
builtin/ls-files.c makes me feel dirty.

A further tangent (Duy Cc'ed for this point).  We might want to
rethink the interface to ce_path_match() and report_path_error()
so that we do not have to do a separate allocation of "has this
pathspec been used?" array.  This was a remnant from the olden days
back when pathspec were mere "const char **" where we did not have
any room to add per-item bit---these days pathspec is repreasented
as an array of "struct pathspec" and we can afford to add a bit
to the structure---which will make this kind of leak much less
likely to happen.
