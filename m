From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] difftool: Use symlinks when diffing against the
 worktree
Date: Sun, 22 Jul 2012 21:57:09 -0700
Message-ID: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
 <1343015831-17498-2-git-send-email-davvid@gmail.com>
 <1343015831-17498-3-git-send-email-davvid@gmail.com>
 <1343015831-17498-4-git-send-email-davvid@gmail.com>
 <1343015831-17498-5-git-send-email-davvid@gmail.com>
 <1343015831-17498-6-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:57:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAhp-0002vW-FD
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab2GWE5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 00:57:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab2GWE5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 00:57:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E60DF58CF;
	Mon, 23 Jul 2012 00:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qCCpucYNvZUg1+8LfDqMVhs/aPg=; b=Yc10fo
	EpsK4eqZLV2bJaqy18/ajB5RptXYhMio0wG9R0ZS0+4cBN+mXxhklnhz279NrIwT
	v88yO83XyfZiwMrtovx8QzLK0KqQj1RulSFjfRDL5IyXggsatrHJiC1Uai70yuzw
	oSZQFYncM5mY7lAqVmjzAWlysvqUx2Yjn2C8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPn5eXl40MH+/ucGJ5cDyP7bsNAvlojW
	AB//9aPGkY42rtTN4fWOjZozyoFTJSlbnkhGmk4I/ggRtl0GOlHfnNg1j4kSZbGW
	Zgv5fNJiSyVPuM8OrDYo1YVyuy8Px3mGD8YHygDnrwfIVjPR0UIUNRjcHuWju7Uc
	sEyHaTUssE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D412F58CE;
	Mon, 23 Jul 2012 00:57:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E58D58CD; Mon, 23 Jul 2012
 00:57:11 -0400 (EDT)
In-Reply-To: <1343015831-17498-6-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 22 Jul 2012 20:57:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCBC1DC8-D482-11E1-9EE1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201897>

David Aguilar <davvid@gmail.com> writes:

> +	# Do not copy back files when symlinks are used
> +	if ($symlinks) {
> +		exit(0);
> +	}
> +

Isn't this a bit risky, depending on the behaviour of the tool that
eventually lead the user to invoke his favorite editor to muck with
the files in the temporary directory?  I think most sane people and
their editors would follow symlinks and update the file the symlink
points at when writing out the modified contents, but it should not
be too much trouble to detect the case in which the editor unlinked
the symlink and recreated a regular file in its place, and copy the
file back when that happened, to make it even safer, no?

The most lazy solution would be to just remove the above block, and
let the compare() compare the symlink $b/$file and the working tree
file $workdir/$file that is pointed by it. We will find data losing
case where the editor unlinks and creates that way automatically.

Optionally, you can update

	if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {

with

	if (! -l "$b/$file" && -f _ && compare("$b/$file", "$workdir/$file")) {

to avoid the cost of comparison.

>  	# If the diff including working copy files and those
>  	# files were modified during the diff, then the changes
>  	# should be copied back to the working tree
> +
>  	for my $file (@working_tree) {
>  		if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
>  			copy("$b/$file", "$workdir/$file") or die $!;
> -			chmod(stat("$b/$file")->mode, "$workdir/$file") or die $!;
> +			my $mode = stat("$b/$file")->mode;
> +			chmod($mode, "$workdir/$file") or die $!;
>  		}
>  	}
> +	exit(0);
>  }

Other than that, the series looked well thought-out.

Thanks.
