From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] t9100-git-svn-basic.sh: use the $( ... ) construct for command substitution
Date: Tue, 12 Jan 2016 11:56:42 -0800
Message-ID: <xmqqd1t6tvut.fsf@gitster.mtv.corp.google.com>
References: <1452595518-38149-1-git-send-email-gitter.spiros@gmail.com>
	<1452595518-38149-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:56:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ53i-0001rp-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbcALT4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 14:56:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752552AbcALT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 14:56:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9F9D3BF19;
	Tue, 12 Jan 2016 14:56:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=baVOBkkWSfWIP1y4wZkC9KkvdUk=; b=g8Pqru
	NSlFLFXyFPXy90TjqbKJLXm2plPnn5rtJz2VvzldxV7X+v+Z5f55OpW+7jT+AAjD
	05gi24W6J6Zu4eDtscSw6ZrteuSUE5aThL5JdLk700KS3oUS+XcRhaBoDABErkow
	gh7Ykg+OffhbRQ47Gnwg+271Ix4cyq/h0LgZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ukqmc8l2KQvdmJcAaWgeYOlL0tz23kNe
	vvpaCer/zAOqUfAfpLW4ssOhtfCj4ijWzOjA3h6mpHKAn/kEoSq6NtYHM2TPJNkr
	L8GfippQaPAK6RlK+kVCjU71fn5vxquXZnt7wx4KFAEPTX+LWC7slGmd7Ex+J8Rz
	cnbp7frm9kA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D17B13BF18;
	Tue, 12 Jan 2016 14:56:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 558883BF17;
	Tue, 12 Jan 2016 14:56:43 -0500 (EST)
In-Reply-To: <1452595518-38149-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 12 Jan 2016 10:45:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A721C02-B966-11E5-8153-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283840>

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -265,18 +265,18 @@ test_expect_success 'able to dcommit to a subdirectory' "
>  	git update-index --add d &&
>  	git commit -m '/bar/d should be in the log' &&
>  	git svn dcommit -i bar &&
> -	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
> +	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\" &&

This is entirely outside the scope of this series, but we may want
to see if it makes it easier to read and maintain to turn executable
part of test_expect_success that is double-quoted to use single
quotes around it instead for many of our tests.

This one is a prime example of it.  I do not think the executable
part is getting _any_ benefit from being quoted inside double-quote
pair.  All the single quoted strings it uses in the script commands
(e.g. the argument to "git commit -m") can equally be quoted with
double quotes safely, and there is no $variable reference that it
wants to refer to the value of the $variable when the command line
of test_expect_success itself is constructed.

>  	mkdir newdir &&
>  	echo new > newdir/dir &&
>  	git update-index --add newdir/dir &&
>  	git commit -m 'add a new directory' &&
>  	git svn dcommit -i bar &&
> -	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\" &&
> +	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\" &&
>  	echo foo >> newdir/dir &&
>  	git update-index newdir/dir &&
>  	git commit -m 'modify a file in new directory' &&
>  	git svn dcommit -i bar &&
> -	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
> +	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\"
>  	"
>  
>  test_expect_success 'dcommit should not fail with a touched file' '
> @@ -295,7 +295,7 @@ test_expect_success 'able to set-tree to a subdirectory' "
>  	git update-index d &&
>  	git commit -m 'update /bar/d' &&
>  	git svn set-tree -i bar HEAD &&
> -	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
> +	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\"
>  	"

Likewise.
