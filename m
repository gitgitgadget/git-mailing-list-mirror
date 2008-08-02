From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn and the post-receive hook
Date: Sat, 02 Aug 2008 13:16:05 -0700
Message-ID: <7vod4bdvga.fsf@gitster.siamese.dyndns.org>
References: <489485BC.1020607@obry.net>
 <7vwsizl0l9.fsf@gitster.siamese.dyndns.org> <4894B387.4040004@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Aug 02 22:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPNXO-0001CA-Hz
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 22:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbYHBUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 16:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbYHBUQM
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 16:16:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbYHBUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 16:16:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 71BCF48CA4;
	Sat,  2 Aug 2008 16:16:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8CDB848CA3; Sat,  2 Aug 2008 16:16:07 -0400 (EDT)
In-Reply-To: <4894B387.4040004@obry.net> (Pascal Obry's message of "Sat, 02
 Aug 2008 21:20:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8E8019C-60CF-11DD-B893-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91173>

Pascal Obry <pascal@obry.net> writes:

> BTW, I do not see why this would be a problem with git-svn whereas the
> post-receive hook is fine for Git.

You probably haven't read Miklos's response have you?  post-receive is
about what happens at the remote end after you "push" there, and does not
have to do with what happens when you fetch.

The article I gave you a link earlier gives a guideline to decide when we
choose to add hook for particular step of operation (and when we choose
not to).  The new call from "git svn rebase" (and presumably "git svn
fetch" which is the first step of that operation) needs to be justified.

Having said that, I would have framed your argument in a different way.  I
suspect then you would not have heard the above objections if you did so:

   After pushing to a remote side, there is a post-receive hook so that
   some processing can happen depending on which refs changed from what
   commit to what new commit.  This is primarily because "push" goes to
   the remote side and the user may not have any other means to trigger an
   operation over there (e.g. there may not be ssh login access, just
   git-shell running to accept pushes).

   After fetching from somewhere else, there is no post-fetch hook.  This
   is not a show-stopper problem because the operation is local.  You can
   remember where the refs were before running a fetch, run the fetch, and
   run necessary post-fetch operation.  IOW, instead of "git fetch" (or
   "git svn fetch") calling a custom script installed as a hook, a custom
   script can call "git fetch" (or "git svn fetch") as part of what it
   does.

   However, fetch and push are logically the same operation --- update a
   set of refs on one end to match the other end, while transferring the
   necessary objects to keep the updated refs valid.  We even suggest
   (with satellite-mothership configuration) to push into remote when
   network reachability constraints keeps you from fetching in the other
   direction or vice versa.  If you used fetch to update refs at the
   receiving end only because you somehow cannot push in the other
   direction, it is natural you would want to do the same processing after
   the fetch that post-receive hook would have done if you could push in
   the direction you originally wanted to.

   Which suggests that we may be better off having a unified post-sync
   hook, that would be called with the same arguments as existing
   post-receive hook is called with, whenever fetch initiated at the local
   end or a push initiated from elsewhere updates refs in the local
   repository (such a hook is justified because it needs to _also_ work
   at the remote side).

   To keep the migration hassle to the minimum, we can reuse post-receive
   hook itself for that purpose without actually introducing a new
   post-sync hook.  So how about calling post-receive from "git fetch" and
   "git svn fetch"?  This is a change in semantics, and it may break
   people's existing setups (i.e. they may be relying on post-receive not
   to trigger when they fetch), so we need to proceed carefully, but I
   think it is in the right direction.

I actually am more than sympathetic to this cause. I think the unified
post-sync mechanism is a sensible thing to do, at least in the longer
term.

We might also need to teach push over http (which is not even a second
class citizen) to trigger post-receive if it does not already do so.
