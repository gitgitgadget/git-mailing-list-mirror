From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Mon, 09 Apr 2012 12:07:44 -0700
Message-ID: <7v1unwwwov.fsf@alter.siamese.dyndns.org>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJwP-0005Z7-T4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab2DITHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 15:07:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757858Ab2DITHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 15:07:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91DBF7E4E;
	Mon,  9 Apr 2012 15:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l/zCJx84kHpVodiClFFgoY5uuRU=; b=GKeMuz
	tDrjvRaRpdlbKhFDi0+7EGqD2uUHMW6yGx/HFcnpXwx688RpaapbjiuKqtAyqAED
	C86z8S12WUk7o1vbcg/3Pv2Y3eDLcmxNO6fUCG2lw4KtNKqh3iDIaD7jJanC5gCV
	ej0nanVjGZJh23A11oVPPXSfmABKrVMR6ROfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WNh5N165lF24MnLN0Su2BSVOxLTDmNWq
	/jn5ThbAIvhwpega+Vb2SKa28oGg90VnsGLklFWrTV45AgHV7UGwdj9JSZcpLc2w
	GuGEGhDrgl0ANvZXjMWquiVqRDPQbDnBbI+UyOwpj7JcclIOdALLTvaaiCQGujdV
	z2W4dR4+dgI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8624C7E4D;
	Mon,  9 Apr 2012 15:07:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16AAE7E4C; Mon,  9 Apr 2012
 15:07:45 -0400 (EDT)
In-Reply-To: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
 (Ross Lagerwall's message of "Mon, 9 Apr 2012 15:27:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A89089C-8277-11E1-8989-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195031>

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index e661147..8f36aa9 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -68,7 +68,7 @@ test_expect_success 'inside work tree' '
>  	)
>  '
>  
> -test_expect_failure 'empty prefix is actually written out' '
> +test_expect_success 'empty prefix is actually written out' '
>  	echo >expected &&
>  	(
>  		cd work &&

fc68875 (t1501 (rev-parse): clarify, 2010-07-24) says it is a "possible
bug", but I do not think the expectation of the new test added by that
commit is entirely correct.

Because the assignment will strip the trailing LF away adding an extra
newline at the end would not matter in practice in many scripts, e.g.

	a=$(git rev-parse --show-prefix)
        if test -z "$a"
        then
		echo we are at toplevel
	fi

or

	pfx=$(git rev-parse --show-prefix)
	cd_to_toplevel
	for arg
        do
		case "$arg" in
                /*)
                       	user refers to "$arg" that is a full path ;;
		*)
			user refers to "$pfx$arg" ;;
		esac
	done

But it will break existing scripts if they expect the following to work:

	file="$(git rev-parse --show-prefix)/$1"
        cd_to_toplevel
        test -f "$file"
