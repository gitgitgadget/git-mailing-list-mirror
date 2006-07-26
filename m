From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Nasty git corruption problem
Date: Wed, 26 Jul 2006 10:07:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607260945440.29649__37133.1703653142$1153933936$gmane$org@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 19:12:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5mvG-0008AM-4Z
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWGZRLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWGZRLq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:11:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1160999AbWGZRLp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 13:11:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6QHBgnW012289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Jul 2006 10:11:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6QHBfl0008713;
	Wed, 26 Jul 2006 10:11:41 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1153929715.13509.12.camel@localhost.localdomain>
X-Spam-Status: No, hits=-0.517 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24225>



On Wed, 26 Jul 2006, Alan Cox wrote:
> 
> During a git rebase my machine crashed. Git claims that the rebase is 
> complete but contains none of the outstanding 30 odd patches. There is 
> no .dotest directory and git-fsck-objects produces some warnings about a 
> few dangling objects, but these objects aren't the relevant ones (at 
> least directly)

They definitely should be, unless you actually did a "git prune" (or a 
"git repack -d").

> CVS and SVN in crashes don't lose old stuff, though they are pretty good
> at losing the last commit or two.

And git should be even harder to get to lose old stuff, because it won't 
even touch it. 

> Doing
> 
> for i in *; do (cd $i; for j in *; do git-unpack-file $i$j; done; );
> done
> 
> shows that lots of the changes are still somewhere in the object tree
> but there seems to be no tool for fixing rather than moaning about
> objects dangling, and also no obvious way to fix it.

Well, the "dangling objects" really should be the fix. We could make it 
even more obvious by creating links to the dangling objects in a 
"lost+found" directory, but I usually just do it by hand.

So the thing to do to recover any old stuff is

 - do "git-fsck-objects --full".

   The "--full" is going to make it much slower, but it means that it will 
   look _inside_ old packs too, and if you repacked the old stuff, that's 
   what you want. Besides, if you actually had a real crash in the middle 
   of a git op, you probably do want this anyway, although quite frankly, 
   a truly corrupted pack is pretty damn unlikely (the only case I 
   remember ever seing was due to actual hardware problems)

   I _suspect_ you didn't do the "--full". By default, git-fsck-objects 
   will only look at the unpacked objects, exactly because pack-files are 
   so stable. So the only reason to use "--full" is if you're really anal 
   and suspect hw issues, _or_ if you are looking for dangling work that 
   may be older than your last repack.

 - take all the dangling objects, and either list them explicitly to 
   "gitk" (or other visualizer), or you could save them off as

	.git/refs/lost+found/<some-random-names-here>

   and then do "gitk --all"

In fact, if you want to play around with a git patch, this trivial one 
should make git-fsck-objects create those lost-and-found entries 
automatically if you give it the "--lost-n-found" flag.

Anyway, I'm pretty sure that git is a hell of a lot _safer_ than either 
CVS or SVN have ever been, or will ever be.

		Linus

---
diff --git a/fsck-objects.c b/fsck-objects.c
index e167f41..fa50190 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -14,6 +14,7 @@ #include "tree-walk.h"
 #define REACHABLE 0x0001
 #define SEEN      0x0002
 
+static int lost_and_found = 0;
 static int show_root = 0;
 static int show_tags = 0;
 static int show_unreachable = 0;
@@ -102,8 +103,23 @@ static void check_connectivity(void)
 		}
 
 		if (!obj->used) {
-			printf("dangling %s %s\n", typename(obj->type),
-			       sha1_to_hex(obj->sha1));
+			char *hex = sha1_to_hex(obj->sha1);
+			printf("dangling %s %s\n", typename(obj->type), hex);
+			if (lost_and_found) {
+				int fd, ret;
+				mkdir(git_path("refs/lost+found"), 0777);
+				fd = open(git_path("refs/lost+found/%s", hex), O_CREAT | O_TRUNC | O_WRONLY, 0666);
+				if (fd < 0) {
+					perror("lost+found");
+					continue;
+				}
+				hex[40] = '\n';
+				ret = xwrite(fd, hex, 41);
+				close(fd);
+				if (ret != 41)
+					error("unable to write to lost+found");
+				continue;
+			}
 		}
 	}
 }
@@ -514,6 +530,10 @@ int main(int argc, char **argv)
 			check_strict = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--lost-n-found")) {
+			lost_and_found = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage("git-fsck-objects [--tags] [--root] [[--unreachable] [--cache] [--full] [--strict] <head-sha1>*]");
 	}
