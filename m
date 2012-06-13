From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Wed, 13 Jun 2012 18:17:46 +0000 (UTC)
Message-ID: <loom.20120613T185623-81@post.gmane.org>
References: <20120611213948.GB32061@sigill.intra.peff.net> <20120611221439.GE21775@thunk.org> <20120611222308.GA10476@sigill.intra.peff.net> <alpine.LFD.2.02.1206112024110.23555@xanadu.home> <20120612171048.GB12706@sigill.intra.peff.net> <alpine.LFD.2.02.1206121326490.23555@xanadu.home> <20120612173214.GA16014@sigill.intra.peff.net> <alpine.LFD.2.02.1206121345500.23555@xanadu.home> <20120612175438.GB16522@sigill.intra.peff.net> <alpine.LFD.2.02.1206121359260.23555@xanadu.home> <20120612191528.GB16911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 20:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SesKk-0005MD-C3
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab2FMSaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 14:30:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:57407 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2FMSaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 14:30:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SesKT-0004Ya-7F
	for git@vger.kernel.org; Wed, 13 Jun 2012 20:30:06 +0200
Received: from sp6.qualcomm.com ([199.106.103.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 20:30:05 +0200
Received: from mfick by sp6.qualcomm.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 20:30:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 199.106.103.56 (Mozilla/5.0 (X11; U; Linux; en-US) AppleWebKit/532.4 (KHTML, like Gecko) konqueror/4.4.5 Safari/532.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199917>

Jeff King <peff <at> peff.net> writes:
> > Then, the creation of unreferenced objects from successive 'git add' 
> > shouldn't create that many objects in the first place.  They currently 
> > never get the chance to be packed to start with.
> 
> I don't think these objects are necessarily from successive "git add"s.
> That is one source, but they may also come from reflogs expiring. I
> guess in that case that they would typically be in an older pack,
> though.
...
> That is satisfyingly simple, but the storage requirement is quite bad.
> The unreachable objects are very much in the minority, and an 
> occasional duplication there is not a big deal; duplicating all of the 
> reachable objects would double the object directory's size.
...
(I don't think this is a valid generalization for servers)

I am sorry to be coming a bit late into this discussion, but I think there
 is an even worse use case which can cause much worse loose object 
explosions which does not seem to have been mentioned yet:   "the 
server upload rejected case".  For example, think of a client pushing a 
change from the wrong repository to a server.  Since there will be no 
history in common, the client will push the entire repository and if for
 some reason this gets rejected by the server (perhaps a pre-receive 
hook, or a gerrit server which says:  "way too many new changes..."), 
then the pack file may stay abandonned on the server.  When gc runs: 
boom the entire history of that other project will explode but not get
 pruned since the pack file may be fairly new!

I believe that this has happened to us several times fairly recently.  We
 have a tiny project which some people keep confusing for the kernel
and they push a change destined for the kernel to it.  Gerrit rejects it and
their massive packfile (larger than the entire project) stays around.  If gc 
runs, it almost becomes a DOS for us, the sheer number of loose object
files makes the system crawl when accessing that repo, even on an SSD.
 We have been talking about moving to NFS soon (with packfiles git 
should still perform fairly well on NFS), but this explosion really scares 
me.

It seems like the current design is a DOS just waiting to happen for
servers.  While I would love to eliminate the races discussed in this
thread, I think I agree with Ted in that the first fix should just focus on
never expanding loose objects for pruning (if certain objects simply don't 
do well in pack files and the local gc policy says they should be loose, 
go ahead: expand them, but that should be unrelated to pruning).  People
can DOS a server with unused packfiles too, but that rarely will have the
same impact that loose objects would have,

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a member 
of Code Aurora Forum
