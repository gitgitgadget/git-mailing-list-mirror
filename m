From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] mailinfo: allow e-mail files as input
Date: Thu, 16 Jul 2009 18:05:10 -0700
Message-ID: <7v1vog6rw9.fsf@alter.siamese.dyndns.org>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
 <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Stephen Boyd <bebarino@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jul 17 03:05:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRbtB-0008W8-7F
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 03:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933453AbZGQBFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 21:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbZGQBFT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 21:05:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933450AbZGQBFT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 21:05:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C778C497A;
	Thu, 16 Jul 2009 21:05:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 489214977; Thu, 16 Jul 2009
 21:05:11 -0400 (EDT)
In-Reply-To: <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Thu\, 16 Jul 2009 19\:45\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4790A32-726D-11DE-BBA2-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123436>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> We traditionally allowed a mbox file or a directory name of a maildir to be
> ...
> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>

Thanks.

I have one more comment on the test script, but it's something I can
locally fix (iow, there is no need to resend your patch if there is no
other issue pointed out by others, and if you agree to my suggested
improvements).

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index a12bf84..4c99240 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -63,6 +63,53 @@ with the data reset to initial values.
>  
>  EOF
>  
> +cat >rfc2822_email <<EOF
> +Return-Path: <user@domain.name>
> +X-Flags: 0000
> +	999

Please quote that EOF if you do not mean to have any $variable substituted
in the "here document", like this:

	cat >rfc2822_email <<\EOF
        ... here document comes here ...
	EOF

Otherwise reviewers need to waste time looking for what is being replaced
in the huge here document to understand what is going on.

> +Delivered-To: delivery to user@domain.name
> +Received: (qmail invoked by alias); 16 Jul 2009 05:25:49 -0000
> +Received: from vger.knl.xyz (EHLO vger.knl.xyz) [4.3.2.1]
> +  by mx0.gmx.com (mx-us004) with SMTP; 16 Jul 2009 01:25:49 -0400
> ...
> +
> +EOF
> +

The headers look a bit too excessive to my taste, but probably you wanted
to take a real-life example.  If that is the case, I suspect the manually
added X-Flags: at the beginning defeats that purpose, though.  I'd suggest
either removing the hand-munging, or triming the Received: sequence to
make it a bit shorter.

> @@ -222,6 +269,13 @@ test_expect_success 'am takes patches from a Pine mailbox' '
>  	test -z "$(git diff master^..HEAD)"
>  '
>  
> +test_expect_success 'am takes patches from a RFC2822 formated email' '
> +	git checkout first &&
> +	cat rfc2822_email patch1 | git am &&
> +	! test -d .git/rebase-apply &&
> +	test -z "$(git diff master^..HEAD)"
> +'

These days we tend to write the last step

	git diff --exit-code master^ HEAD

which allows "sh t4150-am.sh -i -v" to be more useful when debugging.  But
the existing tests in this script are old fashioned, and you matched their
style in this patch, which is very good.

We probably would want a separate patch to modernize them after 1.6.4,
though.
