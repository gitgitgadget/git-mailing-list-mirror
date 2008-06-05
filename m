From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] Add new test to ensure git-merge handles
 pull.twohead and pull.octopus
Date: Thu, 05 Jun 2008 15:58:23 -0700
Message-ID: <7vmylzzdyo.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4OQY-0005WD-Tw
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 00:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYFEW6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 18:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbYFEW6e
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 18:58:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYFEW6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 18:58:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8789236CA;
	Thu,  5 Jun 2008 18:58:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C20836C7; Thu,  5 Jun 2008 18:58:27 -0400 (EDT)
In-Reply-To: <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Thu, 5 Jun 2008 22:44:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA7D5308-3352-11DD-A0DC-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83991>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Test if the given strategies are used and test the case when multiple
> strategies are configured using a space separated list.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  t/t7601-merge-pull-config.sh |   57 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
>  create mode 100755 t/t7601-merge-pull-config.sh
>
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> new file mode 100755
> index 0000000..cc595ac
> --- /dev/null
> +++ b/t/t7601-merge-pull-config.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +test_description='git-merge
> +
> +Testing pull.* configuration parsing.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo c0 >c0.c &&
> +	git add c0.c &&
> +	git commit -m c0 &&
> +	git tag c0 &&
> +	echo c1 >c1.c &&
> +	git add c1.c &&
> +	git commit -m c1 &&
> +	git tag c1 &&
> +	git reset --hard c0 &&
> +	echo c2 >c2.c &&
> +	git add c2.c &&
> +	git commit -m c2 &&
> +	git tag c2
> +	git reset --hard c0 &&
> +	echo c3 >c3.c &&
> +	git add c3.c &&
> +	git commit -m c3 &&
> +	git tag c3
> +'
> +
> +test_expect_success 'merge c1 with c2' '
> +	git reset --hard c1 &&

test that c0 and c1 do and c2 and c3 do not exist here, as it is cheap,
and otherwise you may end up chasing wild-goose when somebody breaks
git-reset.  No need to do so in later tests in this script, but it is a
cheap protection for yourself from others' mistakes ;-).

> +	git merge c2 &&
> +	test -e c1.c &&
> +	test -e c2.c
> +'

Nobody runs V7 that lacked "test -e" to run these test scripts, but you
expect them to be regular files at this point of the test, so the correct
way to spell these is with "test -f".

In general, you are better off training yourself to think if you can use
"test -f" before blindly using "test -e".

> +test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
> +	git reset --hard c1 &&
> +	git config pull.twohead ours &&
> +	git merge c2 &&
> +	test -e c1.c &&
> +	! test -e c2.c
> +'
> +
> +test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
> +	git reset --hard c1 &&
> +	git config pull.octopus "recursive" &&
> +	! git merge c2 c3

Is it because it should dump core, or is it because the command should
decline to work, gracefully failing with an error message and non-zero
exit status?  Use "test_must_fail" to check for the latter.

Don't you want to check how it fails and in what shape the command leaves
the work tree?  I am assuming that recursive sees more than one "remote"
head and declines to work without touching work tree nor the index, so if
that is what you expect, you should check for that.  Otherwise, a
regression that loses local changes will go unnoticed.

> +'
> +
> +test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
> +	git reset --hard c1 &&
> +	git config pull.octopus "recursive octopus" &&
> +	git merge c2 c3

Likewise, don't you want to check the result of the merge?  Not just
"merge exited with 0", but you would want to see that the HEAD has
advanced, it has the expected parents, there is no unexpected local
changes (because you did not have any when you started the merge), and it
has the expected tree contents.

> +'
> +
> +test_done
> -- 
> 1.5.6.rc0.dirty
