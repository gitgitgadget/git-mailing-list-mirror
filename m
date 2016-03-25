From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] submodule: fix recursive execution from non root directory
Date: Fri, 25 Mar 2016 09:46:28 -0700
Message-ID: <xmqqtwju4iaj.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:46:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUse-00041z-BV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbcCYQqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:46:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753501AbcCYQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:46:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB67D4DAAB;
	Fri, 25 Mar 2016 12:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bjXi8mlneQyAudTcLnobNmJldKI=; b=aoZhmi
	LAIQ1crnx5P4iWU2HO1II2wD2PZIhJncRKKft6PwlI3aOpP1mBrCU4STRzBtidTO
	El3RCpLrN7erD+txpooWBlD4+o9x6ClS2NEfcV4uLasyQqMbIBVChjqJq2Yk6xyL
	GAWKdvHXs6aU8PRUi/bbec3k99P9uluS5jdss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8lEoCurlv2OFxEnvoJ00Mhr+ljPMEqx
	bfty+CQKm1ROv2ikc3xpiPL9372/dQhSZxe+2Ub/sYDwzUGPmwtkwaseadmpgWe/
	Coav3p0uDKkrpy63omqBPnpIEdG9LwO9JeqVA9H/VLZSQglLhsEDnMHlTbv1dlq8
	Sx/oO4tsYPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D27B84DAAA;
	Fri, 25 Mar 2016 12:46:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3532B4DAA7;
	Fri, 25 Mar 2016 12:46:30 -0400 (EDT)
In-Reply-To: <1458862468-12460-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 24 Mar 2016 16:34:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FD80D54-F2A9-11E5-896A-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289902>

Stefan Beller <sbeller@google.com> writes:

> Most times that directory doesn't exist and we error out. Fix this bug
> by clearing wt_prefix, such that any recursive instances of will assume
> to operate from the respective root of the respective submodule.

As long as the recursive instances do not take any filenames and
pathspecs that needs adjustment with respect to the prefix, this
would be an OK change; I am not sure if that precondition holds,
though.

Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 536ba68..6b18a03 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -827,6 +827,7 @@ Maybe you want to use 'update --init'?")"
>  			(
>  				prefix="$(relative_path $prefix$sm_path)/"
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
> @@ -1240,6 +1242,7 @@ cmd_sync()
>  
>  				if test -n "$recursive"
>  				then
> +					wt_prefix=
>  					eval cmd_sync
>  				fi
>  			)
