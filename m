From: Anton Gyllenberg <anton@iki.fi>
Subject: git-svn: broken symlink check fetches wrong revision from svn 
	(possible regression)
Date: Tue, 10 Feb 2009 16:51:16 +0200
Message-ID: <83dfc36c0902100651s531ca5a2x10b40ee305d4678d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 15:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtyf-00029K-SQ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbZBJOvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZBJOvT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:51:19 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:55043 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbZBJOvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:51:18 -0500
Received: by ey-out-2122.google.com with SMTP id 25so601469eya.37
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=couUv3R97CCt42IWG3GPi9mqSBwfO8DTcavp4inFzTw=;
        b=rvE0U1HUiJaPfqVOchz2u0ts/QvFGvD8OWdtOeNSTIkRUouhocCA3VKZ1hcRXqshK/
         fjYSqT2HW7o7A63GOa6ohVX1acnA4+W1sGlC20D+Mn2iFGKl2E3AnULg9D9bsjjmXGOr
         DSJdsLP4Ak4oACp887jNRXwSYOW327wI5diRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=wPU8JcPxdmsCyb3MUeOOnRYl0+B4wbfF0zfXyPekXSZbJZLOGCdcxwwmhWqqnMoSJA
         FhYphrjrlYAaQN5OP15sXTEqIZ+f7gdZWKfWD38V9B8724fJdThGRKr85tv0dZ5iAz4i
         d5ocKtxJHbVyKrdLhBjUAw//tBwGrvr3xHFK8=
Received: by 10.210.120.7 with SMTP id s7mr4833158ebc.184.1234277476251; Tue, 
	10 Feb 2009 06:51:16 -0800 (PST)
X-Google-Sender-Auth: 6a58545ada97a4e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109250>

The check for broken symlinks introduced in dbc6c74d0 "git-svn: handle
empty files marked as symlinks in SVN" changed git-svn fetch behavior
for a real-life repository I need to access. It doesn't have broken
symlinks. The repository had a branch deleted and recreated off of a
different branch point. The new branch point has empty files not in
the original branch point. It seems the symlink check
_mark_empty_symlinks fetches the wrong SVN revision of the empty files
in this special case. git-svn fetch stops with an error like

Filesystem has no item: File not found: revision 4, path
'/branches/branch-c/b1' at git-svn line 3288

Which is true, there is no such file, but in my case the empty file b1
is in revision 6 (new branch-c copied from branch-b@r5 where the
original branch-c was deleted), not revision 4 (original branch-c
copied from trunk in r4).


I used the following shell script to produce a test repository that
displays the symptom:
#!/bin/bash

SVNREPO=file:///$PWD/test.db
svnadmin create test.db
svn co $SVNREPO testreposvn
cd testreposvn
mkdir trunk branches
svn add trunk branches
svn ci -m "init standard layout"
svn cp trunk branches/branch-b
svn ci -m 'branch-b off trunk'
touch branches/branch-b/b1
svn add branches/branch-b/b1
svn ci -m 'add empty file b1'
svn cp -m 'branch-c' $SVNREPO/{trunk,branches/branch-c}
svn del -m 'oops, wrong branchpoint' $SVNREPO/branches/branch-c
svn cp -m 'branch-c off of branch-b' $SVNREPO/branches/{branch-b,branch-c}

----
This leaves the svn repository in ./test.db, svn working copy in
./testreposvn. And the problem:

$ git init -s file:///$PWD/test.db testrepogit
Initialized empty Git repository in /tmp/test/testrepogit/.git/
$ cd testrepogit
$ git --version
git version 1.6.2.rc0
$ git svn fetch
r1 = ff1aea02906c970caa49055db564158d6911a512 (trunk)
Found possible branch point: file:////tmp/test/test.db/trunk =>
file:////tmp/test/test.db/branches/branch-b, 1
Found branch parent: (branch-b) ff1aea02906c970caa49055db564158d6911a512
Following parent with do_switch
Successfully followed parent
r2 = d0f256cbf64dc1e49597e54a55538758ca70d65f (branch-b)
	A	b1
r3 = 48d511b172a95a609d5e10f1275664e6b4ca4e62 (branch-b)
Found possible branch point: file:////tmp/test/test.db/trunk =>
file:////tmp/test/test.db/branches/branch-c, 3
Found branch parent: (branch-c) ff1aea02906c970caa49055db564158d6911a512
Following parent with do_switch
Successfully followed parent
r4 = 57923c03b201b2dbbb9d52b81e198a1a78b9de44 (branch-c)
Found possible branch point:
file:////tmp/test/test.db/branches/branch-b =>
file:////tmp/test/test.db/branches/branch-c, 5
Found branch parent: (branch-c) 48d511b172a95a609d5e10f1275664e6b4ca4e62
Index mismatch: 934e48f4addc4882a9b7b99615348569d531c873 !=
4b825dc642cb6eb9a060e54bf8d69288fbee4904
rereading 48d511b172a95a609d5e10f1275664e6b4ca4e62
Following parent with do_switch
Filesystem has no item: File not found: revision 4, path
'/branches/branch-c/b1' at git-svn line 3288

----

Breaking out of _mark_empty_symlinks() before SVN access makes the
git-svn fetch complete without errors but does record the original
branch-c as parent which I did not expect but it kind of makes sense.
I tried to figure out where the revision to fetch in
_mark_empty_symlinks() comes from but eventually gave up as I am not
that fluent in perl.

Anton
