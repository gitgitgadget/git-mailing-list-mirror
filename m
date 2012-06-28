From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] difftool: only copy back files modified during
 directory diff
Date: Thu, 28 Jun 2012 12:51:43 -0700
Message-ID: <7vbok35i5s.fsf@alter.siamese.dyndns.org>
References: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 21:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkKks-0007le-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 21:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab2F1Tvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 15:51:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2F1Tvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 15:51:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2538D19;
	Thu, 28 Jun 2012 15:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IrYlEGahyfV5zpCR0Airf84x4A8=; b=Hmmcri
	anr3cXapFWxjNZe8EaPU7zwqsKjh2VAhc4pQO1xDk3R6akHze84n8YcUAGn9Xy+L
	PKkc9Gtd0kySzJrxkm60qSj5HVXxpIpwOY5TRDdYCg+RjQMeg9exQQChYlNHBLHt
	VKBD4DhmTL210g71qCs7XYGonaOXYJYBNdcrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZevCPLo/14kDpR6C473Ln+cjdUjMUfQ
	SO31kUK1Gq/XZoE5rNUgccLcDZkGEhF7ht3NjmecfbyYV/mrHAiYFC3bBqvwwBNK
	+cLaxxidGNiSvqRdPYqVKacwEaeoA0LJlo2evvuyPTEr79o/Jl8abtUey+xOHLHm
	/C7UjOU1p1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C349E8D17;
	Thu, 28 Jun 2012 15:51:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51D818D16; Thu, 28 Jun 2012
 15:51:45 -0400 (EDT)
In-Reply-To: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 28 Jun 2012 15:39:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0B16EC6-C15A-11E1-AD47-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200793>

Tim Henigan <tim.henigan@gmail.com> writes:

> When 'difftool --dir-diff' is used to compare working tree files,
> it always copies files from the tmp dir back to the working tree
> when the diff tool is closed, even if the files were not modified
> by the diff tool.
>
> This causes the file timestamp to change. Files should only be
> copied from the tmp dir back to the working copy if they were
> actually modified.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> This patch must be applied after commit 304970d on next (diff-no-index:
> exit(1) if 'diff --quiet <repo file> <external file>' finds changes).
> because it relies on 'git diff --quiet' to compare files outside the
> repository.
>
>
>  git-difftool.perl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index ae1e052..679a56d 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -336,8 +336,11 @@ if (defined($dirdiff)) {
>  	# files were modified during the diff, then the changes
>  	# should be copied back to the working tree
>  	for my $file (@working_tree) {
> -		copy("$b/$file", "$workdir/$file") or die $!;
> -		chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
> +		if ((-e "$b/$file") &&
> +		    (system('git', 'diff', '--quiet', "$b/$file", "$workdir/$file") != 0)) {

Why waste cycles to spawn "git diff" when you only want to find if
they are byte-for-byte identical *and* when you are importing many
perl modules from File::* already into the script?

> +			copy("$b/$file", "$workdir/$file") or die $!;
> +			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
> +		}
>  	}
>  } else {
>  	if (defined($prompt)) {
