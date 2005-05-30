From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 16:15:17 -0700
Message-ID: <7v7jhgz4oq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<20050530221214.GA29556@redhat.com>
	<200505301755.15371.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 31 01:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DctZF-0002fm-Bd
	for gcvg-git@gmane.org; Tue, 31 May 2005 01:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVE3XWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 19:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVE3XVO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 19:21:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17323 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261826AbVE3XP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 19:15:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530231518.KWTW26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 19:15:18 -0400
To: git@vger.kernel.org
In-Reply-To: <200505301755.15371.dtor_core@ameritech.net> (Dmitry Torokhov's
 message of "Mon, 30 May 2005 17:55:14 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On a related topic of making bare Plumbing a bit easier to use,
here is what I use to prepare patches, one patch per file, to be
sent to Linus via e-mail.

Usage:

  $ git-format-patch-script HEAD linus

Assuming that "linus" is the tip of the tree from Linus
(typically stored in .git/branches/linus if you use Cogito), and
HEAD is your additions on top of it, the above command will
produce patches in the format you have been seeing on this list
from me, one file per commit, in .patches/XXXX-patch-title.txt
file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
sed -e 's/^X//' >git-format-patch-script <<\EOF
X#!/bin/sh
X#
X# Copyright (c) 2005 Junio C Hamano
X#
Xjunio="$1"
Xlinus="$2"
X
Xtmp=.tmp-series$$
Xtrap 'rm -f $tmp-*' 0 1 2 3 15
X
Xseries=$tmp-series
X
XtitleScript='
X	1,/^$/d
X	: loop
X	/^$/b loop
X	s/[^-a-z.A-Z_0-9]/-/g
X	s/^--*//g
X	s/--*$//g
X	s/---*/-/g
X	s/$/.txt/
X        s/\.\.\.*/\./g
X	q
X'
XO=
Xif test -f .git/patch-order
Xthen
X	O=-O.git/patch-order
Xfi
Xgit-rev-list "$junio" "$linus" >$series
Xtotal=`wc -l <$series`
Xi=$total
Xwhile read commit
Xdo
X    title=`git-cat-file commit "$commit" | sed -e "$titleScript"`
X    num=`printf "%d/%d" $i $total`
X    file=`printf '%04d-%s' $i "$title"`
X    i=`expr "$i" - 1`
X    echo "$file"
X    {
X	mailScript='
X	1,/^$/d
X	: loop
X	/^$/b loop
X	s|^|[PATCH '"$num"'] |
X	: body
X	p
X	n
X	b body'
X
X	git-cat-file commit "$commit" | sed -ne "$mailScript"
X	echo '---'
X	git-diff-tree -p $O "$commit" | diffstat -p1
X	echo
X	git-diff-tree -p $O "$commit"
X    } >".patches/$file"
Xdone <$series
EOF

