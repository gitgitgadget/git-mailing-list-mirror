From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: handle uninitialized variable on empty
 diff
Date: Thu, 28 Jun 2012 13:00:40 -0700
Message-ID: <7v7gur5hqv.fsf@alter.siamese.dyndns.org>
References: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
 <1340912395-16990-2-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 22:00:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkKtW-00031M-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 22:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab2F1UAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 16:00:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2F1UAq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 16:00:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD6768F34;
	Thu, 28 Jun 2012 16:00:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HSxWslN29S4UlooJ1Bxs9lVqnz4=; b=NwTyXu
	mj+M+F9P1xfpqaEKzTIL4IK9uYrfumIw0LWlQWOab9F/75LzahM85B9iw5O+t3GI
	LccAE+s3cuBkzrqPiutlav1BID+7Zo38Hr6TTwHQY86Nf5lYOGZEu9EOqpmUrQU+
	ZTmi9nV+NVWfbdLgwaF72hpS00qDU3Isz9q0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAgkf3rOHzttmPXiYUay/d6w+WSdPQ6j
	aLDs6Oa8IQzCbwkRgrmfheD62rLnq81ONZcLKl2TCrcm9IWBIg9rx4d12k4hU73B
	YhLzl55ekHZ7uRsxAy997DQA7fHCw+5YXaolzygnY+560dj8oRcjwQXeIuLWQTNB
	jPyfOmIU6ZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8D48F33;
	Thu, 28 Jun 2012 16:00:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 387C48F2D; Thu, 28 Jun 2012
 16:00:42 -0400 (EDT)
In-Reply-To: <1340912395-16990-2-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 28 Jun 2012 15:39:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0B53434-C15B-11E1-9597-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200794>

Tim Henigan <tim.henigan@gmail.com> writes:

> When 'difftool --dir-diff' finds no changes, it results in an
> uninitialized variable warning.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>  git-difftool.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 679a56d..c94557d 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -117,7 +117,7 @@ sub setup_dir_diff
>  	# by Git->repository->command*.
>  	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
>  	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
> -	exit(0) if (length($diffrtn) == 0);
> +	exit(0) if ((not defined($diffrtn)) or (length($diffrtn) == 0));

Wouldn't it be far more readable to say something like

        if (!$diffrtn) {
        	exit(0);
	}

instead, as "diff --raw" output, when not empty, cannot be a single
"0"?

By the way, I suspect that the use of command_oneline() here is
wrong.  It uses '-z' so that it can handle whitespace characters in
pathnames sensibly (in other words, the output does not use LF as a
record separator), so pathnames with LF in them will be output
literally.  Taking only the first line of the "diff -z" output would
mean that you will stop when you see the first pathname with LF in
it.

This is not a new problem with this patch, but came from your
7e0abce (difftool: teach difftool to handle directory diffs,
2012-04-23).
