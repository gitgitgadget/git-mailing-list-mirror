From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t/t5528-push-default: generalize test_push_*
Date: Wed, 19 Jun 2013 14:56:34 -0700
Message-ID: <7vd2rhydbh.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 23:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQMr-00040y-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 23:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935015Ab3FSV4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 17:56:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934566Ab3FSV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 17:56:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 699D029E65;
	Wed, 19 Jun 2013 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rp3NnVhRF1tFFB8pShm5iTIqG8w=; b=RyQKC4
	YBfO/CcnUysQaCv+en4vg3zUQVJbTw6bzb77jI5ft70TbdGGppTZ7RuLlBAUiz2T
	vymtNxI/0E63hsJt0XhzDZBdl/UzEdcEsXQ+HaiRoStBcTlXgZoFFRvmOdgpV6Ea
	i3wUwv3aTkF///Ru1GW9MAShSLua8BzyvCbIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwYvX/iDWdkE43W06qPxr9DL+ixZ89FF
	AlDa/2ZYcJXMv/2dfIZUhXp+T04vr+WEgYhpGB42NlxSR/7CzNsV9HG3vsEM5CYl
	4R3RmA7zLyPbdQ+oKjua2bPrSKEoV19qS/Joyem34fQgoN4HETHsnqwwHsji5F31
	N3cnPu9HxMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C80429E5E;
	Wed, 19 Jun 2013 21:56:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC65029E5D;
	Wed, 19 Jun 2013 21:56:35 +0000 (UTC)
In-Reply-To: <1371640304-26019-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C65FE96-D92B-11E2-8126-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228427>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The setup creates two bare repositories: repo1 and repo2, but
> test_push_commit() hard-codes checking in repo1 for the actual output.
> Generalize it and its caller, test_push_success(), to optionally accept
> a third argument to specify the name of the repository to check for
> actual output.  We will use this in the next patch.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

Makes sense.

>  t/t5528-push-default.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index e54dd02..b599186 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -15,17 +15,19 @@ test_expect_success 'setup bare remotes' '
>  
>  # $1 = local revision
>  # $2 = remote revision (tested to be equal to the local one)
> +# $3 = [optional] repo to check for actual output (repo1 by default)
>  check_pushed_commit () {
>  	git log -1 --format='%h %s' "$1" >expect &&
> -	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
> +	git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>  	test_cmp expect actual
>  }
>  
>  # $1 = push.default value
>  # $2 = expected target branch for the push
> +# $3 = [optional] repo to check for actual output (repo1 by default)
>  test_push_success () {
>  	git -c push.default="$1" push &&
> -	check_pushed_commit HEAD "$2"
> +	check_pushed_commit HEAD "$2" "$3"
>  }
>  
>  # $1 = push.default value
