From: Junio C Hamano <junkio@cox.net>
Subject: Re: Trouble building newer git with older
Date: Tue, 08 Aug 2006 13:11:16 -0700
Message-ID: <7v7j1jvvh7.fsf@assigned-by-dhcp.cox.net>
References: <20060808184716.GC4546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 22:11:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAXvA-0005uJ-LE
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 22:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWHHULT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHHULT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 16:11:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30865 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030261AbWHHULS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 16:11:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808201117.KVDN23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 16:11:17 -0400
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20060808184716.GC4546@us.ibm.com> (Nishanth Aravamudan's message
	of "Tue, 8 Aug 2006 11:47:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25085>

Nishanth Aravamudan <nacc@us.ibm.com> writes:

> This is because GIT-VERSION-GEN attempts to invoke `git describe` but
> describe is not a valid parameter to the current version of git. This is
> not treated as a failure case, though, as output is stored in VN.
> Perhaps the return code of `git describe` should also be checked? Or am
> I just not supposed to upgrade from this old of a version of git via
> git?

No, it was broken when this patch was applied.

        commit 1100ac81a90b03e0c037a286569a340decf7489b
        Author: Sean <seanlkml@sympatico.ca>
        Date:   Mon May 22 00:39:52 2006 -0400

Luckily, my copy of GNU interactive tools, when invoked like this:

	git describe --abbrev=4 HEAD 2>/dev/null

exits with an error code 1, so the existing code already catches it.

How about this patch?

-- >8 --
GIT-VERSION-GEN: adjust for ancient git

When an ancient "git" that does not understand "describe"
command is on the $PATH, "git describe" emitted a Usage message
without exiting non-zero status (which is a mistake we cannot
fix retroactively).  Catch this case to make sure we do not try
using phoney multi-line string as a version number.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 1ce217d..14923c9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,9 +3,17 @@ #!/bin/sh
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.4.2.GIT
 
+LF='
+'
+
 # First try git-describe, then see if there is a version file
 # (included in release tarballs), then default
-if VN=$(git describe --abbrev=4 HEAD 2>/dev/null); then
+if VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+   case "$VN" in
+   *$LF*) (exit 1) ;;
+   v[0-9]*) : happy ;;
+   esac
+then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
 elif test -f version
 then
