From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc & deleted branches
Date: Sun, 11 May 2008 11:39:12 -0700
Message-ID: <7vy76g3ctr.fsf@gitster.siamese.dyndns.org>
References: <loom.20080509T011318-478@post.gmane.org>
 <20080509041921.GA14773@sigill.intra.peff.net>
 <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
 <48246A44.7020303@nrlssc.navy.mil>
 <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
 <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
 <20080510002014.GH29038@spearce.org>
 <7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com>
 <20080510052548.GA11556@sigill.intra.peff.net> <87tzh6yb2w.fsf@jeremyms.com>
 <alpine.DEB.1.00.0805101003350.30431@racer> <87prruxh3z.fsf@jeremyms.com>
 <alpine.DEB.1.00.0805111204580.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 11 20:40:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGTD-0001jT-2a
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbYEKSji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbYEKSjh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:39:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbYEKSjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:39:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7B142612;
	Sun, 11 May 2008 14:39:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9508B260D; Sun, 11 May 2008 14:39:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A10A9C4-1F89-11DD-8A61-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81809>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, I think that the setuid helper script would open a whole bunch of 
> other issues.
>
> I think that the shared repository problem is rather a semantic one, i.e. 
> it is only solvable between the owners of the repository by good-ole 
> talking, not something that can be solved by the tool (Git).

I very strongly agree with you that the suid helper would be the last
ditch thing we would want to avoid doing unless there is no other way.  I
also agree with you that the owners of the repository need to be talking.

But I think the tool _could_ help them do their talking.  It is
conceivable that just like you can explicitly allow selected others to
push into your own repository, you would want to explicitly allow some
others to ask you to keep objects their repositories borrow from you.

	Originally, I wrote "allow others to borrow from you", but that is
	very ill defined.  If they can read from your repository they can
	unilaterally borrow from you without having any write permission
	to your repository that is needed to install backpointers.

I am not fundamentally opposed to a backpointer that point at borrowers so
that the lender can protect the objects that are pointed by them.
However, there are two technical issues in the solution of pointing at the
borrower's .git/refs with a symlink from the repository that is borrowed
from, as I pointed out when this came up last time.

 - There are systems without symbolic links.

 - A symref (e.g. refs/remotes/origin/HEAD of borrower that points at
   refs/remotes/origin/master of borrower) is relative to borrower's
   repository.
