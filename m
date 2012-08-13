From: Christopher Marshall <christopherlmarshall@gmail.com>
Subject: git svn clone, a non-standard layout question
Date: Sun, 12 Aug 2012 23:23:16 -0400
Message-ID: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 05:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0lFW-0007cR-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 05:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab2HMDXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 23:23:18 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39912 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab2HMDXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 23:23:17 -0400
Received: by wicr5 with SMTP id r5so2137787wic.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 20:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VoE5I3TKL4Jip+eBzMhjjE+jylV5D607Pk2uqL9M/5s=;
        b=OqfYz/zA+2qzsQdgdAuwLtxDeX7kvCDrIb5VyqW5pKlg/dYFrZL83TmkATNzLDxAF1
         WjhCIHWYeXkSIhJfmzyCH1Z5oXeuvX2m0h+gmYxzMcewt3hrhsEsDbF05OxJs6BDy6cH
         KjZOsTibqKTC3FyQav6kofcVJddW5VknWD1cUP5XvuJ3NUlmyl1USW1RxCXY1nfpmUaM
         P/x4ScobAcpRni8gpRkNuAx1dYEbzN8Cy/fwPmA70ACvmhpWTwAPvFJ5jiV+sv8o6E74
         rha8MYcEDFFH8BVo/OPmG3ibzE4E8Vg67lTyYTFtCuPK/cpaZiLl0wdARPMioTLPfqNi
         S4Aw==
Received: by 10.216.137.193 with SMTP id y43mr3720282wei.71.1344828196189;
 Sun, 12 Aug 2012 20:23:16 -0700 (PDT)
Received: by 10.223.160.3 with HTTP; Sun, 12 Aug 2012 20:23:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203320>

I would like to use git svn to clone an svn repo with a non-standard
branches layout roughly like this:
trunk/
tags/
branches/
   b1
   b2
   ...
   bdir/
      b3
      b4
      ...

That is, every directory under branches is a branch except bdir, and
every directory under bdir is a branch.

One thing I have attempted is this:
   git svn clone \
                      --trunk=trunk \
                      --branches=branches/bdir \
                      --branches=branches \
                      --tags=tags \
                      --prefix=svn/ $SVN_REPO \
                      git.svn

That properly creates the remote tracking branches b1,b2,b3,b4 but
also creates the remote tracking branch bdir, which I am trying to
exclude.  If I were to settle for this, the bdir branch would have
enormous trees committed to it (when I ran against the real svn repo I
am targetting).

I get can exactly the branch mapping I want by editing .git/config like this:
[svn-remote "svn"]
        url = file:///home/chris/programs/svn/repo
        fetch = trunk:refs/remotes/svn/trunk
        tags = tags/*:refs/remotes/svn/tags/*
        branches = branches/{b1,b2}:refs/remotes/svn/*
        branches = branches/bdir/{b3,b4}:refs/remotes/svn/*

but then I would have to manually add branches before every git svn
fetch, or risk not importing new branches that other developers have
created since I last fetched.

Chris Marshall

p.s.  Here is the bash script I am using to experiment with this type
of svn layout.  It creates a svn repo with the structure described
above, then applies my second (non-wildcard) solution.  The "bash"
line right before the cleanup lines at the end is to allow you to look
around before everything disappears.

#!/bin/bash
# file_summary: svn non-standard layout.  this works, and excludes
bdir, but by not using wild cards it requires that branches be
added manually before a fetch.

export SVN_EDITOR=vi
CWD=$(pwd)
export URL=file://$(pwd)/repo

svnadmin create repo

# create top level directories.
svn checkout $URL proj
cd proj
svn mkdir branches tags trunk
svn commit -m "created top level dirs"
svn mkdir branches/bdir
svn commit -m "created non-standard branches dir"
cd $CWD

# trunk
svn checkout ${URL}/trunk proj-t
cd proj-t
echo -e "1\n2\n3" > f1
svn add f1
svn commit -m "added f1: 1,2,3"
cd $CWD

# create branches b1,b2,b3,b4
svn copy ${URL}/trunk ${URL}/branches/b1 -m "created branch b1"
svn copy ${URL}/trunk ${URL}/branches/b2 -m "created branch b2"
svn copy ${URL}/trunk ${URL}/branches/bdir/b3 -m "created branch b3"
svn copy ${URL}/trunk ${URL}/branches/bdir/b4 -m "created branch b4"
cd $CWD

# create a b1 commit
svn checkout ${URL}/branches/b1 proj-b1
cd proj-b1
echo -e "b1" >> f1; svn commit -m "b1 line"
cd $CWD

# create a b2 commit
svn checkout ${URL}/branches/b2 proj-b2
cd proj-b2
echo -e "b2" >> f1; svn commit -m "b2 line"
cd $CWD

# create a b3 commit
svn checkout ${URL}/branches/bdir/b3 proj-b3
cd proj-b3
echo -e "b3" >> f1; svn commit -m "b3 line"
cd $CWD

# create a b4 commit
svn checkout ${URL}/branches/bdir/b4 proj-b4
cd proj-b4
echo -e "b4" >> f1; svn commit -m "b4 line"
cd $CWD

git svn clone --trunk=trunk --branches=branches --tags=tags
--prefix=svn/ $URL -r 1:1 git.svn
cd git.svn
grep -v branches .git/config > .git/config2
mv .git/config2 .git/config
echo "branches = branches/{b1,b2}:refs/remotes/svn/*" >> .git/config
echo "branches = branches/bdir/{b3,b4}:refs/remotes/svn/*" >> .git/config
rm .git/svn/.metadata
git svn fetch

bash
cd $CWD
rm -rf repo proj proj-{t,b{1,2,3,4}} git.svn
