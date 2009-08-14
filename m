From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-config: Parse config files leniently
Date: Fri, 14 Aug 2009 12:52:13 -0700
Message-ID: <7veirejhqq.fsf@alter.siamese.dyndns.org>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
 <a812f567b4541ce55e9c60037a047488a0893c36.1250262273.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc2pF-0001Dj-M4
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 21:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045AbZHNTwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756999AbZHNTwY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 15:52:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbZHNTwX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 15:52:23 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C52ADAC;
	Fri, 14 Aug 2009 15:52:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83DC4ADAB; Fri, 14 Aug
 2009 15:52:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB743E28-890B-11DE-8578-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125940>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, git config dies as soon as there is a parsing error. This is
> especially unfortunate in case a user tries to correct config mistakes
> using git config -e.
>
> Instead, issue a warning only and treat the rest of the line as a
> comment (ignore it). This benefits not only git config -e users.

... a broken sentence in the middle?  I would have expected the "not only"
followed by "but also"; the question is "but also what?"

Hopefully the benefit is not that it now allows all the other commands to
cause unspecified types of damage to the repository by following iffy
settings obtained from a broken configuration file.

> Reported-by: David Reitter <david.reitter@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

> Test had to be adjusted as well.

The change to the test demonstrates the issue rather well.  The check()
shell function does not check the exit value from "git config --get", but
in a real script that cares to check and stop on error, this change will
now let the script go on, leaving the breakage unnoticed.  I suspect
command implemented in C, that call git_config(), will also have the same
issue, and I cannot convince myself this is a good change in general,
outside the scope of helping "git config -e".

But I may be being overly cautious.

By the way, why did you have to change s/echo/printf/?  Can't you give two
lines in a single argument without "\n" escape?

> diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
> index 080117c..be850c5 100755
> --- a/t/t1303-wacky-config.sh
> +++ b/t/t1303-wacky-config.sh
> @@ -9,7 +9,7 @@ setup() {
>  }
>  
>  check() {
> -	echo "$2" >expected
> +	printf "$2\n" >expected
>  	git config --get "$1" >actual 2>&1
>  	test_cmp actual expected
>  }
> @@ -44,7 +44,7 @@ LONG_VALUE=$(printf "x%01021dx a" 7)
>  test_expect_success 'do not crash on special long config line' '
>  	setup &&
>  	git config section.key "$LONG_VALUE" &&
> -	check section.key "fatal: bad config file line 2 in .git/config"
> +	check section.key "warning: bad config file line 2 in .git/config\nwarning: bad config file line 2 in .git/config"
>  '
>  
>  test_done
