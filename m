From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 2 Feb 2012 15:12:26 -0500
Message-ID: <20120202201226.GA1032@thunk.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt31H-0000NI-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab2BBUMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:12:31 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:42449 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870Ab2BBUMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:12:30 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1Rt319-00014b-QR; Thu, 02 Feb 2012 20:12:27 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Rt318-0008BB-E2; Thu, 02 Feb 2012 15:12:26 -0500
Content-Disposition: inline
In-Reply-To: <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189695>

On Thu, Feb 02, 2012 at 12:02:27PM -0800, Junio C Hamano wrote:
> 
> Thanks for a patch.  How does this compare with what was discussed in the
> other thread?
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/188992/focus=189172

I wasn't aware of this other approach when I created this patch (I
must have missed the e-mail thread, sorry).

One of the reasons why I did it this way was for more flexibility.  I
wanted to be able to do:

$ make PROFILE_GEN=YesPlease PROFILE_DIR=/var/cache/FDO all
# make PROFILE_GEN=YesPlease PROFILE_DIR=/var/cache/FDO install

run a bunch of git commands on various git repositories to get
real-life usage...

Then do...

$ make PROFILE_USE=YesPlease PROFILE_DIR=/var/cache/FDO all
# make PROFILE_GEN=YesPlease PROFILE_DIR=/var/cache/FDO install

But for many people they would probably be satisfied with something
that builds git using a single magic recipe, even if they give up some
fractional performance improvement (keep in mind that the feedback
directed optimization seems to buy you only a single digit percentage
improvement according according to Andi's original experiment; I just
got interested in this more for amusement value than any thought that
it would save me serious amounts of time).

> I would wish a solution ideally would support
> 
> 	make PROFILE_BUILD=YesPlease
>         make PROFILE_BUILD=YesPlease install

At least in theory, it should be possible to have something which
supports both PROFILE_GEN/PROFILE_USE as well as a combined
PROFILE_BUILD.

The hard part is that PROFILE_BUILD requires a multi-pass process; you
need to build with one set of CFLAGS, then run the sample workload to
get the data for your feedback directed optimizations, and then re-run
the build with another set of CFLAGS.  I think what we could to check
for PROFILE_BUILD, and if it is set, do the first PROFILE_GEN / make
test commands as part of the top-level Makefile's all: rule, and then
do the normal build after that.

It's a little kludgy, but does that sound acceptable to you?

       	      	      	       	    	  - Ted
