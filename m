From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log --parents broken post v1.3.0
Date: Wed, 3 May 2006 07:59:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605030745550.4086@g5.osdl.org>
References: <46a038f90605030456q679ceebcsa037b834bced9ca2@mail.gmail.com>
 <46a038f90605030510x6d582804w6c0d2fec60bd56e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 03 16:59:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbIoq-0000Us-4B
	for gcvg-git@gmane.org; Wed, 03 May 2006 16:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWECO7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWECO7J
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 10:59:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32705 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965211AbWECO7I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 10:59:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43Ex1tH002316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 07:59:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43Ex1Ro003129;
	Wed, 3 May 2006 07:59:01 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605030510x6d582804w6c0d2fec60bd56e5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19487>



On Thu, 4 May 2006, Martin Langhoff wrote:

> On 5/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > Soon after v1.3.0 git-log --parents got broken. When using --parents,
> 
> Ok -- perhaps that was a bit of a rushed statement. Reading back on
> the archives, it seems like it may have been intentional.

No it wasn't. "git log --parents" was definitely supposed to still work. 

That said, I suspect a git-cvsserver kind of usage is better off using 
"git-rev-list --parents HEAD" instead, which didn't break in the first 
place.

> I have to confess, I don't quite follow the changes happening in that
> series of commits. If --parents is really not coming back I'll change
> the log entry parsing in cvsserver. However, I suspect git-log should
> error out on it ("fatal: deprecated option") so porcelains break
> explicitly, rather than silently.

No, the option really isn't deprecated, it was just missed because nothing 
seemed to use it.. How about this diff?

Signed-off-by: Yadda yadda

		Linus

---
diff --git a/log-tree.c b/log-tree.c
index 9634c46..f9c6f7c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,6 +3,15 @@ #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
 
+static void show_parents(struct commit *commit, int abbrev)
+{
+	struct commit_list *p;
+	for (p = commit->parents; p ; p = p->next) {
+		struct commit *parent = p->item;
+		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+	}
+}
+
 void show_log(struct rev_info *opt, struct log_info *log, const char *sep)
 {
 	static char this_header[16384];
@@ -14,7 +23,10 @@ void show_log(struct rev_info *opt, stru
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
-		puts(sha1_to_hex(commit->object.sha1));
+		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
+		if (opt->parents)
+			show_parents(commit, abbrev_commit);
+		putchar('\n');
 		return;
 	}
 
@@ -40,6 +52,8 @@ void show_log(struct rev_info *opt, stru
 	printf("%s%s",
 		opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
 		diff_unique_abbrev(commit->object.sha1, abbrev_commit));
+	if (opt->parents)
+		show_parents(commit, abbrev_commit);
 	if (parent) 
 		printf(" (from %s)", diff_unique_abbrev(parent->object.sha1, abbrev_commit));
 	putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
