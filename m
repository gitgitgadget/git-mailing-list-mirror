From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Fri, 14 Nov 2014 13:51:39 -0800
Message-ID: <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpOmb-0007TS-FH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161861AbaKNVvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:51:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161484AbaKNVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:51:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97DDC1E592;
	Fri, 14 Nov 2014 16:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=stZyBdXGxtJ50Z7blX3UadRQzds=; b=Z8GwVC
	m6lX1eWAhN8rwLOcSBY4y7NVCacLsAd9xu5qPl2GrXqMjzkgSM/Vb3LzwMnKKDkx
	HUtTqtOzsikxv2Uo+hX/cNepUMMdiNxr/IlOwKdXhERXcophFgTcScXCG3gcqwRF
	1we+wQAGdOoTRXStD10Fedf/ICi7ZdCHFaIe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wPqoEEjiW7IznVhwA8cOGSc8xTe5F9lH
	utx1o3yYkyxJ4g/Qyhva2C3gtJhonkb79vGI3ZchCDwTWF+Fc+SArSvacKLwpZIr
	0Be3cU68tt4XjscTN7sdObXSXMtuaB5iIz8PmxwGRhreRdV6NNaCuHTw1PRfdhOq
	lMPsMR6sL/M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD6D1E590;
	Fri, 14 Nov 2014 16:51:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 135951E58F;
	Fri, 14 Nov 2014 16:51:41 -0500 (EST)
In-Reply-To: <1416000835-79274-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 14 Nov 2014 13:33:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AA99D36-6C48-11E4-AFC4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> run_merge_tool() was not setting $status, which prevented the
> exit code for builtin tools from being forwarded to the caller.
>
> Capture the exit status and add a test to guarantee the behavior.
>
> Reported-by: Adria Farres <14farresa@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 1 +
>  t/t7800-difftool.sh   | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index a40d3df..2b66351 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -221,6 +221,7 @@ run_merge_tool () {
>  	else
>  		run_diff_cmd "$1"
>  	fi
> +	status=$?
>  	return $status
>  }

Thanks for a quick turn-around.  As a hot-fix for what is already in
-rc I am fine with this fix but the patch makes me wonder if $status
as a global shell variable has any significance.

I see that this shell function in its early part does this:

	status=0
        setup_tool "$1" || return 1

which means that the caller of this function, instead of checking
what is returned as the return value of the function like:

	if run_merge_tool ...
        then
		...

relies on the value of $status in its later part of the code like:

	run_merge_tool ...
	...
	if test "$status" = 0
	then
		...

then we are already in trouble.  And the latter form, if we had such
a flow in the code, is simply a bad taste.

A cleaner fix might be to get rid of the extra $status variable from
this function and let the function return the result of its last
command, either run_merge_cmd or run_diff_cmd, by either explicitly
having "return $?" at the end, or not having that "return $status"
line.  But that relies on us not having any caller that relies on
the $status carried as a global variable around, so it will be more
work to convince ourselves that such a fix is correctly done.  From
my cursory look, what I suggested above should be safe and correct,
but I do not want to risk an unnecessary and silly breakage this
late in the cycle.

So I'll queue this patch as-is for upcoming 2.2, but I think we
would want to revisit this issue after the release is done.
