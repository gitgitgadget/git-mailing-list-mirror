From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Thu, 02 Feb 2006 11:31:35 -0800
Message-ID: <7v3bj1r208.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
	<7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602020113200.30910@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr76m36ge.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602021932450.16426@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 20:32:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4kBL-0002LX-HN
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 20:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWBBTbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 14:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBBTbi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 14:31:38 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25735 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932200AbWBBTbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 14:31:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202193140.JYVU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 14:31:40 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15517>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Scenario: I have cvsimported a project. Using a graft, I told git that a 
> certain commit is indeed a merge between two branches. That is, in 
> addition to the parent the commit objects tells us about, it has another 
> parent which was tip of another branch.
>
> How would this graft be interpreted by the server we want to pull from? As 
> if we had cut off the history. Which we did not. In effect, we could be 
> sent many, many objects we already have.

I thought the protocol is sending the full graft file both ways.
The uploader says "here are the grafts I have and use", and the
downloader modifies it and sends back what grafts it wants to
be used during the common revision discovery (aka building
rev-list parameters).  The most important modification during
this exchange is to cauterize the history at --since=v2.6.14
commit (or tag).

The uploader may not have the fake parent you grafted onto a
commit.  You may have a graft entry that says commit W has X, Y
and Z as its parents, when its real parent is only X.  Y may be
some other commit in the project (i.e. the other end knows about
it but it is not a real parent of W), and Z may be from a
development track that the uploader has not even heard of.  You
may say a commit V does not have parent but that commit itself
is from a separate development track the uploader does not know
about.

The uploader, however, should be able to at least honour, modulo
implementation bugs ;-), "X and Y are both parents of W" part.
Just ignoring V and Z and keeping usable part of information
would be a reasonable fallback position [*1*].  And that should
not result in a "many objects" situation when the downloader
says "Now I happen to have W, do not send things reachable from
it".  The uploader side should be able to omit what are
reachable from X or Y even though it cannot exclude things
reachable from Z.  Because the uploader does not even have Z,
there is no reason to worry about things reachable from Z being
sent unnecessarily to the downloader.

At least that was the intention.  "graft" messages are not about
sending "here are the cut-off points"; it is to agree on the
graft information both ends use during the common revision
computation.  The experimental code does not treat cut-offs any
differently other grafts.


[Footnote]

*1* we might want to enhance the "shallow" protocol further to
do this exchange slightly differently.  The downloader first
sends its grafts (which may contain parents or graft/cutoff
points that uploader does not have), and the uploader adjusts
the received grafts for commits like V and parents like Z and
then add its own grafts.  The result is sent back to the
downloader and that becomes the common set of grafts in effect
during the common revision discovery.  This would contain
commits and parents that the downloader does not yet have but
that is not a problem for common revision discovery.  After the
transfer is done, the downloader would adjust its "graft" file
if it made a new shallow clone, but otherwise it should not use
the information it received from the uploader, because things
like V and Z are not in this list.  I _think_ it would suffice
to look at each graft entry and to add that entry locally if it
talks about a commit the downloader does not have in its graft
file.
