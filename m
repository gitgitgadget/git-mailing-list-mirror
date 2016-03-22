From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t1300: fix the new --show-origin tests on Windows
Date: Tue, 22 Mar 2016 11:13:03 -0700
Message-ID: <xmqq37riidow.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<a43d6d1f46a90eea9083f329ad0dfb17915c38a1.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:13:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQno-0000Qt-Db
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcCVSNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:13:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901AbcCVSNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:13:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 180114F217;
	Tue, 22 Mar 2016 14:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AQL1cNTMA6snV4I6I5/avLn+Op8=; b=VikqbK
	QBRr41vDyB/FJFUeBAgmlarQ61athRY9kwsGdL3rKrwt9wJ17cWWwocWPUlCzjig
	W8ECnfcWgO0eDNNteG78x7BH4K9qP0BgEiIdIBGCWfby8c0uCshoxCtj/6/JYcWk
	KYMMslck2w0kLPbBYEhScFFA48UBN8QanS4gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVWlH35Rs3/ALZA/1QD8+iFIZANb778x
	o6hpL9iGhRFTotBYCLSQMnk+CK5ZVFBhrHZuhClmyHFWDzZEy+xVOa6Hb9fuoUA8
	1heHzZ0W6Z/V22o0d1/RTxCGeiBsab7/4krzbH2C8xwJ7tx3LpgM4UC+YfzNs4ZY
	tjWwIjZogVw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E3544F216;
	Tue, 22 Mar 2016 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 704174F215;
	Tue, 22 Mar 2016 14:13:04 -0400 (EDT)
In-Reply-To: <a43d6d1f46a90eea9083f329ad0dfb17915c38a1.1458668543.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 22 Mar 2016 18:42:55 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8A75528-F059-11E5-B542-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289539>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, we have that funny situation where the test script can refer
> to POSIX paths because it runs in a shell that uses a POSIX emulation
> layer ("MSYS2 runtime"). Yet, git.exe does *not* understand POSIX paths
> at all but only pure Windows paths.
>
> So let's just convert the POSIX paths to Windows paths before passing
> them on to Git, using `pwd` (which is already modified on Windows to
> output Windows paths).
>
> While fixing the new tests on Windows, we also have to exclude the tests
> that want to write a file with a name that is illegal on Windows
> (unfortunately, there is more than one test trying to make use of that
> file).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1300-repo-config.sh | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 0236fe2..18eb769 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1232,6 +1232,15 @@ test_expect_success 'set up --show-origin tests' '
>  	EOF
>  '
>  
> +if test_have_prereq MINGW
> +then
> +	# convert to Windows paths
> +	HOME="$(pwd)"

We override HOME in t/test-lib.sh; shouldn't this be done there?

> +	INCLUDE_DIR="$HOME/include"

I am puzzled. 'set up --show-origin tests' do say INCLUDE_DIR is
"$HOME/include" already, so why is this needed?

> +	export HOME INCLUDE_DIR

Existing tests use $INCLUDE_DIR (and $HOME) as shell variables just
fine without exporting.  Why do these need to be exported only on
MINGW?

> +	git config -f .gitconfig include.path "$INCLUDE_DIR/absolute.include"
> +fi

Perhaps if you adjust HOME before 'set up --show-origin tests' test,
most (or all) of the above become unnecessary?

The changes below that skip tests that relies on pathnames that
cannot be used on Windows makes sense, though.

>  test_expect_success '--show-origin with --list' '
>  	cat >expect <<-EOF &&
>  		file:$HOME/.gitconfig	user.global=true
> @@ -1304,7 +1313,7 @@ test_expect_success 'set up custom config file' '
>  	EOF
>  '
>  
> -test_expect_success '--show-origin escape special file name characters' '
> +test_expect_success !MINGW '--show-origin escape special file name characters' '
>  	cat >expect <<-\EOF &&
>  		file:"file\" (dq) and spaces.conf"	user.custom=true
>  	EOF
> @@ -1333,7 +1342,7 @@ test_expect_success '--show-origin stdin with file include' '
>  	test_cmp expect output
>  '
>  
> -test_expect_success '--show-origin blob' '
> +test_expect_success !MINGW '--show-origin blob' '
>  	cat >expect <<-\EOF &&
>  		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
>  	EOF
> @@ -1342,7 +1351,7 @@ test_expect_success '--show-origin blob' '
>  	test_cmp expect output
>  '
>  
> -test_expect_success '--show-origin blob ref' '
> +test_expect_success !MINGW '--show-origin blob ref' '
>  	cat >expect <<-\EOF &&
>  		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
>  	EOF
