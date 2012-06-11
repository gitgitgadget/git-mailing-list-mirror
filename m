From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 11:31:03 -0400
Message-ID: <20120611153103.GA16086@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6as-0005hT-9v
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab2FKPb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:31:27 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49067 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2FKPb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:31:26 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1Se6aI-00034L-Ip; Mon, 11 Jun 2012 15:31:14 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Se6a7-0004KY-Cc; Mon, 11 Jun 2012 11:31:03 -0400
Content-Disposition: inline
In-Reply-To: <87vcixaoxe.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199661>

On Mon, Jun 11, 2012 at 04:44:29PM +0200, Thomas Rast wrote:
> 
> Starting with v1.7.10.2, and in the v1.7.11-rc versions, there's a
> change by Peff: 7e52f56 (gc: do not explode objects which will be
> immediately pruned, 2012-04-07).  Does it solve your problem?

I'm currently using 1.7.10.2.552.gaa3bb87, and a "git gc" still kicked
loose a little over 4.5 megabytes of loose objects were not pruned via
"git prune" (since they hadn't yet expired).  These loose objects
could be stored in a 244k pack file.

So while I'm sure that change has helped, if you happen to use a
workflow that uses git rebase and/or guilt and/or throwaway test
integration branches a lot, there will still be a large number of
unexpired commits which still get kicked loose, and won't get pruned
for a week or two.

What I think would make sense is for git pack-objects to have a new
option which outputs a list of object id's which whould have been
kicked out as loose objects if it had been given the (undocumented)
--unpacked-unreachable option.  Then the git-repack shell script (if
given the -A option) would use that new option instead of
--unpacked-unreachable, and then using the list created by this new
option, create another pack which contains all of these
unreachable-but-not-yet-expired objects.

Regards,

						- Ted
