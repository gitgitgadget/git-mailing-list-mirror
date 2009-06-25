From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and *lots* of ssh connections
Date: Thu, 25 Jun 2009 02:49:20 -0700
Message-ID: <20090625094919.GC2901@dcvr.yhbt.net>
References: <cccedfc60906100709r18364bc2h82d8e1a7ee0b8fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlaH-0004VY-TB
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 11:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZFYJtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 05:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZFYJtV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 05:49:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39894 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZFYJtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 05:49:21 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 8C0CD1F44D;
	Thu, 25 Jun 2009 09:49:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cccedfc60906100709r18364bc2h82d8e1a7ee0b8fd1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122190>

Jon Nelson <jnelson@jamponi.net> wrote:
> The company I work for (but do not speak for) uses svn (via ssh). I
> tried to use it; I really did. But I missed git and found svn quite
> honestly painful to use so I went to git-svn, and other than some
> caveats I'm pretty happy.  However, one of the issues I've had with
> git-svn is fairly troublesome.
> 
> Basically, during the fetch stage (or clone) git-svn uses a *ton* of
> ssh connections. Many dozens and in even with smaller projects well
> over a hundred. By "small" I mean a .git of less than 6MB and less
> than 60 files in the checkout. I've got 4MBit bandwidth available but
> frequently see only a single digit fraction of that going to the
> fetch/clone process. Is there anything that can be done to reduce the
> number of ssh connections involved? Why can't a single connection
> simple be re-used? I can't use "ssh connection sharing" for a variety
> of reasons that aren't relevant here.
> 
> I'm using 1.6.0.2.

Hi Jon,

The actual connection setup/teardown is handled by the SVN Perl bindings
which gives git-svn little control over handling them.  We actually try
to force a zero reference count to close a connection to an open SVN
repository.

Which OS/Perl version/SVN bindings version are you using?

Could the ssh processes just be zombies that didn't get reaped?

Does this happen when you clone a single directory with
--no-follow-parent?  (no --stdlayout/-s option or --branches/--tags
switches, either).  Can you test against an http/https/plain-svn
server and see if it happens there?

I could be talked into putting in a (nasty!) hack to start zapping
integer file descriptors when switching paths/repos and hope SVN closes
those; but that may not work...

-- 
Eric Wong
