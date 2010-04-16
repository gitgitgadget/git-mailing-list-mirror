From: David Michael Barr <david.barr@cordelta.com>
Subject: Replay subversion into git via filesystem
Date: Fri, 16 Apr 2010 18:29:03 +1000
Message-ID: <BF711404-63BB-4212-A0F9-0025D1D6F7C5@cordelta.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 10:29:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2gvN-0007xc-6B
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 10:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab0DPI3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 04:29:10 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:32107
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756402Ab0DPI3I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 04:29:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEALq8x0vLWHsF/2dsb2JhbACbcXG1ZohGhQ4Eij8
X-IronPort-AV: E=Sophos;i="4.52,218,1270389600"; 
   d="scan'208";a="167567499"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 16 Apr 2010 18:29:04 +1000
Received: (qmail 16488 invoked from network); 16 Apr 2010 18:29:04 +1000
Received: from d122-109-106-179.mit3.act.optusnet.com.au (HELO ?192.168.1.8?) (122.109.106.179)
  by node2.alpha.aussiehq.net.au with SMTP; 16 Apr 2010 18:29:03 +1000
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145057>

Hi all,

In response to some recent questions about big imports of svn history
into git and as a part of my svn-dump-fast export project, I have
created a simple bash script to replay the root of a svn repository
into a git repository.
The assumption is that svnsync is used to pull the remote repository
and that svk is used to manage the working copy.

The mirror might be set up like so:
svnadmin create /path/to/mirror
svnsync init file:///path/to/mirror http://remote.com/svn
svnsync sync file:///path/to/mirror
svk depot depot_name /path/to/mirror

I'd appreciate any comments on the correctness of the script.

--
David Barr
--

#!/bin/bash
SVK_DEPOT=""
CO_DIR=validation
HASH_DIR=.git/wc

SVN_UUID=`svk pg --revprop -r0 svn:sync-from-uuid /$SVK_DEPOT/`
SVN_URL=`svk pg --revprop -r0 svn:sync-from-url /$SVK_DEPOT/`
MAX_REV=`svk pg --revprop -r0 svn:sync-last-merged-rev /$SVK_DEPOT/`

echo SVN_UUID: $SVN_UUID
echo SVN_URL: $SVN_URL
echo MAX_REV: $MAX_REV

svk co -r1 /$SVK_DEPOT/ $CO_DIR
cd $CO_DIR
git init
mkdir -p $HASH_DIR/{0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}\
{0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}
for (( REV=1 ; REV<=MAX_REV ; ++REV )) do
  svk up -r$REV
  # Hashify working copy
  git update-index --refresh 2>/dev/null
  git ls-files -modz | tee .git/filelist \
   | git update-index -z --add --replace --remove --stdin
  xargs -0 git ls-files -s < .git/filelist | (
    while read MODE HASH STAGE FILE ; do
      HASH_FILE="$HASH_DIR/${HASH:0:2}/$HASH$MODE"
      ln "$FILE" "$HASH_FILE" 2>/dev/null || \
        ln -f "$HASH_FILE" "$FILE"
    done
  )
  SVN_AUTHOR=`svk pg --revprop -r$REV svn:author`
  SVN_DATE=`svk pg --revprop -r$REV svn:date`
  export GIT_COMMITTER_NAME=$SVN_AUTHOR
  export GIT_COMMITTER_EMAIL=$SVN_AUTHOR"@"$SVN_UUID
  export GIT_COMMITTER_DATE="`date -juf '%FT%T' $SVN_DATE \
    '+%F %T %z' 2>/dev/null`"
  export GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
  export GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"
  export GIT_AUTHOR_DATE="$GIT_COMMITTER_DATE"
  GIT_PARENT=""
  [ $REV -gt 1 ] && GIT_PARENT="-p `git show-ref --head -s HEAD`"
  GIT_TREE=`git write-tree`
  echo git commit-tree $GIT_TREE $GIT_PARENT
  GIT_COMMIT=`svk pg --revprop -r$REV svn:log \
   | git commit-tree $GIT_TREE $GIT_PARENT`
  git update-ref HEAD $GIT_COMMIT
  git tag $REV
  git gc --auto
done
