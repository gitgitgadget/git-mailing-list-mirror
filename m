From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git-svnimport.perl bug when copy source path has a revision
Date: Wed, 15 Oct 2008 23:43:43 -0700
Message-ID: <48F6E29F.1050807@pcharlan.com>
References: <quack.20081015T1211.lth8wsp65dk@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Thu Oct 16 08:44:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqMbR-0005ga-RI
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 08:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYJPGnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 02:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbYJPGnp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 02:43:45 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:49193 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752221AbYJPGno (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 02:43:44 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 396328F18E;
	Wed, 15 Oct 2008 23:43:44 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <quack.20081015T1211.lth8wsp65dk@roar.cs.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98349>

Karl Chen wrote:
> This looks like a bug in git-svnimport.perl.  If a tag (or
> branch?) is created retroactively, git-svnimport doesn't respect
> the copy source revision.
> 
> To reproduce:
> 
> svnadmin create somerepo;  export R=file://$PWD/somerepo
> 
> svn co $R wc && cd wc
> 
> mkdir trunk tags && svn add trunk tags && svn commit -m ""  # rev 1
> 
> cd trunk
> echo a > a
> echo b > b
> echo c > c
> 
> svn add a && svn commit -m "commit a"   # rev 2
> svn add b && svn commit -m "commit b"   # rev 3
> # Copy from revision 2 instead of HEAD:
> svn cp -m "tag rev 2" $R/trunk@2 $R/tags/mytag  # rev 4
> svn add c && svn commit -m "commit c"   # rev 5
> 
> svn ls $R/tags/mytag 
> # Lists only 'a'
> 
> mkdir /tmp/gitrepo && cd /tmp/gitrepo
> perl /usr/share/doc/git-core/contrib/examples/git-svnimport.perl $R
> 
> git log mytag
> # 'mytag' includes "commit b"; it was created as if it were tagged
> # at r3; the "@2" was ignored.

If you replace this:

> perl /usr/share/doc/git-core/contrib/examples/git-svnimport.perl $R

with:

git svn init -T trunk -t tags $R
git svn fetch
git log tags/mytag

you get a log that doesn't include "commit b".  (And it does include the
tag commit, as svn does.)  tags/mytag is a branch, visibile via "git
branch -r", instead of a tag.  I'm not fluent enough in git svn to know
if this is a bug or a feature.

According to git logs (8cb070a4, fee9832a), git-svnimport.perl hasn't
been maintained in a while, presumably because git svn provides a
superset of its functionality.

HTH,

--Pete
