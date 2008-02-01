From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Thu, 31 Jan 2008 23:17:11 -0800
Message-ID: <7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
	<7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKqA6-0004rW-L3
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 08:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbYBAHR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 02:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYBAHR2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 02:17:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYBAHR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 02:17:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B70239B;
	Fri,  1 Feb 2008 02:17:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A16C0239A;
	Fri,  1 Feb 2008 02:17:18 -0500 (EST)
In-Reply-To: <200802010534.55925.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Fri, 1 Feb 2008 05:34:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72152>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> +test_expect_failure 'add a directory outside the work tree' '
> +	d1="$(cd .. ; pwd)" &&
> +	git add "$d1"
> +	echo $?
> +'

This test will always fail as the final exit status is that of
"echo", which will exit with success and you are expecting a
failure.

> +test_expect_failure 'add a file outside the work tree, nasty case 1' '(
> +	f="$(pwd)x" &&
> +	touch "$f" &&
> +	git add "$f"
> +)'

You are in the directory "t/trash", and try to add t/trashx, so
this should fail and you would want to make sure it fails.

But this has a few problems:

 * First, the obvious one.  You are creating a garbage file
   outside of t/trash directory.  Don't.  If you need to, dig a
   test directory one level lower inside t/trash and play around
   there.

 * In general you should stay away from test_expect_failure.  If
   any of the command in && chain fails, it fails the whole
   thing, but you cannot tell if the sequence failed at the
   command you expected to fail or something else that is much
   earlier.  For example, it may be that somebody created t/trashx
   file in the source tree that is read-only, and the comand
   that failed in the sequence could be 'touch' before the
   command you are testing.

   Instead, write it like (after fixing it not to go outside
   t/trash):

	test_expect_success 'add a path outside repo (1)' '

		file=path_to_outside_repo &&
                touch "$file" &&
		! git add "$f"

	'

I'd like to make the _first_ patch after 1.5.4 to be a fix-up
for tests that misuse test_expect_failure.  After that, we can
use test_expect_failure to mark tests that ought to pass but
don't because of bugs in the commands.  That way, people who are
absolutely bored can grep for test_expect_failure to see what
existing issues to tackle ;-).
