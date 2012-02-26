From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow Overriding GIT_BUILD_DIR
Date: Sun, 26 Feb 2012 14:19:28 -0800
Message-ID: <7vpqd1dyq7.fsf@alter.siamese.dyndns.org>
References: <87vcmu5psm.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 23:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1mRN-0005RL-2g
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 23:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab2BZWTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 17:19:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab2BZWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 17:19:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B5E16D92;
	Sun, 26 Feb 2012 17:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C4/QF1UpdKM19dhvkrYRfVGF7ZU=; b=RG4g2U
	7jLvrVtrpg2riT/+HZoqvQ9+YeSG4+C34jkg3PdBsDXnTyWyLmTe26+v2Rj/m41N
	g7UVrEw3Kz9rtyRGkobuBxZjgkE6Sah1U+l1XfPDNqbb4tQhdbLyNcZwMq8yP5ay
	Jqs+5LNScUP4r4lnOdwBlNTyfyYaeC3iRDXuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyuTgeCATMg6wqOWA3hNikLrPBeLBt08
	UmV1SUCf3L4XtkvCT7zArIhT6W5Tyh1vuoz90rM6gaEv9RjkTDp5I0QUXk6IaYgb
	jsW576CTqLD5hSoWxaPP4XCX68L/Q7W2D5S697cLFM8V1TTL6tISc5KaH3NxmMP9
	x2lMimCkxUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8243C6D91;
	Sun, 26 Feb 2012 17:19:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA3066D8F; Sun, 26 Feb 2012
 17:19:29 -0500 (EST)
In-Reply-To: <87vcmu5psm.fsf@smith.obbligato.org> (David A. Greene's message
 of "Sun, 5 Feb 2012 16:28:06 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F39272F6-60C7-11E1-83EA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191578>

"David A. Greene" <greened@obbligato.org> writes:

> Let tests override GIT_BUILD_DIR so git will work if tests are not at
> the same directory level as standard git tests.  Prior to this change,
> GIT_BUILD_DIR is hardwired to be exactly one directory above where the
> test lives.  A test within contrib/, for example, can now use
> test-lib.sh and set an appropriate value for GIT_BUILD_DIR.

Ok, this is getting closer. We use GIT_BUILD_DIR to find out crucial bits
of the build environment in order to run tests, like the binaries being
tested that are in $GIT_BUILD_DIR/bin-wrappers, but we set GIT_BUILD_DIR
always to one level above where the test script being run is (because they
are typically t/t1234-name.sh).  By making them able to name GIT_BUILD_DIR
directly to a place that is different from a level above "$TEST_DIRECTORY",
a test script can live anywhere.

There are two more things that worries me a bit.

One is what TEST_DIRECTORY should mean in the new world order.  We use it
to find where the test-lib.sh and other lib-*.sh helper definitions are,
also we use it to find large-ish test vectors like t3900/ and t4013/.  If
an external test script t1234-git-subtree.sh wants to use a separate file
to keep its own helper definitions, how should it name it?  It cannot be
relative to TEST_DIRECTORY that is typically "t/".  It cannot be relative
to "../" as TRASH_DIRECTORY where the script runs, as the --root option
may move it elsewhere on the filesystem (and is the reason TEST_DIRECTORY
variable exists in the first place).

And how well does an external test script work with the --root option that
moves the TEST_DIRECTORY?

> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  t/test-lib.sh |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
>
> ------------------
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a65dfc7..4585138 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -55,6 +55,7 @@ unset $(perl -e '
>  		.*_TEST
>  		PROVE
>  		VALGRIND
> +                BUILD_DIR

A funny    indentation found here.

>  	));

> @@ -901,7 +902,14 @@ then
>  	# itself.
>  	TEST_DIRECTORY=$(pwd)
>  fi
> -GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> +
> +if test -z "$GIT_BUILD_DIR"
> +then
> +	# We allow tests to override this, in case they want to run tests
> +	# outside of t/, e.g. for running tests on the test library
> +	# itself.

# For in-tree test scripts, this is one level above the TEST_DIRECTORY
# (t/), but a test script that lives outside t/ can set this variable to
# point at the right place so that it can find t/ directory that house
# test helpers like lib-pager*.sh and test vectors like t4013/.

> +        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> +fi
>  
>  if test -n "$valgrind"
>  then
>
> --------------------
