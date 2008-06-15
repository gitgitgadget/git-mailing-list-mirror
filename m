From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gc changes permissions of files
Date: Sun, 15 Jun 2008 06:38:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806150551010.6439@racer>
References: <20080615035917.GA13414@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Allan Wind <allan_wind@lifeintegrity.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 07:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7kzh-0001KV-Ix
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 07:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbYFOFkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 01:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYFOFkH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 01:40:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:39614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750958AbYFOFkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 01:40:05 -0400
Received: (qmail invoked by alias); 15 Jun 2008 05:40:02 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 15 Jun 2008 07:40:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18D2CwuOeoDkJC8mlXKycMu4V6IrI4f9i29l8RITq
	LWSfp/cb8MtRlJ
X-X-Sender: gene099@racer
In-Reply-To: <20080615035917.GA13414@lifeintegrity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85065>

Hi,

On Sat, 14 Jun 2008, Allan Wind wrote:

> Is anyone looking into fixing gc so it does not change permission on 
> files?  I would think it should consider current permissions of files 
> before umask.
> 
> I believe Nigel reported this issue with:
> http://thread.gmane.org/gmane.comp.version-control.git/79213/focus=79237
> and still seeing issues with 1.5.5.4.

It would have been nice to briefly illustrate the problem again.

In the message you referred to, it seems to suggest that git-gc (in 
fact, git pack-refs) set the permissions wrong in a shared repository.

However, I cannot reproduce at all:

-- snip --
[PATCH] Verify that permissions for packed-refs are set correctly

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1301-shared-repo.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 5e4252a..c4d3239 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -43,6 +43,24 @@ test_expect_success 'update-server-info honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success 'pack-refs honors core.sharedRepository' '
+
+	(umask 0217 &&
+	 : > a2 &&
+	 git pack-refs) &&
+	actual="$(ls -l .git/packed-refs)" &&
+	case "$actual" in
+	-r--r--r--*)
+		: happy
+		;;
+	*)
+		echo Oops, .git/packed-refs is not 0444
+		false
+		;;
+	esac
+
+'
+
 for u in	0660:rw-rw---- \
 		0640:rw-r----- \
 		0600:rw------- \
-- snap --

This succeeds.

Indeed, it should succeed, since the relevant part in lockfile.c was fixed 
in version v1.4.0~4.

However, I suspect from the original message that the reflogs did not have 
the correct permissions.  But again, a simple test succeeds:

-- snip --
[PATCH] Add a test for logrefs in bare repositories

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1301-shared-repo.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 5e4252a..8530a56 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -24,6 +24,39 @@ test_expect_success 'shared=all' '
 	test 2 = $(git config core.sharedrepository)
 '
 
+test_expect_success 'reflogs honor core.sharedRepository' '
+	git config core.logAllRefUpdates true &&
+	echo 2 > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m a1 &&
+	actual="$(ls -l .git/logs/refs/heads/master)" &&
+	case "$actual" in
+	-rw-rw-r--*)
+		: happy
+		;;
+	*)
+		echo Oops, .git/logs/refs/heads/master is not 0664
+		false
+		;;
+	esac &&
+	(mkdir bare.git &&
+	 cd bare.git &&
+	 git --bare init --shared &&
+	 git config core.logAllRefUpdates true) &&
+	git push bare.git master:refs/heads/new &&
+	actual="$(ls -l bare.git/logs/refs/heads/new)" &&
+	case "$actual" in
+	-rw-rw-*)
+		: happy
+		;;
+	*)
+		echo Oops, bare.git/logs/refs/heads/new is not 0664
+		false
+		;;
+	esac
+'
+
 test_expect_success 'update-server-info honors core.sharedRepository' '
 	: > a1 &&
 	git add a1 &&
-- 
1.5.5.1.780.g346de
-- snap --

So now I got curious and tested it with v1.5.4.4, and indeed, it failed.

If you are curious who/what fixed it, go ahead, bisect it.

I wrote all this down so that the next time, you could verify yourself if 
the bug was fixed or not, instead of having to ask here.

Ciao,
Dscho
