From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also
 "skip"ped
Date: Thu, 26 Feb 2009 00:47:25 -0800
Message-ID: <7v63ixwpnm.fsf@gitster.siamese.dyndns.org>
References: <20090226082918.6adbc565.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 09:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcbvR-0007VY-J8
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 09:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbZBZIrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 03:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZBZIre
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 03:47:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZBZIrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 03:47:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20EC016F1;
	Fri, 27 Feb 2009 03:47:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2C32A16F0; Fri,
 27 Feb 2009 03:47:27 -0500 (EST)
In-Reply-To: <20090226082918.6adbc565.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu, 26 Feb 2009 08:29:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4467ACAE-04AB-11DE-B168-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111539>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch, when the "bad" commit was also "skip"ped and
> when more than one commit was skipped, the "filter_skipped" function
> would have printed something like:

Everybody knows that the problem description that comes at the beginning
of the commit log message talks about the state of the code before the
patch is applied.

Try reading the first sentence without "Before this patch, ".  It still
makes perfect sense and more importantly, it is much more readable.

> bisect_rev=<hash1>|<hash2>
>
> (where <hash1> and <hash2> are hexadecimal sha1 hashes)
>
> and this would have been evaled later as piping "bisect_rev=<hash1>"
> into "<hash2>", which would have failed.

I am a bit worried why this "would have failed" was not noticed.

> So this patch makes the "filter_skipped" function properly quote
> what it outputs, so that it will print something like:
>
> bisect_rev="<hash1>|<hash2>"
>
> which will be properly evaled later.
>
> A test case is added to the test suite.

Thanks.  Fixes before the 1.6.2 release are very much welcomed.

> And while at it, we also remove a spurious space where the
> "exit_if_skipped_commits" function is defined.

Looking at:

$ git grep '^[a-z_A-Z][a-z_A-Z0-9]* *() *{' -- '*.sh' |
  sed -e 's/^[^ (]*/X/' | sort | uniq -c

and then doing the same for only git-bisect.sh, i.e.

$ git grep '^[a-z_A-Z][a-z_A-Z0-9]* *() *{' -- 'git-bisect.sh' |
  sed -e 's/^[^ (]*/X/' | sort | uniq -c

you will notice that git-bisect is an odd-man out that uses 3 "func () {"
and 13 "func() {".  Majority of functions have one SP after the function
name.

If we were to standardize on one style, we should consistently have SP
there.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index dd7eac8..b5da16f 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -224,6 +224,31 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
>  	fi
>  '
>  
> +# $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
> +# and $HASH2 is good,
> +# so we should not be able to tell the first bad commit
> +# among $HASH3 and $HASH4
> +test_expect_success 'bisect skip: with commit both bad and skipped' '
> +	git bisect start &&
> +	git bisect skip &&
> +	git bisect bad &&
> +	git bisect good $HASH1 &&
> +	git bisect skip &&
> +	if git bisect good > my_bisect_log.txt

An unpatched "git-bisect" seems to say "32a594a3 was both good and bad" in
its my_bisect_log.txt .  This makes me suspect that we are forgetting to
check return status after we eval the output from filter_skipped function.
Shouldn't the function should string its commands together with "&&" to
protect it from a breakage like this?

Also, VARS, FOUND and TRIED are not initialized anywhere.  We should
protect ourselves from environment variables the user may have with these
names before starting bisect to break the logic of this code.

Back to the test script.

> +		grep "first bad commit could be any of" my_bisect_log.txt &&
> +		test_must_fail grep $HASH1 my_bisect_log.txt &&
> +		test_must_fail grep $HASH2 my_bisect_log.txt &&

These two are easier to read with ! not test_must_fail; we do not expect
grep to be buggy and dump core ;-)

So perhaps the big loop should be better written like this...

filter_skipped() {
	...
	# Let's parse the output of:
	# "git rev-list --bisect-vars --bisect-all ..."
	eval_rev_list "$_eval" | {
		VARS= FOUND= TRIED=
		while read hash line
		do
			case "$VARS,$FOUND,$TRIED,$hash" in
			1,*,*,*)
				# "bisect_foo=bar" read from rev-list output.
				echo "$hash &&"
				;;
			,*,*,---*)
				# Separator
				;;

			,,,bisect_rev*)
				# We had nothing to search.
				echo "bisect_rev= &&"
				VARS=1
				;;
			,,*,bisect_rev*)
				# We did not find a good bisect rev.
				# This should happen only if the "bad"
				# commit is also a "skip" commit.
				echo "bisect_rev='$TRIED' &&"
				VARS=1
				;;
			,,*,*)
				# We are searching.
				TRIED="${TRIED:+$TRIED|}$hash"
				case "$_skip" in
				*$hash*) ;;
				*)
					echo "bisect_rev=$hash &&"
					echo "bisect_tried='$TRIED' &&"
					FOUND=1
					;;
				esac
				;;

			,1,*,bisect_rev*)
				# We have already found a rev to be tested.
				VARS=1
				;;
			,1,*,*)
				;;
			*) 
				# An unexpected input
				echo "die 'filter_skipped error'"
				echo >&2 \
					"VARS: '$VARS' " \
					"FOUND: '$FOUND' " \
					"TRIED: '$TRIED' " \
					"hash: '$hash' " \
					"line: '$line'"
				;;
			esac
		done
		echo ':'
	}
}
