From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7502: perform commits using alternate editor in a
 subshell
Date: Fri, 22 Feb 2013 15:24:28 -0800
Message-ID: <7vliagaq4z.fsf@alter.siamese.dyndns.org>
References: <1361574780-30067-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <ralf.thielow@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:24:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91z6-0007TQ-7s
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435Ab3BVXYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:24:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139Ab3BVXYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:24:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297A4B86D;
	Fri, 22 Feb 2013 18:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n2Upn6I7FpdiCqbIfQ06+4SjrTE=; b=jTmQHR
	OfneH+1m7GhqKwK2Kkup1nQUEfus6oeFTbik2YGHqSQn1YXl3A4OUmwrPNqwlXIG
	uRLTR3MZGmPo3VRIcRxlke+tkxkk7PMvQlybrc0EO6fmc5YBYsmAVeQdyvKzcm5G
	8trg/UBIbxCvMQPaDnQA/GKE4LdANbRXjNtd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xzARorcmfZSR/DkBHgi7HV2sf8rWGFy8
	Q6++J83aMgSo/WLg4aumn9GAEzUgKyn492OW568TkzkXhz8nsU+TpwDEUh7BxcJ6
	7GFv5d8PHud3FYgfGk6oQqlkYxurp9YSK882G0QreJ6BI7lcxzxP4PEzMwCW07Ed
	RIXG2xFMTZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D895B86C;
	Fri, 22 Feb 2013 18:24:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C46CB869; Fri, 22 Feb 2013
 18:24:30 -0500 (EST)
In-Reply-To: <1361574780-30067-1-git-send-email-bcasey@nvidia.com> (Brandon
 Casey's message of "Fri, 22 Feb 2013 15:13:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01FA5D80-7D47-11E2-82C9-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216882>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> These tests call test_set_editor to set an alternate editor script, but
> they appear to presume that the assignment is of a temporary nature and
> will not have any effect outside of each individual test.  That is not
> the case.  All of the test functions within a test script share a single
> environment, so any variables modified in one, are visible in the ones
> that follow.
>
> So, let's protect the test functions that follow these, which set an
> alternate editor, by performing the test_set_editor and 'git commit'
> in a subshell.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>
>
> Before "git-commit: populate the edit buffer with 2 blank lines before s-o-b"
> is merged, this is needed on top of rt/commit-cleanup-config 51fb3a3d so that
> the default EDITOR remains in effect for the new test.

Yeah, what I already pushed out forces EDITOR=: for your test for
the same effect, but this patch clearly takes us in the right (and
better) direction.

>
> -Brandon
>
>
>  t/t7502-commit.sh | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index b1c7648..520a5cd 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -255,32 +255,40 @@ test_expect_success 'cleanup commit message (fail on invalid cleanup mode config
>  test_expect_success 'cleanup commit message (no config and no option uses default)' '
>  	echo content >>file &&
>  	git add file &&
> -	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> -	git commit --no-status &&
> +	(
> +	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> +	  git commit --no-status
> +	) &&
>  	commit_msg_is "commit message"
>  '
>  
>  test_expect_success 'cleanup commit message (option overrides default)' '
>  	echo content >>file &&
>  	git add file &&
> -	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> -	git commit --cleanup=whitespace --no-status &&
> +	(
> +	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> +	  git commit --cleanup=whitespace --no-status
> +	) &&
>  	commit_msg_is "commit message # comment"
>  '
>  
>  test_expect_success 'cleanup commit message (config overrides default)' '
>  	echo content >>file &&
>  	git add file &&
> -	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> -	git -c commit.cleanup=whitespace commit --no-status &&
> +	(
> +	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> +	  git -c commit.cleanup=whitespace commit --no-status
> +	) &&
>  	commit_msg_is "commit message # comment"
>  '
>  
>  test_expect_success 'cleanup commit message (option overrides config)' '
>  	echo content >>file &&
>  	git add file &&
> -	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> -	git -c commit.cleanup=whitespace commit --cleanup=default &&
> +	(
> +	  test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
> +	  git -c commit.cleanup=whitespace commit --cleanup=default
> +	) &&
>  	commit_msg_is "commit message"
>  '
