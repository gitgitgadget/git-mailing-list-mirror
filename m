From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: add tests for "git fetch -v"
Date: Sat, 13 Feb 2016 12:48:49 -0800
Message-ID: <xmqqtwlcs5e6.fsf@gitster.mtv.corp.google.com>
References: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
	<20160212234953.GA8691@dcvr.yhbt.net>
	<CAPc5daUd6fQ6hX6W1AzQ9rCzrsTvkXOxZgwVdibbM5S34nF7ZA@mail.gmail.com>
	<20160213003526.GA15899@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 21:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUh83-0008VU-MX
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 21:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcBMUs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 15:48:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751229AbcBMUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 15:48:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D40942921;
	Sat, 13 Feb 2016 15:48:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=awc1fE7+1vNc9z3nzw58BBW8OpI=; b=qtiyRM
	VUO3DWrDkoVdO2GLX1xg1OPyz7kj8lm9iqJcHr2rBJxmCE+IlFPVPxs1a4ORvUjW
	fxI0RX0uvG+WVWV6J8KVf3VQupz3s+LDEKjyxLtIAQzjx2aVBtRvVbrYnehbP/N7
	V9r5ehNQ8F/M/WhMEoCL+GpHZUAf8Dygg5q5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTzF805O3VYKN3lKGJZr4JnQsq3Dww84
	mhmwjEJ3GhXugc5KHDiKOm7fpUeq8xdk3LPXUPub285r7yRTwL/nmZTLgmBZ/ynV
	erWBCdoswlLJPfffBfLnFLndufy1m8ZrV4Eeab2lCe4O3jqu8hH08LOzHUfPXdl8
	mX8Vby7gkDg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 747684291E;
	Sat, 13 Feb 2016 15:48:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE40042918;
	Sat, 13 Feb 2016 15:48:50 -0500 (EST)
In-Reply-To: <20160213003526.GA15899@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 13 Feb 2016 00:35:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FDFB58E-D293-11E5-9374-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286126>

Eric Wong <normalperson@yhbt.net> writes:

> Now that git_connect is more information about connectivity
> progress after: ("pass transport verbosity down to git_connect")
> we should ensure it remains so for future users who need to
> to diagnose networking problems.

Thanks.

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index d76269a..095e862 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -6,6 +6,13 @@ test_description='test fetching over git protocol'
>  . "$TEST_DIRECTORY"/lib-git-daemon.sh
>  start_git_daemon
>  
> +check_verbose_connect () {
> +	grep -qF "Looking up 127.0.0.1 ..." stderr &&
> +	grep -qF "Connecting to 127.0.0.1 (port " stderr &&
> +	grep -qF "done." stderr &&
> +	rm stderr
> +}

If you run the test without "-v", you would not see these strings
from grep hits, right?  I'd prefer losing "-q" here.  Also do we
need "rm stderr" at the end?  Everybody that uses this heler to
check the result will create the file from scratch anyway, so...

> @@ -24,18 +31,32 @@ test_expect_success 'create git-accessible bare repository' '
>  '
>  
>  test_expect_success 'clone git repository' '
> -	git clone "$GIT_DAEMON_URL/repo.git" clone &&
> +	git clone -v "$GIT_DAEMON_URL/repo.git" clone 2>stderr &&
>  	test_cmp file clone/file
>  '

What's the point of saving the error output without checking?

> +test_expect_success 'clone -v stderr is as expected' check_verbose_connect
> +

Ahh, you made it into two separate tests, one depending on the
previous one not being skipped?  I think it is better to fold this
into the previous one, i.e.

	clone -v 2>stderr &&
        check_verbose_output &&
        test_cmp file clone/file

The same comment applies to the next one.

The test for "fetch -v" is already in that form, so no need to
correct anything there.  Also it is good that you test the case
without "-v" and ensure it stays quiet.

Thanks.
