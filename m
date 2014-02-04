From: chris <jugg@hotmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 10:35:53 +0000 (UTC)
Message-ID: <loom.20140204T104753-1@post.gmane.org>
References: <loom.20140204T030158-758@post.gmane.org> <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com> <loom.20140204T055040-646@post.gmane.org> <87r47jxp6k.fsf@fencepost.gnu.org> <loom.20140204T094437-148@post.gmane.org> <87mwi7xm04.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 11:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAdMj-0002aO-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 11:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbaBDKg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 05:36:26 -0500
Received: from plane.gmane.org ([80.91.229.3]:58890 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbaBDKgY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 05:36:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAdMX-0002RL-VH
	for git@vger.kernel.org; Tue, 04 Feb 2014 11:36:17 +0100
Received: from 1-165-180-147.dynamic.hinet.net ([1.165.180.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 11:36:17 +0100
Received: from jugg by 1-165-180-147.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 11:36:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 1.165.180.147 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241520>

David Kastrup <dak <at> gnu.org> writes:
> chris <jugg <at> hotmail.com> writes:
> > That said I would naively assume that a server side house keeping
> > operation that does not get invoked with every client request be a
> > nice candidate for asynchronous handling without any need to tell the
> > client about it.
> 
> Except that there are _no_ asynchronously handled repository actions
> executed on behalf of a client action.  If the repository owner decided
> to disable demand-based garbage collection in favor of a cron job,
> that's his call to make.  It makes some sense when there are frequent
> and multiple accesses to the repository since it avoids getting denied
> access because of somebody _else_ triggering garbage collection
> predominantly when times are busiest.
> 
> Usually you are not denied access by your _own_ garbage collection since
> the client waits until completion.
> 
> It would be quite bad for scripting git if you constantly had to check
> after every action whether any associated garbage collection might or
> might not have completed.

I can't comment for every use case, but I find it strange that a client
script should need to care whether the server is currently garbage
collecting or not.  If such a detail must be exposed to a client, then I'd
put forth that there is a deeper issue here.  But any details there are
moving well beyond the scope I'm able to comment on.

That said, I think I understand you that it currently does matter in the
sense that a client can't perform other actions while garbage collection is
running.

> Note also that when pushing without a separate server process (like when
> pushing into a local repository), there is no other job which could be
> responsible for packing the repository rather than the one doing the
> push.

Ok, given your full response, I understand how this is being conceptualized
now, thanks.  However, if you look at it purely from a user's perspective
who is manually invoking these commands for the command's primary purpose,
the current behavior is annoying.

If we assume Git is right in implementing that no server async actions are
executed on behalf of a client action, then this falls under the category of
an ill-behaved server in my opinion.  Anything a server does that is not
directly related to fulfilling the requested client action is now considered
bad behavior as it blocks the client from continuing whatever it needs to
get on with.  I see such implementation in Git as favoring server's needs
over clients.

Regards,

Chris
