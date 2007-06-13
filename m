From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] make git barf when an alias changes environment variables
Date: Wed, 13 Jun 2007 07:41:36 +0200
Message-ID: <20070613054136.GA27476@moooo.ath.cx>
References: <20070608205755.GA21901@moooo.ath.cx> <7vejkgh1jf.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 07:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyLc1-0000YF-Kz
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 07:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXFMFll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 01:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXFMFll
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 01:41:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:59750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751269AbXFMFlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 01:41:40 -0400
Received: (qmail invoked by alias); 13 Jun 2007 05:41:38 -0000
Received: from pD9EBB4AE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.174]
  by mail.gmx.net (mp017) with SMTP; 13 Jun 2007 07:41:38 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/FitxHGWbFlkc1w4Ik3TQcZVnLeJ9N8q9ribRY0M
	089yIoebgzR+8q
Content-Disposition: inline
In-Reply-To: <7vejkgh1jf.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50016>

Junio C Hamano <gitster@pobox.com> wrote:
> What does this patch do when you do this?
> 
> 	: Because I usually work with this repository...
>       $ GIT_DIR=$some_repository
>       $ export GIT_DIR
> 
>       : Then much later, I happen to visit another repository
>       : to take a peek...
> 	$ cd $somewhere_else
>       $ git --git-dir .git some-command
> 

This one has no alias involved as far as I see, so there is no change.

The patch makes git barf when an alias changes the environment (i.e.
an alias uses --git-dir/--work-tree/--bare).  When git has read the
configuration file to find out about aliases setup_git_env has been
called and a pointer returned by getenv("GIT_DIR") is already stored
in a static pointer.  If the environment variable is changed
afterwards git might or might not use the new value depending on the
implementation.

That is what my example shows: FreeBSD libc reuses the old memory
location if the new value of an environment variable fits in the old
place.  Because setup_git_env uses xstrdup on the object dir and some
other directories the old value is used for those but the new one is
used for git_dir (which is just a pointer returned by getenv).  This
way HEAD is read from the new repository but objects are searched in
the old repository.
