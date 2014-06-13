From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Fri, 13 Jun 2014 10:48:55 -0700
Message-ID: <xmqqppic3dko.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<1402603225-46240-1-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Mike Burns <mike@mike-burns.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:49:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVbA-0003nQ-LG
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbaFMRtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:49:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbaFMRtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:49:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD4161E3A5;
	Fri, 13 Jun 2014 13:49:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L4kYMGrYIZkNGiIP0Y/HohTxHbs=; b=m83hpz
	4Hb2hSgS4SBmIl7Re1qGw1Swt2GAzK5v6xzd1RhJYmQYpl+j5xR8P8IQXCjNAyMT
	I9QntIuIU0O4UtVQHxZ16C2344slUmNp7K6kp3S3EZ5PS1N8f2741csEanf+8EUD
	BTy3x+V6072T9NSUNw/1XR0BIo/WSiJ6jIpJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sUR7pkLV4BWzoh59Z0ZU78axgw1vbzEz
	LIVgaYNk3RbLDvTEIO4mQLslPx8E4pzxB8DNgJQbJASz8nv0BFi/x0d6IPKZK3gd
	qdU4KOBA5PCRxthYRTUmu7HvCKVRe/XcSgCBVuVOqXrK/OfZGfhY/pw1acbprjZs
	9Zp4gk85OGo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B49F41E3A4;
	Fri, 13 Jun 2014 13:49:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79F391E394;
	Fri, 13 Jun 2014 13:48:57 -0400 (EDT)
In-Reply-To: <1402603225-46240-1-git-send-email-caleb@calebthompson.io> (Caleb
	Thompson's message of "Thu, 12 Jun 2014 15:00:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE8420F2-F322-11E3-B4D0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251622>

Caleb Thompson <caleb@calebthompson.io> writes:

> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 35a4d06..402d6a1 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
> 	exec grep '^diff --git' "$1"
>  EOF
>
> +write_script check-for-no-diff <<-'EOF'
> +	exec grep -v '^diff --git' "$1"
> +EOF

This lets grep show all lines that are not "diff --git" in the
input, and as usual grep exits success if it has any line in the
output.

    $ grep -v '^diff --git' <<\EOF ; echo $?
    diff --git
    a
    EOF
    a
    0
    $ exit

What are we testing, exactly?

> @@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> 	check_message message
>  '
>
> +test_expect_success 'commit shows verbose diff with commit.verbose true' '
> +	echo morecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$PWD/check-for-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --verbose overrides commit.verbose false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false  &&
> +	test_set_editor "$PWD/check-for-diff" &&
> +	git commit --amend --verbose
> +'
> +
> +test_expect_success 'commit does not show verbose diff with commit.verbose false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false &&
> +	test_set_editor "$PWD/check-for-no-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --no-verbose overrides commit.verbose true' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$PWD/check-for-no-diff" &&
> +	git commit --amend --no-verbose
> +'
> +
>  cat >diff <<'EOF'
>  This is an example commit message that contains a diff.
>
> --
> 2.0.0
