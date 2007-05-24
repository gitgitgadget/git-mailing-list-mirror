From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 12:43:41 -0700
Message-ID: <7vk5uyvwgi.fsf@assigned-by-dhcp.cox.net>
References: <11795163061588-git-send-email-skimo@liacs.nl>
	<20070518215312.GB10475@steel.home>
	<20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu May 24 21:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJDu-0007ML-As
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbXEXTnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXEXTnn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:43:43 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55566 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbXEXTnm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:43:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524194341.HRZK2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 15:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 37jg1X00j1kojtg0000000; Thu, 24 May 2007 15:43:41 -0400
In-Reply-To: <7viraixeme.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 24 May 2007 11:26:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48298>

Junio C Hamano <junkio@cox.net> writes:

Sorry, I hate to send "amend" message like this, but there are
some places I was not clear enough...

> How about doing something like this, instead?
>
>  (1) superproject .gitmodules (in-tree) and .git/config (local
>      repository) use the three-level naming in $gmane/47567.
>      Namely, (1a) .gitmodules says which subdirectory has a
>      checkout of what project, and names the project in
>      logical/abstract terms, not with a URL (e.g. "kernel26");
>      (1b) .gitmodules also associates a set of suggested URLs
>      for each of the logical/abstract project name; (1c)
>      .git/config records which project are of interest.

... are of interest, and perhaps which URL to use but that is
not necessary, as we can record that in repositories we create
in (2).

>  (2) In superproject .git/, we would have a bare repository for
>      each project used by the superproject.
>
> 	.git/subproject/kernel26/{objects,refs,...}
>
>      This is created by making a bare clone from the upstream
>      URL, decided by the user with the help from suggested URL
>      described in the superproject .gitmodules.

This bare clone probably have its own config that records
remote.origin.url, which would probably be the same as one of
the URL suggested in .gitmodules for many people, but could be
different.  As to what should happen when the .gitmodules that
comes from the upstream changes the set of suggested URLs
recorded in there, see $gmane/47621,

>      The idea is to use this repository as a long-term
>      subproject state across branch switching.
>
>  (3) When we need to check out a revision of superproject whose
>      .gitmodules has "kernel-src/ -> kernel26", and when we
>      haven't done so (perhaps we are doing an initial checkout,
>      perhaps we are switching from a different revision of the
>      superproject that did not have "kernel26" project at
>      kernel-src/ directory), we rm -f kernel-src/ and then
>      "git-clone -l -s" from the repository we keep in (2) to
>      populate kernel-src/ directory.

The last part of the above should have been:

       we "rm -fr kernel-src/" and then "git-clone -l -s -n"
       from the repository we keep in (2).  And then check out
       the commit that is pointed at by the superproject tree
       (rather, "index").

>  (4) Before performing the above step (3), we need to make sure
>      we are not losing anything in kernel-src/ if exists.  Three
>      cases plus one:
>
>      (4a) The path kernel-src/ in the old checkout was not a
>      subproject (either it did not exist, it was a blob, or it
>      was a directory with files that are tracked as part of the
>      superproject).  The usual "don't lose local modification"
>      rule we use try to carry local changes forward across
>      branch switching, but in this case we shouldn't do so.

The last part of the above should have been:

       ... but in this case we shouldn't even try to carry local
       changes forward, as there is nowhere to carry them to.
       Instead we should error out and have the user clean-up
       the subproject repository (either "git reset", or "git
       commit && git push" to stash the change back to
       repository we prepared in (2)).  We might also want to
       allow the user to say "local changes in this subproject
       checkout does not matter" by saying "git checkout -f
       $commit" at the superproject level, but I think that is
       rather dangerous.

>      (4b) It has the same logical/abstract project checked out;
> ...
>      (4c) It has a different project checked out; we need to be
>      careful to keep local changes, and also we need to make
>      sure the local changes in this subproject repository are
>      pushed back to (2).  It could be that automated "git push"
>      after making sure everything is committed is sufficient and
>      have the user handle failure cases.
>
>      (4d) This applies not just "before step (3)", but in cases
>      where we need to replace a checked out subproject directory
>      with something else (e.g. blob or directory that belong to
>      the superproject, or noneness).  We would need to make sure
>      no local change is lost, and the repository is synched up
>      with (2).

... which is the same check and action we would do in case (4c).
