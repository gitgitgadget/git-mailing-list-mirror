From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Wed, 25 Jul 2007 15:28:12 -0700
Message-ID: <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
References: <20070725212311.GA13325@cassiopeia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpLE-0004L9-Rx
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208AbXGYW2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 18:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbXGYW2T
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:28:19 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47577 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759120AbXGYW2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 18:28:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725222815.UZSG1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 18:28:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TyUE1X00D1kojtg0000000; Wed, 25 Jul 2007 18:28:14 -0400
In-Reply-To: <20070725212311.GA13325@cassiopeia> (Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig's?= message
	of "Wed, 25 Jul 2007 23:23:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53727>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> zeisberg@cassiopeia:/tmp$ mkdir repo; cd repo; git init
> Initialized empty Git repository in .git/
>
> zeisberg@cassiopeia:/tmp/repo$ mkdir dir; echo one > file; echo two >=
 dir/file
>
> zeisberg@cassiopeia:/tmp/repo$ git add file dir/file
>
> zeisberg@cassiopeia:/tmp/repo$ git commit -m tralala
> Created initial commit 265b7d7: tralala
>  2 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 dir/file
>  create mode 100644 file
>
> zeisberg@cassiopeia:/tmp/repo$ echo three >> file
>
> zeisberg@cassiopeia:/tmp/repo$ git stash
> Saved "WIP on master: 265b7d7... tralala"
> HEAD is now at 265b7d7... tralala
>
> zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
> error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d=
84f59789'
> /home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault =
     git-merge-recursive $b_tree -- $c_tree $w_tree

This probably is a merge-recursive bug, but in the meantime,
I think this should fix it.

---

 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index de13dd1..d9cd42d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -6,6 +6,7 @@ USAGE=3D'[ | list | show | apply | clear]'
 SUBDIRECTORY_OK=3DYes
 . git-sh-setup
 require_work_tree
+cd_to_toplevel
=20
 TMP=3D"$GIT_DIR/.git-stash.$$"
 trap 'rm -f "$TMP-*"' 0
