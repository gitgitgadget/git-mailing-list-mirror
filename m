From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around broken ln on solaris as used in t8006
Date: Sun, 20 Mar 2011 18:02:13 -0700
Message-ID: <7vd3lluvze.fsf@alter.siamese.dyndns.org>
References: <1300665586-24512-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1TVs-0003ZE-Cv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab1CUBCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:02:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1CUBCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:02:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 665724E91;
	Sun, 20 Mar 2011 21:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kz1iqC1Ba+nwLx+9sBeh8bAWCU4=; b=T6zQ43
	5LStpXbChjMznwHSuSu54OAX+o3vPfFX2BPBMDkEixX84TT63tQ0rlCNTINALWD4
	GmIRS0hGcPljjtsNXW8z/JXmukz03scdQUQjbt7mspBEC64jT1aGMcbOHXaPJk09
	dZfOhZnXPph8imvFNxX/WrZscWDfRJPh65tTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUM+MEKgtpP8RaIrcwlog2cQa/qFcx3o
	w2bUmI/q49AMQ2PGCAs3SYmSKjGX3Hh/kFwSt+Hm3itvxG2JflRl23JHmbbXleM7
	HOJfZffqGoTltcGYCKACr3/Ph3vL/xjUohOcQ8QQsk6QbeyRMdWE7PlDLtOn3s1M
	58i0RwRHPy8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43D804E8F;
	Sun, 20 Mar 2011 21:03:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 402034E8E; Sun, 20 Mar 2011
 21:03:51 -0400 (EDT)
In-Reply-To: <1300665586-24512-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sun, 20 Mar 2011 19:59:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 180C1E5E-5357-11E0-93DC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169543>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> The test setup in t8006-blame-textconv.sh used ln -sf to overwrite an
> existing symlink.  Unfortunately, both /usr/bin/ln and
> /usr/xpg4/bin/ln on solaris 9 don't properly handle -f when -s is
> used.

Thanks for reporting.  I recall "ln -s -f" traditionally has been a pain
point not just on Solaris.

> This caused the test setup to fail which caused subsequent
> checks to also fail.
>
> This patch uses changes the first check in the test to rm the symlink
> and then create the new symlink using only -s.

s/uses //; I think.

It is curious why "rm symlink.bin" is not inside the test-have-prereq
part, iow, immediately before the problematic "ln -s", where it logically
belongs to, though.  What does the updated code do on systems without
symbolic link support?

> The upstream Solaris bug (fixed in 10, but not 9) is documented here:
> http://bugs.opensolaris.org/view_bug.do?bug_id=4372462
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>  t/t8006-blame-textconv.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
> index ea64cd8..c5362d9 100755
> --- a/t/t8006-blame-textconv.sh
> +++ b/t/t8006-blame-textconv.sh
> @@ -24,8 +24,9 @@ test_expect_success 'setup ' '
>  	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
>  	echo "bin: test 1 version 2" >one.bin &&
>  	echo "bin: test number 2 version 2" >>two.bin &&
> +	rm symlink.bin &&
>  	if test_have_prereq SYMLINKS; then
> -		ln -sf two.bin symlink.bin
> +		ln -s two.bin symlink.bin
>  	fi &&
>  	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
>  '
