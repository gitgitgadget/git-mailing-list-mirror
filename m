From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 4/6] add tests of commit --fixup
Date: Wed, 27 Oct 2010 15:35:54 -0700
Message-ID: <7vk4l3b6wl.fsf@alter.siamese.dyndns.org>
References: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
 <1287689637-95301-5-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:36:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEbO-0005Ub-EM
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406Ab0J0WgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:36:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0J0WgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:36:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44B9F1144;
	Wed, 27 Oct 2010 18:36:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JTeS6NeSaJXfkG3Q56mmFzlfOI0=; b=c0q7p2PJ3IvIPt816dxxN9a
	cJ9SY9F+glq6zCrr48oSopNZZobZ/kQDADtJdoG7PN3pePvNqDBwxYwm0QG/4EAt
	VCSEWh7dvP5jWKJUW7MEKWO8Ny1804LpgpeZGL49d8CNAFIWhjnDAy9MjmEFMcjE
	X3UReijywsQlzghpXj8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sdSyJ9B0tzwrJd5FRzi9YsDXrydPuXK5mdVHJTG1GuHN2Ru0N
	++J/aKiDiS7oq08SGoBSTNL5R7X/DXKwRCuWCkMCnG0VewA9vW3Ue3YOL5nPd6w8
	e/qhdiyQNONYS4GZU4rXv5QMjlhrg9VRf2oUZL+Y4l6cAfKXSNWF5b/w88=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 202B61140;
	Wed, 27 Oct 2010 18:35:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61F3D113C; Wed, 27 Oct
 2010 18:35:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 920219A6-E21A-11DF-853A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160132>

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 256c4c9..f9a26c8 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -133,4 +133,31 @@ do
>  	'
>  done
>  
> +test_commit_autosquash_flags () {
> +	H=$1
> +	flag=$2
> +	test_expect_success "commit --$flag with $H encoding" '
> +		git config i18n.commitencoding $H &&
> +		git checkout -b $H-$flag C0 &&
> +		echo $H >>F &&
> +		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
> +		test_tick &&
> +		echo intermediate stuff >>G &&
> +		git add G &&
> +		git commit -a -m "intermediate commit" &&
> +		test_tick &&
> +		echo $H $flag >>F &&
> +		git commit -a --$flag HEAD~1 $3 &&
> +		E=$(git cat-file commit '$H-$flag' | \
> +			sed -ne "s/^encoding //p") &&
> +		test "z$E" = "z'$H'" &&

A few nits.

 - You don't need that backslash after the pipe (with the vertical bar at
   the end of line the shell knows you haven't finished your statement).

 - I am not sure what the single-quote around only the last two occurrence
   of $H are about.  H and flag are used as part of branch name, so I
   suspect you do not need any quoting around them, no?
