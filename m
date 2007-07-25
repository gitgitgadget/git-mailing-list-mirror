From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Thu, 26 Jul 2007 00:01:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260001091.14781@racer.site>
References: <20070725212311.GA13325@cassiopeia> <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1451772899-1185404512=:14781"
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDprl-00056q-MG
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622AbXGYXB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759021AbXGYXB5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:01:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:51267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754759AbXGYXB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:01:57 -0400
Received: (qmail invoked by alias); 25 Jul 2007 23:01:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 26 Jul 2007 01:01:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192Q6lF3m92C0ni3M0+U6F4Onhc/hCA1ib7oOHMmA
	LfL3o2AVRKD9GM
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53733>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1451772899-1185404512=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Jul 2007, Junio C Hamano wrote:

> Uwe Kleine-König  <ukleinek@informatik.uni-freiburg.de> writes:
> 
> > zeisberg@cassiopeia:/tmp$ mkdir repo; cd repo; git init
> > Initialized empty Git repository in .git/
> >
> > zeisberg@cassiopeia:/tmp/repo$ mkdir dir; echo one > file; echo two > dir/file
> >
> > zeisberg@cassiopeia:/tmp/repo$ git add file dir/file
> >
> > zeisberg@cassiopeia:/tmp/repo$ git commit -m tralala
> > Created initial commit 265b7d7: tralala
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> >  create mode 100644 dir/file
> >  create mode 100644 file
> >
> > zeisberg@cassiopeia:/tmp/repo$ echo three >> file
> >
> > zeisberg@cassiopeia:/tmp/repo$ git stash
> > Saved "WIP on master: 265b7d7... tralala"
> > HEAD is now at 265b7d7... tralala
> >
> > zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
> > error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d84f59789'
> > /home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault      git-merge-recursive $b_tree -- $c_tree $w_tree
> 
> This probably is a merge-recursive bug, but in the meantime,
> I think this should fix it.
> 
> ---
> 
>  git-stash.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index de13dd1..d9cd42d 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -6,6 +6,7 @@ USAGE='[ | list | show | apply | clear]'
>  SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  require_work_tree
> +cd_to_toplevel
>  
>  TMP="$GIT_DIR/.git-stash.$$"
>  trap 'rm -f "$TMP-*"' 0

It does... And here is a test case:

-- snipsnap --
[PATCH] Test "stash apply" in a subdirectory

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t3903-stash.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 392ac1c..9e363fd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -66,4 +66,18 @@ test_expect_success 'apply stashed changes (including index)' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'apply in subdir' '
+	git --git-dir=new init &&
+	cd new &&
+	mkdir dir &&
+	echo one > file &&
+	echo two > dir/file &&
+	git add file dir/file &&
+	git commit -m first &&
+	echo three >> file &&
+	git stash &&
+	cd dir &&
+	git stash apply
+'
+
 test_done
--8323584-1451772899-1185404512=:14781--
