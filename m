From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 06 Sep 2010 16:16:27 -0700
Message-ID: <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
References: <4C85357A.8090000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oskvm-0001rn-L4
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab0IFXQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:16:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab0IFXQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:16:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FBED314D;
	Mon,  6 Sep 2010 19:16:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sXg8M1aIArcpdDkjx9ctJNma0Fs=; b=YHG5Kr
	LtDbyMKZQMFkUdaS5L2QwC472hwiQjwomsnIfw74ynA/Vk6hkBzLbnNib1bBdg1A
	fRaziBEexHspvjJRpfZSPZtpSo9knvRR75Lqsz2zcGVo2S4Rj8tItY3SVZtY/nYA
	jD05DsaCKXVoXgQk9wodLid1DfLoE4NunYvYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bU06aM2EmhF+esWIVhNu65EtzzU5P61h
	WVRTH0rAj/NyLsLXfPXKJWX34ub+ID1I/QKurAZPTQJ/uwSkko3ScjfaGxlJSJDv
	EynuKABVZHy0m91kNS67G1/rItzfV4hK+CGSucm/3a/qwfd83sOlKXDnllGClpR5
	yt/iuu45Hzw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBCF4D314C;
	Mon,  6 Sep 2010 19:16:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D881AD3149; Mon,  6 Sep
 2010 19:16:28 -0400 (EDT)
In-Reply-To: <4C85357A.8090000@web.de> (Jens Lehmann's message of "Mon\, 06
 Sep 2010 20\:39\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8E7FF98-BA0C-11DF-B26D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155638>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Fixed all places where it was a straightforward change from cd'ing into a
> directory and back via "cd .." to a cd inside a subshell.
>
> Found these places with "git grep -w "cd \.\.".
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Thanks; that is a huge effort of cleaning things up.

> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 5687499..c36157a 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -27,13 +27,13 @@ test_expect_success 'update-index and ls-files' '
>  	one) echo pass one ;;
>  	*) echo bad one; exit 1 ;;
>  	esac &&
> -	cd dir &&
> +	(cd dir &&
>  	git update-index --add two &&
>  	case "`git ls-files`" in
>  	two) echo pass two ;;
>  	*) echo bad two; exit 1 ;;
> -	esac &&
> -	cd .. &&
> +	esac
> +	) &&
>  	case "`git ls-files`" in
>  	dir/two"$LF"one) echo pass both ;;
>  	*) echo bad; exit 1 ;;

If we were to do this, shouldn't we be able to lose 'cd "$HERE"' at the
beginning of each test?  The test after this one does "cd dir" without
even coming back up and relies on the next one to go back itself,
suggesting that grepping for 'cd ..' may not be sufficient, depending on
what we are trying to fix.

If we were to insist that no matter how an individual test fail, the test
that follows it must start in a known location (namely, $TRASH), then we
might want to use something like the attached patch.  On the other hand,
we might want to be lenient to a test suite whose one test moves around
and the test that follows such a test knows that, and also anticipates
that the previous one _can_ fail and tries recover from that failure (e.g.
use of 'cd "$HERE"' in the test that follows the above one.

Thoughts?


 t/test-lib.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 29fd720..f07f275 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -432,10 +432,14 @@ test_expect_success () {
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
 	if ! test_skip "$@"
 	then
+		test ",$TRASH_DIRECTORY" = ",$(pwd)" ||
+		error "bug in the test script: starting from a different directory"
 		say >&3 "expecting success: $2"
 		test_run_ "$2"
 		if [ "$?" = 0 -a "$eval_ret" = 0 ]
 		then
+			test ",$TRASH_DIRECTORY" = ",$(pwd)" ||
+			error "bug in the test script: moved to a different directory"
 			test_ok_ "$1"
 		else
 			test_failure_ "$@"
