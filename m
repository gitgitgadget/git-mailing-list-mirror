From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4.4
Date: Sun, 09 Mar 2008 23:34:22 -0700
Message-ID: <7vmyp7kryp.fsf@gitster.siamese.dyndns.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org>
 <7vr6eknpjf.fsf@gitster.siamese.dyndns.org> <47D416C8.1020903@garzik.org>
 <7v1w6jod54.fsf@gitster.siamese.dyndns.org> <47D459D5.2020101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 07:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYbbS-0004uq-5S
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 07:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYCJGej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 02:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbYCJGej
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 02:34:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYCJGei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 02:34:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AC24129D;
	Mon, 10 Mar 2008 02:34:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 05370129C; Mon, 10 Mar 2008 02:34:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76701>

Jeff Garzik <jeff@garzik.org> writes:

> Yes, I regularly run both 'git gc' and 'git prune'.
>
> But since (ref original email) I was doing some rebasing, there are
> inevitably changesets left dangling after such an operation.

Yeah, I'd say it is stupid if "am" ran "gc --auto" for every patch.  I
recall that we had the same issue with git-svn and we made it run once
every 1k round, and we probably should do the same for "am" and "rebase",
running once at the very end.

I notice however that git-am does exactly that.  It runs "gc --auto" only
at the end, and does not run it when it stops upon unapplicable patch.

Perhaps we would want to raise the default "gc --auto" limit?  Currently
when it estimates that you have roughly 6700 objects unpacked it runs
"repack --prune-packed", and if there still are that many unpacked objects
after that, it suggests you to run "git prune" to remove them.  If you are
rebasing, the commits in the old history that are rewritten will _not_
immediately become dangling because they will still be reachable from your
reflog.  If you are getting the message, these objects were already
dangling (ancient commits that are not even reachable from your reflog
entries that are by default kept for 90 days) even before you started your
rebase or am run.

After you finished your day's work on a typical day, what does the output
from "git count-objects -v" and "git fsck-objects" look like, I wonder?
