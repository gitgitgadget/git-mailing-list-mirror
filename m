From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: Include check for objects when fetching
Date: Mon, 22 Feb 2016 14:54:53 -0800
Message-ID: <xmqqoab84apu.fsf@gitster.mtv.corp.google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
	<1456180548-20996-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:55:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzNd-00054d-RR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbcBVWy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:54:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756476AbcBVWy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:54:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F9D947289;
	Mon, 22 Feb 2016 17:54:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PivFRReKJ2hTTaSQsnAUTwIAnV0=; b=lD8ZJz
	EtFxdoCElTdCtHiH4bf9Y4DgY84PKNL2Xjrpsk45tMgSQZ+5u87nxRHIOCRKiHSU
	4BdKL8TrStuInR7BCPQoluEMZa46cppENhtv98MMlGDqDpnrfuIdAcbGsn3v/sSs
	fnFVyOZR2BIf8bTX6PBBhHAhn2iIIQwxgn3Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnsbkjIrxF6Eqd8F8lnjhLcDZuV97gwp
	Cz9PLeqjHhK7G10c9Q1i3qR2HpAtOL3In3gflhfK5+y5egtZECrosgeoQlTAn4O3
	Ob7O6ZuFAfqCaywckqFl0lWQ8cqkAW2W/nfHMHu/kV+eTkLM/BwX6Sm40VYjfWsY
	YGpCOG2Bkeo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4549447288;
	Mon, 22 Feb 2016 17:54:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95A1A47286;
	Mon, 22 Feb 2016 17:54:54 -0500 (EST)
In-Reply-To: <1456180548-20996-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 22 Feb 2016 14:35:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49ED3520-D9B7-11E5-B3BB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286994>

Stefan Beller <sbeller@google.com> writes:

> Junio wrote:
>> To be complete, the rev-list command line should also run with
>> "--objects"; after all, a commit walker fetch may have downloaded
>> commit chain completely but haven't fetched necessary trees and
>> blobs when it was killed, and "rev-list $sha1 --not --all" would not
>> catch such a breakage without "--objects".
>
> By adding the --objects switch to rev-list we make sure to do a complete
> check.

You also need to drop "-n1" for the command to be equivalent to
quickfetch, I think.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f..f5d6675 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -746,7 +746,7 @@ Maybe you want to use 'update --init'?")"
>  				# Run fetch only if $sha1 isn't present or it
>  				# is not reachable from a ref.
>  				(clear_local_git_env; cd "$sm_path" &&
> -					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> +					( (rev=$(git rev-list --objects -n 1 $sha1 --not --all 2>/dev/null) &&
>  					 test -z "$rev") || git-fetch)) ||
>  				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>  			fi
