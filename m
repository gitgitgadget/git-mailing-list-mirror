From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add test_repo_expect_success for running tests in a new repository
Date: Mon, 21 Sep 2015 10:38:43 -0700
Message-ID: <xmqq4minbrks.fsf@gitster.mtv.corp.google.com>
References: <1442712302-7912-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:38:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze53C-00086W-EO
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbbIURiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 13:38:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36059 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbbIURip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:38:45 -0400
Received: by padbj2 with SMTP id bj2so12630861pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=SFjOsmbNj59hhP4fPzYR4PVqnECXc7qagVhcJvTcjsA=;
        b=tSrP6FI97dUZ32PcpgJya8lyypnXbabW9J/CqsoCWCvXoD5U5RMFqifcJ/ymIcvKXf
         DRBCQYV8b2/jCqymnJospCtA4D8fQAUQR9s06x75IJjqq3D7h78C2wRHl5iAIQEypjZ9
         kBjCBOrXn1+SVRxVNMwzTSw0o/MfXhR8r5w0X6X+qqVTx44iKVGdct+B5lAZ8O0oXKR6
         cYme+ZjWZyFXz2mGfhHCQFM7FPaprZRVW6ERs76VVwAJOxYK06z7mBsufDxLsHXW76gK
         hBXuicEVji4InRPpEr4gLvygxJq7u7lTWlmO+JZ7DgTHT+A75Ksl6xZy1kopCbBcey0Z
         0ZfA==
X-Received: by 10.68.68.167 with SMTP id x7mr25649491pbt.140.1442857124471;
        Mon, 21 Sep 2015 10:38:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id ip1sm25642981pbc.30.2015.09.21.10.38.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:38:43 -0700 (PDT)
In-Reply-To: <1442712302-7912-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 20
 Sep 2015 08:25:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278317>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This could be convenient when tests are independent from the rest in =
the
> same file. Normally we would do this
>
> test_expect_success '...' '
> 	git init foo &&
> 	(
> 		cd foo &&
> 		<script>
> 	)
> '
>
> Now we can write a shorter version
>
> test_repo_expect_success '...' '
> 	<script>
> '
>
> The other function, test_subdir_expect_success, expands the script to
> "( cd <repo> && <script> )", which can be useful for grouping a serie=
s of
> tests that operate on the same repository in a subdir, e.g.
>
> test_expect_success 'create repo abc' 'test_create_repo abc'
> test_subdir_expect_success abc '...' <script>
> test_subdir_expect_success abc '...' <another-script>
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Lately I start to add more and more tests in this style. So this
>  looks like a good change to me.

Implementations of these helper functions are not all that
interesting for reviewers (except for finding unacceptable bits,
that is), I would think.

More interesting are how much cleaner the existing code would become.
I know we have tons of them that do "create a new, do this and that
in the repository".

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index e8d3c0f..45d7423 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -394,6 +394,26 @@ test_expect_success () {
>  	test_finish_
>  }

Need a good doc here for a function that takes variable number of
parameters in a funny way.

> +test_subdir_expect_success () {
> +	local subdir=3D"$1"

This bash-ism will never be applied to my tree.

> +	shift
> +	case "$#" in
> +		2) test_expect_success "$1" "( cd $subdir && $2 )";;

Mental note: Two-arg form is for title and script.

By the way, unquoted subdir makes it too sloppy to live.

> +		3) test_expect_success "$1" "$2" "( cd $subdir && $3 )";;

Mental note: Three-arg form is for title, prereq and script.

> +		4) test_expect_success "$1" "$2" "$4 && ( cd $subdir && $3 )";;

What the heck is this one?  That is why I said "implementations are
not interesting, the way they help existing ones more readable is".
It is totally unclear where the $4 comes from and has to be given in
a funny order to the helper (and I am sure it will make perfect
sense when it is explained).

> +		*) error "bug in the test script: not 3-5 parameters to test-subdi=
r-expect-success";;

Too deep an indent level here.

> +	esac
> +}
> +
> +test_repo_expect_success () {
> +	local repo=3Drepo-$(($test_count+1))
> +	case "$#" in
> +		2) test_subdir_expect_success "$repo" '' "$1" "$2" "test_create_re=
po $repo";;
> +		3) test_subdir_expect_success "$repo" "$1" "$2" "$3" "test_create_=
repo $repo";;
> +		*) error "bug in the test script: not 2 or 3 parameters to test-re=
po-expect-success";;
> +	esac

I do not like a few things in here (besides the same kind of
unacceptable stuff as the other one).

Often we need a new repository for testing a handful steps, and we
would want to be able to do this sequence:

    - create a new repo
    - do one thing in that repo
    - do another thing in that repo
    - do yet another thing in that repo

That would force tests to say "test_repo_expect_success" to do the
first thing (creating and running the first command) and then
subsequently do "test_subdir_expect_success $there" to run the
remainder. =20

I think we would only want to have test_expect_success_there (I am
avoiding "subdir" because the word has connotations that you do not
want in your use case.  When we say "subdir" we typically do not
mean a separate repository or submodule) without the "auto creation
of a repository with unknown name" bit.

	test_expect_success 'set up a new repository for testing' '
		test_create_repo myrepo
	'

        test_expect_success_there mytest 'do one thing there' '
		>empty &&
                git add empty
                git commit -m "add empty"
	'

        test_expect_success_there mytest 'do another thing there' '
		git ls-files >actual &&
                echo empty >expect &&
                test_cmp expect actual
	'
