From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 11:26:01 -0700
Message-ID: <7viraixeme.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu May 24 20:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrI0k-0005Wv-5d
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXEXS0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXEXS0F
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:26:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42419 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXEXS0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:26:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524182602.FNUQ13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 14:26:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 36S11X0051kojtg0000000; Thu, 24 May 2007 14:26:01 -0400
In-Reply-To: <20070521211133.GD5412@admingilde.org> (Martin Waitz's message of
	"Mon, 21 May 2007 23:11:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48287>

Martin Waitz <tali@admingilde.org> writes:

> On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
>> Here is one possible idea:
>> 
>> We could store the GIT_DIR of submodule within the GIT_DIR of the
>> superproject instead of the submodule directory itself. So instead of:
>>  /
>>  /.git
>>  /subdir
>>  /subdir/.git
>> 
>> There would be:
>>  /
>>  /.git
>>  /subdir
>>  /.git/submodules/submodule-name.git
>> 
>> This would require changes to the logic how git finds GIT_DIR (which would be
>> really deep change), but it would provide place to store the submodule data
>> while the submodule is not being checked out. 
>
> I agree that we need something like that.
>
> We don't have to move the entire subproject.git into the superproject,
> but we need to have all _referenced_ objects in the .git dir of the
> superproject.
>
> There are several possibilities to do so:
>
>  * move the entire .git dir
>  * move .git/objects
>  * explicitly copy all referenced objects

I was hoping that we can start from an initial cut that supports
only a superproject that had its subprojects in their places
from its initial commit, and did not have to worry about this
from day one, and deal with this kind of "more advanced" stuff
incrementally.  Unfortunately it's more fun to talk about more
advanced stuff than starting with small but solid stuff.

And we would need to make sure whatever we do as the "small but
solid" initial round can later support more advanced
arrangements later, so we would need to think about the issues
now anyway to a certain degree.

How about doing something like this, instead?

 (1) superproject .gitmodules (in-tree) and .git/config (local
     repository) use the three-level naming in $gmane/47567.
     Namely, (1a) .gitmodules says which subdirectory has a
     checkout of what project, and names the project in
     logical/abstract terms, not with a URL (e.g. "kernel26");
     (1b) .gitmodules also associates a set of suggested URLs
     for each of the logical/abstract project name; (1c)
     .git/config records which project are of interest.

 (2) In superproject .git/, we would have a bare repository for
     each project used by the superproject.

	.git/subproject/kernel26/{objects,refs,...}

     This is created by making a bare clone from the upstream
     URL, decided by the user with the help from suggested URL
     described in the superproject .gitmodules.

     The idea is to use this repository as a long-term
     subproject state across branch switching.

 (3) When we need to check out a revision of superproject whose
     .gitmodules has "kernel-src/ -> kernel26", and when we
     haven't done so (perhaps we are doing an initial checkout,
     perhaps we are switching from a different revision of the
     superproject that did not have "kernel26" project at
     kernel-src/ directory), we rm -f kernel-src/ and then
     "git-clone -l -s" from the repository we keep in (2) to
     populate kernel-src/ directory.

 (4) Before performing the above step (3), we need to make sure
     we are not losing anything in kernel-src/ if exists.  Three
     cases plus one:

     (4a) The path kernel-src/ in the old checkout was not a
     subproject (either it did not exist, it was a blob, or it
     was a directory with files that are tracked as part of the
     superproject).  The usual "don't lose local modification"
     rule we use try to carry local changes forward across
     branch switching, but in this case we shouldn't do so.

     (4b) It has the same logical/abstract project checked out;
     the commit recorded in the superproject tree may or may not
     be the same as what its HEAD points at.  In this case we do
     not have to worry about swapping the git repository at
     kernel-src/ directory, although we would need to check out
     the correct revision, and worry about what to do with any
     local modification (I think the usual "don't lose local
     modification but carry them forward" rule would be Ok in
     this case).

     (4c) It has a different project checked out; we need to be
     careful to keep local changes, and also we need to make
     sure the local changes in this subproject repository are
     pushed back to (2).  It could be that automated "git push"
     after making sure everything is committed is sufficient and
     have the user handle failure cases.

     (4d) This applies not just "before step (3)", but in cases
     where we need to replace a checked out subproject directory
     with something else (e.g. blob or directory that belong to
     the superproject, or noneness).  We would need to make sure
     no local change is lost, and the repository is synched up
     with (2).

I think an arrangement like this would solve "symlink is a bitch
for MinGW" problem Johannes Sixt brought up today with Sven's
RFC as well.
