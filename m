From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/3] cat-file: add --follow-symlinks to --batch
Date: Sun, 10 May 2015 09:06:32 +0200
Message-ID: <554F0378.2070803@kdbg.org>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com> <1431203769-11855-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sun May 10 09:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrLM0-0007Eu-6G
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 09:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbEJHIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 03:08:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:33863 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752545AbbEJHGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 03:06:37 -0400
X-Greylist: delayed 135998 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2015 03:06:37 EDT
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lkxJp0NSqz5tlB;
	Sun, 10 May 2015 09:06:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 16CBD51E0;
	Sun, 10 May 2015 09:06:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1431203769-11855-3-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268725>

Am 09.05.2015 um 22:36 schrieb dturner@twopensource.com:
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ab36b1e..dd80c08 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -189,6 +189,13 @@ do
>       '
>   done
>
> +for opt in t s e p
> +do
> +    test_expect_success "Passing -$opt with --follow-symlinks fails" '
> +	    test_must_fail git cat-file --follow-symlinks -$opt $hello_sha1
> +	'
> +done
> +
>   test_expect_success "--batch-check for a non-existent named object" '
>       test "foobar42 missing
>   foobar84 missing" = \
> @@ -296,4 +303,187 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>   	}
>   '
>
> +# Tests for git cat-file --follow-symlinks
> +test_expect_success 'prep for symlink tests' '
> +	echo_without_newline "$hello_content" > morx &&
> +	ln -s morx same-dir-link &&
> +	ln -s ../fleem out-of-repo-link &&
> +	ln -s .. out-of-repo-link-dir &&
> +	ln -s same-dir-link link-to-link &&
> +	ln -s nope broken-same-dir-link &&
> +	mkdir dir &&
> +	ln -s ../morx dir/parent-dir-link &&
> +	ln -s .. dir/link-dir &&
> +	ln -s ../../escape dir/out-of-repo-link &&
> +	ln -s ../.. dir/out-of-repo-link-dir &&
> +	ln -s nope dir/broken-link-in-dir &&
> +	mkdir dir/subdir &&
> +	ln -s ../../morx dir/subdir/grandparent-dir-link &&
> +	ln -s ../../../great-escape dir/subdir/out-of-repo-link &&
> +	ln -s ../../.. dir/subdir/out-of-repo-link-dir &&
> +	ln -s ../../../ dir/subdir/out-of-repo-link-dir-trailing &&
> +	ln -s ../parent-dir-link dir/subdir/parent-dir-link-to-link &&
> +	echo_without_newline "$hello_content" >dir/subdir/ind2 &&
> +	echo_without_newline "$hello_content" >dir/ind1 &&
> +	ln -s dir dirlink &&
> +	ln -s dir/subdir subdirlink &&
> +	ln -s subdir/ind2 dir/link-to-child &&
> +	ln -s dir/link-to-child link-to-down-link &&
> +	ln -s dir/.. up-down &&
> +	ln -s dir/../ up-down-trailing &&
> +	ln -s dir/../morx up-down-file &&
> +	ln -s dir/../../morx up-up-down-file &&
> +	ln -s subdirlink/../../morx up-two-down-file &&
> +	ln -s loop1 loop2 &&
> +	ln -s loop2 loop1 &&
> +	git add . &&
> +	git commit -am "test"
> +'

These tests will fail on a file system that does not support symbolic 
links, such as on Windows. Would you please separate the test cases 
(that come after the setup) into two groups:

1. Those that inspect the filesystem and expect a symbolic link. Protect 
these tests with a SYMLINKS prerequisite.

2. Those that look only at repository or index contents and do not 
require a symbolic link on the file system. These do not need to be 
protected.

Note that you do not require a symlink enabled file system to generate a 
repository with symlinks, i.e., you don't have to protect the setup code 
with SYMLINKS. For this, you can use 'test_ln_s_add' instead of the 
above sequence of 'ln -s' followed by a single 'git add .'.

> +
> +echo $hello_sha1 blob $hello_size > found

This seems to be used only in the next test. Please move it inside 
test_expect_success.

> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for non-links' '
> +	echo HEAD:morx | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo HEAD:nope missing > expect &&
> +	echo HEAD:nope | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for in-repo, same-dir links' '
> +	echo HEAD:same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for broken in-repo, same-dir links' '
> +	echo HEAD:broken-same-dir-link missing > expect &&
> +	echo HEAD:broken-same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for same-dir links-to-links' '
> +	echo HEAD:link-to-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for parent-dir links' '
> +	echo HEAD:dir/parent-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo HEAD:dir/parent-dir-link/nope missing > expect &&
> +	echo HEAD:dir/parent-dir-link/nope | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for .. links' '
> +	echo HEAD:dir/link-dir/nope missing > expect &&
> +	echo HEAD:dir/link-dir/nope | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:dir/link-dir/morx | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo HEAD:dir/broken-link-in-dir missing > expect &&
> +	echo HEAD:dir/broken-link-in-dir | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for ../.. links' '
> +	echo HEAD:dir/subdir/grandparent-dir-link/nope missing > expect &&
> +	echo HEAD:dir/subdir/grandparent-dir-link/nope | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:dir/subdir/grandparent-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo HEAD:dir/subdir/parent-dir-link-to-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/ links' '
> +	echo HEAD:dirlink/morx missing > expect &&
> +	echo HEAD:dirlink/morx | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo $hello_sha1 blob $hello_size > expect &&
> +	echo HEAD:dirlink/ind1 | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/subdir links' '
> +	echo HEAD:subdirlink/morx missing > expect &&
> +	echo HEAD:subdirlink/morx | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:subdirlink/ind2 | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir -> subdir links' '
> +	echo HEAD:dir/link-to-child/morx missing > expect &&
> +	echo HEAD:dir/link-to-child/morx | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:dir/link-to-child | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo HEAD:link-to-down-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks' '
> +	echo symlink 8 > expect &&
> +	echo ../fleem >> expect &&
> +	echo HEAD:out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo symlink 2 > expect &&
> +	echo .. >> expect &&
> +	echo HEAD:out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in dirs' '
> +	echo symlink 9 > expect &&
> +	echo ../escape >> expect &&
> +	echo HEAD:dir/out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo symlink 2 > expect &&
> +	echo .. >> expect &&
> +	echo HEAD:dir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in subdirs' '
> +	echo symlink 15 > expect &&
> +	echo ../great-escape >> expect &&
> +	echo HEAD:dir/subdir/out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo symlink 2 > expect &&
> +	echo .. >> expect &&
> +	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo symlink 3 > expect &&
> +	echo ../ >> expect &&
> +	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
> +	echo HEAD: | git cat-file --batch-check > expect &&
> +	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual &&
> +	echo symlink 7 > expect &&
> +	echo ../morx >> expect &&
> +	echo HEAD:up-up-down-file | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual &&
> +	echo HEAD:up-two-down-file | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp found actual
> +'
> +
> +test_expect_success 'git cat-file --batch-check --follow-symlink breaks loops' '
> +	echo HEAD:loop1 missing > expect &&
> +	echo HEAD:loop1 | git cat-file --batch-check --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch --follow-symlink returns correct sha and mode' '
> +	echo HEAD:morx | git cat-file --batch > expect &&
> +	echo HEAD:morx | git cat-file --batch --follow-symlinks > actual &&
> +	test_cmp expect actual
> +'
>   test_done
>

-- Hannes
