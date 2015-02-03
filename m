From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] apply: do not touch a file beyond a symbolic link
Date: Tue, 03 Feb 2015 13:01:06 -0800
Message-ID: <xmqqy4oepv59.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-5-git-send-email-gitster@pobox.com>
	<20150203011139.GC31946@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIkb0-0000gT-V1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbbBCVBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:01:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756172AbbBCVBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:01:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F651356AE;
	Tue,  3 Feb 2015 16:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6jPkvb2nNa++BNNfgDdOMG9Irc=; b=ZwHzQ7
	3HL+3hU9wqxgtr8vdx5K22ITIY9yl0jd1cySdwhL1zHcScnrUKp6zbioORIYhO1l
	97wod+NHP7DvsUk1d0tKvenV3rJ9uxeFuUFsDskJm76RunzOl6YGNgUAhqPtJ3UD
	xlDFVhTNozbYRON9e2OY+yQMcKAbzAJj0jz4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hSlfHVZVu93LKiBNX4GMDZ+Sa6I6Ko+J
	XW931jhf/T4zFBdKHJNW3ld4AM3Z0J6vLFaXIeRtHWOvhgvnga0I/lllLZmsk7WC
	cqqv9qny5sBJvCXfADkjiLgRmnq0+gxdOmcX8Q+0jjxwFFb23AQ+9DadCV/3LUJ8
	dNF/oAHV6h0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26FF1356AD;
	Tue,  3 Feb 2015 16:01:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84347356AA;
	Tue,  3 Feb 2015 16:01:07 -0500 (EST)
In-Reply-To: <20150203011139.GC31946@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 20:11:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5FDDABA-ABE7-11E4-A2B7-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263332>

Jeff King <peff@peff.net> writes:

> Here's the test addition I came up with, because it didn't look like we
> were covering this case. 

Thanks.

> diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
> index 942c5cb..fbba8dd 100755
> --- a/t/t4122-apply-symlink-inside.sh
> +++ b/t/t4122-apply-symlink-inside.sh
> @@ -89,6 +89,7 @@ test_expect_success SYMLINKS 'do not follow symbolic link (setup)' '
>  	rm -fr arch/x86_64/dir &&
>  
>  	cat add_symlink.patch add_file.patch >patch &&
> +	cat add_symlink.patch del_file.patch >tricky_del &&

This new patch

 (1) creates a symlink arch/x86_64/dir pointing at ../i386/dir
 (2) deletes arch/x86_64/dir/file

It can be a valid patch to be applied to a tree where arch/x86_64/dir/file
is in the index (either as a regular file, a symlink, or even a submodule)
and nothing else is in arch/x86_64/dir directory.


> @@ -112,6 +113,20 @@ test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
>  	test_i18ngrep "beyond a symbolic link" error-ct &&
>  	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
>  	test_must_fail git ls-files --error-unmatch arch/i386/dir
> +
> +	>arch/i386/dir/file &&
> +	git add arch/i386/dir/file &&

At this point, the target of the patch application has:

	arch/i386/boot/Makefile
	arch/i386/dir/file
	arch/x86_64/boot/Makefile

all of which are regular files.  The index and the working tree
match.

> +	test_must_fail git apply tricky_del &&

The reason why this does not apply has nothing to do with the topic
of this series, I think.  It wants to delete arch/x86_64/dir/file,
which does not exist in the target, and the patch is rejected.

It is a good test to make sure that we do not "incrementally" apply
and get fooled by arch/x86_64/dir that will become a symbolic link,
making arch/x86_64/dir/file to appear as arch/i386/dir/file that
does exist in the preimage.

> +	test_path_is_file arch/i386/dir/file &&

When we reject the entire patch, we do so without touching the
outside world, of course ;-), which is good.

> +	test_must_fail git apply --index tricky_del &&
> +	test_path_is_file arch/i386/dir/file &&
> +	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
> +	git ls-files --error-unmatch arch/i386/dir &&
> +
> +	test_must_fail git apply --cached tricky_del &&
> +	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
> +	git ls-files --error-unmatch arch/i386/dir
>  '

In both of the above, "git apply" rejects its input for the same
reason.  The file it wants to remove does not exist in the target.

>  test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
> @@ -125,6 +140,7 @@ test_expect_success SYMLINKS 'do not follow symbolic link (existing)' '
>  	test_i18ngrep "beyond a symbolic link" error-wt-add &&
>  	test_path_is_missing arch/i386/dir/file &&
>  
> +	mkdir arch/i386/dir &&

Thanks for spotting this one ;-)

>  	>arch/i386/dir/file &&
>  	test_must_fail git apply del_file.patch 2>error-wt-del &&

del_file.patch wants to remove arch/x86_64/dir/file, and arch/x86_64/dir
is a symbolic link to ../i386/dir in the target at this point, so it
is trying to delete beyond the symbolic link, which gets rejected by
this series.  Good.

>  	test_i18ngrep "beyond a symbolic link" error-wt-del &&
