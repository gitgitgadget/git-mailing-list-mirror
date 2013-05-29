From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/send-email.sh: add test for suppress self
Date: Wed, 29 May 2013 13:28:52 -0700
Message-ID: <7vy5axr0mz.fsf@alter.siamese.dyndns.org>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
	<1369579187-27573-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmzU-0005PT-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966790Ab3E2U25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 16:28:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965827Ab3E2U2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 16:28:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06123225D1;
	Wed, 29 May 2013 20:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJX/PBZtGSfuw0tCtn6Pi5LORaU=; b=oiDNsd
	WWOSJ+f5xCe0iNi++IQ263JVLpuTnYgg2TFAM4V0mgjKOcREGrV5FrEHO0dd+ZNH
	y1ZLPee5ASjm+mlTrt9Nqq6I87pFUkjB3A0hVvOWdolAcqIEgohj58J6noPCGYXe
	TrQm0rWN72iK47Ejcjmve/5K5i073GkjWGc24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2niL2356N2b7KIXl8ziedfZGwpzk0QX
	mn7idFhvFDWLeOFEwlYlufxNpjnuIvGcGGeUFla9QeSB+5aFd/YpZo4tqAP+D93k
	hvF7miJtlZ/q0sga6j69c5Ji2bXpC96wMBveBJvEkrLFpRVQuZr5WLn8laKR7U/I
	L5CWz87nMLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1F1225D0;
	Wed, 29 May 2013 20:28:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35ECD225CA;
	Wed, 29 May 2013 20:28:54 +0000 (UTC)
In-Reply-To: <1369579187-27573-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Sun, 26 May 2013 17:40:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61982536-C89E-11E2-B4C4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225887>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Thanks.

>  t/t9001-send-email.sh | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index ebd5c5d..36ecf73 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -171,6 +171,47 @@ Result: OK
>  EOF
>  "
>  
> +test_suppress_self () {
> +		test_commit $3 &&
> +		test_when_finished "git reset --hard HEAD^" &&
> +		{
> +			echo "#!$SHELL_PATH"
> +			echo sed -n -e s/^cccmd--//p \"\$1\"
> +		} > cccmd-sed &&
> +		chmod +x cccmd-sed &&

We can use write_script for this kind of thing, I think.

> +		git commit --amend --author="$1 <$2>" -F - << EOF && \

Hmm,...  everything below this function is fed as the standard input
to "git commit" as its updated log message (i.e. "--amend -F -")?

Puzzled...

The EOF I can find is at the very bottom of this function, so there
is no "next command" that && at the end of the above line is
cascading the control to.

Doubly puzzled...

In any case, please do not add " \" at the end of line when the line
ends one command and "&&" at the end of line clearly tells the shell
that you haven't stopped talking yet.

> +		clean_fake_sendmail && \
> +		echo suppress-self-$3.patch > /dev/tty && \

Do we always have /dev/tty?  If this is a leftover debugging, please
remove it.  If redirecting it to >&2 does not upset what the test
does, that is good, too (you can run the test with -v option to view
the output).

> +		git format-patch --stdout -1 >suppress-self-$3.patch && \
> +		git send-email --from="$1 <$2>" \
> +		--to=nobody@example.com \
> +		--cc-cmd=./cccmd-sed \
> +		--suppress-cc=self \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		suppress-self-$3.patch && \
> +		mv msgtxt1 msgtxt1-$3 && \
> +		sed -e '/^$/q' msgtxt1-$3 > msghdr1-$3 && \

Style.  No SP between redirection operator and redirection target,
e.g. >$filename, <$filename, etc.  Some in this patch is done
correctly (e.g. format-patch above), some others are not.

> +		rm -f expected-no-cc-$3 && \
> +		touch expected-no-cc-$3 && \

Please reserve "touch" for "make sure it has recent timestamp", not
for "make sure it exists and is empty".  The above two should be
more like:

		>"expected-no-cc-$3" &&

Also, even though it is not required by POSIX, please dquote the
redirection target filename if you have variable expansion.  Some
versions of bash (incorrectly) give warning if you don't.

> +		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
> +		test_cmp expected-no-cc-$3 actual-no-cc-$3
> +test suppress-cc.self $3 with name $1 email $2
> +
> +$3
> +
> +cccmd--"$1" <$2>
> +
> +Cc: "$1" <$2>
> +Cc: $1 <$2>
> +Signed-off-by: "$1" <$2>
> +Signed-off-by: $1 <$2>
> +EOF
> +}
> +
> +test_expect_success $PREREQ 'self name is suppressed' "
> +	test_suppress_self 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
> +"
> +
>  test_expect_success $PREREQ 'Show all headers' '
>  	git send-email \
>  		--dry-run \
