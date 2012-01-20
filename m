From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:00:33 -0800
Message-ID: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr5mUiJkNk-urNn5fP5x+gkzaTfx2y=K1S0AJZCy7Muwdg@mail.gmail.com>
 <1327042010-79552-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8Sn-0000Yo-T9
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab2ATHAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:00:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab2ATHAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:00:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4690C25A2;
	Fri, 20 Jan 2012 02:00:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=leqn6qxeaqcoaWBb0wuiqf4k7K0=; b=LlgxOr
	QPC6Zn0q7OW46aYYaDI+ABpH7DbnjicjFmnjWwZSMhcYvwHPgMZA4cvmaI8Ww/EI
	In0xCdHbkHWXLjbvlPb/Tk+EqntE9hNGSQNiJ8+shPhqP8APd36rVqIEbLozWJFF
	MJo40mfOi0jZ0OfC3AnU96X+M6R85gSn79+fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPTlVLg8bQqPQfOqmSKXSFF5+IsJR4Vc
	9dErCZDyznbG1jv1ySvF4SGDZdYDvzm4oKHxSSR1o+PHfWz0NyTJ64mfcTRubNK+
	VPGc3fSKninNeSkqa8KpHtjJggG2Rr65Es0crIONhzp9DtJTwn1VEV88gTc9Fqap
	Mt1yhTUiqNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D29825A1;
	Fri, 20 Jan 2012 02:00:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BB2325A0; Fri, 20 Jan 2012
 02:00:35 -0500 (EST)
In-Reply-To: <1327042010-79552-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 19 Jan 2012 22:46:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7397CBB0-4334-11E1-9C48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188855>

David Aguilar <davvid@gmail.com> writes:

> Some mergetools cannot cope when $BASE is missing.
> This can happen when two branches add the same file.
> Provide an empty file to make these tools happy.
>
> Reported-by: Jason Wenger <jcwenger@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool.sh     |    6 +++++-
>  t/t7610-mergetool.sh |   27 ++++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 085e213..8521b81 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -224,7 +224,11 @@ merge_file () {
>      mv -- "$MERGED" "$BACKUP"
>      cp -- "$BACKUP" "$MERGED"
>  
> -    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
> +    if base_present; then
> +	checkout_staged_file 1 "$MERGED" "$BASE"
> +    else
> +	touch "$BASE"
> +    fi

Using "touch" for things like this is a disease.

You not just want to make sure it exists, but also you want to make sure
it is empty, so it would make your intention more explicit and clear if
you wrote this as

	>"$BASE"

instead.

I also wonder if it may help mergetools if we come up with a fake base
image using the common material between the two files, in a way similar to
how git-merge-one-file.sh does it (look for "Added $4 in both, but
differently"), but obviously it would belong to a separate patch.

Thanks.
