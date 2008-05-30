From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 22:29:01 -0700
Message-ID: <7vr6bkmkbm.fsf@gitster.siamese.dyndns.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 30 07:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1xBu-0005Qz-Lm
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 07:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYE3F3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 01:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYE3F3W
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 01:29:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYE3F3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 01:29:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3E18386F;
	Fri, 30 May 2008 01:29:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2B33D386D; Fri, 30 May 2008 01:29:17 -0400 (EDT)
In-Reply-To: <E1K1eXH-00063c-Bt@fencepost.gnu.org> (Paolo Bonzini's message
 of "Thu, 29 May 2008 10:09:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A7A731A-2E09-11DD-8C6F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83268>

Paolo Bonzini <bonzini@gnu.org> writes:

> I noticed that the way "git commit --interactive" sets up the commit
> is different from the way a normal "git commit" does it.  Commit
> 2888605c changed one, but not the other.  This makes the behavior
> equivalent in the two cases.

Sorry, you need to defend this change much better than that.

I fail to see why it is a bad thing to have differences among the
codepaths that do different things.  The quoted commit 2888605
(builtin-commit: fix partial-commit support, 2007-11-18) was _not_ about
"doing it the same way".  It was simply "commit has three cases, AS_IS,
NORMAL and PARTIAL; the codepath that implements PARTIAL case is not done
right, so fix it to behave exactly the same as the old scripted version".

When interactive_add() returns, the index has already been updated, and
there is no reason to take the index lock, refresh the index, nor anything
that the normal "as-is" commit codepath needs to do (let alone the
alternate index dance forced upon the partial commit codepath).

If your change were so that "git commit --interactive" reverts the index
when one of the hooks exited non-zero just like COMMIT_NORMAL case (as
opposed to the current code which does not revert the index), I would
understand the need to change what's inside "if (interactive)" block.  But
that is not what the patch is about.  Changing the codepath so that it
does not return from that block made me follow unnecessary and unrelated
codepath to convince myself that this patch is mostly a no-op, except that
you are doing an extra refresh_cache() on the index that interactive_add()
has already refreshed before giving the control back to you.

Can you explain why this is an improvement?
