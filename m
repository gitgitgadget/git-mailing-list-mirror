From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] rebase: prepare to do generic housekeeping
Date: Fri, 10 May 2013 08:32:10 -0700
Message-ID: <7vvc6q3l6t.fsf@alter.siamese.dyndns.org>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 17:32:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UapIx-0003in-MG
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757643Ab3EJPcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487Ab3EJPcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72911CCB2;
	Fri, 10 May 2013 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zHbYLIVXHmSOlUtAc2NPdjVQGJ0=; b=MjqcKlbyVZFD4gA1v/M6
	glb0VrkIZL9sDNMan5FirClmWR2I+JOuOMQVyTxOeh2+qGduBGZ9si6BTARCW1bl
	eE0w2LDidAjK+Mu/yHn527l6UXdaJXLeEIN+STvoaYhQCnZZf1AHtfihrSUxCy/j
	Hvg/7LmtQK7VCTJ7W6Ln0KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XbxfyjMx5C2uCNAc3NT+11xsxI4/y8jSwMY78ZzndQKvk9
	d/R6ZMRa4VGoDl/VtLQT6eDIVuXwHA2GZlsA0mnsYdRuHIArKVRa1jPfjPql/G8I
	bC97QPaxtW+m3X7TETdmh0aU2Xm9MyAXHhUB+XTHe1EA9PzVZmYEkb755CppM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E7AF1CCB1;
	Fri, 10 May 2013 15:32:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0119E1CCAF;
	Fri, 10 May 2013 15:32:11 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8CC2BC0-B986-11E2-9294-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223873>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On successful completion of a rebase in git-rebase--$backend.sh, the
> $backend script cleans up on its own and exits.  The cleanup routine
> is however, independent of the $backend, and each $backend script
> unnecessarily duplicates this work:
>
>     rm -rf "$state_dir"
>     git gc --auto
>
> Prepare git-rebase.sh for later patches that return control from each
> $backend script back to us, for performing this generic cleanup
> routine.
>
> Another advantage is that git-rebase.sh can implement a generic
> finish_rebase() to possibly do additional tasks in addition to the
> cleanup.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2c692c3..84dc7b0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -150,6 +150,13 @@ run_specific_rebase () {
>  		autosquash=
>  	fi
>  	. git-rebase--$type
> +	ret=$?
> +	if test $ret = 0
> +	then
> +		git gc --auto &&
> +		rm -rf "$state_dir"
> +	fi
> +	exit $ret
>  }

Doesn't this exit look suspicious?  The existing callsites of this
shell function has a lot of code after them (e.g. when "continue"
$action is given, run_specific_rebase is run) but there is no exit
after the call returns, so they may already be expecting the
function not to return, exiting by itself.  But then the last step
of this function in the original code, ". git-rebase--$type", would
be the one that is causing us to exit, no?

So it is either (1) the added code is unreachable and unexercised at
this point in the series, or (2) my analysis above is incorrect and
". git-rebase--$type" does return to let the caller proceed, but
this patch changes the behaviour and breaks the caller.  I think it
is the former but then the organization of the series does not make
sense.

Perhaps this should come a bit later in the series?

At least the log message should mention that this is adding an
unreachable cruft at this step, if the order is to be kept.
