From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] (minor) Cloning an empty repository
Date: Fri, 31 Aug 2007 12:03:50 +0200
Message-ID: <vpqk5rc10mx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 12:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR3Mx-0001Pl-IG
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbXHaKEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbXHaKEW
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:04:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:44830 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723AbXHaKEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:04:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7VA3obT017232
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 31 Aug 2007 12:03:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IR3Ly-0006jX-7s; Fri, 31 Aug 2007 12:03:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IR3Ly-000293-5b; Fri, 31 Aug 2007 12:03:50 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 31 Aug 2007 12:03:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57145>

Hi,

Git fails to clone an empty repository (no commit yet), but claims it
does:

/tmp$ mkdir empty
/tmp$ cd empty
/tmp/empty$ git init
Initialized empty Git repository in .git/
/tmp/empty$ cd ../
/tmp$ git clone empty my-clone
Initialized empty Git repository in /tmp/my-clone/.git/

# All seems correct.

/tmp$ cd my-clone
cd: no such file or directory: my-clone

# Gosh, git lied when telling me it initialized
# /tmp/my-clone/.git/ ? ;-)

A quick look at the code tells me that the directory was actually
initialized, but later, at git-clone.sh:282,

			# objects directory should not be empty because
			# we are cloning!
			test -f "$repo/$sample_file" || exit

and the exit is trapped to "cleanup()" which rm -fr the directory.
Unfortunately, just commenting-out this line isn't sufficient, it
leaves me with a half-initialized repository (.git/config/ doesn't
contain the "origin" remote).

That's a detail, but it would be better if either git could actually
do the clone, or give me a clean error message like "Can not clone
empty repository".

If no one does anything better, the following patch can be a very
small step forward.


>From fdbb61bb9ac26627c4786b58f38426bde621cdcb Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Fri, 31 Aug 2007 12:00:09 +0200
Subject: [PATCH] Slightly more informative error message when cloning an empty repository.

---
 git-clone.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 18003ab..1aad510 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -278,7 +278,11 @@ yes)
 				      find objects -type f -print | sed -e 1q)
 			# objects directory should not be empty because
 			# we are cloning!
-			test -f "$repo/$sample_file" || exit
+			if test \! -f "$repo/$sample_file"
+			then
+				echo "No objects in repository. Cleaning up ..." >&2
+				exit
+			fi
 			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
 			then
 				rm -f "$GIT_DIR/objects/sample"
-- 
1.5.3.rc6.49.gd50b


PS: In case someone's interested, my use-case is the following:

I have ~/archives/git/ which contains git tree-less repositories
(normally bare repository, but sometimes simply normal repositories in
which I didn't checkout), and I have a working tree somewhere else in
my $HOME (or on my /local, faster but not backed-up). I set my commit
hook to "git push --all", so it's a kind of centralized system inside
my machine. Just to separate the stuff that matters (repositories),
and the others (working tree).

To start a new project, I can either create the repository with the
working tree, and clone it to ~/archives/git/some-project, but it's
more conveinient to create ~/archives/git/some-project and then clone
it somewhere else, since it sets up the "origin" remote for me, and
push/pull work out of the box.

-- 
Matthieu
