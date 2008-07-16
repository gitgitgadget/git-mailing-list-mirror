From: "Jukka Zitting" <jukka.zitting@gmail.com>
Subject: git-svn: Trouble after project has moved in svn
Date: Thu, 17 Jul 2008 01:12:00 +0300
Message-ID: <510143ac0807161512w44a612bcndc53713639b0b70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFF8-0003Ly-Ea
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbYGPWMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbYGPWMD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:12:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:26606 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbYGPWMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:12:01 -0400
Received: by wr-out-0506.google.com with SMTP id 69so4230796wri.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=WcBTyTJ/J2gE/rkLP9eovlEx+LZkD/ifkRBKeJAEf5c=;
        b=PLSoCjDneiX7rU9YQqJROxihEKsDhe1aO5gjLzxke5JEA4+ixHAiJhZDlR9ohtvUjx
         cpMKXhOykVW/gGqSrKPDjB6+RIIAbdYzr/VmabnWH/IOfzv/XzVKh9Sn9t8pc2u/44Ma
         b1L/hsV5D64R4jg6g2XRh/oSYTAO7CHm1ncVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ED26U2p5Jp0UUJHdL+WT0aNn7GvC83v062j5mCF9DLwSEGmS4NQScveSqvp/unGeU5
         Y7h+3LxrU49zJnvazPJlK0cOSiG3pCLivqk51vgyJdbfAkb7DIM+xD+BvClJqRc83VII
         Tksf+8TE8HJzwFD5LpaEJi4kr42QGhznUUoD8=
Received: by 10.90.27.5 with SMTP id a5mr2241291aga.85.1216246320036;
        Wed, 16 Jul 2008 15:12:00 -0700 (PDT)
Received: by 10.90.115.13 with HTTP; Wed, 16 Jul 2008 15:12:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88770>

Hi,

Somewhat related to the recent thread about Apache Synapse, I'm having
trouble making a git-svn clone of a project that has been moved around
in a Subversion repository.

See the script at the end of this message for a simple test case that
does the following svn commits:

    PREPARE: creates projectA with the standard trunk,branches,tags structure
    VERSION1: first version of README.txt in projectA/trunk
    TAG1: tags projectA/trunk to projectA/tags/v1
    MOVE: moves projectA to projectB
    VERSION2: second version of README.txt in projectB/trunk
    TAG2: tags projectB/trunk to projectB/tags/v2

The resulting repository structure is:

    /projectB/
        trunk/
            README.txt # version 2
        branches/
        tags/
            v1/
                README.txt # version 1
            v2/
                README.txt # version 2

Here's the git commit graph created by the test case:

    * TAG2 <- refs/remotes/tags/v2
    | * VERSION2 <- refs/remotes/trunk
    |/
    * MOVE
    * VERSION1 <- refs/remotes/trunk@3
    | * MOVE <- refs/remotes/tags/v1
    | * TAG1 <- refs/remotes/tags/v1@3
    |/
    * PREPARE <- refs/remotes/tags/v1@1

The most pressing issue is that the refs/remotes/tags/v1 branch starts
directly from the first PREPARE commit instead of VERSION1. Also, the
branch point of refs/remotes/tags/v2 seems to be incorrect, it should
be based on the VERSION2 commit instead of MOVE.

A more accurate commit graph would be:

    * TAG2 <- refs/remotes/tags/v2
    * VERSION2 <- refs/remotes/trunk
    * MOVE
    | * MOVE <- refs/remotes/tags/v1
    | * TAG1
    |/
    * VERSION1
    * PREPARE

Or even (but I guess git-svn needs to map each svn commit to at least
one git commit, so this probably wouldn't work):

    * VERSION2 <- refs/remotes/trunk, refs/remotes/tags/v2
    * VERSION1 <- refs/remotes/tags/v1
    * PREPARE

I tried working my way through git-svn.perl to figure out how to
improve the way git-svn tracks svn moves, but so far I couldn't figure
out how to do that. Any ideas or hints?

BR,

Jukka Zitting

=====
#!/bin/sh

REPO=`pwd`/repo
svnadmin create $REPO

svn checkout file://$REPO checkout
cd checkout

svn mkdir projectA
svn mkdir projectA/trunk
svn mkdir projectA/branches
svn mkdir projectA/tags
svn commit -m PREPARE

echo VERSION1 > projectA/trunk/README.txt
svn add projectA/trunk/README.txt
svn commit -m VERSION1

svn copy projectA/trunk projectA/tags/v1
svn commit -m TAG1
svn update

svn move projectA projectB
svn commit -m MOVE

echo VERSION2 > projectB/trunk/README.txt
svn commit -m VERSION2

svn copy projectB/trunk projectB/tags/v2
svn commit -m TAG2
svn update

mkdir ../git
cd ../git

git svn init -s file://$REPO/projectB
git svn fetch
