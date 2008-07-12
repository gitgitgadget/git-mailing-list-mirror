From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Fix backwards-incompatible handling of
 core.sharedRepository
Date: Fri, 11 Jul 2008 17:20:29 -0700
Message-ID: <7vhcawhs1e.fsf@gitster.siamese.dyndns.org>
References: <20080711233841.30916.75885.stgit@rover.dkm.cz>
 <20080711234257.16449.85447.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Heikki Orsila <heikki.orsila@iki.fi>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 12 02:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSrp-0001b6-Q5
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 02:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYGLAUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 20:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYGLAUi
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 20:20:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYGLAUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 20:20:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C47B027D4F;
	Fri, 11 Jul 2008 20:20:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5463627D4E; Fri, 11 Jul 2008 20:20:31 -0400 (EDT)
In-Reply-To: <20080711234257.16449.85447.stgit@rover.dkm.cz> (Petr Baudis's
 message of "Sat, 12 Jul 2008 01:45:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59A3147C-4FA8-11DD-8653-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88210>

Petr Baudis <pasky@suse.cz> writes:

> The 06cbe8550324e0fd2290839bf3b9a92aa53b70ab core.sharedRepository
> handling extension broke backwards compatibility; before, shared=1 meant
> that Git merely ensured the repository is group-writable, not that it's
> _only_ group-writable, which is the current behaviour. Thus, with umask 002,
> Git creates repository with /rw.rw.--./, this patch fixes it back to
> /rw.rw.r-./.

Is it just me who finds the above unreadable blob of black ink?

	06cbe85 (Make core.sharedRepository more generic, 2008-04-16)
	broke the traditional setting core.sharedRepository to true,
        which was to make the repository group writable.

	The call to adjust_shared_perm() should only loosen the
	permission.  If the user has umask 002 (or 022) that allow others
	to read, the resulting files should be made readable and writable
	by group, without restricting the readability by others.

> Maybe it makes sense to provide the current semantics in some way too,
> but that cannot be done at the expense of ditching backwards
> compatibility; this bug has just wasted me two hours and broke
> repo.or.cz pushing for several hours.

I do not think this gripe after the semicolon belongs before the
three-dash lines.

> Cc: Heikki Orsila <heikki.orsila@iki.fi>
> Signed-off-by: Petr Baudis <pasky@rover.dkm.cz>
> ---
>
>   Oops, this testcase wouldn't really remove its test subrepository
> after itself properly, though the testsuite would still pass; of course
> this bug slipped through all the previous visual inspections of mine.
>
>   Sorry for the continuous noise. :-)

Hmm, I am very puzzled.

I am afraid I have to ask you for another round.  I applied only your
update to t/t1301 without the change to path.c, and the test passes, which
means either (1) the test is incorrect and does not exposing the breakage,
or (2) the breakage is not real and existing code is correct.
