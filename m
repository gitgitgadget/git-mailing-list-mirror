From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn-problem: Unnecessary  downloading entire branch?
Date: Tue, 22 Sep 2009 23:55:13 -0700
Message-ID: <20090923065513.GA18490@dcvr.yhbt.net>
References: <1253102039.6509.143.camel@martin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Martin Larsson <martin.liste.larsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 08:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqLl9-0007YY-15
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 08:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbZIWGzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 02:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbZIWGzL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 02:55:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39774 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZIWGzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 02:55:11 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 234A11F78E;
	Wed, 23 Sep 2009 06:55:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253102039.6509.143.camel@martin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128970>

Martin Larsson <martin.liste.larsson@gmail.com> wrote:
> I have a local git-copy of the company svn-repository. The git-copy is
> up-to-date (git svn fetch). I then add a new branch in the
> svn-repository (svn cp http://.../trunk http://...branches/JIRA-4444).
> When I then do 'git svn fetch' again, it pulls all the files from the
> svn-repository. 
> 
> I was expecting it to only pull the fact that a new branch was made
> (taking milliseconds), not all the files in the branch (taking more than
> half an hour to complete). Why does it need to transfer all the files?

Are some branches at a different depth in the repository?  E.g:

	project/trunk
	project/branches/feature-a
	project/branches/martin/feature-b
	project/branches/martin/feature-c
	project/branches/feature-d
	project/branches/feature-e

Basically a refs layout like this in your $GIT_CONFIG:

	fetch = project/trunk:refs/remotes/trunk
	branches = project/branches/*:refs/remotes/*

Is going to get git svn confused and think "martin" is a branch when
it is rather a container of a branch.


However if you have a consistent depth and two branch containers
("martin" and his evil twin, "nitram"):

	project/trunk
	project/branches/martin/feature-b
	project/branches/martin/feature-c
	project/branches/nitram/feature-a
	project/branches/nitram/feature-d
	project/branches/nitram/feature-e


As of git v1.6.4, you can repeat "branches" or "tags" lines in
$GIT_CONFIG thanks to Marc Branchaud:

	fetch = project/trunk:refs/remotes/trunk
	branches = project/branches/martin/*:refs/remotes/martin/*
	branches = project/branches/nitram/*:refs/remotes/nitram/*

This is a known problem with the (extremely flexible and therefore
inconsistent) way SVN repositories can be laid out.

> I did have problems getting the original svn-repository. It took several
> days and stopped several times in the process. Each time it stopped, I
> just issued 'git svn fetch' again and it seemed to continue. Could this
> be related? How could I make a better copy?

It could be the server disconnecting you or a bad Internet connection.
Resuming "git svn fetch" should be perfectly safe, though.

-- 
Eric Wong
