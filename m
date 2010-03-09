From: Alexander Gladysh <agladysh@gmail.com>
Subject: Cherry-pick with symlinks fails horribly
Date: Tue, 9 Mar 2010 04:28:30 +0300
Message-ID: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyTS-0001Do-QQ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0CIB2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 20:28:32 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44281 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab0CIB2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 20:28:30 -0500
Received: by pvb32 with SMTP id 32so1647165pvb.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 17:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=rmyf8vSkt8Q9viYBe2VR70sod7eK723OyD4LZalsOH0=;
        b=Gw4cCQawY/wrU2h/GHtZ0hD/MHtrAIepNPw0gTl4Uo3AV9915/Q95c7VTIfuXCGSE1
         W9rvQxlDOvS2GE31ZmtSyg8ZCCsBHKaQNYbkOU5NgTovdy2ti1A5S9B0zahX6mEguQf/
         dN5I9eTWj7M0kWXY5vzVzPbD3t5Awn0KkYpVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OI1Q7wLdbV7lRj0A0suNzr50iTAlb6tsTqY99AktDsMYLdGZllr9KKfwVHeY6DHsIw
         Gp3DbyiXMVWWTVNbDV/dCX7XIQKPe1QKPFynX31GSwt+biwcGgmHdu60k0X62lbUSMv+
         zm9xIoX8iSYpelxrPz+aqy6/pawtnf4uGK6Yo=
Received: by 10.114.138.17 with SMTP id l17mr678805wad.159.1268098110141; Mon, 
	08 Mar 2010 17:28:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141813>

Hi, list!

OS X 10.6.2
Git 1.7.0.2

I'm complaining about Git symlink handling again. This time it is cherry-pick.

In my repo I have a symlink pointing to a directory.

I swap symlink with the directory in a single commit.

Now, if I try to cherry-pick any later commit from the branch that has
that swap commit to a branch that have not, cherry-pick fails
horribly.

See script to reproduce the bug below (run it in a clean directory).

Output example:

$ git cherry-pick <SHA>

Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
and commit the result with:

        git commit -c 6a398597ce7a00fe05f43ff88808303eb151dfb5

$ git status # Note the "Untracked files" section

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	renamed:    a/f -> f1
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	added by us:        b/a
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	b/a~HEAD

(Also I've seen git reset --hard to fail afterwards, complaining it
can't delete a directory, but I can't reproduce it now.)

I see a similar behaviour if I try to do interactive rebase accross
symlink swap commit.

Alexander.

#! /bin/bash

git init

mkdir a
touch a/f
git add a
git commit -m "a"

mkdir b
ln -s ../a b/a
git add b
git commit -m "b"

git checkout -b branch
rm b/a
mv a b/
ln -s b/a a
git add .
git commit -m "swap"

touch f1
git add f1
git commit -m "f1"

git checkout master

git cherry-pick `git rev-parse branch` # This one breaks horribly
