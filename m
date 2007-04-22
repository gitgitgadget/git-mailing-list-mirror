From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 0/4] External 'filter' attributes and drivers
Date: Sat, 21 Apr 2007 18:19:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704211757210.5655@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfRFa-0004DB-2z
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbXDVBwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXDVBwX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:52:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:60462 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753968AbXDVBwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:52:22 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 21 Apr 2007 18:52:22 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 21 Apr 2007 18:52:20 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <11771520591529-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45207>

On Sat, 21 Apr 2007, Junio C Hamano wrote:

> I know this is controversial, but here is a small four patch
> series to let you insert arbitrary external filter in checkin
> and checkout codepath.
>
> [PATCH 1/4] Simplify calling of CR/LF conversion routines
> [PATCH 2/4] convert.c: restructure the attribute checking part.
> [PATCH 3/4] lockfile: record the primary process.
> [PATCH 4/4] Add 'filter' attribute and external filter driver definition.
>
>
> [1/4] is Alex's earlier patch, rebased on top of 'next'.
>
> [3/4] is necessary for the series because otherwise 'git add'
> would not work with any external filter, but the change is
> applicable to 'master'.
>
> [4/4] is the body of the change.  I wanted to like run-command.h
> process spawning infrastructure, but I suspect I did not use it
> optimally.  People who were more involved in its evolution
> hopefully have suggestions for better use of it.

thanks for doing this.

from other discussions on the subject I was under the impression that in some 
cases git commands would look at the file in the working directory instead of 
extracing it from the object blob if the index and timestamp indicated that the 
file had not been changed.

with an external filter in use this is not a safe thing to do and that needs to 
be disabled if gitattributes specifies an external filter (and possibly if 
gitattributes specifies crlf)

this brings up a potential performance problem. if you have to look for 
.gitattributes in all parent directories for each file manipulation tha may want 
to use the working tree optimization, you can end up with a lot fo time wasted 
in just looking up non-existant files (or in finding files and parseing them). 
Apache has this problem with their .htaccess files wher eyou can get a pretty 
substantial performance boost by disabling them. it may be worth it to be able 
to not use .gitattribute files, but only use the repository-wide gitattributes 
file.

Finally, a how-to question

in my case I have two uses for this

1. a permission preserving filter.

  This records the permissions on checking, sets them on checkout

2. host specific file munging for config files

   I have a XML file that specifies what munging should be done for each host and 
a perl script that does this munging

in both of these cases I have a config for the filter (the list of permissions 
or the xml file defining the munging) that should be checked into the repository 
as part of the commit

the problems I see are

1. the config file needs to be checked out before any files that go through the 
filter so that the filter has it available to use

2. when checking in files there is a potential of having the config file change 
between one addition to the index and another. Part of this is in the "well, 
don't do that then catagory" of things, but for things like the permission 
filter this is harder to do

if there is one master permission file then each file checkin could potentially 
add/modify a line in it. as long as lines related to other files aren't changed 
you could re-add it to the index, overriding the prior version.

if you do one permission file per file you are tracking the permissions of (say 
.permissions.$file) then you don't have to worry about different versions of the 
file, but you still need to have the filter (which is running as part of a 
checking) do a checkin of another file. This approach would also make it harder 
to know which files need to be checked out before the filter can run.

any thoughts on how to deal with these issues?

David Lang
