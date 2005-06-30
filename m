From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 19:48:33 +0100
Message-ID: <1120157313.2066.324.camel@sisko.sctweedie.blueyonder.co.uk>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Stephen Tweedie <sct@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 20:42:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do3yt-0004P3-RD
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVF3StM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 14:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVF3StM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 14:49:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262897AbVF3StH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 14:49:07 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5UImhe0025451;
	Thu, 30 Jun 2005 14:48:43 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5UImcu09838;
	Thu, 30 Jun 2005 14:48:38 -0400
Received: from chunnel (sct.cipe.redhat.com [10.0.1.44])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j5UImYs8023503;
	Thu, 30 Jun 2005 14:48:37 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2005-06-28 at 20:23, Matthias Urlichs wrote:

> That was cvs2git's shell script. Which, by the way, is slow as hell.

I discovered why yesterday --- it's this patch:

commit deb153a75ae1f5eca628a38b911474a69edd242d
...
    [PATCH] cvs2git and file permissions
    git-cvs2git: propagate mode information
     
    Let cvs checkout in a temporary directory rather than
    using the pipe option to avoid loss of mode information.

This has a very unfortunate side effect --- when CVS checks out into a
new directory, it then waits for the time to advance to the next second
so that it can guarantee that future writes to the checked-out file
always change the timestamp from what it stores in CVS/Entries.

And when you're doing repeated checkouts, that means you get one per
second, max.  And so the git cvs import was taking one ... second ...
per ... revision ... per ... file, instead of the 8 complete changesets
or better I was getting before the above change.

Reverting the change back to checkout-via-pipe fixed the performance
problem for me, but obviously we're back to losing the mode information.

--Stephen
