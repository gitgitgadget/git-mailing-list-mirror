From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] am --abort: keep unrelated commits on unborn branch
Date: Mon, 08 Jun 2015 13:13:40 -0700
Message-ID: <xmqq4mmi9cwb.fsf@gitster.dls.corp.google.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
	<1433591172-27077-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:13:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23QZ-0007yi-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbbFHUNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:13:43 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35950 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbbFHUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:13:42 -0400
Received: by ieclw1 with SMTP id lw1so910081iec.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GhFvLVLH/LvGu0WObB6++fOntArGafHh9Z7yGIWk9ww=;
        b=0jIml+DlcCBnIOnHwDLvX9wTbap+wxVp2PqWEfBW6eoMJIp+9uHy4jt3HkSq6h7S89
         g2f/jSeZE7O3A1rGRLm5avP7HMhGGyrr+rk20eBmVtCiC7/C53MZEWoNEd9PQHQA8Wvx
         0y0GgHhxJqEtjbo7dZHL3VgTj200/r9siRarxMkpKOuWQRkubniO/3EiyWl3i4wCUyu3
         /gS2SKchUYMh6WtLn4GDXs8WRgqX6/q5f06Qh8g1Q6Yn/1uxyQMKuUk1cMd9Tmw1Iwz5
         IDLhce1QhbLq2PlfApoO5GyPF82EUhN0I7ip4r7klqThDeBjeLRoM/51ejpNwKjo88Qk
         meAA==
X-Received: by 10.42.142.66 with SMTP id r2mr12990417icu.87.1433794421679;
        Mon, 08 Jun 2015 13:13:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id j20sm1055880igt.16.2015.06.08.13.13.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 13:13:41 -0700 (PDT)
In-Reply-To: <1433591172-27077-7-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Sat, 6 Jun 2015 19:46:12 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271122>

Paul Tan <pyokagan@gmail.com> writes:

> Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
> and warn, 2010-12-21), git-am would refuse to rewind HEAD if commits
> were made since the last git-am failure. This check was implemented in
> safe_to_abort(), which checked to see if HEAD's hash matched the
> abort-safety file.
>
> However, this check was skipped if the abort-safety file was empty,
> which can happen if git-am failed while on an unborn branch.

Shouldn't we then be checking that the HEAD is still unborn if this
file is found and says that there was no history in the beginning,
in order to give the "am on top of unborn" workflow the same degree
of safety?  Or is the fact that the file is empty sufficient not to
match any valid commit name that is 40-hex?

> As such, if
> any commits were made since then, they would be discarded. Fix this by
> carrying on the abort safety check even if the abort-safety file is
> empty.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-am.sh           |  2 +-
>  t/t4151-am-abort.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 95f90a0..4324bb1 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -87,7 +87,7 @@ safe_to_abort () {
>  		return 1
>  	fi
>  
> -	if ! test -s "$dotest/abort-safety"
> +	if ! test -f "$dotest/abort-safety"
>  	then
>  		return 0
>  	fi
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index b2a7fc5..833e7b2 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -142,4 +142,15 @@ test_expect_success 'am -3 --abort on unborn branch removes applied commits' '
>  	test refs/heads/orphan = "$(git symbolic-ref HEAD)"
>  '
>  
> +test_expect_success 'am --abort on unborn branch will keep local commits intact' '
> +	git checkout -f --orphan orphan &&
> +	git reset &&
> +	test_must_fail git am 0004-*.patch &&
> +	test_commit unrelated2 &&
> +	git rev-parse HEAD >expect &&
> +	git am --abort &&
> +	git rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
