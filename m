From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] merge hook tests: use 'test_must_fail' instead of '!'
Date: Thu, 06 Mar 2014 13:29:54 -0800
Message-ID: <xmqqiorrvwvh.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-7-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfrg-0003Ca-1d
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaCFV37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:29:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094AbaCFV36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:29:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38CB70DB2;
	Thu,  6 Mar 2014 16:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R8x4sU3Hcmypc0ihvy0a3c/nZ+g=; b=JIou1n
	iA1Wdm1YFbz5DYOnMCgca4pXYEygWOBSnJsjBTHykdXo1LDLEBdQx7aWJVYraTeC
	C3g4L9lrqPMyFgm9NTSgNQqVvir2YfX338n5Zs1n6eeEA8ue06wSQwL+vSFPL1kh
	Ahhe881OhQrvvEwF1Slf68ltTXVXOgzyu2fmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LW6EEp6NsCQZmVVzTeM791YIC6HpEh5X
	mqj09qwzTnKQLs0oFNsrPIdUhjewlyZqaW7TS5PKiPvsbdZ+qD+LkuZ5CQAdhzYW
	yM2euW2ZuLuil2q5xTPd2q3Ye5+Lfcj9Jz5btNCxK304mKMWP/ZeT1eU+gbnEgt2
	GyLezPOArBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF13870DB1;
	Thu,  6 Mar 2014 16:29:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0153C70DAE;
	Thu,  6 Mar 2014 16:29:56 -0500 (EST)
In-Reply-To: <1394117424-29780-7-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Thu, 6 Mar 2014 15:50:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76DC7F86-A576-11E3-BFD2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243558>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7505-prepare-commit-msg-hook.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index 604c06e..1be6cec 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -167,7 +167,7 @@ test_expect_success 'with failing hook' '
>  	head=`git rev-parse HEAD` &&
>  	echo "more" >> file &&
>  	git add file &&
> -	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
> +	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head

Thanks. It is good that you avoided the common pitfall of attempting

	GIT_EDITOR=... test_must_fail git commit -c $head    ;# WRONG

but do we assume everybody has "env"?

To be portable, we can do this instead.

	(
		GIT_EDITOR=... &&
        	export GIT_EDITOR &&
                test_must_fail git commit -c $head
	)
