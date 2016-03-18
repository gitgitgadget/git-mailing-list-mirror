From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] dir.c: fix bug in 'nd/exclusion-regression-fix' topic
Date: Fri, 18 Mar 2016 10:38:04 -0700
Message-ID: <xmqqegb7r8jn.fsf@gitster.mtv.corp.google.com>
References: <56E9F5B3.6030903@fb.com>
	<1458218744-15810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, durham@fb.com, mitrandir@fb.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:38:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agyLm-0000dn-G3
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 18:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbcCRRiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 13:38:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754931AbcCRRiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 13:38:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 267324D934;
	Fri, 18 Mar 2016 13:38:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yIbthlfjJZ0u
	pCLCpVQIbTnplm8=; b=ghHl5kZFVxhkTqoLk3a/YTRNrTVAcVghXwjiXxAg8//Z
	VjMAOa2gXOBQb9yx7HPSMUErq4PcZYm8q5s64i691DuWXOR9VFZGuneelID77cKv
	va4uydK9cnWh51XRpmtsgHBNfvhNtikkcPF7s4lQT0e6J7XlGeuf2P+m69oaxZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lbdRQe
	9Om4SRhYZiX3tgwdG77l0ilGt/GIROM7UgXTiRFLMq/ju1PlNuBmKfE00JbMWoDo
	4+xuyJlwqeBn2wKCF7hRBT0Zf//elblxUR9yzz6zqOjwAdJxbQ6CAm8NG4tdoMEA
	+ISRlO3uRE3/x4maGYdeMdRUHZMV0egO7RpkE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E16F4D933;
	Fri, 18 Mar 2016 13:38:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 621B64D932;
	Fri, 18 Mar 2016 13:38:06 -0400 (EDT)
In-Reply-To: <1458218744-15810-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 17
 Mar 2016 19:45:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C6BE3CA-ED30-11E5-91B7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289235>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The topic in question introduces "sticky" path list for this purpose:
> given a path 'abc/def', if 'abc' already matches a pattern X, it's ad=
ded
> to X's sticky path list. When we need to check if 'abc/def' matches
> pattern X and see that 'abc' is already in the list, we conclude righ=
t
> away that 'abc/def' also matches X.

It took me two reads to realize that I can get what this paragraph
wants to say if I ignore "given a path 'abc/def'" at the beginning.
In short, if we already know that a directory 'abc' matches a
pattern, the pattern remembers that fact in the list and further
queries about anything in that directory, e.g. 'abc/def', is
answered with "we already know abc matches, so it also does match".

"Sticky" is probably better understood if called "ancestor directory".

> The short reason (*) for sticky path list is to workaround limitation=
s
> of matching code that will return "not match" when we compare
> 'abc/def' and pattern X.

If one asks about 'abc/def' first, you ask "does '*' match
'abc/def'?"--if there is a limitation with the matching code, this
list would not work at all as a workaround.  But we can safely
assume that before asking about 'abc/def' we would always ask about
'abc', so it is OK.  Is that what happens here?

> The bug is in this code. Not only it does "when we need to check if
> 'abc/def' matches...", it does an extra thing: if 'foo/bar' is _not_ =
in
> the list, return 'not matched' by bypassing all matching code with th=
e
> "continue;" statement. It should let the remaining code decide match
> status instead.

So once a pattern has a non-empty "sticky" list after examining
'abc' and if you ask about 'foo', because it is not in the list and
instead of saying "it is not in the list, so we need to try matching
the pattern against 'foo' to decide if it matches", it incorrectly
says "'foo' does not match".  Is that what happens here?

An abrupt appearance of 'foo/bar' in the description made me read
the above three times and that is why I dropped '/bar' part in the
above.  The correctness of the 'sticky' hack seems to depend on the
assumption that we would always ask about 'foo' before asking about
'foo/bar', so the scenario presented with 'foo/bar' is implausible;
even when asking about 'foo/bar', we would have 'foo' in the list,
no?

The remainder, assuming that I read the above correctly, made sense
to me and justifies what the update code does.

Thanks.

> This bug affects both .gitignore and sparse checkout, but it's report=
ed
> as a sparse checkout bug, so let's examine how it happens. The
> sparse-checkout pattern has two rules
>
>     /*
>     !one/hideme
>
> and the worktree has three tracked files, one/hideme, one/showme and
> two/showme. What happens is this
>
> * check "one", it matches the first pattern -> positive -> keep
>   examining.
>
> *1* "thanks" to 'nd/exclusion-regression-fix' we detect this pair of
>   patterns, so we put "one" in the sticky list of pattern "/*"
>
> * enter "one", check "one/hideme", it matches the second pattern
>   first (we search from bottom up) -> negative -> excluded
>
> * check "one/showme", it does not match the second pattern.
>
> *2* We then check it against the first pattern and notice the sticky =
list
>   that includes "one", so we decide right away that "one/showme" is
>   included.
>
> * leave "one", check "two" which does not match the second pattern.
>
> *3* then we check "two" against the first pattern and notice that thi=
s
>    pattern has a non-empty sticky list, which contains "one", not "tw=
o".
>    This bug kicks in and bypasses the true matching logic for pattern
>    "/*". As a result, we exclude "two/showme".
>
> One may notice that the order of these steps matter. If *3* occurs
> before *1*, then the sticky list at that moment is empty and the bug
> does not kick in. Sparse checkout always examines entries in
> alphabetical order, so "abc/showme" would be examined before "one" an=
d
> not hit this bug!
>
> The last remark is important when we move to .gitignore. We receive t=
he
> list of entries with readdir() and cannot control the order of
> entries. Which means we can't write a test for .gitignore that will
> reliably fail without this fix. Which is why this patch only adds a t=
est
> for sparse checkout, even though the same above steps happen to
> .gitignore.
>
> (*) The problem is known and will be fixed later and described in
> detail then. For this commit, it's sufficient to see the following
> link because the long reason is really long:
>
> http://article.gmane.org/gmane.comp.version-control.git/288479
>
> Reported-by: Durham Goode <durham@fb.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c                                |  1 -
>  t/t1011-read-tree-sparse-checkout.sh | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 69e0be6..77f38a5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_fr=
om_list(const char *pathname,
>  				exc =3D x;
>  				break;
>  			}
> -			continue;
>  		}
> =20
>  		if (x->flags & EXC_FLAG_MUSTBEDIR) {
> diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree=
-sparse-checkout.sh
> index 0c74bee..ecc5e93 100755
> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -274,4 +274,24 @@ test_expect_success 'checkout with --ignore-skip=
-worktree-bits' '
>  	git diff --exit-code HEAD
>  '
> =20
> +test_expect_success 'sparse checkout and dir.c sticky bits' '
> +	git init sticky &&
> +	(
> +		cd sticky &&
> +		mkdir one two &&
> +		touch one/hideme one/showme two/showme &&
> +		git add . &&
> +		git commit -m initial &&
> +		cat >.git/info/sparse-checkout <<-\EOF &&
> +		/*
> +		!one/hideme
> +		EOF
> +		git config core.sparsecheckout true &&
> +		git checkout &&
> +		test_path_is_missing one/hideme &&
> +		test_path_is_file    one/showme &&
> +		test_path_is_file    two/showme
> +	)
> +'
> +
>  test_done
