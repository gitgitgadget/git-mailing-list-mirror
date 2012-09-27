From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: diff.context configuration gives default to -U
Date: Thu, 27 Sep 2012 15:18:08 -0700
Message-ID: <7v3923p0tb.fsf@alter.siamese.dyndns.org>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com>
 <7vobl82u26.fsf@alter.siamese.dyndns.org>
 <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com>
 <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
 <B358ACEB-83C2-45C6-887F-D85C25A3496E@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Muizelaar <jmuizelaar@mozilla.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:18:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THMPX-0000Eh-E5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab2I0WSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 18:18:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab2I0WSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 18:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6BD98504;
	Thu, 27 Sep 2012 18:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pf4NEl28XCHO3NumfKslVp0stmI=; b=PE4NIN
	Bn9G/oc9vs60l16C5ZqwnwmjTymiEqiUOZI6o9uCunsZPQI5OVYdl/izfufvbMAi
	NOVME6wF0GYpWU6qi71S5mOo5+97He7ofl/krlasyGqkTQ3HA4zj6WA71FXZey4O
	dbJ/z1qRPEgVA3Mau2zfY1e7lcRRyK6uJSlrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XM0y2ymIlMSHqDPSH9kqijupWASVCTKv
	fCtkCKt92T7uxKEIJeBPvPIYS/g5vTV3yPAqcMWb7NNoLT5JknKl0bfs7m7Exksa
	bkUyc3GEFWKbpu5sXHp9UCuSjr+hO1eK7eS7x3ndXMJmkshHy1mztNckQI7KKs+Q
	61N/j3Qqvi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F448503;
	Thu, 27 Sep 2012 18:18:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CA1D8502; Thu, 27 Sep 2012
 18:18:09 -0400 (EDT)
In-Reply-To: <B358ACEB-83C2-45C6-887F-D85C25A3496E@mozilla.com> (Jeff
 Muizelaar's message of "Thu, 27 Sep 2012 15:12:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3818E4D8-08F1-11E2-97AB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206524>

Jeff Muizelaar <jmuizelaar@mozilla.com> writes:

> +	if (!strcmp(var, "diff.context")) {
> +		diff_context_default = git_config_int(var, value);
> +		if (diff_context_default < 0)
> +			return -1;
> +		return 0;

I am somewhat torn on this part. This fails the entire command when
diff.context is set to non integer or negative integer, which means
trouble for a user of a future version of git that accepts such a
value to do something intelligent we do not anticipate today. The
useful configuration value cannot be given unless the user is
certain that .gitconfig file will never be read by older version of
git.

Perhaps it is OK, at least for now.  We'd have the same worry for
what is given to -U<n> anyway.

> +	}
>  	if (!strcmp(var, "diff.renames")) {
>  		diff_detect_rename_default = git_config_rename(var, value);
>  		return 0;
> @@ -3170,7 +3177,7 @@ void diff_setup(struct diff_options *options)
>  	options->break_opt = -1;
>  	options->rename_limit = -1;
>  	options->dirstat_permille = diff_dirstat_permille_default;
> -	options->context = 3;
> +	options->context = diff_context_default;
>  	DIFF_OPT_SET(options, RENAME_EMPTY);
>  
>  	options->change = diff_change;
> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> new file mode 100755
> index 0000000..8a31448
> --- /dev/null
> +++ b/t/t4055-diff-context.sh
> @@ -0,0 +1,128 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Mozilla Foundation
> +#
> +
> +test_description='diff.context configuration'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	cat >x <<-EOF &&
> +firstline
> +b
> +...
> +n
> +EOF
> +	git update-index --add x &&
> +	git commit -m initial &&
> +	cat >x <<-\EOF &&
> +firstline
> +b

The dash after here-document redirection (i.e. "<<-") allows you to
indent the meat of the here-document and the end-of-here-document
marker.  Please take advantage of the facility to make the result
more readable.

Also unless there is something that needs interpolation by the
shell, we prefer to use quoted here-document (i.e. "<<-\EOF") to
reduce the mental burden by the readers of the code.  So

	test_expect_success setup '
		cat >x <<-\EOF &&
		firstline
		b
		...
		n
		EOF
		use x in the test &&
		check the result
	'

This comment applies to all other uses of <<- in this patch.

> +test_expect_success 'diff.context affects log' '
> +	git log -1 -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	git log -1 -p >output &&
> +	grep firstline output
> +'

Is there a reason to favor "log -1 -p" over something a lot simpler
like "show"?  Not requesting to change anything, but just being
curious.

> +test_expect_success 'different -U value' '
> +	git config diff.context 8 &&
> +	git log -U4 -1 >output &&
> +	! grep firstline output
> +'

OK, so -U4 overrides configured diff.context setting and you make
sure by asking -U4 that is too small to show firstline (but if 8
were used, the line would have been shown).

> +test_expect_success 'diff.context affects diff' '
> +	git config diff.context 8 &&
> +	git diff >output &&
> +	grep firstline output
> +'

Don't we want to make sure that without diff.context the output will
give you the default 3 lines of context?  It is a common mistake
shared by people who want to demonstrate their shiny new toys to
test only the positive cases while forgetting to test non-regression.

> +test_expect_success 'plumbing not affected' '
> +	git config diff.context 8 &&
> +	git diff-files -p > output &&

Style.  No SP between redirection and the filename, i.e.

	git diff-files -p >output &&

> +	! grep firstline output
> +'

A blank line between tests.

> +test_expect_success 'non-integer config parsing' '
> +	cat > .git/config <<-\EOF &&

> +[diff]
> +	context = no
> +EOF
> +	! git diff 2>output &&
> +	grep "bad config value" output
> +'

We are not in the business of debugging "grep", so writing "! grep ..."
to make sure grep does not find something is perfectly fine, but
when expecting an error from "git" command, please write it like

	test_must_fail git diff 2>error &&
        test_i18ngrep "bad config value" error

instead.  The error messages meant for human consumption could be
localized, and use of test_i18ngrep allows use to ignore its error
condition when the test is run under "funny" locale.

> +test_expect_success 'negative integer config parsing' '
> +	cat >.git/config <<-\EOF &&
> +[diff]
> +	context = -1
> +EOF
> +	! git diff 2>output &&
> +	grep "bad config file" output
> +'
> +
> +test_expect_success '0 config parsing' '
> +	cat > .git/config <<-\EOF &&
> +[diff]
> +	context = 0
> +EOF
> +	git diff >output &&
> +	grep preline output
> +'

Hrm, is this correct?  Your test vectors change a single line that
is surrounded by "preline" and "postline", so -U0 patch should show
only the change for that single line, without showing "preline" or
"postline".

I think the "grep" pattern you used is too loose to be useful.  You
would probably want to be grepping for something like

	git diff >output &&
        grep "^-1" output &&
        grep "^+2" output

instead.

> +test_expect_success 'config parsing' '
> +	cat >.git/config <<-\EOF &&
> +[diff]
> +	context = 8
> +EOF
> +	git diff >output &&
> +	grep postline output
> +'

I do not think this last test adds any value; you already checked it
with "git config diff.context 8" much earlier, no?  This script is
not about parsing of the handcrafted configuration files.

> +test_done

To summarize...

 t/t4055-diff-context.sh | 135 ++++++++++++++++++------------------------------
 1 file changed, 50 insertions(+), 85 deletions(-)

diff --git c/t/t4055-diff-context.sh w/t/t4055-diff-context.sh
index 8a31448..3527686 100755
--- c/t/t4055-diff-context.sh
+++ w/t/t4055-diff-context.sh
@@ -8,121 +8,86 @@ test_description='diff.context configuration'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	cat >x <<-EOF &&
-firstline
-b
-c
-d
-e
-f
-preline
-postline
-i
-j
-k
-l
-m
-n
-EOF
+	cat >x <<-\EOF &&
+	firstline
+	b
+	c
+	d
+	e
+	f
+	preline
+	postline
+	i
+	j
+	k
+	l
+	m
+	n
+	EOF
 	git update-index --add x &&
 	git commit -m initial &&
-	cat >x <<-\EOF &&
-firstline
-b
-c
-d
-e
-f
-preline
-1
-postline
-i
-j
-k
-l
-m
-n
-EOF
+
+	git cat-file blob HEAD:x |
+	sed "/preline/a\
+	ADDED" >x &&
 	git update-index --add x &&
 	git commit -m next &&
-cat >x <<-\EOF
-firstline
-b
-c
-d
-e
-f
-preline
-2
-postline
-i
-j
-k
-l
-m
-n
-EOF
+
+	git cat-file blob HEAD:x |
+	sed s/ADDED/MODIFIED/ >x
 '
 
-test_expect_success 'diff.context affects log' '
+test_expect_success 'the default number of context lines is 3' '
+	git diff >output &&
+	! grep "^ d" output &&
+	grep "^ e" output &&
+	grep "^ j" output &&
+	! grep "^ k" output
+'
+
+test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
 	! grep firstline output &&
 	git config diff.context 8 &&
 	git log -1 -p >output &&
-	grep firstline output
+	grep "^ firstline" output
 '
 
-test_expect_success 'different -U value' '
+test_expect_success 'The -U option overrides diff.context' '
 	git config diff.context 8 &&
 	git log -U4 -1 >output &&
-	! grep firstline output
+	! grep "^ firstline" output
 '
 
-test_expect_success 'diff.context affects diff' '
+test_expect_success 'diff.context honored by "diff"' '
 	git config diff.context 8 &&
 	git diff >output &&
-	grep firstline output
+	grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
 	git config diff.context 8 &&
-	git diff-files -p > output &&
-	! grep firstline output
+	git diff-files -p >output &&
+	! grep "^ firstline" output
 '
+
 test_expect_success 'non-integer config parsing' '
-	cat > .git/config <<-\EOF &&
-[diff]
-	context = no
-EOF
-	! git diff 2>output &&
-	grep "bad config value" output
+	git config diff.context no &&
+	test_must_fail git diff 2>output &&
+	test_i18ngrep "bad config value" output
 '
 
 test_expect_success 'negative integer config parsing' '
-	cat >.git/config <<-\EOF &&
-[diff]
-	context = -1
-EOF
-	! git diff 2>output &&
-	grep "bad config file" output
-'
-
-test_expect_success '0 config parsing' '
-	cat > .git/config <<-\EOF &&
-[diff]
-	context = 0
-EOF
-	git diff >output &&
-	grep preline output
+	git config diff.context -1 &&
+	test_must_fail git diff 2>output &&
+	test_i18ngrep "bad config file" output
 '
 
-test_expect_success 'config parsing' '
-	cat >.git/config <<-\EOF &&
-[diff]
-	context = 8
-EOF
+test_expect_success '-U0 is valid, so is diff.context=0' '
+	git config diff.context 0 &&
 	git diff >output &&
-	grep postline output
+	grep "^-ADDED" output &&
+	grep "^+MODIFIED" output
 '
 
 test_done
