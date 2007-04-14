From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn failure when symlink added in svn
Date: Fri, 13 Apr 2007 23:41:43 -0700
Message-ID: <m2647zh2zc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 08:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcbx6-0004ei-Gv
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 08:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030812AbXDNGlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 02:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965407AbXDNGlY
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 02:41:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:55598 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356AbXDNGlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 02:41:23 -0400
Received: by nz-out-0506.google.com with SMTP id s1so924811nze
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 23:41:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=ANgBvAKVaqfXd1ZyGM/g2F4tnw95ddO+mCYedlN4bdqXNfH0S3ZRMOpUutrrBAguU/VOoDIjCXOHjPxS/hdV2zbueWmt/4hTBM60ouPEkxCxU6vcGNwTa/kwz/xzQRyykjfStmfnyF/PTF1pCOxiaTL6G6NrIB55HgAe3srE+1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=WimKLgn8MDOxnZymhpgUxaUKEPUfDQWJwsuh5mbYmysajeOU520i/6im/LQCFR+FEgvALymAN2waKPN+6qVlh72BMByQBcul5kR6y0Ef0mMQf9mPx3Pwf/c0TggoQok07SRDMitDsFY1R4z+i6YobCJWRo4PD0nQBssuJF8khgQ=
Received: by 10.114.181.1 with SMTP id d1mr1259017waf.1176532882757;
        Fri, 13 Apr 2007 23:41:22 -0700 (PDT)
Received: from ziti ( [24.19.44.95])
        by mx.google.com with ESMTP id z15sm2799847pod.2007.04.13.23.41.21;
        Fri, 13 Apr 2007 23:41:22 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44445>

Hi,

A few weeks ago I reported a symlink related error with git-svn and
I've now had a chance to track down a few more details.  The trigger
seems to be if a file is removed from svn and then later added as a
symlink.  The error I get is:

  error: git-checkout-index: unable to create symlink foo.txt (Invalid argument)

This is from the call to symlink(new, path) in entry.c and it seems
that new is ''.

Here is a recipe to reproduce:

## First create an svn repository
  svnadmin create SVN123-repos
  svn co file:///Users/seth/temp/SVN123-repos SVN123
  cd SVN123
  echo 123 > foo.txt
  svn add foo.txt 
  svn ci -m "add a file"

## Now mirror using git-svn
  cd ..
  mkdir GIT123
  cd GIT123/
  git svn init file:///Users/seth/temp/SVN123-repos
  git svn fetch

## Next remove and add a file as a symlink
  cd ..
  cd SVN123
  echo 123 > bar.txt
  svn add bar.txt 
  svn ci -m"add bar"
  svn rm foo.txt 
  svn ci -m "remove foo"
  ln -s bar.txt foo.txt
  svn add foo.txt 
  svn ci -m"add foo as symlink"

## Finally, try to rebase
  cd ../GIT123/
  git svn rebase

git version 1.5.1.53.g77e6f
svn 1.4.0


+ seth
