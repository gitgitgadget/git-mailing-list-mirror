From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: set temp variables using 'env' in test function instead of subshell
Date: Mon, 17 Mar 2014 13:57:54 -0700
Message-ID: <xmqqeh20czl9.fsf@gitster.dls.corp.google.com>
References: <1395046593-4057-1-git-send-email-unsignedzero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:58:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPebi-0001sp-RC
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbaCQU55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:57:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbaCQU55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:57:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F597677B;
	Mon, 17 Mar 2014 16:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YklEJZ11HFyu95TZx8DkzVFsBeM=; b=yS3z9h
	BjbeighiTdzkGLIV7amsqKyxVCIvvOFRlVqEWlYTRHJGBtHnk+Q+EdgFMN4wgfyO
	yRx1wXr3PYSzzW+r1deZP4Z7wJYZbZsDISx9Wy7YKojW4gnCnvawKZgF7yJDDZ67
	+NlKsTwDHZCT+k0y6AjchPEgcoz5ZbWj5IT2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpoDTFP4mxaJjsoD31bgV+RfbV9R4RI/
	bl1VGB08iE93o2/W3VeRGch+tmNg4vLIh+3TKXvN/vWlyRB8MLV7VQ8gcu98XX5X
	grlhodLUAQyTeU3oYwLB3EzoBuDyxRn0/wzLhIci0IB7mOV0Hz3lrX9wcIClja6X
	S0b4IuVxVI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA4E7677A;
	Mon, 17 Mar 2014 16:57:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD12D76776;
	Mon, 17 Mar 2014 16:57:55 -0400 (EDT)
In-Reply-To: <1395046593-4057-1-git-send-email-unsignedzero@gmail.com> (David
	Tran's message of "Mon, 17 Mar 2014 08:56:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D04D0EA2-AE16-11E3-928F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244284>

David Tran <unsignedzero@gmail.com> writes:

> Fixed the broken &&-chain and the tests run correctly. The double env is
> fixed to be a single env. The useless subshells are removed.
> ...

Hmph.

>  test_expect_success 'need valid notes ref' '
> -	(MSG=1 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
> -	 test_must_fail git notes add) &&
> -	(MSG=2 GIT_NOTES_REF=/ && export MSG GIT_NOTES_REF &&
> -	 test_must_fail git notes show)
> +	test_must_fail env MSG=1 env GIT_NOTES_REF=/ git notes show &&
> +	test_must_fail env MSG=2 env GIT_NOTES_REF=/ git notes show
>  '

Oh, really ;-)?

>  test_expect_success 'refusing to add notes in refs/heads/' '
> -	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
> -	 export MSG GIT_NOTES_REF &&
> -	 test_must_fail git notes add)
> +	test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes add
>  '

This one is good.

> @@ -529,9 +510,7 @@ test_expect_success 'aborted --continue does not squash commits after "edit"' '
>  	echo "edited again" > file7 &&
>  	git add file7 &&
>  	(
> -		FAKE_COMMIT_MESSAGE=" " &&
> -		export FAKE_COMMIT_MESSAGE &&
> -		test_must_fail git rebase --continue
> +		test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue
>  	) &&

Do we do anything to cause us misbehave if the above is done outside
the subshell?

Thanks.  Getting closer, I think.
