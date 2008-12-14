From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-sh-setup: Fix scripts whose PWD is a symlink into
 a git work-dir
Date: Sat, 13 Dec 2008 19:54:49 -0800
Message-ID: <7v4p174diu.fsf@gitster.siamese.dyndns.org>
References: <7viqprzsvs.fsf@gitster.siamese.dyndns.org>
 <1229201231-12586-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Sun Dec 14 04:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBi5e-00055R-0N
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 04:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYLNDzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 22:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYLNDzD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 22:55:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYLNDzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 22:55:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 991F21A405;
	Sat, 13 Dec 2008 22:54:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 596161A402; Sat,
 13 Dec 2008 22:54:50 -0500 (EST)
In-Reply-To: <1229201231-12586-1-git-send-email-marcel@oak.homeunix.org>
 (Marcel M. Cary's message of "Sat, 13 Dec 2008 12:47:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA80F3BE-C992-11DD-B90C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103048>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> I also removed the "pwd -P" from the unit test.

Hmm, really...?

>> > +# Prove that the remote end really is a repo, and other commands
>> > +# work fine in this context.
>> > +#
>> > +test_debug "
>> > +    test_expect_success 'pushing from symlinked subdir' '
>> > +
>> > +        git push
>> > +    '
>> > +"
>> 
>> Why should this be hidden inside test_debug?
>
> I'm not particularly trying to test "git push" or "git pull" in general
> here.  That's also why the other "git pull" was in a test_debug.  I
> thought it was really only useful to someone trying to understand the
> contents of the test file.  There are other files that cover push and
> pull.  Do you think these test cases should run all the time here?

I'd say so.  Your supporting argument could be "See, push works just fine
with this layout, but pull doesn't because it is a shell script that can
be fooled, and this change is to fix the inconsistencies between them."
Having these test enabled would be a good way to do so.  Then it becomes
irrelevant if "jump into the middle of a directory hierarchy sideways via
symlink" is worth supporting or not ;-)

But whether it is inside test_debug or not, the test should check not just
the exit status from 'git push' but also check what happened to the
receiving repository at least to make sure it is pushing to the location
you are expecting it to.

> diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
> new file mode 100755
> index 0000000..05854b4
> --- /dev/null
> +++ b/t/t2300-cd-to-toplevel.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='cd_to_toplevel'
> +
> +. ./test-lib.sh
> +
> +test_cd_to_toplevel () {
> +	test_expect_success "$2" '
> +		(
> +			cd '"'$1'"' &&
> +			. git-sh-setup &&
> +			cd_to_toplevel &&
> +			[ "$(pwd -P)" = "$TOPLEVEL" ]
> +		)
> +	'
> +}

The quoting of $1 here is a bit tricky, but I think it is good enough for
directory names used in tests that use this function.
