From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] stash: simplify option parser for create
Date: Mon, 13 May 2013 07:34:28 -0700
Message-ID: <7vfvxrosnf.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubtpk-0001p3-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3EMOec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:34:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab3EMOeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:34:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5E81D1A0;
	Mon, 13 May 2013 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lyyqDiZHsZzc5uwQMbZSa4n5eZE=; b=EUzmmo
	BRickggcfxG6g0PwdV/0V7dIqVfBcffCJFsj81VW7IkYgaAFouRVGx3a5wST68pI
	br6o+9SFbtePtmIHzRBGEYOT95Rmw1VRoPSebUx8KEi3nCKPsWHqrNGhLb9l69BV
	s0jBFNdC7PifSEYRwNNIEQkPmPgDg6jSnqk+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gyhfqr7sVyrRVJuPSHZJIaHDu7jX+/6c
	d9HsDqD4xFKs5DZp91ifjq7QePdU+Gkbz16JFn7oW/AtqtVntQLbAPvkYNVUVwsl
	odrz3SGOWAR+EMOQ5lKxZmy/ovltchZLvUK58oLyQzOXB3EcEQhZVZ5q80ao8f+w
	xHX3DvF3iZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F356A1D19F;
	Mon, 13 May 2013 14:34:30 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 647E91D19E;
	Mon, 13 May 2013 14:34:30 +0000 (UTC)
In-Reply-To: <1368449154-21882-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 13 May 2013 18:15:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38C4E7FA-BBDA-11E2-9178-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224153>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The option parser for create unnecessarily checks "$1" inside a case
> statement that matches "$1" in the first place.  Also, use "$@", not
> "$*", as our caller is expecting "$1" "$2", not "$1c$2" (where c is the
> first character of IFS).

The first part of the patch may be OK but the rest unfortunately is
wrong.

The semi-user facing "git stash create" never was meant to take
anything but a message sentence and "$*" is the proper way to say
"everything is meant for a single message (just like echo)".
Changing it to "$@" will change the semantics in a big way.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-stash.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index bbefdf6..0ede313 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -546,11 +546,8 @@ clear)
>  	clear_stash "$@"
>  	;;
>  create)
> -	if test $# -gt 0 && test "$1" = create
> -	then
> -		shift
> -	fi
> -	create_stash "$*" && echo "$w_commit"
> +	shift
> +	create_stash "$@" && echo "$w_commit"
>  	;;
>  drop)
>  	shift
