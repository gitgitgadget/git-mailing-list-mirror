From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 01 Feb 2008 02:51:28 -0800
Message-ID: <7v1w7x9cgf.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
	<7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
	<200802011010.41938.robin.rosenberg.lists@dewire.com>
	<7v63x99dt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKtVh-0000AH-Hi
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 11:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbYBAKvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 05:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbYBAKvq
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 05:51:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbYBAKvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 05:51:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 24EAE1146;
	Fri,  1 Feb 2008 05:51:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F661142;
	Fri,  1 Feb 2008 05:51:35 -0500 (EST)
In-Reply-To: <7v63x99dt9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 01 Feb 2008 02:22:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72166>

Junio C Hamano <gitster@pobox.com> writes:

> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
>
>>> > +test_expect_failure 'add a directory outside the work tree' '
>>> > +	d1="$(cd .. ; pwd)" &&
>>> > +	git add "$d1"
>>> > +	echo $?
>>> > +'
>>
>> Oops. Remove the echo $?. It still fails, i.e. git add succeeds when
>> it shouldn't. I was double checking it just before sending the patch.
>
> Ah, you found breakages.

I haven't looked at the code, but I suspect that "git add" and
anything that uses the same logic as "ls-files --error-unmatch"
would still not work with the setup patch.

The updated get_pathspec() issues a warning message and returns
the result that omits paths outside of the work tree.  It does
not die (and it is intentional, by the way).  The callers that
expect to always receive the same number of paths in the return
value as argv+i they pass to get_pathspec() should be updated to
notice that they got less than they passed in, if they care
about this error condition, and --error-unmatch codepath is one
of them.  I did not touch that in the weatherbaloon patch.
