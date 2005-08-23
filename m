From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Current status toward 0.99.5 and beyond
Date: Tue, 23 Aug 2005 10:31:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231022340.3317@g5.osdl.org>
References: <7vmzn8poc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 19:34:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7ccq-0006M1-Hw
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHWRbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVHWRbt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 13:31:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932241AbVHWRbs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 13:31:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7NHVhjA016994
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 10:31:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7NHVggC027135;
	Tue, 23 Aug 2005 10:31:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzn8poc8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7660>



On Tue, 23 Aug 2005, Junio C Hamano wrote:
>
> So far, the following commands should be usable with relative directory
> paths:
> 
>     update-cache
>     ls-files
>     diff-files
>     diff-cache
>     diff-tree

Also, git-rev-parse.

Finally, this trivial patch makes "git-rev-list" also able to handle not
being in the top-level directory, which makes it possible to do "git log" 
and "git-whatchanged" at any point in the directory structure.

			Linus

---
Subject: Make "git-rev-list" work within subdirectories

This trivial patch makes ""git-rev-list" able to handle not being in the
top-level directory. This magically also makes "git-whatchanged" do the 
right thing.

Trivial scripting fix to make sure that "git log" also works.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-log-script b/git-log-script
--- a/git-log-script
+++ b/git-log-script
@@ -1,5 +1,4 @@
 #!/bin/sh
-. git-sh-setup-script || die "Not a git archive"
-revs=$(git-rev-parse --revs-only --default HEAD "$@")
+revs=$(git-rev-parse --revs-only --default HEAD "$@") || exit
 [ "$revs" ] || die "No HEAD ref"
 git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | LESS=-S ${PAGER:-less}
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -481,6 +481,7 @@ static void handle_one_commit(struct com
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
+	const char *prefix = setup_git_directory();
 	int i, limited = 0;
 
 	for (i = 1 ; i < argc; i++) {
