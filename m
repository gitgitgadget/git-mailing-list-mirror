From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 04 May 2011 10:47:29 +0200
Message-ID: <4DC112A1.5090805@drmicha.warpmail.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXkE-0000l4-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab1EDIrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:47:36 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41546 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab1EDIrg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 04:47:36 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F04C420161;
	Wed,  4 May 2011 04:47:34 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 04 May 2011 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5lkn6IEYPLQ+H/Ov+quZC8+ipgg=; b=heOx1WmWsNrtx2dp7VJEpxW1BhCcPyMPlOJLv9Ya4Y8Czf6OslQiqd7BxSOMYn4BMzKs95vB3+1ca4viG78kPlzGyQxI6pTx8P1eb2pKpnI0UCGEk9tjWA0808H3t881tXJd7n8Y4LLBQZ6f+z5qlZ8FWiJsu37F6G0JFvThsBo=
X-Sasl-enc: NYE59Cuml3YXoT21A8vsT0/ajsQJbUFSITcaFHK87O0m 1304498854
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5A4E2442BD3;
	Wed,  4 May 2011 04:47:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172726>

Junio C Hamano venit, vidit, dixit 04.05.2011 01:33:
> Somebody tried "git pull" from a random place completely outside the work
> tree, while exporting GIT_DIR and GIT_WORK_TREE that are set to correct
> places, e.g.
> 
> 	GIT_WORK_TREE=$HOME/git.git
>         GIT_DIR=$GIT_WORK_TREE/.git
>         export GIT_WORK_TREE GIT_DIR
>         cd /tmp
>         git pull
> 
> At the beginning of git-pull, we check "require-work-tree" and then
> "cd-to-toplevel".  I _think_ the original intention when I wrote the
> command was "we MUST have a work tree, our $(cwd) might not be at the
> top-level directory of it", and no stronger than that.  That check is a
> very sensible thing to do before doing cd-to-toplevel.  We check that the
> place we would want to go exists, and then go there.
> 
> But the implementation of require_work_tree we have today is quite
> different.  I don't have energy to dig the history, but currently it says:
> 
>  	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
>  	die "fatal: $0 cannot be used without a working tree."
> 
> Which is completely bogus.  Even though we may happen to be just outside
> of it right now, we may have a working tree that we can cd_to_toplevel
> back to.
> 
> I recall there was a discussion sometime last year about this topic, and
> vaguely recall somebody proposed to swap the order of cd-to-toplevel and
> require-work-tree.  While I agree that would sweep the issue under the rug,

I may have been that one that year or another...

> I think the right solution would be to apply the attached patch; and then
> audit all the callers that call "require_work_tree" to see if any of them
> meant "No, it is not Ok just to have working tree somewhere! I want you to
> be IN that working tree when you call me", and convert them to call the
> new require_to_be_in_work_tree instead.
> 
> Thoughts?

Same thoughts as Jeff. git-sh-setup is explicitly meant to be used by
scripters, and the users in git.git serve as an example how to use it.
If that usage changes it requires a long migration plan.

The only thing I can imagine doing right now is changing
require_work_tree() to actually cd to toplevel when possible, so that
(like before) on success we're really within. But that changes cwd, of
course. In summary, a require_work_tree() now can have three assumptions
when it returns with success:

- we have a worktree
- we are within worktree
- cwd has not changed

I'd rather break the last one than the second one, but breaking any may
be a problem, depending on the caller.

Michael
