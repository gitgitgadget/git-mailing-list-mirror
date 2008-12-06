From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9129: Prevent test failure if no UTF-8 locale
Date: Fri, 05 Dec 2008 18:05:50 -0800
Message-ID: <7vk5aevz0h.fsf@gitster.siamese.dyndns.org>
References: <20081206013152.GA6129@cumin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: applehq <theappleman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 03:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8map-0000Xr-8W
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 03:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbYLFCF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 21:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYLFCF6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 21:05:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbYLFCF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 21:05:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 454BE18334;
	Fri,  5 Dec 2008 21:05:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9BDB1832E; Fri, 
 5 Dec 2008 21:05:52 -0500 (EST)
In-Reply-To: <20081206013152.GA6129@cumin> (theappleman@gmail.com's message
 of "Sat, 6 Dec 2008 01:31:52 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BA88A16-C33A-11DD-A585-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102439>

applehq <theappleman@gmail.com> writes:

> Commit 16fc08e2d86dad152194829d21bc55b2ef0c8fb1 introduced a
> test that failed if the en_US.UTF-8 locale was not installed.
>
> Make the test find a UTF-8 locale, and expect failure.

NAK on the latter one.

test_expect_failure does not mean "This might, and it is Ok to, fail", as
you seem to think.  It means "This should succeed if our software is not
buggy, but there is a known breakage to cause it to fail, so this test is
marked as such until the bug is fixed."

Skipping the test on a platform that lacks necessary locale is fine, but
if you run the test, they should expect success.  Otherwise you cannot
tell if it is a platform issue (i.e. not having any UTF-8 locale) or
a bug in the software (i.e. git-svn not working as expected).

> Signed-off-by: applehq <theappleman@gmail.com>

Sign off with an unreal name, hmm..., what good would that give us...?

> @@ -15,8 +15,9 @@ compare_git_head_with () {
>  }
>  
>  compare_svn_head_with () {
> -	LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
> -		sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
> +	LC_ALL=`locale -a | grep -i utf | head -1` \
> +		svn log --limit 1 `git svn info --url` | \
> +			sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&

I think what this part tries to do is good, in that we do not care if it
is en_US UTF-8 or any other UTF-8.  But cramming that logic all in one
pipeline (and an inefficient one at that) makes it harder to read.

Do something like this upfront:

	a_utf8_locale=$(locale -a | sed -ne '/[Uu][Tt][Ff]-*8/{
        	p
                q
	'})

and if that variable is empty then skip the test that relies on having a
UTF-8 locale on the platform.  Then the function can say:

	LC_ALL="$a_utf8_locale" svn log --limit 1 ...
