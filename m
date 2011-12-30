From: Slawomir Testowy <slawomir.testowy@gmail.com>
Subject: What's the best way to push/fetch replace refs?
Date: Fri, 30 Dec 2011 12:59:26 +0100
Message-ID: <CAA61mJgCjt0O5LE5OQ=aNbtUHCZeZdZ=3dXYTNv_AhFi7JXwkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 12:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgb7U-0004T3-EL
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 12:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab1L3L72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 06:59:28 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38196 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1L3L70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 06:59:26 -0500
Received: by dajs34 with SMTP id s34so8766629daj.19
        for <git@vger.kernel.org>; Fri, 30 Dec 2011 03:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GMLRwncBboU67YQ4wx2jLz3HT/I7uKR9GzrUYsZ7L8Y=;
        b=KZB8M7VTMC3E2OCZT9JUbE0ZJFhpBWj9HMo6FnWbcK6Va5H95+617z5KgRhjP5xdvP
         bQxTgq/yqCDWOHPCuOKmJFnHGgYV5ckMwE+E1kEnoA4Dkad883rMz20JewSOr6kg4VXN
         /Lmkaj+n/j8iVztA4hIQ6STmDmj7AhHPleaYs=
Received: by 10.68.199.38 with SMTP id jh6mr93881588pbc.77.1325246366401; Fri,
 30 Dec 2011 03:59:26 -0800 (PST)
Received: by 10.143.142.9 with HTTP; Fri, 30 Dec 2011 03:59:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187800>

I want to use git-replace to connect two disjoined commits (git-svn didn't
detect massive file movement) and I want to share these replace refs with others
(we're moving from svn to git). I cannot use git-rebase because the history
after the split contains lots of branches and merges and using git-rebase for
that is an overkill.

I did something like this:

# Setup some repositories and create basic commit.
git init --bare repo
git init a
git init b
cd a
echo a > a && git add a && git commit -m initial
git branch tmp
echo b > b && git add b && git commit -m second
git checkout tmp
echo c > c && git add c && git commit -m replacement

# Replace a commit with another one
git replace `git rev-parse master` `git rev-parse tmp`

# Push changes to public repo; this doesn't push replace refs.
git push --all ../repo/

# Is this the best way to push replace refs?
git push  ../repo/ 'refs/replace/*'

# Fetch commits from public repo
cd ../b/
git pull ../repo/

# We didn't fetch replace refs in previous git-pull. But this seems to
work. Is this the correct way?
git fetch ../repo/ 'refs/replace/*:refs/replace/*'

# I also added "fetch = +refs/replace/*:refs/replace/*" to [remote
"origin"] in "b" and this also seems to work.
