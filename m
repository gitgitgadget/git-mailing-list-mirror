From: =?UTF-8?Q?Micha=C5=82_Janiszewski?= <janisozaur@gmail.com>
Subject: A bug or unhandled case
Date: Mon, 11 Mar 2013 17:06:26 +0100
Message-ID: <CABB6UqEfx=ssbiD1+2HA3AtmSrFeJeg5fmU3z1SKukNsKvd4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 17:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5Fq-0000NX-DY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3CKQGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:06:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50545 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab3CKQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:06:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so3933912pbc.19
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=wOFphOqvabtusMi0F6tqy35xrrNJcrxG3JpTOw0iG5I=;
        b=HgolXEJz6ZxPEELC15S12w76SULWlhaVnge3q37JY3X0f4dCGVhF/5IhhXMVr3gxvR
         5SD9feFfIH7rwvSlR20XgbW/sHKJAXm5JpyIzZjbDQ8wFkzGsci6//iZ25f0z0rz5EFJ
         s8gtFMyRJ7hoNjSUK5gzOMczNCXW/y39b6XNMry5JbH6PLynPRLMFrh8G9UNvAJlhOiK
         v2oVze72zCqgAK3mG7eGzVut0DVOC1zlMvLnYBxoJkvu9ocifGEFk/I0T6D8CcvBRjkN
         K41f5ri1nGHUN6+fL9F8QswDElJIMEG20K7AV4ThhnXA4w/NcFqRXDCQkwZtxiBfguQ7
         sP9w==
X-Received: by 10.68.91.66 with SMTP id cc2mr29935186pbb.51.1363018006496;
 Mon, 11 Mar 2013 09:06:46 -0700 (PDT)
Received: by 10.68.43.225 with HTTP; Mon, 11 Mar 2013 09:06:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217882>

Hi,
I think I've found a bug in git or at least a use case that is not handled.
In few words it can be described like this: if you push a remote
branch to another remote, which is bare repository, you cannot remove
that branch from said bare repository.
Here is a recipe how to reproduce that with git 1.8.0:
git init foo
git init --bare bar.git
git init --bare baz.git
cd foo
echo test > file
git commit -am "initial commit"
git remote add bar ../bar.git
git remote add baz ../baz.git
git push bar master
cd ..
git clone bar.git bax
cd bax
git checkout -b "test_branch"
echo evil > file
git commit -am "evil commit"
git push origin test-branch
cd ../foo
git fetch bar
git push baz bar/test_branch
cd ../baz.git

###
# on that point in baz.git there is only one branch:
# remotes/bar/test_branch 8b96ffe evil commit
# trying to remove that branch yields no results:
$ git branch -D refs/remotes/bar/test_branch
error: branch 'refs/remotes/bar/test_branch' not found.
$ git branch -D remotes/bar/test_branch
error: branch 'remotes/bar/test_branch' not found.
$ git branch -D bar/test_branch
error: branch 'bar/test_branch' not found.
$ git branch -D test_branch
error: branch 'test_branch' not found.

git gc --prune=now
# also does nothing

The only way to remove that branch is to:
cd ../foo
git push baz :bar/test_branch

Shouldn't someone who owns bare repository be able to delete that kind
of branches as he is able to do with "regular" branches?

--
Michal Janiszewski
