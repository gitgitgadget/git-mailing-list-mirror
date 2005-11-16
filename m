From: Linus Torvalds <torvalds@osdl.org>
Subject: Disallow empty pattern in "git grep"
Date: Wed, 16 Nov 2005 09:38:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511160934480.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 16 18:42:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcRFZ-0000gD-3S
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 18:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVKPRjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVKPRjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 12:39:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030251AbVKPRjH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 12:39:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAGHcnnO023030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 16 Nov 2005 09:38:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAGHckD7003655;
	Wed, 16 Nov 2005 09:38:48 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12032>


For some reason I've done a "git grep" twice with no pattern, which is 
really irritating, since it just grep everything. If I actually wanted 
that, I could do "git grep ^" or something.

So add a "usage" message if the pattern is empty.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Yeah, maybe we should allow an empty pattern, and just check the number of 
arguments instead. However, the argument parsing isn't set up that way, so 
this was the simple and ugly approach.

So this will warn even for

	git grep ""

which might be otherwise be considered legal (but stupid).

diff --git a/git-grep.sh b/git-grep.sh
index e7a35eb..44c1613 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -39,5 +39,9 @@ while : ; do
 	esac
 	shift
 done
+[ "$pattern" ] || {
+	echo >&2 "usage: 'git grep <pattern> [pathspec*]'"
+	exit 1
+}
 git-ls-files -z "${git_flags[@]}" "$@" |
 	xargs -0 grep "${flags[@]}" -e "$pattern"
