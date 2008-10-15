From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-svnimport.perl bug when copy source path has a revision
Date: Wed, 15 Oct 2008 12:11:03 -0700
Message-ID: <quack.20081015T1211.lth8wsp65dk@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBvN-0005hP-5t
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbYJOTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYJOTTg
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:19:36 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:46635 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbYJOTTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:19:36 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 15:19:36 EDT
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 99204343C1; Wed, 15 Oct 2008 12:11:03 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98299>


This looks like a bug in git-svnimport.perl.  If a tag (or
branch?) is created retroactively, git-svnimport doesn't respect
the copy source revision.

To reproduce:

svnadmin create somerepo;  export R=file://$PWD/somerepo

svn co $R wc && cd wc

mkdir trunk tags && svn add trunk tags && svn commit -m ""  # rev 1

cd trunk
echo a > a
echo b > b
echo c > c

svn add a && svn commit -m "commit a"   # rev 2
svn add b && svn commit -m "commit b"   # rev 3
# Copy from revision 2 instead of HEAD:
svn cp -m "tag rev 2" $R/trunk@2 $R/tags/mytag  # rev 4
svn add c && svn commit -m "commit c"   # rev 5

svn ls $R/tags/mytag 
# Lists only 'a'

mkdir /tmp/gitrepo && cd /tmp/gitrepo
perl /usr/share/doc/git-core/contrib/examples/git-svnimport.perl $R

git log mytag
# 'mytag' includes "commit b"; it was created as if it were tagged
# at r3; the "@2" was ignored.
