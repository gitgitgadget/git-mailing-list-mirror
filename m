From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git push" logic changed?
Date: Fri, 20 Jan 2006 16:03:50 -0800
Message-ID: <7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F06Ej-0003a1-IT
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 01:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAUADx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 19:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWAUADx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 19:03:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33020 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750823AbWAUADw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 19:03:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121000237.JLFF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 19:02:37 -0500
To: Greg KH <greg@kroah.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14980>

Greg KH <greg@kroah.com> writes:

> As of the git development tree from last night, 'git push' seems to work
> a bit differently now.

The change was 9e9b267.  I suspect the earlier way was a bit
more friendly to savvier people (especially the subsystem
maintainers and the project lead), but it was found to be
confusing for people who clone from an upstream and then use
that as a shared repository.  Their developers further clone
from that shared repository, and as needed pull from the true
upstream.  When they push their changes back, "git push
central:/shared.git/" would trigger a "remote origin does not
fast forward" error, depending on when these developers fetched
from the shared repository the last time, and whether they
stored what they fetched from the shared repository in their
"origin" or not.  If you do "git pull central:/shared.git/", not
"git pull origin" (taking advantage of remotes/origin file),
your "origin" branch would become out-of-date.  Which is OK for
the purpose of maintaining "master" branch properly, but pushing
meaningless "origin" back to "origin" at the shared repository
(which is also meaningless) was triggering an error and causing
confusion in that setup.

> Or should I always be doing --all?

In order to make sure all your local refs are on the "parent",
then yes.  And this is not new.  It used to push all the refs
that appear in _both_ your local repo and the "parent" repo, so
your new tags and branches did not get propagated so you needed
to use '--all' in such a case anyway.  We now also have '--tags'
to push all tags.

We could probably resurrect the earlier behaviour with a
'--matching' option or something if you'd like.
