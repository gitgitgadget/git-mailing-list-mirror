From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix-up previous expr changes.
Date: Thu, 13 Apr 2006 19:12:24 -0700
Message-ID: <7v8xq8x5vb.fsf@assigned-by-dhcp.cox.net>
References: <slrne3tihk.1dq.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Apr 14 04:12:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUDnT-0003fc-Kk
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 04:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWDNCM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 22:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWDNCM0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 22:12:26 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53924 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965067AbWDNCM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 22:12:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414021225.TSFC2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 22:12:25 -0400
To: git@vger.kernel.org
In-Reply-To: <slrne3tihk.1dq.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Thu, 13 Apr 2006 22:01:24 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18681>

The regexp on the right hand side of expr : operator somehow was
broken.

	expr 'z+pu:refs/tags/ko-pu' : 'z\+\(.*\)'

does not strip '+'; write 'z+\(.*\)' instead.

We probably should switch to shell based substring post 1.3.0;
that's not bashism but just POSIX anyway.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Funny thing is that before the z prefixing, the code was
   already broken (we said expr "$ref" : '\+\(.*\)'), but
   somehow it worked.  It could be a bug in expr.

	# already buggy but did not trigger somehow.
        : siamese; expr '+pu:ko-pu' : '\+\(.*\)'
        pu:ko-pu
        # z prefix exposed the breakage.
        : siamese; expr 'z+pu:ko-pu' : 'z\+\(.*\)'
        +pu:ko-pu
        # the fix-up this patch is about.
        : siamese; expr 'z+pu:ko-pu' : 'z+\(.*\)'
        pu:ko-pu
        # this is the way it should have been written from the start.
        : siamese; expr '+pu:ko-pu' : '+\(.*\)'
        pu:ko-pu
        # maybe I am using broken expr...
        : siamese; type expr
        expr is hashed (/usr/bin/expr)
        : siamese; /usr/bin/expr --version |head -n2
        expr (GNU coreutils) 5.94
        Copyright (C) 2006 Free Software Foundation, Inc.

 git-fetch.sh        |    4 ++--
 git-parse-remote.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

dfdcb558ecf93c0e09b8dab89cff4839e8c95e36
diff --git a/git-fetch.sh b/git-fetch.sh
index 711650f..83143f8 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -252,10 +252,10 @@ fetch_main () {
       else
 	  not_for_merge=
       fi
-      if expr "z$ref" : 'z\+' >/dev/null
+      if expr "z$ref" : 'z+' >/dev/null
       then
 	  single_force=t
-	  ref=$(expr "z$ref" : 'z\+\(.*\)')
+	  ref=$(expr "z$ref" : 'z+\(.*\)')
       else
 	  single_force=
       fi
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 65c66d5..c9b899e 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -77,7 +77,7 @@ canon_refs_list_for_fetch () {
 		force=
 		case "$ref" in
 		+*)
-			ref=$(expr "z$ref" : 'z\+\(.*\)')
+			ref=$(expr "z$ref" : 'z+\(.*\)')
 			force=+
 			;;
 		esac
-- 
1.3.0.rc3.gce03
