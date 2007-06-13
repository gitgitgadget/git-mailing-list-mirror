From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 12:57:58 -0700
Message-ID: <7vwsy7d3uh.fsf@assigned-by-dhcp.pobox.com>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
	<200706132034.29934.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Watson <dwatson@mimvista.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyYzG-0004y2-NZ
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbXFMT6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 15:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbXFMT6D
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 15:58:03 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43817 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbXFMT6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 15:58:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613195801.IRQZ2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 15:58:01 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7xz1X00D1kojtg0000000; Wed, 13 Jun 2007 15:57:59 -0400
In-Reply-To: <200706132034.29934.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 13 Jun 2007 20:34:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50122>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007, June 13, David Watson wrote:
>> I've got a problem, or maybe annoyance is more the proper term, that
>> I haven't seen solved by any SCM system (at least not to my
>> knowledge). Basically, I may make some changes, e.g. to a Makefile or
>> somesuch, that I want to ignore when looking at what's changed from
>
> So you want to tell git to track a file and then have it not track 
> changes to that file?  Sounds crazy to me.  Don't put files in the 
> repository that you don't want tracking.

Actually, that is a sign that either the upstream project is
broken, and/or the user's workflow is broken.

Taking an example closer to home, if we tell tell users "in
config.mk file you can suit your local needs" and at the same
time add config.mk to the official repository, that would be
crazy.  The changes to that file is _supposed_ to be local and
the other side will never be interested in getting updates to
that file.  So if David is dealing with such a situation, then
the problem is in the project organization.

On the other hand, it is usual to see a comment in the Makefile
that says "# No user tweakable part below this line", with
expectations that users will muck with make variable definitions
in the earlier parts of the Makefile to suit the local
filesystem layout and such.

The changes users will make to such a file fall into one of two
categories:

 (1) Local configuration changes to adjust to the user's
     particular installation.

 (2) Fixes, improvements and enhancements to the generic part
     ("below that line").

Other people, especially the "upstream" people, are never
interested in ever seeing patches of the former kind, while the
latter are of general use and you would want to feed themback.

You would need to separete out these two kinds at SOME stage
when you need to make changes of both kinds.  You can do that at
patch submission time, cleaning up the series, if you are
feeding the changes via patches.

If you are communicating with the other side via pull/push, then
you would need to have two histories that cleanly separates the
two.  Probably a good workflow is:

 - The tracking branch remotes/origin/master; this holds what is
   'pristine';
   
 - Keep 'master' branch for only the changes for general
   consumption.

 - Have a separate 'local' branch, that is forked from 'master'
   branch of yours.  Local configuration changes will go to this
   branch, never to 'master'.

You would never publish 'local' as it contains the local
configuration changes that are of no interest to others, but the
changes you may want to give back to outside will be readily
available in 'master'.

If I _were_ doing this, I would further use a topic branch that
forked from pristine to hold only the local changes, and use
'local' only as an integration branch between that local
configuration topic and 'master' (i.e. no commits will be made
to 'local' directly -- everything will come from either separate
topics or 'master').
