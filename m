From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in t1508
Date: Sun, 24 Jan 2016 18:03:40 -0800
Message-ID: <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Braun <thomas.braun@byte-physics.de>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:04:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWVy-0005ym-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbcAYCDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 21:03:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752543AbcAYCDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 21:03:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02BFD3F2C8;
	Sun, 24 Jan 2016 21:03:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I0D+S9kzVTsBhwM3FhtXiWGNlmc=; b=YyzohE
	i6Oq/m6cC0R8aoXrv4j7zD+mCPrXB1KicVw3ZUETfMXv80nHiGcXuEXvMdBfc/zR
	aNQheUmH6j+LxyFn9th4lQ6OIMPl6FQnxQXvXMCgmhNQCdDIGGBXV2bVpMu9Rt0A
	M1eQENvXNLHhtOQl2wsse1gV2Lqs4tA6LAD10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NMoXGCoMrX0+me8I2pmvhZ67xyMlLyMx
	j5QqWJ7pTmErWOWLM1thGu2RgncAFDky94yLB9pHulVq6ZrdO6d6FcTYd+gUki+S
	cVgokcnXlUIn98NtWv1R+a38P+6MVH9W0jR6b5IROgzAWwwPaM6RO8FhDekjcLfR
	PSs8iIAaoOA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E400C3F2C7;
	Sun, 24 Jan 2016 21:03:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5522E3F2C5;
	Sun, 24 Jan 2016 21:03:41 -0500 (EST)
In-Reply-To: <1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:45:09 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB27107C-C307-11E5-9F18-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284709>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Thomas Braun <thomas.braun@byte-physics.de>
>
> A string of the form "@/abcd" is considered a file path
> by the msys layer and therefore translated to a Windows path.
>
> Here the trick is to double the slashes.
>
> The MSYS2 patch translation can be studied by calling
>
> 	test-path-utils print_path <path>
>
> Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This feels wrong.

The point of this test is that you can ask to checkout a branch
whose name is a strangely looking "@/at-test", and a ref whose name
is "refs/heads/@/at-test" indeed is created.

The current "checkout" may be lazy and not signal an error for a
branch name with two consecutive slashes, but I wouldn't be
surprised if we tighten that later, and more importantly, I do not
think we ever promised users if you asked a branch "a//b" to be
created, we would create "refs/heads/a/b".

The new test hardcodes and promises such an incompatible behaviour,
i.e. a request to create "@//b" results in "@/b" created, only to
users on MINGW, fracturing the expectations of the Git userbase.

Wouldn't it be better to declare "On other people's Git, @/foo is
just as normal a branch name as a/foo, but on MINGW @/foo cannot be
used" by skipping some tests using prerequisites instead?


>  t/t1508-at-combinations.sh | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 078e119..1d9fd7b 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -29,13 +29,22 @@ fail() {
>  	"$@" failure
>  }
>  
> +if test_have_prereq MINGW
> +then
> +	# MSYS2 interprets `@/abc` to be a file list, and wants to substitute
> +	# the Unix-y path with a Windows one (e.g. @C:\msys64\abc)
> +	AT_SLASH=@//at-test
> +else
> +	AT_SLASH=@/at-test
> +fi
> +
>  test_expect_success 'setup' '
>  	test_commit master-one &&
>  	test_commit master-two &&
>  	git checkout -b upstream-branch &&
>  	test_commit upstream-one &&
>  	test_commit upstream-two &&
> -	git checkout -b @/at-test &&
> +	git checkout -b $AT_SLASH &&
>  	git checkout -b @@/at-test &&
>  	git checkout -b @at-test &&
>  	git checkout -b old-branch &&
> @@ -64,7 +73,7 @@ check "@{-1}@{u}@{1}" commit master-one
>  check "@" commit new-two
>  check "@@{u}" ref refs/heads/upstream-branch
>  check "@@/at-test" ref refs/heads/@@/at-test
> -check "@/at-test" ref refs/heads/@/at-test
> +check "$AT_SLASH" ref refs/heads/@/at-test
>  check "@at-test" ref refs/heads/@at-test
>  nonsense "@{u}@{-1}"
>  nonsense "@{0}@{0}"
