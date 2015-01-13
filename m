From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 10:56:32 -0800
Message-ID: <xmqqtwzucxwf.fsf@gitster.dls.corp.google.com>
References: <54B5579B.4080607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6ds-0004CS-DK
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbbAMS4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:56:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808AbbAMS4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:56:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E80C2CFF8;
	Tue, 13 Jan 2015 13:56:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UFTPKj6lZF5eksAmakq4WaCuRQg=; b=YA6zzy
	uodaCq3XHzyYP86OJCM1M1kMP2vxBCcol2gv+x3wBDJJumjZwwuuqsQFK0NWkg75
	aoSBE2DBT/s5CYS+BlsqZW5PQKfSlr+T42+u17sFpzkbLQptEm3I8Mgd23e4pspA
	PMQFZT8J4o9vP10aSllxbcFrqVMHo9aZFrnsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IOA70X1hY3rm2ZiTgSjhCHg0fHwOR1eF
	iz3x6O5QVwO+6yJI7dAlhMprgJOlrxZgifKBm+Ada7YFn84oSzOXefn9gwo2uihQ
	zAPjQjHWbBk/nWVUDTycYQpZBBE4IciSEeRZyCHUEOO4ytTb9VBGps0pYpNB+0Vw
	GsEf0K1XJgI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 534212CFF7;
	Tue, 13 Jan 2015 13:56:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB78E2CFF3;
	Tue, 13 Jan 2015 13:56:33 -0500 (EST)
In-Reply-To: <54B5579B.4080607@kdbg.org> (Johannes Sixt's message of "Tue, 13
	Jan 2015 18:36:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4A3D8EA-9B55-11E4-B275-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262349>

Johannes Sixt <j6t@kdbg.org> writes:

> For some unknown reason, the dd on my Windows box segfaults every now
> and than, but since recently, it does so much more often than it used
> to, which makes running the test suite burdensome.
>
> Get rid of four invocations of dd and use test-genrandom instead.
>
> The new code does change some properties of the generated files:
>
>  - They are a bit smaller.
>  - They are not sparse anymore.
>  - They do not compress well anymore.
>  - The smaller of the four files is now a prefix of the larger.
>
> Fortunately, the tests do not depend on these properties, which would
> have a big influence on the size of the generated pack files. There *is*
> a test in t1050 that checks the size of pack files generated from large
> blobs, but it runs in its own repository with its own set of files (that
> are already generated with test-genrandom!).
>
> To emphasize that three of the large blobs are exact copies, use cp to
> allocate them.
>
> While we are here, replace cmp with test_cmp_bin to document the
> binary-ness of the comparison, which was hinted at by a comment, but not
> stated explicitly.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I won't mind if the first paragraph of the proposed commit message is
>  removed, but without the motivation, this commit reads as if it were
>  merely code churn.

I agree that it is good to see the motivation.  Thanks.

>
>  The existing test-genrandom invocations look like this:
>
>    test-genrandom "a" $(( 66 * 1024 )) >mid1
>
>  I chose not to mimick this style because being precise with the file
>  size is not important for the files generated here.
>
>  t/t1050-large.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index f5a9119..f653121 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -9,10 +9,10 @@ test_expect_success setup '
>  	# clone does not allow us to pass core.bigfilethreshold to
>  	# new repos, so set core.bigfilethreshold globally
>  	git config --global core.bigfilethreshold 200k &&
> -	echo X | dd of=large1 bs=1k seek=2000 &&
> -	echo X | dd of=large2 bs=1k seek=2000 &&
> -	echo X | dd of=large3 bs=1k seek=2000 &&
> -	echo Y | dd of=huge bs=1k seek=2500 &&
> +	test-genrandom seed1 2000000 >large1 &&
> +	cp large1 large2 &&
> +	cp large1 large3 &&
> +	test-genrandom seed2 2500000 >huge &&
>  	GIT_ALLOC_LIMIT=1500k &&
>  	export GIT_ALLOC_LIMIT
>  '
> @@ -61,7 +61,7 @@ test_expect_success 'checkout a large file' '
>  	large1=$(git rev-parse :large1) &&
>  	git update-index --add --cacheinfo 100644 $large1 another &&
>  	git checkout another &&
> -	cmp large1 another ;# this must not be test_cmp
> +	test_cmp_bin large1 another
>  '
>  
>  test_expect_success 'packsize limit' '
> @@ -162,7 +162,7 @@ test_expect_success 'pack-objects with large loose object' '
>  	test_create_repo packed &&
>  	mv pack-* packed/.git/objects/pack &&
>  	GIT_DIR=packed/.git git cat-file blob $SHA1 >actual &&
> -	cmp huge actual
> +	test_cmp_bin huge actual
>  '
>  
>  test_expect_success 'tar achiving' '
