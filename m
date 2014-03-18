From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase: Teach rebase "-" shorthand.
Date: Tue, 18 Mar 2014 12:42:06 -0700
Message-ID: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
References: <1395132268-69488-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPztx-000748-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856AbaCRTmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:42:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757663AbaCRTmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:42:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C808D728C7;
	Tue, 18 Mar 2014 15:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jst6ja3/cFRlVW2hj5bBa3FHso4=; b=PN8eLj
	qAaDupuWOg72FJ0PG1CtNkzm/e6tPrUYv4mwszDP2GRCRLY9YwDSpd5xVXOsoExz
	5i/7GcM7Nv7qJrgBfmahyavlCljKJMcTIB4YRtTZY8NSeN/2eNxSwrS0O+2m60WM
	X6U+jspZvYlng/LKU65rWWuIK0idobHZ0YrH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hFAvZ2SLW/caH6p6zN01oebstTm9Xxg6
	9P+Htz0bCSnMq5s+/QmOR0KwQjhUs4W/LP7D+1MqHzc2cPAm6gRgcQjozVmtG9am
	38/Ngfb2RbqprSQfj0w2GB9H5IaOviMeB7LkrakS9XGewUoDllUC3p4STKBGTyrH
	gmSprrjChDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B53AA728C5;
	Tue, 18 Mar 2014 15:42:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5651728C0;
	Tue, 18 Mar 2014 15:42:09 -0400 (EDT)
In-Reply-To: <1395132268-69488-1-git-send-email-modocache@gmail.com> (Brian
	Gesiak's message of "Tue, 18 Mar 2014 17:44:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6511EAD0-AED5-11E3-9099-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244374>

Brian Gesiak <modocache@gmail.com> writes:

> Teach rebase the same shorthand as checkout and merge; that is, that "-"
> means "the branch we were previously on".
>
> Reported-by: Tim Chase <git@tim.thechases.com>
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  git-rebase.sh     | 4 ++++
>  t/t3400-rebase.sh | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f6732b..2c75e9f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -453,6 +453,10 @@ then
>  		test "$fork_point" = auto && fork_point=t
>  		;;
>  	*)	upstream_name="$1"
> +		if test "$upstream_name" = "-"
> +		then
> +			upstream_name="@{-1}"
> +		fi
>  		shift
>  		;;
>  	esac
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6d94b1f..00aba9f 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -88,6 +88,12 @@ test_expect_success 'rebase from ambiguous branch name' '
>  	git rebase master
>  '
>  
> +test_expect_success 'rebase using shorthand' '
> +	git checkout master
> +	git checkout -b shorthand HEAD^
> +	GIT_TRACE=1 git rebase -

I'd rather not to see that TRACE there.  We would also want to make
sure the result is what we expect to see, not only the command does
not error out, no?

> +'
> +
>  test_expect_success 'rebase a single mode change' '
>  	git checkout master &&
>  	git branch -D topic &&
