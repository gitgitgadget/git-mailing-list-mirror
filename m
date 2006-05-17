From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 13:53:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171342370.10823@g5.osdl.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com>
 <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
 <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org>
 <1147893786.16654.5.camel@dv> <20060517153903.6b896fdd.seanlkml@sympatico.ca>
 <1147895816.30618.6.camel@dv> <Pine.LNX.4.64.0605171325200.10823@g5.osdl.org>
 <e4g1f4$anv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 22:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgT1B-0004oO-6B
	for gcvg-git@gmane.org; Wed, 17 May 2006 22:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWEQUxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 16:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWEQUxO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 16:53:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWEQUxO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 16:53:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HKrAtH008992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 13:53:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HKr9il025995;
	Wed, 17 May 2006 13:53:10 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4g1f4$anv$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20242>



On Wed, 17 May 2006, Jakub Narebski wrote:
> 
> The changes in docummentation are nice and dandy, but it would be even nicer
> if "git add" told us about "git update-index --add" when it adds no files,
> as it is certainly the case when something is wrong (perhaps user
> expectations, but still...).

Well, with the new-and-improved builtin "git add", you could probably do 
something like the appended (on top of my most recent patch).

It says

	No added files - did you perhaps mean to do a 'git update-index'?

whenever it finds that "git add" has ignored a file and not actually added 
anything. That, btw, can happen either because it refused to see the file 
in the first place (ie it was ignored), or because all the files listed 
were already added.

In both cases the warning may or may not be sensible.

Anyway, I dunno. I don't have any strong opinions on this.

		Linus

---
diff --git a/builtin-add.c b/builtin-add.c
index 82e8f44..8641137 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,8 @@ #include "dir.h"
 static const char builtin_add_usage[] =
 "git-add [-n] [-v] <filepattern>...";
 
+static int ignored;
+
 static int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
@@ -123,8 +125,10 @@ static void prune_directory(struct dir_s
 
 		/* Existing file? We must have ignored it */
 		match = pathspec[i];
-		if (!lstat(match, &st))
+		if (!lstat(match, &st)) {
+			ignored = 1;
 			continue;
+		}
 		die("pathspec '%s' did not match any files", match);
 	}
 }
@@ -257,6 +261,9 @@ int cmd_add(int argc, const char **argv,
 	for (i = 0; i < dir.nr; i++)
 		add_file_to_index(dir.entries[i]->name, verbose);
 
+	if (ignored && !active_cache_changed)
+		fprintf(stderr, "No added files - did you perhaps mean to do a 'git update-index'?\n");
+
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_index_file(&cache_file))
