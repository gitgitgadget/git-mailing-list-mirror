From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: print filename when it contains %
Date: Fri, 08 Feb 2013 09:32:23 -0800
Message-ID: <7vhalm3e54.fsf@alter.siamese.dyndns.org>
References: <1360286184-14278-1-git-send-email-asheesh@asheesh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3roi-00048N-3M
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946812Ab3BHRc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:32:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946799Ab3BHRc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:32:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A821EBD9A;
	Fri,  8 Feb 2013 12:32:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r53qDo8cFkZKvrPPJAnWT1NfObI=; b=l7xQt/
	hkbAhMM4HAwyBUmP6kMl6F0kiL8qHQIs8Ejq5ciRAGXzIFdAKpr/yKzHyUO0dOLM
	YwAFlbTYZFTD11X8KzmHnrw2ijteAk2GRwNjlbSKQXRC9h1al5eVOJoJT9o/UF7V
	x8pO5phevcGRoVEZZ8oWmR4lXqF7JIrCbdJI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KqfZslEeVpRyQYEqaewD0lsAi3aHXfN3
	/RyKQlHTreUdyV30wIX1c08K+tLC+D78lYDcYwOBOKmY4GHH3VgOwvlV+HdZ/MOl
	RNdnW4/EbD+fdVdAeQPOqz1taUToe8/KcgZPzzEOMrqjeQlf4eX774sXVmQRWs8o
	RU2Y1+shYq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BCA0BD99;
	Fri,  8 Feb 2013 12:32:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A947BD93; Fri,  8 Feb 2013
 12:32:25 -0500 (EST)
In-Reply-To: <1360286184-14278-1-git-send-email-asheesh@asheesh.org> (Asheesh
 Laroia's message of "Thu, 7 Feb 2013 17:16:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 808D563A-7215-11E2-AC74-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215786>

Asheesh Laroia <asheesh@asheesh.org> writes:

> Before this change, if git-mergetool was invoked with regard to

Drop "before this change,"; it is clear (and it is a recommended
practice) you are first describing what problem you are addressing.

> files with a percent sign (%) in their names, it would print an
> error. For example, if you were calling mergetool on a file called
> "%2F":
>
>     printf: %2F: invalid directive
>
> This changes the behavior to pass "%s" to printf as its first argument
> to avoid processing the filename as a format string.
>
> Signed-off-by: Asheesh Laroia <asheesh@asheesh.org>
> ---

Thanks.

As a follow-up to this patch, we may want to perform a systematic
audit of

    $ git grep -e 'printf "[^"]*\$[^"]*"'

There is one in git-difftool-helper.sh

    printf "\nViewing: '$MERGED'\n"

and mergetools/p4merge:

    printf "$empty_file"

>  git-mergetool.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index c50e18a..d2b9289 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -440,7 +440,7 @@ then
>  fi
>  
>  printf "Merging:\n"
> -printf "$files\n"
> +printf "%s" "$files\n"

I think

	printf "%s\n" "$files"

would be clearer.

>  
>  IFS='
>  '
