From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus?  Really?  Interesting...
Date: Fri, 04 Jan 2008 14:42:57 -0800
Message-ID: <7vhchti55a.fsf@gitster.siamese.dyndns.org>
References: <1199471321.3133.22.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 23:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAvGJ-0007S5-Fj
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 23:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbYADWnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 17:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYADWnG
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 17:43:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYADWnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 17:43:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E2BE5780;
	Fri,  4 Jan 2008 17:43:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF34565D;
	Fri,  4 Jan 2008 17:42:58 -0500 (EST)
In-Reply-To: <1199471321.3133.22.camel@ld0161-tx32> (Jon Loeliger's message of
	"Fri, 04 Jan 2008 12:28:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69611>

Jon Loeliger <jdl@freescale.com> writes:

> Couple questions:
>
>     Is it ever NOT the case, that if you are on one
>     branch ("master") and name it as a "to be merged"
>     branch along with some others, that we can simplify
>     the request by noting that it is the same as the
>     current "to be merged into" target branch?

Yes we can, but "filter ancestors out from the remotes"
computation does not happen before the merge strategy is chosen.

>     Other than creating a log message with "merged
>     by octopus", will this merge be content-identical
>     to the obvious simplified merge?

I think octopus actually tries to be careful not to run the
read-tree 3-way merge when merging a true ancestor (see ll.77-87
in git-merge-octopus.sh, but see below), so the resulting tree
should be identical to "-s resolve" merge.

But that does not mean the user's wish to record such a commit
as one ancestor should not be honored, and I think there
actually is a benign bug there.  Due to the "Already up-to-date
with $SHA1" part, the codepath that says "Fast forwarding to:"
never actually triggers, so in practice we end up dropping any
true ancestor from the parent list of the resulting merge.  That
contradicts the comment in ll.77-87 that suggests we try not to
outsmart the user who told us to create such an octopus for
unfathomable reason ;-)
