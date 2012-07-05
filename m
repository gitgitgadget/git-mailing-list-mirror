From: Bob Halley <halley@play-bow.org>
Subject: git-submodule path computation bug with recursive submodules
Date: Thu, 5 Jul 2012 13:09:06 +0100
Message-ID: <0B4C40CC-862E-4B15-9A4F-903DC8DBBAEC@play-bow.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 14:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smkyz-0005pn-BK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 14:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab2GEMQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 08:16:23 -0400
Received: from howl.play-bow.org ([78.32.75.15]:62802 "EHLO howl.play-bow.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab2GEMQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 08:16:23 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2012 08:16:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by howl.play-bow.org (Postfix) with ESMTP id 59F98D5BC8C
	for <git@vger.kernel.org>; Thu,  5 Jul 2012 13:09:08 +0100 (BST)
Received: from howl.play-bow.org ([127.0.0.1])
	by localhost (howl.play-bow.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id trhDc8mJUNbm for <git@vger.kernel.org>;
	Thu,  5 Jul 2012 13:09:07 +0100 (BST)
Received: from [192.168.219.136] (unknown [192.168.219.136])
	(Authenticated sender: halley)
	by howl.play-bow.org (Postfix) with ESMTPSA id 1AAE1D5BC7F
	for <git@vger.kernel.org>; Thu,  5 Jul 2012 13:09:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=play-bow.org;
	s=201002; t=1341490147;
	bh=wTEpvRdttZZtdlyXttF6O15nLF0z4YsHXEKwKYawZK0=;
	h=From:Content-Type:Content-Transfer-Encoding:Subject:Date:
	 Message-Id:To:Mime-Version;
	b=jihyxkpETvDxM5RVsBdGRzmAAUBoeF91lYr8bs/+dAeMin33tgKZuAkW//9NSHsQn
	 q0q8zPE8Q9MttWf/7y/PMEaIKB3Zm97SRqNP+O4tzn0o+bK9jvIOZcKjJ33MmTVNBj
	 9xeoU0WIe2kQellh2luSRUJX3bHs2jAT79R864b0=
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201043>


The git-submodule command has problems in some cases when there is a symlink
in the path returned by pwd.

I've created a repository at http://www.play-bow.org/repos/product to
demonstrate the issue.

$ git --version
git version 1.7.11.1.116.g8228a23

I copied and built the head of the master branch today.

First we need a symlink.  I discovered this problem because I had a symlink
in / to a directory under my home directory for typing convenience.

$ ls -al /bug
lrwxr-xr-x  1 root  admin  17  5 Jul 12:26 /bug@ -> /Users/halley/bug

$ cd /bug
$ pwd
/bug

Note that pwd does not resolve the symlink (though pwd -P would on many
platforms)

$ pwd -P
/Users/halley/bug/product

$ git clone http://www.play-bow.org/repos/product
Cloning into 'product'...

I'm purposely not using 'clone --recursive' as the bug doesn't appear if you
do that.

$ cd product/
$ ls
file1	file2	foo/

Let's get those submodules...

$ git submodule update --init --recursive
Submodule 'foo' (http://www.play-bow.org/repos/foo) registered for path 'foo'
Cloning into 'foo'...
Submodule path 'foo': checked out '2b02e1eb2e34961d807cfc5fc7e477e0ca844600'
Submodule 'bar' (http://www.play-bow.org/repos/bar) registered for path 'bar'
Cloning into 'bar'...
fatal: Not a git repository: ../../../../Users/halley/bug/product/.git/modules/foo/modules/bar
Failed to recurse into submodule path 'foo'

The first level of submodule clones successfully, but submodule 'foo'
contains submodule 'bar', and cloning it fails.

Now we'll try it again, but this time we'll take the symlink out of the picture.

$ cd /Users/halley/bug
$ rm -rf product
$ pwd
/Users/halley/bug
$ git clone http://www.play-bow.org/repos/product
Cloning into 'product'...
$ cd product
$ git submodule update --init --recursive
Submodule 'foo' (http://www.play-bow.org/repos/foo) registered for path 'foo'
Cloning into 'foo'...
Submodule path 'foo': checked out '2b02e1eb2e34961d807cfc5fc7e477e0ca844600'
Submodule 'bar' (http://www.play-bow.org/repos/bar) registered for path 'bar'
Cloning into 'bar'...
Submodule path 'bar': checked out '00f1d87d3bd6948ef861f2b134daafabb10f7d6f'

All good.

The problem occurs in git-submodule when it replaces path components
with '..'.  It's assuming this will create a valid relative path by
going up to the common root and then down, but this is an invalid
assumption if any of the path components are symlinks.

Here's some partial output of git-submodule running with sh -x set, in a
situation when the pwd is /bug:

++ git clone -n --separate-git-dir /Users/halley/bug/product/.git/modules/foo/modules/bar http://www.play-bow.org/repos/bar bar
Cloning into 'bar'...
+++ cd /Users/halley/bug/product/.git/modules/foo/modules/bar
+++ pwd
++ a=/Users/halley/bug/product/.git/modules/foo/modules/bar/
+++ cd bar
+++ pwd
++ b=/bug/product/foo/bar/
++ case $a in
++ case $b in
++ test /Users/halley/bug/product/.git/modules/foo/modules/bar/ '!=' /Users/halley/bug/product/.git/modules/foo/modules/bar/
++ test /bug/product/foo/bar/ '!=' /bug/product/foo/bar/
++ test '' = ''
++ a=Users/halley/bug/product/.git/modules/foo/modules/bar/
++ b=bug/product/foo/bar/
++ test Users = bug
++ a=Users/halley/bug/product/.git/modules/foo/modules/bar
++ b=bug/product/foo/bar
+++ echo bug/product/foo/bar
+++ sed -e 's|[^/][^/]*|..|g'
++ rel=../../../..
++ echo 'gitdir: ../../../../Users/halley/bug/product/.git/modules/foo/modules/bar'
+++ echo Users/halley/bug/product/.git/modules/foo/modules/bar
+++ sed -e 's|[^/][^/]*|..|g'
++ rel=../../../../../../../../..
++ clear_local_git_env
+++ git rev-parse --local-env-vars
++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES GIT_CONFIG GIT_CONFIG_PARAMETERS GIT_OBJECT_DIRECTORY GIT_DIR GIT_WORK_TREE GIT_GRAFT_FILE GIT_INDEX_FILE GIT_NO_REPLACE_OBJECTS
++ cd bar
++ GIT_WORK_TREE=.
++ git config core.worktree ../../../../../../../../../bug/product/foo/bar
fatal: Not a git repository: ../../../../Users/halley/bug/product/.git/modules/foo/modules/bar

This bit:

++ rel=../../../..
++ echo 'gitdir: ../../../../Users/halley/bug/product/.git/modules/foo/modules/bar'

is wrong, because from /bug/product/foo/bar, ../../../.. is
/Users/halley, not /.

If I replace the calls to "pwd" with "pwd -P", the problem goes away.
Unfortunately I'm not sure how to fix the script portably, as neither pwd -P
nor readlink(1) seem to be universally available.

Regards,

/Bob
