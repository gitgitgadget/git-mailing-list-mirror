From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Mon, 18 Jul 2005 00:38:40 -0700
Message-ID: <7vr7dw36nz.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<200507180853.41633.snake@penza-gsm.ru>
	<7vfyucfzgt.fsf@assigned-by-dhcp.cox.net>
	<200507181048.50303.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:39:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuQE8-0003zh-Q6
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 09:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGRHjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 03:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGRHjU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 03:39:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51922 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261226AbVGRHio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 03:38:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718073842.QLS17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 03:38:42 -0400
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200507181048.50303.snake@penza-gsm.ru> (Alexey Nezhdanov's message of "Mon, 18 Jul 2005 10:48:50 +0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov <snake@penza-gsm.ru> writes:

> But this should not be user's problem - it's just the UI that doesn't 
> understands when transcoding should be done.

I disagree.

Yes, while you _could_ do something like this to feed text in
local encoding to the VISUAL/EDITOR, and convert it back to
UTF-8:

--- a/git-commit-script
+++ b/git-commit-script
@@ -84,7 +84,7 @@
 fi
 if [ "$?" != "0" ]
 then
-	cat .editmsg
+	git-char-conv --utf8-to-user < .editmsg
 	rm .editmsg
 	exit 1
 fi
@@ -93,7 +93,9 @@
 	${VISUAL:-${EDITOR:-vi}} .editmsg
 	;;
 esac
-grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
+grep -v '^#' < .editmsg |
+git-stripspace |
+git-char-conv --user-to-utf8 > .cmitmsg
 [ -s .cmitmsg ] && 
 	tree=$(git-write-tree) &&
 	commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&


I think it is a horrible way to do things.

I presume that your bringing up UTF-8 suggests that you believe
doing things in UTF-8 for interoperability's sake is the right
thing.  If that is indeed the case, then tools other than GIT
and Cogito you would use would need to deal with this exact same
problem, that your VISUAL/EDITOR does not understand UTF-8.

How about writing a little wrapper, koi-vi, which would roughly
be:

    #!/bin/sh
    tcs -f utf -t koi8 "$1" >.tmp-koi
    vi .tmp-koi
    tcs -t utf -f koi8 .tmp-koi >"$1"

and point VISUAL/EDITOR environment variable at it?  That way
your other tools would be able to let you keep using your
favorite editor, now utf8 enabled, and deal with UTF-8.  None of
the scripts, including the script I quoted above, has to be
changed that way.

Having said that, I personally feel that the choice of the
character encoding of commit messages is per-project convention
issue and does not even warrant a per-project "configuration
file".  As long as your developers all agree to use KOI, and you
are reasonably sure that you will not ever cross-merge with
another project that uses different encoding for commit
messages, I think it is perfectly fine to use KOI in your commit
messages.  The core's job is only to ensure that we are 8-bit
clean and faithfully record whatever you throw at us.
