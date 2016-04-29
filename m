From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/15] submodule init: redirect stdout to stderr
Date: Fri, 29 Apr 2016 11:27:00 -0700
Message-ID: <xmqqy47wxocr.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:27:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awD8A-0002Wy-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcD2S1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:27:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbcD2S1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:27:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE28015E40;
	Fri, 29 Apr 2016 14:27:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DbxSDTRlEUr/QLQXViz0uqMiQEE=; b=VTOHvx
	HJa4/YYg3rEnEWKV9zx+49g5FA868tUVtCxTe/jCK5GGZr6aDtO7Yg+jfugs0zuK
	7X6LsOVnoIxs5mSqq3JMgTbcKDlyX1vyTe1d76nML/tCNi7FzqzOgchtYZo8tJwR
	uyZyqzwuozdWXoSIk7aFcUI56lPBQB4eheKqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d84jclUj7s8cTkUYBSg45BmvK8OmqkK4
	vLAko1mwK8vLXWvoAydHU0yxkiC0vXZmjz+jZpMXxUkKWi1FuFLo1FWXdvVXYe9Y
	HZQhFmmDFcXKTFdCkT/ihKvFJc/R6uSv37UoiHbAE/UCewF6bVv5lYdnpTa8exjt
	ZWDYfxEy21U=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D56FF15E3F;
	Fri, 29 Apr 2016 14:27:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A59F15E37;
	Fri, 29 Apr 2016 14:27:02 -0400 (EDT)
In-Reply-To: <1461703833-10350-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7AAB9D0-0E37-11E6-B99D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293040>

Stefan Beller <sbeller@google.com> writes:

> Reroute the output of stdout to stderr as it is just informative
> messages, not to be consumed by machines.
>
> We want to init submodules from the helper for `submodule update`
> in a later patch and the stdout output of said helper is consumed
> by the parts of `submodule update` which are still written in shell.
> So we have to be careful which messages are on stdout.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I do not mind if this step is split out and queued as a separate
follow-up to sb/submodule-init.  The grouping and labelling is a
bigger and more important change that deserves attention without
distraction than this single step, and making as many such things
graduate and allowing us to forget about them is better ;-)

>  builtin/submodule--helper.c |  3 ++-
>  t/t7406-submodule-update.sh | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 23d7224..7b9a4d7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -362,7 +362,8 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  			die(_("Failed to register url for submodule path '%s'"),
>  			    displaypath);
>  		if (!quiet)
> -			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
> +			fprintf(stderr,
> +				_("Submodule '%s' (%s) registered for path '%s'\n"),
>  				sub->name, url, displaypath);
>  	}
>  
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index fd741f5..5f27879 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -108,24 +108,36 @@ pwd=$(pwd)
>  
>  cat <<EOF >expect
>  Submodule path '../super': checked out '$supersha1'
> -Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
> -Submodule 'none' ($pwd/none) registered for path '../super/none'
> -Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
> -Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
>  Submodule path '../super/merging': checked out '$mergingsha1'
>  Submodule path '../super/none': checked out '$nonesha1'
>  Submodule path '../super/rebasing': checked out '$rebasingsha1'
>  Submodule path '../super/submodule': checked out '$submodulesha1'
>  EOF
>  
> +cat <<EOF >expect2
> +Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
> +Submodule 'none' ($pwd/none) registered for path '../super/none'
> +Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
> +Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
> +Cloning into '$pwd/recursivesuper/super/merging'...
> +done.
> +Cloning into '$pwd/recursivesuper/super/none'...
> +done.
> +Cloning into '$pwd/recursivesuper/super/rebasing'...
> +done.
> +Cloning into '$pwd/recursivesuper/super/submodule'...
> +done.
> +EOF
> +
>  test_expect_success 'submodule update --init --recursive from subdirectory' '
>  	git -C recursivesuper/super reset --hard HEAD^ &&
>  	(cd recursivesuper &&
>  	 mkdir tmp &&
>  	 cd tmp &&
> -	 git submodule update --init --recursive ../super >../../actual
> +	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
>  	) &&
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	test_cmp expect2 actual2
>  '
>  
>  apos="'";
