From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 11:58:26 -0700
Message-ID: <7vy7jevyjx.fsf@assigned-by-dhcp.cox.net>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
	<20070524184549.GW942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 20:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIW7-0004VD-MR
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbXEXS62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXEXS62
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:58:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46311 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbXEXS61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:58:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524185827.VXYC19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 14:58:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 36yS1X0021kojtg0000000; Thu, 24 May 2007 14:58:26 -0400
In-Reply-To: <20070524184549.GW942MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Thu, 24 May 2007 20:45:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48292>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Thu, May 24, 2007 at 11:26:01AM -0700, Junio C Hamano wrote:
>> How about doing something like this, instead?
>> 
>>  (1) superproject .gitmodules (in-tree) and .git/config (local
>>      repository) use the three-level naming in $gmane/47567.
>>      Namely, (1a) .gitmodules says which subdirectory has a
>>      checkout of what project, and names the project in
>>      logical/abstract terms, not with a URL (e.g. "kernel26");
>>      (1b) .gitmodules also associates a set of suggested URLs
>>      for each of the logical/abstract project name; (1c)
>>      .git/config records which project are of interest.
>
> What about the idea of considering any project that is already
> present to be of interest by default ?

You could do that -- I consider that a minor detail in the
implementation.

>>  (2) In superproject .git/, we would have a bare repository for
>>      each project used by the superproject.
>> 
>> 	.git/subproject/kernel26/{objects,refs,...}
>> 
>>      This is created by making a bare clone from the upstream
>>      URL, decided by the user with the help from suggested URL
>>      described in the superproject .gitmodules.
>
> Do you mean a "pure" clone, i.e., without a working tree,
> but with separate-remotes?

I meant a bare clone without separate remotes.

The counter-proposal outline essentially says, for the sake of
simplicity, "nuke existing subproject directory whenever we need
to replace it with something else, and reclone a new/replacement
subproject directory every time we need to check it out, after
making sure nothing is lost".

Except that having this intermediate repository (a) helps making
such a re-clone extremely cheap "git clone -l -s -n", and (b)
provides with a place to hold locally committed changes that are
not pushed back to the true upstream (you may _never_ push it
back in the first place).

>>      (4b) It has the same logical/abstract project checked out;
>>      the commit recorded in the superproject tree may or may not
>>      be the same as what its HEAD points at.  In this case we do
>>      not have to worry about swapping the git repository at
>>      kernel-src/ directory, although we would need to check out
>>      the correct revision, and worry about what to do with any
>>      local modification (I think the usual "don't lose local
>>      modification but carry them forward" rule would be Ok in
>>      this case).
>
> We may also need to fetch from the remote subproject.
> Should I do this with a "git fetch" during the checkout as I do now?

If you are disconnected, you obviously cannot afford to update
(2) every time you switch branches in the superproject, and even
if you are connected, updating (2) would not be needed most of
the time if what you are doing is switching superproject
branches, as long as your last superproject fetch is not very
much more recent than your last subproject fetch.

If we were to follow the outline in the counter-proposal, I'd
imagine that update of (2) can happen at any time.  It could be
part of "git fetch" in superprojects, of lazily done when we
need to checkout a new revision for a particular subproject, but
only if the last time you fetched superproject is more recent
than the time you updated (2) for the subproject last time.

Or something like that.  I consider that also a minor detail in
the implementation.
