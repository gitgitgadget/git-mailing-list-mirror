From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver 
  definition.
Date: Sun, 22 Apr 2007 14:05:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704221328300.6340@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net> 
 <11771520591703-git-send-email-junkio@cox.net><Pine.LNX.4.63.0704211821560.
 5655@qynat.qvtvafv  gr.pbz><7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.63.070422020255
 0.5946@qynat.qvtvafvgr.pbz> <7v4pn8paqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 23:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfjmG-0000rw-2f
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbXDVVjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXDVVjU
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:39:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:37308 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752548AbXDVVjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:39:19 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 14:39:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 14:39:15 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v4pn8paqf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45282>

On Sun, 22 Apr 2007, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>>> The conversion is not about overriding the mode bits recorded in
>>> tree objects, nor making git as a replacement for build procedure.
>>
>> what build procedures?
>>
>> I'm talking about doing things like managing files in /etc
>
> That's exactly what "build procedure" is about.  Nobody sane
> should be managing /etc files *directly* under any SCM.  A saner
> practice is to have a separate source area with Makefile to
> regenerate /etc files, so that (1) "make" manages the target
> host specific customizations, (2) "make diff" can be used to
> compare and sanity check the result of "make" against what is
> currently installed under /etc, and (3) "make install" manages
> the permission bits.  The same applies to dotfiles under $HOME/.

this I disagree with this, simply becouse it discourages people from useing a 
SCM for these things due to all the other work that needs to be done

doing it this way you need to
create a new work area
create a build system
find all the tools that change the files and change them to work on the files in 
the work area (and note that some of these tools are distro provided that you 
will have to fork, replace, or live without)
change all sysadmin work habits to use the new work area
not to mention, pick up the pieces when someone/something makes changes to the 
files directly.

by comparison, working in /etc directly all you need to do is to train the 
sysadmins to do a commit after they make changes, and how to revert to the 
prior version if things break (and then train the senior sysadmins to do the 
checkouts of specific versions, resolve merges, and other 'advanced' things to 
pickup the pices when things get messed up)

in fact, you can even get a lot of utility out of a daily cron job to do a 
commit and teaching a few people about git while the remainder don't even know 
that it's running.

everything above is just dealing with the simple case of managing the config 
files on a single system

now, I agree that there are advantages to not working directly in /etc and 
instead working in a seperate area with a build system to actually modify the 
files, but getting to that point is a lot of work, and getting everyone 
(including management) convinced that it's worth that much up-front effort for 
the long-term benifits is hard. and if the sysadmins are under water currently, 
it won't happen becouse they can't let other things fall apart while they go and 
build this new system.

I think this is a case of perfect being the enemy of better.

the simple case of handling files in /etc/directly is so non-intrusive that 
distros could ship it with a nightly cron job enabled by default (ideally the 
cron job would detect that no changes were made and not do a commit) and once 
you have a SCM in place managing the files by default it's much more likely that 
sysadmin tools will start to be changed to work with it directly.

This should not be a huge change for git to suppor this either (although I admit 
it is a change)

with filters enabled at all you need to be able to disable any optimizations 
that use the working tree instead of opeing up an object/pack

so the remaining changes are

1. define a dependancy that allows for filter config files to be extracted 
before the filter is run on checkout

2. allow the filter to do git-add of a file while it is running on git-add (or 
otherwise tell git that a file needs to be added before a commit is done). I 
don't know if this would work today, or if there are locks that would cause a 
deadlock (I suspect a deadlock from comments about git-lib needing to be made 
re-entrent)

3. move the filter from a pipe/pipe model to a pipe/file model (it's fair to 
require the filters to support - as a filename for stdin/stdout git needs this, 
it's fairly standard for unix utilities to do this)

David Lang
