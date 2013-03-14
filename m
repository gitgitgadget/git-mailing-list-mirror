From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] difftool: avoid double slashes in symlink targets
Date: Thu, 14 Mar 2013 14:19:47 -0700
Message-ID: <7va9q5y8zw.fsf@alter.siamese.dyndns.org>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
 <b10c6d19bd4004887868dd7626320bd676fee540.1363291949.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 22:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGFZS-0006TC-Np
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 22:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab3CNVTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 17:19:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab3CNVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 17:19:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EA28C120;
	Thu, 14 Mar 2013 17:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65QHod1aHIlNPJkr6CduEK97qjw=; b=UQUgtF
	5Bgrw3db+C/HXzIX45BRO3xvwS14s4VdrtYtnW6L7cciXF0CXmOpuczGLzBXx+Vj
	low4qtIG9ATIFNKOyd9S/+uZ1pC2xxP9SlZKblXZRCI3d3u8OYncz0nv4/otak6f
	sf12WKYY2Mrd14Kry0SjU8lHyeS/OxLyOq9QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DTmdRnk992RyXsY44EVKHWZ8yNOGoeD4
	YclAhpEfNciUD54UPT5XOz5orQIDamoi7fVDRmDjcdIjt528g7vMRjBZioMI2W7y
	oWPKoqkquXkWm9RjSOQuoDEfROeRG7FfQFsYLTej6C/zCDxE15a70Z/sygwlJQgt
	+9/VwhmLR0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C714C11E;
	Thu, 14 Mar 2013 17:19:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FAE3C118; Thu, 14 Mar 2013
 17:19:49 -0400 (EDT)
In-Reply-To: <b10c6d19bd4004887868dd7626320bd676fee540.1363291949.git.john@keeping.me.uk>
 (John Keeping's message of "Thu, 14 Mar 2013 20:19:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7429DD0-8CEC-11E2-BFD5-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218169>

John Keeping <john@keeping.me.uk> writes:

> When we add tests for symlinks in "git difftool --dir-diff" it's easier
> to check the target path if we don't have to worry about double slashes
> separating directories.  Remove the trailing slash (if present) from
> $workdir before creating the symlinks in order to avoid this.

Yup, and it is a good basic hygiene even without tests that expect
the exact pathnames.

The code would work even when your $workdir is at the root of the
filesystem; the patch looks good.

Thanks.

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-difftool.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 12231fb..e594f9c 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -209,7 +209,9 @@ EOF
>  	delete($ENV{GIT_INDEX_FILE});
>  
>  	# Changes in the working tree need special treatment since they are
> -	# not part of the index
> +	# not part of the index. Remove any trailing slash from $workdir
> +	# before starting to avoid double slashes in symlink targets.
> +	$workdir =~ s|/$||;
>  	for my $file (@working_tree) {
>  		my $dir = dirname($file);
>  		unless (-d "$rdir/$dir") {
