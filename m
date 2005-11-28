From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Mon, 28 Nov 2005 02:51:11 -0800
Message-ID: <7v3blhvye8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
	<7vr792fnta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
	<20051127182244.GK22159@pasky.or.cz>
	<Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
	<7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511271742520.13959@g5.osdl.org>
	<7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511272219420.13959@g5.osdl.org>
	<7v64qdyxxx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 11:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EggbT-0000rc-Vj
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 11:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVK1KvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 05:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVK1KvN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 05:51:13 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:133 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751243AbVK1KvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 05:51:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128104941.FWTM20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 05:49:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64qdyxxx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 28 Nov 2005 00:32:42 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12870>

Junio C Hamano <junkio@cox.net> writes:

> So let's cook this for a while and have Porcelain people holler
> if they find something lacking.  I'll put this in the proposed
> updates tonight, and we will plan to push everything in the
> proposed updates branch to the master branch on Wednesday, with
> any fixes and updates necessary.

OK, so I did some tests adjustments (they are in "pu").  Most
differences are easily explained but some are not.

Easy ones:

    - With -r, tree entries are not shown.

    - Unlike /bin/ls arguments, the paths are now filters, so
      no duplicates on the output, nor the output order does not
      depend on command line argument order.

    - "path" shows the tree if path corresponds to a directory;
      say "path/" to get its contents.

However I do not have an easy way to explain how these two work
the way they do.  Taken from t/t3101 test.

The first one has both path0/a/b/c and path0/a in the filter,
and path0/a tree entry itself is not shown because it "recurses
through it".

+# I am not so sure about this one after ls-tree doing pathspec match.
+# Having both path0/a and path0/a/b/c makes path0/a redundant, and
+# it behaves as if path0/a/b/c, path1/b/c, path2 and path3 are specified.
 test_expect_success \
     'ls-tree filter directories' \
     'git-ls-tree $tree path3 path2 path0/a/b/c path1/b/c path0/a >current &&
      cat >expected <<\EOF &&
-040000 tree X	path3
-100644 blob X	path3/1.txt
-100644 blob X	path3/2.txt
-040000 tree X	path2
-100644 blob X	path2/1.txt
 040000 tree X	path0/a/b/c
-100644 blob X	path0/a/b/c/1.txt
 040000 tree X	path1/b/c
-100644 blob X	path1/b/c/1.txt
-040000 tree X	path0/a
-040000 tree X	path0/a/b
+040000 tree X	path2
+040000 tree X	path3
 EOF
      test_output'

The second one is the same; since there is path3/, it recurses
through it and path3 itself is not shown but its contents are.
It is showing both path3/1.txt and path3/2.txt not because
path3/1.txt is specified but path3/ was specified.

+# Again, duplicates are filtered away so this is equivalent to
+# having 1.txt and path3/
 test_expect_success \
     'ls-tree filter odd names' \
     'git-ls-tree $tree 1.txt /1.txt //1.txt path3/1.txt /path3/1.txt //path3//1.txt path3 /path3/ path3// >current &&
      cat >expected <<\EOF &&
 100644 blob X	1.txt
-100644 blob X	1.txt
-100644 blob X	1.txt
-100644 blob X	path3/1.txt
-100644 blob X	path3/1.txt
-100644 blob X	path3/1.txt
-040000 tree X	path3
-100644 blob X	path3/1.txt
-100644 blob X	path3/2.txt
-040000 tree X	path3
-100644 blob X	path3/1.txt
-100644 blob X	path3/2.txt
-040000 tree X	path3
 100644 blob X	path3/1.txt
 100644 blob X	path3/2.txt
 EOF
