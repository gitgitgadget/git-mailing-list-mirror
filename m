From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 7/7] Improve error handling when parsing dirstat
 parameters
Date: Thu, 28 Apr 2011 11:41:14 -0700
Message-ID: <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-1-git-send-email-johan@herland.net>
 <1303953442-26536-8-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFW9g-0005ZT-Ha
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 20:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab1D1Slb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 14:41:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1D1Sla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 14:41:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D965D43B5;
	Thu, 28 Apr 2011 14:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cjjRlPGQc95aPuVeXhS4u+Ym5TA=; b=cc1SJ5
	FLhM/89/zuHrkujDXiNVnuZlmi4qtllx2LeBENY7KphCjTRfRgaMc4F9V7I+wl0l
	fX3rzEKbvbPIFxIHYcdASyb2EgRXUXVH0zQq+iXsO5eXXgiR9SwNYQwJLu7nHsS6
	fKXqoVs1hAnFensA3UgXPGj+j26yruZ64ktp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXGCkIhR4HAlTpquxLPrHA9cc0j0qiY2
	qEcSc0IZKIu2A82Uj2JOHCLHpl8PmZEn/lQwocCPr7RpRmBStJJYxbaK0kfGi6Ro
	V2ueX9vxq2IxKvbTSHXkQeFFPBXY3yh+1XLcHaAaXLJTThyaHtITDcpp9nytVVLg
	63pVhWF/aeQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3AB443AC;
	Thu, 28 Apr 2011 14:43:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4AD0A43A9; Thu, 28 Apr 2011
 14:43:19 -0400 (EDT)
In-Reply-To: <1303953442-26536-8-git-send-email-johan@herland.net> (Johan
 Herland's message of "Thu, 28 Apr 2011 03:17:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67412A58-71C7-11E0-8C30-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172381>

Johan Herland <johan@herland.net> writes:

> ...
> The patch also adds a couple of tests verifying the correct behavior of
> --dirstat and diff.dirstat in the face of unknown (possibly future) dirstat
> parameters.

Thanks.  Patches 1-6/7 looks much better.

When writing a shiny new feature, people tend to test only the cases they
expect to work, leaving the cases that should error out unspecified,
leading to future confusion.  Negative tests to specify and guard error
behaviour are very important, and I like this 7/7 very much.

Having said that, you might want to add tests for parsing --dirstat/-X
options themselves for the same reason.  I think you had troubles with -X3
(the first round), --dirstat40 (the third round), and possibly -X=3; they
could have been avoided if you had such tests.  They probably should be
added to 1/7.

> diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
> index 8ca1d58..20a59ac 100755
> --- a/t/t4047-diff-dirstat.sh
> +++ b/t/t4047-diff-dirstat.sh
> @@ -932,4 +932,34 @@ test_expect_success 'diff.dirstat=0,lines' '
>  	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
>  '
>  
> +test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
> +	test_must_fail git diff --dirstat=future_param,lines,0 HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
> +	test_cmp /dev/null actual_diff_dirstat &&
> +	grep -q "future_param" actual_error &&
> +	grep -q "\--dirstat" actual_error &&
> +	test_must_fail git diff --dirstat=future_param,lines,0 -M HEAD^..HEAD >actual_diff_dirstat_M 2>actual_error &&
> +	test_cmp /dev/null actual_diff_dirstat_M &&
> +	grep -q "future_param" actual_error &&
> +	grep -q "\--dirstat" actual_error &&
> +	test_must_fail git diff --dirstat=future_param,lines,0 -C -C HEAD^..HEAD >actual_diff_dirstat_CC 2>actual_error &&
> +	test_cmp /dev/null actual_diff_dirstat_CC &&
> +	grep -q "future_param" actual_error &&
> +	grep -q "\--dirstat" actual_error
> +'

I am not sure if three combinations (vanilla, -M and -C -C) need to be
tested to produce an empty result.  If so, it would make it easier to read
if they are split into three tests, or at least have a blank line between
them, but I suspect that you would agree that it is not worth to have
three separate test_expect_success for these.

I also wanted to see the error output.  How about adding:

	test_debug "cat actual_error" &&

immediately after invocation of "git diff"?

The error output shows "error:" followed by "warning:", which looked
somewhat questionable.  Perhaps allow a pointer to a structure be passed
in to describe the nature of a breakage to parse_dirstat_params()?

Telling "grep" that the pattern string is not an option by quoting the
first dash (i.e. "\--dirstat") is clever, and it is more portable than
using an explicit "-e" to accomodate ancient implementations of grep.

	Side note: we seem to already use "grep -e" in some other tests
	(2200, 2204 and 5540).  We probably should get rid of -e from
	these places.

> +test_expect_success 'diff.dirstat=future_param,0,lines should warn, but still work' '
> +	git -c diff.dirstat=future_param,0,lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
> +	test_cmp expect_diff_dirstat actual_diff_dirstat &&
> +	grep -q "future_param" actual_error &&
> +	grep -q "diff.dirstat" actual_error &&

This should avoid matching "." with anything, i.e.

	grep -q "diff\\.dirstat" actual_error &&

 t/t4047-diff-dirstat.sh |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 20a59ac..0942bdb 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -934,32 +934,23 @@ test_expect_success 'diff.dirstat=0,lines' '
 
 test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
 	test_must_fail git diff --dirstat=future_param,lines,0 HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
+	test_debug "cat actual_error" &&
 	test_cmp /dev/null actual_diff_dirstat &&
 	grep -q "future_param" actual_error &&
-	grep -q "\--dirstat" actual_error &&
-	test_must_fail git diff --dirstat=future_param,lines,0 -M HEAD^..HEAD >actual_diff_dirstat_M 2>actual_error &&
-	test_cmp /dev/null actual_diff_dirstat_M &&
-	grep -q "future_param" actual_error &&
-	grep -q "\--dirstat" actual_error &&
-	test_must_fail git diff --dirstat=future_param,lines,0 -C -C HEAD^..HEAD >actual_diff_dirstat_CC 2>actual_error &&
-	test_cmp /dev/null actual_diff_dirstat_CC &&
-	grep -q "future_param" actual_error &&
 	grep -q "\--dirstat" actual_error
 '
 
 test_expect_success 'diff.dirstat=future_param,0,lines should warn, but still work' '
 	git -c diff.dirstat=future_param,0,lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
+	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
 	grep -q "future_param" actual_error &&
-	grep -q "diff.dirstat" actual_error &&
-	git -c diff.dirstat=future_param,0,lines diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M 2>actual_error &&
-	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
-	grep -q "future_param" actual_error &&
-	grep -q "diff.dirstat" actual_error &&
-	git -c diff.dirstat=future_param,0,lines diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC 2>actual_error &&
-	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC &&
-	grep -q "future_param" actual_error &&
-	grep -q "diff.dirstat" actual_error
+	grep -q "diff\\.dirstat" actual_error
+'
+
+test_expect_success 'various ways to misspell --dirstat' '
+	test_must_fail git show --dirstat10,files &&
+	test_must_fail git show -X=20
 '
 
 test_done
