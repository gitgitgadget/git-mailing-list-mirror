From: Steven Walter <stevenrwalter@gmail.com>
Subject: git-svn and branches
Date: Wed, 26 Sep 2007 22:12:52 -0400
Message-ID: <20070927021252.GA23777@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 04:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaisM-0004td-RN
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 04:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbXI0CNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 22:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbXI0CNF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 22:13:05 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:32252 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbXI0CNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 22:13:02 -0400
Received: by py-out-1112.google.com with SMTP id u77so4528592pyb
        for <git@vger.kernel.org>; Wed, 26 Sep 2007 19:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=t+9G/tDVIub7uIqZWsT43oXuycJWPdFueDzHyhDLjiM=;
        b=B3G0pn9EoiBtodzvXO/RFczVst9hXejeEri/bwGmhr12plfvZWFvD0fG3kAVTLu86OOisv+jscyGkc5rV3ffgfrNH0cUUi6XqGBjPp+HR8vKuXIznGBreQHIClCA1XJggF+YLjYDSXMBjxGFpuBi7GElbL18JPeiLVCECu/nWAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=n+lul+an+LCiOFcKmJde67n+b7SYykUjvRf2WH08FnysI4fwYHH65TNpjdUOqmQaCB6jFQjXwvCcofQWJzZB2rz5zrcX+xWvRTNq3gIp3k8h1AzbIs0nddpDxzT1twkfd2CFHz01PEJ5px+0xAwgSJbfPqGeQ/85P4M5lreLINE=
Received: by 10.64.142.10 with SMTP id p10mr3461329qbd.1190859181355;
        Wed, 26 Sep 2007 19:13:01 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 18sm2303647nzo.2007.09.26.19.12.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2007 19:13:00 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 458E3C1CFD7; Wed, 26 Sep 2007 22:12:52 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59256>

I'm using git-svn to track a rather large subversion repository with a
non-standard layout.  In the past, I've only cared about trunk, but now
I need to occasionally use branches, too.  By adding a second git-svn
remote with the branch URL, I can fetch the branch, and git-svn is even
intelligent enough to notice that the branch was copied off of trunk.

However, git-svn also does a complete checkout for the first revision of
the branch.  By this, I mean it goes through shows "A    file" for every
file in the repository.  This takes quite a while, and seems rather
unnecessary given that git-svn already noticed that the branch shares a
history with trunk, which is already fetched.

Knowing just enough of what git-svn is doing to be dangerous, I whipped
up a short little patch.  This patch seems to work for the common case,
and avoids fetching every file from subversion.  It does break
sometimes, however, and I don't understand why.

Maybe someone with a better grasps of the code can see what I did wrong,
or suggest a better means to my end?

diff --git a/git-svn.perl b/git-svn.perl
index 484b057..1bc92b6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1848,9 +1848,10 @@ sub find_parent_branch {
                                              $self->full_url, $ed)
                          or die "SVN connection failed somewhere...\n";
                } else {
+                       $self->assert_index_clean($parent);
                        print STDERR "Following parent with do_update\n";
                        $ed = SVN::Git::Fetcher->new($self);
-                       $self->ra->gs_do_update($rev, $rev, $self, $ed)
+                       $self->ra->gs_do_update($rev, $r0, $self, $ed)
                          or die "SVN connection failed somewhere...\n";
                }
                print STDERR "Successfully followed parent\n";
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
