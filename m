From: Tim Stoakes <tim@stoakes.net>
Subject: Re: git-svn does not support intermediate directories?
Date: Wed, 4 Mar 2009 15:00:20 +1030
Message-ID: <20090304043019.GC20790@mail.rocksoft.com>
References: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lai <myllai@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 05:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LejBn-0002xi-8d
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 05:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZCDE5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 23:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbZCDE5K
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 23:57:10 -0500
Received: from hosted03.westnet.com.au ([203.10.1.215]:58421 "EHLO
	hosted03.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZCDE5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 23:57:09 -0500
X-Greylist: delayed 1604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 23:57:08 EST
Received: from hosted03.westnet.com.au (hosted03.westnet.com.au [127.0.0.1])
	by hosted03.westnet.com.au (Postfix) with SMTP id 092622BB103;
	Wed,  4 Mar 2009 13:30:22 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted03.westnet.com.au (Postfix) with ESMTP id 9330D2BB1E2;
	Wed,  4 Mar 2009 13:30:21 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 94567EE293;
	Wed,  4 Mar 2009 15:00:20 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 28A2F7F049; Wed,  4 Mar 2009 15:00:20 +1030 (CST)
Mail-Followup-To: Michael Lai <myllai@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112178>

Michael Lai(myllai@gmail.com)@030309-17:43:
>   After spending some hours struggling with git svn, it would appear
> that it does not support svn projects stored in paths similar to
> "http://foo.com/svn/repos/bar/myproject", where "myproject" uses the
> standard SVN tags/trunk/branches layout.  I'm currently using git
> 1.6.1, though I tried this with 1.6.2-rc2 as well.  The resulting
> .git/config looks something like this:
> 
> [svn-remote "svn"]
> 	url = http://foo.com/svn/repos/bar
> 	fetch = myproject/trunk:refs/remotes/trunk
> 	branches = bar/myproject/branches/*:refs/remotes/*
> 	tags = bar/myproject/tags/*:refs/remotes/tags/*
> 
> Yes, that's a redundant "bar" directory under "branches =" and "tags
> =".  The issue seems to lie in git-svn doing something intelligent to
> extract the appropriate trunk directory.  For the branches and tags,
> however, it just takes the full URL and removes the repository root
> (http://foo.com/svn/repos/bar) to produce "bar/myproject/{branches,
> tags}/*".  The second effect is that "git svn fetch" will run but exit
> quietly without actually pulling anything from the repository.  I
> tracked down an existing thread on the mailing list from a while ago
> (Feb 4th, title of "git-svn doesn't fetch anything"), but there was no
> resolution.

I've just run into this exact same issue.

> There is a quick workaround, which was to make this change to match_paths:
> < 	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
> ---
> > 	$self->{path_regex} ||= qr/\/\Q$self->{path}\E\//;
> 
> The additional "bar" directory gets pulled in when git-svn tries to
> determine what paths to pull down, and tries to match
> "/myproject/trunk" to "/bar/myproject/trunk".  I've merely put a
> band-aid on the situation.  My perl is rudimentary at best, or I'd
> have spent additional time to try to put in a "proper" patch, but was
> wondering if anyone else had run into this problem and would be
> willing to put in a fix (or point me in the right direction, that
> works too).

I messed about with disabling $Git::SVN::_minimize_url, but that seemed
to break other things.

Made worse for me was the fact that my 'bar' in the present was renamed
from 'baz' in the past, so git-svn couldn't find it at r1. Very
confusing!

I'd like a nicer solution too.

Tim

-- 
Tim Stoakes
