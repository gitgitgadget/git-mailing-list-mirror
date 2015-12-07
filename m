From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: pass tag name via stdin without newline
Date: Sun, 06 Dec 2015 18:55:21 -0800
Message-ID: <xmqqd1ujnf1i.fsf@gitster.mtv.corp.google.com>
References: <1449451046-19752-1-git-send-email-ericvw@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: "Eric N. Vander Weele" <ericvw@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 03:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5ly0-0002Bp-1u
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 03:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbbLGCzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 21:55:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755021AbbLGCzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 21:55:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0E8A31461;
	Sun,  6 Dec 2015 21:55:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8CY5pqdKifoHcpoptIwFbYarjA=; b=ObMa0g
	xgOkV73iQfaCOXygowVAWYVEBzEDINOyOlH9Ez/UYEfXE14D0dR9DwcpRtQQT60X
	bdF6QS5ibtlMlfqOvvvOEfRTvCOMYzohlMAJPQ9/U9fa0LpuOAWrmdtRrlnLDU1Q
	8gORN71bwzrSP71hATZvzcAZhHEXVaTtUJfF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWIAFIE27sW3zkkCIo9fZphP39tMKi7O
	CJclA4hgvSgd2iztchA7IwJBbgaIkvWcpwq7xhB2Jf/LMWo1IDMDXjjGXOQplirk
	EIKyvNsND4mw1oyCFrdGO8TgLTCjc7GgI2ROSs6rgnRg1GfVt257XOxsXa8Mel3d
	7h3icQ6Jbvk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3F2431460;
	Sun,  6 Dec 2015 21:55:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3ED663145F;
	Sun,  6 Dec 2015 21:55:50 -0500 (EST)
In-Reply-To: <1449451046-19752-1-git-send-email-ericvw@gmail.com> (Eric
	N. Vander Weele's message of "Sun, 6 Dec 2015 17:17:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05E32512-9C8E-11E5-A704-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282073>

"Eric N. Vander Weele" <ericvw@gmail.com> writes:

> "git filter-branch --tag-name-filter" fails when the user-provided
> command attempts to trivially append text to the originally tag name,
> passed via stdin, due to an unexpected newline ('\n').  The newline is
> introduced due to "echo" piping the original tag name to the
> user-provided tag name filter command.

Is there any other place where we feed such an incomplete line
(i.e. a line without the terminating LF) to the filters in this
command?

I am guessing that the answer to that question would be no, and all
existing scripts by users expect the newline at the end of each
line.  So I would have to say that "due to an unexpected newline" is
a misleading statement--isn't it a bug in your filter that it did
not expect one?

> The only portable usage of "echo" is without any options and escape
> sequences.  Therefore, replacing "echo" with "printf" is a suitable,
> POSIX compliant alternative.

Yes, if we wanted to emit an incomplete line, we would be using

    printf "%s" "$var"

instead of

    echo -n "$var"

for portability.  But that would not belong to the log message for
this patch.  If the patch were to correct a script that originally
used "echo -n" to produce an incomplete line to instead use "printf",
these three lines would have been a perfect log message.

Thanks.

> Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
> ---
>  git-filter-branch.sh     | 2 +-
>  t/t7003-filter-branch.sh | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 98f1779..949cd30 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -503,7 +503,7 @@ if [ "$filter_tag_name" ]; then
>  		new_sha1="$(cat "../map/$sha1")"
>  		GIT_COMMIT="$sha1"
>  		export GIT_COMMIT
> -		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
> +		new_ref="$(printf "$ref" | eval "$filter_tag_name")" ||
>  			die "tag name filter failed: $filter_tag_name"
>  
>  		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 869e0bf..0db6808 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -269,6 +269,11 @@ test_expect_success 'Tag name filtering retains tag message' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'Tag name filter does not pass tag ref with newline' '
> +	git filter-branch -f --tag-name-filter "cat && printf "_append"" -- A &&
> +	git rev-parse A_append > /dev/null 2>&1
> +'
> +
>  faux_gpg_tag='object XXXXXX
>  type commit
>  tag S
