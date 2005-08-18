From: Linus Torvalds <torvalds@osdl.org>
Subject: git-applymbox: verify that index is clean
Date: Thu, 18 Aug 2005 15:31:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181527100.3412@g5.osdl.org>
References: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.58.0508181503200.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5svX-0003fQ-Bu
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 00:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHRWb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHRWb4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 18:31:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932503AbVHRWb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 18:31:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7IMVjjA014968
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 15:31:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7IMVeNd012740;
	Thu, 18 Aug 2005 15:31:42 -0700
To: Junio C Hamano <junkio@cox.net>, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <Pine.LNX.4.58.0508181503200.3412@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This makes git-applymbox verify that the index matches the current HEAD 
before it starts applying patches.

Otherwise, you might have updated the index with unrelated changes, and 
the first patch will commit not just the patch from the mbox, but also any 
changes you had in your index.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

This was brough on by: Tony Luck's problem, which _might_ be due to index
file change contents that got committed together with a real patch. This
will make it much harder to make that particular mistake.

On Thu, 18 Aug 2005, Linus Torvalds wrote:
>
> (git-applymbox _does_ verify that the files that it patches are up-to-date 
> in the index, but it does _not_ verify that the index matches the current 
> HEAD. I guess I could add a sanity check for that...)

diff --git a/tools/git-applymbox b/tools/git-applymbox
--- a/tools/git-applymbox
+++ b/tools/git-applymbox
@@ -18,6 +18,8 @@
 ## use a Signoff_file, because applypatch wants to append the sign-off
 ## message to msg-clean every time it is run.
 
+. git-sh-setup-script || die "Not a git archive"
+
 keep_subject= query_apply= continue= resume=t
 while case "$#" in 0) break ;; esac
 do
@@ -39,6 +41,12 @@ case "$continue" in
 	shift
 esac
 
+files=$(git-diff-cache --cached --name-only HEAD) || exit
+if [ "$files" ]; then
+   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
+   exit 1
+fi
+
 case "$query_apply" in
 t)	touch .dotest/.query_apply
 esac
