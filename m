From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 02:10:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609210208350.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmcudt3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 02:10:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQC9D-0004b1-V1
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 02:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWIUAKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 20:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWIUAKd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 20:10:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:32479 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750801AbWIUAKc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 20:10:32 -0400
Received: (qmail invoked by alias); 21 Sep 2006 00:10:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 21 Sep 2006 02:10:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmcudt3t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27439>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If receive.denyNonFastforwards is set to true, git-receive-pack will deny
> > non fast-forwards, i.e. forced updates. Most notably, a push to a repository
> > which has that flag set will fail.
> >
> > As a first user, 'git-init-db --shared' sets this flag, since in a shared
> > setup, you are most unlikely to want forced pushes to succeed.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Looks good.  Care to do a handful more tasks before we forget?
> 
>  Documentation/git-init-db.txt
>  Documentation/config.txt
>  Documentation/git-receive-pack.txt
>  t/t5400-send-pack.sh or a new test t/t5401-push-into-shared-repo.sh

I expected Jakub to ask for it ;-)

-- snip --
[PATCH] Document receive.denyNonFastforwards

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/config.txt           |    7 +++++++
 Documentation/git-init-db.txt      |    4 ++++
 Documentation/git-receive-pack.txt |    2 ++
 t/t5400-send-pack.sh               |   10 ++++++++++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 844cae4..6802d30 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -267,3 +267,10 @@ whatchanged.difftree::
 imap::
 	The configuration variables in the 'imap' section are described
 	in gitlink:git-imap-send[1].
+
+receive.denyNonFastforwads::
+	If set to true, git-receive-pack will deny a ref update which is
+	not a fast forward. Use this to prevent such an update via a push,
+	even if that push is forced. This configuration variable is
+	set when initializing a shared repository.
+	
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 63cd5da..ca7d09d 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -48,6 +48,10 @@ is given:
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
+By default, the configuration flag receive.denyNonFastforward is enabled
+in shared repositories, so that you cannot force a non fast-forwarding push
+into it.
+
 --
 
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index f9457d4..0dfadc2 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -73,6 +73,8 @@ packed and is served via a dumb transpor
 There are other real-world examples of using update and
 post-update hooks found in the Documentation/howto directory.
 
+git-receive-pack honours the receive.denyNonFastforwards flag, which
+tells it if updates to a ref should be denied if they are not fast-forwards.
 
 OPTIONS
 -------
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f3694ac..6be3c80 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -64,4 +64,14 @@ test_expect_success \
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
 '
 
+test_expect_success \
+        'pushing with --force should be denied with denyNonFastforwards' '
+	cd victim &&
+	git-repo-config receive.denyNonFastforwards true &&
+	cd .. &&
+	git-update-ref refs/heads/master master^ &&
+	git-send-pack --force ./victim/.git/ master &&
+	! diff -u .git/refs/heads/master victim/.git/refs/heads/master
+'
+
 test_done
-- 
1.4.2.1.g6ad2-dirty
