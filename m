From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 01:39:27 -0800
Message-ID: <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org>
 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
 <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
 <20090123094529.6117@nanako3.lavabit.com>
 <20090123172646.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQIX5-0008LJ-OU
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbZAWJjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbZAWJjf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:39:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZAWJje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:39:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 896D31D192;
	Fri, 23 Jan 2009 04:39:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 892C81D191; Fri,
 23 Jan 2009 04:39:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDA73552-E931-11DD-9A45-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106869>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Correct.  I did not run that new test, let alone existing ones ;-)
>
> I applied your patch and run the test suite, including the new one, and they passed.

Thanks.

> I tried to write a new option I said that I wanted in my previous message.  Here is a patch.
>
> --->8---
> Subject: [PATCH] git-am: Add --ignore-date option

Good.

Leaving "Subject: " in saves me typing, because I do not have to insert it
manually when editing the submitted patch in my MUA to chop off everything
before the scissors.

> This new option makes the command ignore the date header field recorded in
> the format-patch output.  The commits will have the timestamp when they
> are created instead.
>
> You can work a lot in one day to accumulate many changes, but apply and
> push to the public repository only some of them at the end of the first
> day.  Then next day you can spend all your working hours reading comics or
> chatting with your coworkers, and apply your remaining patches from the
> previous day using this option to pretend that you have been working at
> the end of the day.

LOL.  A slacker option is a tough sell to a serious management, though.

I think it would work equally well if you somehow manage to pass this
through "git-rebase", but this won't work with "git-rebase --interactive".

> @@ -379,7 +383,13 @@ do
>  
>  	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
>  	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
> -	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
> +	case "$ignore_date" in
> +	    t)
> +		GIT_AUTHOR_DATE="$(date -R)"
> +		;;
> +	    '')
> +		GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
> +	esac

Please align case arm labels with case/esac; iow, do not indent t) and '')
by four spaces, when you write your next case/esac statement.

"date -R" is a GNU extension; avoid it (I'll show you how at the end).

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 8d3fb00..5ecf456 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -277,4 +277,13 @@ test_expect_success 'am without --committer-date-is-author-date' '
>  	test "$at" != "$ct"
>  '
>  
> +test_expect_success 'am --ignore-date' '
> +	git checkout first &&
> +	test_tick &&
> +	git am --ignore-date patch1 &&
> +	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
> +	at=$(sed -ne "/^author /s/.*> //p" head1) &&
> +	echo "$at" | grep "+0000"
> +'

This is a convoluted logic.

The committer and author dates are set to -0700 timezone by test_tick,
while TZ is set to UTC (+0000) by test-lib.sh, and you are taking
advantage of them to see which one is being used.

But I do not think of a better way to do this offhand, so I'll let it
pass.

Regarding the "date -R" thing, I think we can take advantage of the fact
that an empty GIT_AUTHOR_DATE (and GIT_COMMITTER_DATE) means "do not use
this environment variable, but use the current date instead".  Something
like this patch on top of yours, whose first hunk reverts your change to
use "date -R", and sets GIT_AUTHOR_DATE to empty when --ignore-date is
asked for.

No, I didn't test it.

diff --git i/git-am.sh w/git-am.sh
index eb88d90..f935178 100755
--- i/git-am.sh
+++ w/git-am.sh
@@ -383,13 +383,7 @@ do
 
 	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	case "$ignore_date" in
-	    t)
-		GIT_AUTHOR_DATE="$(date -R)"
-		;;
-	    '')
-		GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
-	esac
+	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
 
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
@@ -536,6 +530,10 @@ do
 	tree=$(git write-tree) &&
 	parent=$(git rev-parse --verify HEAD) &&
 	commit=$(
+		if test -n "$ignore_date"
+		then
+			GIT_AUTHOR_DATE=
+		fi
 		if test -n "$committer_date_is_author_date"
 		then
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
