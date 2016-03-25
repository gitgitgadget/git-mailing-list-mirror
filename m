From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/5] submodule: prepare recursive path from non root directory
Date: Fri, 25 Mar 2016 12:21:00 -0700
Message-ID: <xmqqk2kq2wkj.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajXIF-0001Av-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 20:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbcCYTVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 15:21:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753420AbcCYTVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 15:21:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E1174F453;
	Fri, 25 Mar 2016 15:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PRqsve7jyjQknqaL3bo3Di/hENo=; b=Cb9Hi7
	yfipVZvMUmL7hHlzftC/T+aIrxP5Qc1L6khrGH+ADFDhtBox7X7Kdg/tVV0QQwm/
	0AYD+ncVpFJl+NmV+lUQCm2aKykhEWlePyr8k00Kh8EJ8ev2iQ23zWglY7TLTdH9
	lbGqAXcVcnqzQ0ZxYM0y/Yyh1pr5adHMeSYSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRsJihUUV4LusI/ynUe1MiyU7gX1165M
	mEP0iH3wCuus0TpPFsK5USaZF88887RtwVyrmTC4Kdzrl8wGO8p1ISHlDFPV2fef
	b3CVD643n1+ggiviAYq73UDODWvBJcmH7ChWHgQU/fcJruW2p/Mchf81/EBMRof/
	0H3AyGnnCN8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EFBD4F452;
	Fri, 25 Mar 2016 15:21:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6EE004F44D;
	Fri, 25 Mar 2016 15:21:02 -0400 (EDT)
In-Reply-To: <1458931156-29125-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 25 Mar 2016 11:39:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6878C6A-F2BE-11E5-AEFF-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289947>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..d83608c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -825,8 +825,9 @@ Maybe you want to use 'update --init'?")"
>  		if test -n "$recursive"
>  		then
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"

Don't you need to protect yourself from IFS chars in $prefix and
$sm_path here (the other invocation of relative_path in this patch
does not have this issue, I would think).

As I think about it more, I am more inclined to say "-C $prefix" is
going in a wrong direction, so justifying this change solely on that
move is somewhat sad.

 - Making things relative should not hurt.

 - Clearing wt_prefix feels like the right thing, because we are
   moving to the root of the working tree of a different repository
   and wt_prefix that tells us where the user originally was in the
   superproject is not useful in the context of the submodule, which
   after all is a separate project.  The user however cannot refer
   to things on the filesystem (including use of pathspecs), as they
   are taken relative to the root level of each submodule by
   clearing wt_prefix, though.  i.e.

       $ git submodule $cmd --read-from-this-file=../m/file

   that is started from t/ subdirectory of the superproject that
   recurses into the submodule at m/ (sitting next to t/) should be
   able to read from "file" sitting at the root level of the working
   tree of submodule m/ by stripping ../m/ (and relative-path should
   be able to help with that), but that may become impossible
   because the fact that the user named ../m/file relative to t/
   subdirectory is lost by clearing wt_prefix that used to hold t/
   here.

is the closest justification I can come to, which is weak ("should
not hurt" does not justify, and "users cannot ever do this without
undoing this change" does not, either).

I think the worst part of this change is that the log message does
not make it clear why it is OK not to clear wt_prefix and not to use
relative_path if you use --prefix, while the "-C $prefix" approach
has problems without these changes.  Without that explanation, these
symptoms, i.e. the fact that you need the changes in this patch,
only smells like an indication that "-C $prefix" approach is somehow
flawed.  I cannot quite pinpoint what that "somehow" is, though.

>  				clear_local_git_env
> +				wt_prefix=
>  				cd "$sm_path" &&
>  				eval cmd_update
>  			)
> @@ -1159,6 +1160,7 @@ cmd_status()
>  			(
>  				prefix="$displaypath/"
>  				clear_local_git_env
> +				wt_prefix=
>  				cd "$sm_path" &&
>  				eval cmd_status
>  			) ||
> @@ -1239,7 +1241,8 @@ cmd_sync()
>  
>  				if test -n "$recursive"
>  				then
> -					prefix="$prefix$sm_path/"
> +					prefix=$(relative_path "$prefix$sm_path/")
> +					wt_prefix=
>  					eval cmd_sync
>  				fi
>  			)
