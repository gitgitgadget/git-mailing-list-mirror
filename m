From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Thu, 30 Sep 2010 13:38:18 -0700
Message-ID: <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Ptn-0001YF-6J
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab0I3Uid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 16:38:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756466Ab0I3Uic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 16:38:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11FB5DA897;
	Thu, 30 Sep 2010 16:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G8PPEmsMUADXA0WTcCqGTItepD4=; b=IfwIFA
	z9M9y5hHuyJHUaY8xEwMxXw5NTthuo+t368u+2Wp4AlWw97hM4mw1TbeyosXTZPX
	jwLrlpQHyvIJamj45o+Rjl5l0MUL9czUYGCR+zFBVrFKO6jPjvxN7iFExpk22Vr1
	dT4fL8xukgsldoqnyTRevEBnuR9gaCnx29Wf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NBY+9BXv5MSb33k9+zbXO4tCTXHOtzqA
	WvauhGKORp47ELm0npQcteZJvLxl0EkMru4fz/afyVVA5TA6++rbedet/RDolIk8
	/o6NO0wNd9Dfup/Z3ChHJ14Rl20MDwfWG3ai1iGGDlNpgrHwDAU2qttH1wqzybSX
	CtIS0iscRyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 972BFDA891;
	Thu, 30 Sep 2010 16:38:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59B26DA890; Thu, 30 Sep
 2010 16:38:20 -0400 (EDT)
In-Reply-To: <1285877017-8060-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri\,  1 Oct 2010 01\:33\:36 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD3A3864-CCD2-11DF-A43F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157711>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Write a new require_clean_work_tree function to error out when
> unstaged changes are present in the working tree and (optionally)
> uncommitted changes in the index.
>
> Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Please don't do this in-body "Cc:"; it is meaningless.

> ---
>  git-sh-setup.sh |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 6131670..215ec33 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -145,6 +145,34 @@ require_work_tree () {
>  	die "fatal: $0 cannot be used without a working tree."
>  }
>  
> +require_clean_work_tree () {
> +	# Update the index
> +	git update-index -q --ignore-submodules --refresh
> +	err=0
> +
> +	# Disallow unstaged changes in the working tree
> +	if ! git diff-files --quiet --ignore-submodules --

What is that trailing double-dash about?

> +	then
> +		echo >&2 "cannot $1: you have unstaged changes."
> +		git diff-files --name-status -r --ignore-submodules -- >&2
> +		err=1
> +	fi
> +
> +	# Disallow uncommitted changes in the index
> +	if ! git diff-index --cached --quiet HEAD --ignore-submodules --

Do not write HEAD there that sets a wrong example; the command line
arguments are flag-options, revs, double-dash and pathspec.

Contrary to what your proposed log message says, I do not see anything
"optional" in the way how this check is done here...  What is going on?

Unfortunately we cannot judge if unconditional check is the right thing to
do without looking at the callers; why did you make this into two-patch
series?

Mental note before reviewing the second patch: do all callers want the
same "both working tree and index are spiffy clean" check?

> +	then
> +		echo >&2 "cannot $1: your index contains uncommitted changes."
> +		git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
> +		err=1
> +	fi
> +
> +	if [ $err = 1 ]
> +	then
> +	    echo >&2 "Please commit or stash them."
> +	    exit 1
> +	fi
> +}

Mental note before reviewing the second patch: warning/error messages from
this codepath are all written without warning: or error: prefixes.
