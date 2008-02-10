From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 09 Feb 2008 20:44:31 -0800
Message-ID: <7v63wx4dzk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
	<alpine.LFD.1.00.0802091531220.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO44S-0006Pf-K3
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYBJEor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbYBJEoq
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:44:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbYBJEoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:44:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D691D10A9;
	Sat,  9 Feb 2008 23:44:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E9210A8;
	Sat,  9 Feb 2008 23:44:41 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802091531220.2896@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 9 Feb 2008 15:52:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73312>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And here's a slight expansion patch on top of the above
>
> It does:
>
>  - when it actually breaks out due to the "everybody_uninteresting()" 
>    case, it adds the uninteresting commits (both the one it's looking at 
>    now, and the list of pending ones) to the list
>
>    This way, we really list *all* the commits we've looked at
>
>  - Because we now end up listing commits we may not even have been parsed 
>    at all "show_log" and "show_commit" need to protect against commits 
>    that don't have a commit buffer entry.
>
> That second part is debatable just how it should work. Maybe we shouldn't 
> show such entries at all (with this patch those entries do get shown, they 
> just don't get any message shown with them). But I think this is a useful 
> case.

Showing them would probably be useful (definitely for
debugging), but I do not think it is useful not to show the
buffer contents (i.e. adding without parsing).

It _might_ mean that the excess uninteresting ones we take out
from "list" can be distinguished from the ones that we did look
at (and once thought they were worth keeping), but I do not
think it is reliable information.  The command line parser may
have caused them to be parsed independent from what the revision
traversal did.

So I think it would make more sense to parse them while we add
them to the "newlist", and if we really want to distinguish them
from others we would want to mark them separately with another
flag bit.

Or unparse them when we add them to the "newlist".
