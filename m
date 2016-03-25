From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] submodule: fix recursive path printing from non root directory
Date: Fri, 25 Mar 2016 09:43:40 -0700
Message-ID: <xmqqy4964if7.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:43:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUpx-0002Y2-0s
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcCYQno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:43:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321AbcCYQnn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:43:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58C964D9C0;
	Fri, 25 Mar 2016 12:43:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NqDCrKxVvF3pkYphzdAuk1IGhhg=; b=GW/AUp
	oNt77HEJBZcJ1zkM7RcR/q4Zo0vuDG4vt877Fve9sUrqGAw/tGHjSml+twZygxcJ
	y8K5ecrrlKaeuVsKoywxEosUKIJ+zU3Yd+2mbI7gZLqk5wzkdLknsWqd/XlVi2p8
	1mwhRPoEM/8FpdsBjkhAVWDNOsxZQToe7BciI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OMyyIGRTURm5xBFAxL+eprnJJUG89g1r
	8Iic+wXRiZkaj7w6fxBFnW6W1YPAVoS6wXVDrtXPL5W8QTZMzrY0Mec4GL87GKbe
	Uqg98ysGjLhHv7m6e713OUPprykrEwaBpUJ0/GShjLC1fONVJ0neo87HF/K6pgNa
	IGVACkUiYtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 507BD4D9BF;
	Fri, 25 Mar 2016 12:43:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BBE1A4D9BA;
	Fri, 25 Mar 2016 12:43:41 -0400 (EDT)
In-Reply-To: <1458862468-12460-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 24 Mar 2016 16:34:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB70E3B8-F2A8-11E5-8495-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289901>

Stefan Beller <sbeller@google.com> writes:

> Recursing into submodules currently works by just calling
> (cd $submodule && eval <command>) for update, sync and status
> command.
>
> Say you have the following setup
>
> repo/ # a superproject repository
> repo/untracked/ # an untracked dir in repo/
> repo/sub/ # a submodule
> repo/sub/subsub # a submodule of a submodule
>
> When being in repo/untracked/ and invoking "git submodule status"
> you would expect output like:
>
>     repo/untracked/$ git submodule status --recursive
>      <sha1> ../sub (version)
>      <sha1> ../sub/subsub (<version>)
>
> We need to take into account that we are in the untracked/ dir,
> so we need to prepend ../ to the paths. By using relative_path
> to compute the prefix, we'll have that output.

tests to demonstrate existing breakage and protect the fix from
future breakages would be needed, no?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..536ba68 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -825,7 +825,7 @@ Maybe you want to use 'update --init'?")"
>  		if test -n "$recursive"
>  		then
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"
>  				clear_local_git_env
>  				cd "$sm_path" &&
>  				eval cmd_update
> @@ -1233,13 +1233,13 @@ cmd_sync()
>  			then
>  			(
>  				clear_local_git_env
> +				prefix=$(relative_path "$prefix$sm_path/")
>  				cd "$sm_path"
>  				remote=$(get_default_remote)
>  				git config remote."$remote".url "$sub_origin_url"
>  
>  				if test -n "$recursive"
>  				then
> -					prefix="$prefix$sm_path/"
>  					eval cmd_sync
>  				fi
>  			)
