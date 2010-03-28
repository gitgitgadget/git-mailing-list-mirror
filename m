From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: Fix '--gui' when diff.guitool is unconfigured
Date: Sun, 28 Mar 2010 09:29:03 -0700
Message-ID: <7v39zk5s1c.fsf@alter.siamese.dyndns.org>
References: <1269727089-9506-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvMS-0004Cf-T8
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0C1Q3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:29:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab0C1Q3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:29:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9C7DA67DB;
	Sun, 28 Mar 2010 12:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPGsRC7avtwTSLTDvpXw/COU8Iw=; b=nk+111
	F47qfWNvsowJu0bP+Fz/vLy0hvaw5mDkBmyv3RKRhlgye1lpf2baccEqqRXIVKy9
	dJ6DLXo2f77epEaCku7Zzkya1sYuEjMbuPVLD3fWVeodqhgdRGcJxen2jPzxJ9iD
	Jw9GACwGYyG3qKcs0b+FQyenZYFz6F+/cIPuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hQfPDsH9dmNQItPZ7TJN1dw3gV+qqQcN
	Wke+3e4bRtO2Vab5r/l83G/LHou1ye+BexLWTB44yrMDagtpbhNdPkxQ/8zTRrCE
	50O+bxlcOAY4aytN16V4Hdb+5OwD8Pv3CfjNf+ZXru9Ll9zrl+pJUGsk+wsPHteC
	6q5Zfkr9/XQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84582A67DA;
	Sun, 28 Mar 2010 12:29:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FC6AA67D2; Sun, 28 Mar
 2010 12:29:05 -0400 (EDT)
In-Reply-To: <1269727089-9506-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat\, 27 Mar 2010 14\:58\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08AF6A68-3A87-11DF-8D31-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143398>

David Aguilar <davvid@gmail.com> writes:

> When diff.guitool is unconfigured and "--gui" is specified
> git-difftool dies with the following error message:
>
> 	config diff.guitool: command returned error: 1
>
> Catch the error so that the "--gui" flag is a no-op when
> diff.guitool is unconfigured.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Makes sense; thanks.

>
> This is probably 'maint' material.
>
>  git-difftool.perl   |   12 +++++++-----
>  t/t7800-difftool.sh |    9 +++++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index d975d07..adc42de 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -78,11 +78,13 @@ sub generate_command
>  			next;
>  		}
>  		if ($arg eq '-g' || $arg eq '--gui') {
> -			my $tool = Git::command_oneline('config',
> -			                                'diff.guitool');
> -			if (length($tool)) {
> -				$ENV{GIT_DIFF_TOOL} = $tool;
> -			}
> +			eval {
> +				my $tool = Git::command_oneline('config',
> +				                                'diff.guitool');
> +				if (length($tool)) {
> +					$ENV{GIT_DIFF_TOOL} = $tool;
> +				}
> +			};
>  			next;
>  		}
>  		if ($arg eq '-y' || $arg eq '--no-prompt') {
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 19c72f5..1de83ef 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -92,6 +92,15 @@ test_expect_success 'difftool honors --gui' '
>  	restore_test_defaults
>  '
>  
> +test_expect_success 'difftool --gui works without configured diff.guitool' '
> +	git config diff.tool test-tool &&
> +
> +	diff=$(git difftool --no-prompt --gui branch) &&
> +	test "$diff" = "branch" &&
> +
> +	restore_test_defaults
> +'
> +
>  # Specify the diff tool using $GIT_DIFF_TOOL
>  test_expect_success 'GIT_DIFF_TOOL variable' '
>  	git config --unset diff.tool
> -- 
> 1.7.0.3.291.g5e4f6
