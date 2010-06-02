From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/18] tests: use "test_cmp", not "diff", when
 verifying the result
Date: Tue, 01 Jun 2010 21:39:24 -0700
Message-ID: <7vy6eyoxoj.fsf@alter.siamese.dyndns.org>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093751.825924000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:39:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfju-0002DL-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0FBEjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:39:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0FBEjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:39:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0F5B6EEF;
	Wed,  2 Jun 2010 00:39:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nHYH/M4YzullTM/xrqNW/BWSCkM=; b=ngXWsD00R6bMIoYI6H2Ym9J
	kLiTQOjsjrDj8NZ38tAg8CLolK1UCsMNSNXbxdOiWIeHQpsJbQjqEk5e56yeGVK0
	Mzx3c9CeRNpB4aTLh2nNmosr9oMqxZyG1bmbSM2bHkPdv0eVsJFWbbZCQwm1AZuo
	qTBEf++QTNdLZOdXRYx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xH4AmDsxApLCeYiUdzyKjbjbv3Njrh024DimHYXkNMzBwf3+R
	L6URnwzkO9avvWS9leztDgtfR/n79vvBGn3FkMHfEgo9BDGSEwmIjCF3Xa7BB+ev
	3tlnKHefWN6DyMrYgU8JuI/J7vy829QvVhfLK/Nye/uxRcqHbo+dKe8mtM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA1ABB6EEE;
	Wed,  2 Jun 2010 00:39:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFC26B6EEA; Wed,  2 Jun
 2010 00:39:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D48A7FCC-6E00-11DF-8075-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148195>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> In tests, call test_cmp rather than raw diff where possible (i.e. if
> the output does not go to a pipe), to allow the use of, say, 'cmp'
> when the default 'diff -u' is not compatible with a vendor diff.
>
> When that is not possible, use $DIFF, as set in GIT-BUILD-OPTIONS.

Both are very worthy goal.

> Index: b/t/t0000-basic.sh
> ===================================================================
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
>  EOF
>  test_expect_success \
>      'validate git diff-files output for a know cache/work tree state.' \
> -    'git diff-files >current && diff >/dev/null -b current expected'
> +    'git diff-files >current && test_cmp current expected >/dev/null'

... and I think we could lose >/dev/null redirection once we rewrite these
using test_cmp, but that can be a separate patch.

> Index: b/t/Makefile
> ===================================================================
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -6,10 +6,14 @@
>  -include ../config.mak
>  
>  #GIT_TEST_OPTS=--verbose --debug
> +GIT_TEST_CMP ?= $(DIFF)
>  SHELL_PATH ?= $(SHELL)
>  TAR ?= $(TAR)
>  RM ?= rm -f
>  
> +# Make sure test-lib.sh uses make's value of GIT_TEST_CMP
> +export GIT_TEST_CMP
> +
>  # Shell quote;
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))

But isn't this a regression?  When GIT_TEST_CMP is not defined, we used to

    GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}

which in turn is used like this:

    test_cmp() {
            $GIT_TEST_CMP "$@"
    }

so people would get a more readable "diff -u" output when GIT_TEST_CMP is
not defined and exported.  With your patch we would lose -u everywhere,
no?

Also even if your vendor diff lacks unified context format, I would
presume that it would support good old copied context format with -c, and
it would give us a better readability.

How about doing something like this on top of your patch?

Your 7/18 will instead be setting "GIT_TEST_CMP_USE_COPIED_CONTEXT =
YesPlease" for (hopefully) most of the targets whose native "diff" knows
copied context format, and others will set GIT_TEST_CMP to cmp, perhaps?

---
 Makefile      |    4 ++++
 t/Makefile    |    4 ----
 t/test-lib.sh |   11 ++++++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 668dbc9..c8cc9e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1374,6 +1374,10 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
+ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
+	export GIT_TEST_CMP_USE_COPIED_CONTEXT
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/t/Makefile b/t/Makefile
index 93a6475..25c559b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -6,14 +6,10 @@
 -include ../config.mak
 
 #GIT_TEST_OPTS=--verbose --debug
-GIT_TEST_CMP ?= $(DIFF)
 SHELL_PATH ?= $(SHELL)
 TAR ?= $(TAR)
 RM ?= rm -f
 
-# Make sure test-lib.sh uses make's value of GIT_TEST_CMP
-export GIT_TEST_CMP
-
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..a290011 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -63,7 +63,16 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
-GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
+
+if test -z "$GIT_TEST_CMP"
+then
+	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
+	then
+		GIT_TEST_CMP="$DIFF -c"
+	else
+		GIT_TEST_CMP="$DIFF -u"
+	fi
+fi
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
