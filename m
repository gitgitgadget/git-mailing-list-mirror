From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial cases)
Date: Tue, 04 Jun 2013 14:55:01 -0700
Message-ID: <7vd2s15yoa.fsf@alter.siamese.dyndns.org>
References: <cover.1370076477.git.j6t@kdbg.org>
	<3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjzCK-0003cl-2e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab3FDVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:55:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab3FDVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16E3825662;
	Tue,  4 Jun 2013 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gefQXNw/fxNE1ajLDr/dVeEbZHI=; b=t9ooCg
	aQXTWRUYROjqQB7kuisouPMGn6nhNw9K7zGz6jeCTnGXKVywlvIdE6PB4atig69o
	X2a9dcfj0j8diQeOipnvuhRaREolxQOqSJfLxXMVpWVngV8tjjo1TYhy7fmbncrT
	tjisXcd7u5kQxRKsTqjk9tQ556jwNnK49Utj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQSawWTvHEPVR/idmkQxZNEYn7oFn2Te
	Pst4Z9CIa8QCPushMRbThyLykDtidZ1foWm2Ak7RYsXWQv1aSNGXuU6tFzK4tWVd
	WC/wk9Ox7VFFojX1yRV6cCyKyIUpEPfhtZ0d+hhkK3nVovUtVP43yv1ZZ0stOz4m
	cc0JLfIgUgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 888B925660;
	Tue,  4 Jun 2013 21:55:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 948502565B;
	Tue,  4 Jun 2013 21:55:02 +0000 (UTC)
In-Reply-To: <3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org>
	(Johannes Sixt's message of "Sat, 1 Jun 2013 11:34:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68ACD872-CD61-11E2-81C6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226415>

Johannes Sixt <j6t@kdbg.org> writes:

> There are many instances where the treatment of symbolic links in the
> object model and the algorithms are tested, but where it is not
> necessary to actually have a symbolic link in the worktree.

> diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
> index 88be904..563ac7f 100755
> --- a/t/t3000-ls-files-others.sh
> +++ b/t/t3000-ls-files-others.sh
> @@ -19,12 +19,7 @@ filesystem.
>  
>  test_expect_success 'setup ' '
>  	date >path0 &&
> -	if test_have_prereq SYMLINKS
> -	then
> -		ln -s xyzzy path1
> -	else
> -		date >path1
> -	fi &&
> +	test_ln_s xyzzy path1 &&
>  	mkdir path2 path3 path4 &&
>  	date >path2/file2 &&
>  	date >path2-junk &&

This also is not appropriate, but it is not as bad as the one in
t2003 I earlier commented on.

This test wants an untracked symbolic link in the working tree as
path1 and wants to see "ls-files -o" report it as "other".  On a
filesystem that lack symbolic link, we obviously cannot have one,
so as a substitute we just create another regular file to make the
expected output and comparison simpler. 

> diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
> index 2d0ff2d..310e0a2 100755
> --- a/t/t3010-ls-files-killed-modified.sh
> +++ b/t/t3010-ls-files-killed-modified.sh
> @@ -39,12 +39,7 @@ modified without reporting path9 and path10.
> ...
> +	test_ln_s_add xyzzy path1 &&
> ...
>  	date >path2/file2 &&
>  	date >path3/file3 &&

This one is correct; the test wants to make sure that path1 would be
checked out as a non-directory, killing any files in path1/ that is
a directory on the filesystem.

> @@ -52,20 +47,14 @@ test_expect_success 'git update-index --add to add various paths.' '
>  	date >path8 &&
>  	: >path9 &&
>  	date >path10 &&
> -	git update-index --add -- path0 path1 path?/file? path7 path8 path9 path10 &&
> +	git update-index --add -- path0 path?/file? path7 path8 path9 path10 &&

And exclusion of path1 here is a logical consequence of the previous
change, so it is good, too.

>  test_expect_success 'git ls-files -k to show killed files.' '
>  	date >path2 &&
> -	if test_have_prereq SYMLINKS
> -	then
> -		ln -s frotz path3 &&
> -		ln -s nitfol path5
> -	else
> -		date >path3 &&
> -		date >path5
> -	fi &&
> +	test_ln_s frotz path3 &&
> +	test_ln_s nitfol path5 &&

This falls into the same category as the one in t3000 above.  The
only thing that matters in this test is path3 and path5 are non
directories so that the former is killed when path3/file3 needs to
be checked out, while path5 will not appear in "ls-files -k" output.
Ideally we would want to test regular files and symlinks as two
different kinds of "non directory" filesystem entities, but on
platforms that lack symbolic links we cannot do so, hence we punt
and create a regular file.

> diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
> index f0d5041..3888519 100755
> --- a/t/t4011-diff-symlink.sh
> +++ b/t/t4011-diff-symlink.sh
> @@ -66,12 +69,12 @@ test_expect_success SYMLINKS 'diff removed symlink and file' '
>  	compare_diff_patch expected current
>  '
>  
> -test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
> +test_expect_success 'diff identical, but newly created symlink and file' '
>  	>expected &&
>  	rm -f frotz nitfol &&
>  	echo xyzzy >nitfol &&
>  	test-chmtime +10 nitfol &&
> -	ln -s xyzzy frotz &&
> +	test_ln_s xyzzy frotz &&
>  	git diff-index -M -p $tree >current &&
>  	compare_diff_patch expected current &&

As the point of test is to compare $tree that has symlink with
another symlink that is identical but newly created one, I think
this _does_ want the filesystem entity to be a symbolic link, but
the index has frotz as a symlink and the mode propagates to what we
read from the filesystem on !has_symlinks systems, so this
conversion may be a correct one, though it is a bit tricky.

> @@ -80,7 +83,7 @@ test_expect_success SYMLINKS 'diff identical, but newly created symlink and file
>  	compare_diff_patch expected current
>  '
>  
> -test_expect_success SYMLINKS 'diff different symlink and file' '
> +test_expect_success 'diff different symlink and file' '
>  	cat >expected <<-\EOF &&
>  	diff --git a/frotz b/frotz
>  	index 7c465af..df1db54 120000
> @@ -100,7 +103,7 @@ test_expect_success SYMLINKS 'diff different symlink and file' '
>  	+yxyyz
>  	EOF
>  	rm -f frotz &&
> -	ln -s yxyyz frotz &&
> +	test_ln_s yxyyz frotz &&
>  	echo yxyyz >nitfol &&
>  	git diff-index -M -p $tree >current &&
>  	compare_diff_patch expected current

Likewise.
