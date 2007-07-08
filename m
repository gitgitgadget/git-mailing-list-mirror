From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Sun, 08 Jul 2007 19:36:48 +0200
Message-ID: <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<vpq7ipittl2.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707022205210.4071@racer.site>
	<vpqoditkc23.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0707031308170.4071@racer.site>
	<vpqir91hagz.fsf@bauges.imag.fr>
	<20070704200806.GA3991@efreet.light.src>
	<vpqd4z7q820.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 19:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ahY-0008Gm-Dt
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 19:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbXGHRhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755955AbXGHRhg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 13:37:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:35087 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755427AbXGHRhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 13:37:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l68HamcO027463
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2007 19:36:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I7agi-0007qV-6d; Sun, 08 Jul 2007 19:36:48 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I7agi-0005CX-42; Sun, 08 Jul 2007 19:36:48 +0200
Mail-Followup-To: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>
In-Reply-To: <vpqd4z7q820.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu\, 05 Jul 2007 15\:44\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 08 Jul 2007 19:36:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51897>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>>  - if (HEAD == index && index == version) unversion and unlink
>
> Just to be more precise:
>
>    - if (HEAD == index && index == version) unversion and
>        * if (--cached is not given) unlink
>        * else do nothing
>
>>  - else if (HEAD == index || index == version) unversion
>>  - else print message and do nothing
>>
>> Would you consider that a sane behaviour?

[...]

> I'll try writting patch for that if people agree that this is saner
> that the current behavior.

Here's a first attempt (I'm still not familiar with the git codebase,
so the patch is probably not so good).

Note: currently, git-rm still shows those "rm '...'" messages on
stdout. AAUI, they were actually useful at a time when git-rm didn't
actually remove the files, and people actually ran the "rm" commands
after. They can probably be removed now, but that's another topic.


>From f4f4aa047b2b9050d968704d1f2db07b2a1a79cc Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sun, 8 Jul 2007 19:27:44 +0200
Subject: [PATCH] Make git-rm obey in more circumstances.

In the previous behavior of git-rm, git refused to do anything in case of
a difference between the file on disk, the index, and the HEAD. As a
result, the -f flag is forced even for simple senarios like:

$ git add foo
# oops, I didn't want to version it
$ git rm -f [--cached] foo
# foo is deleted on disk if --cached isn't provided.

This patch proposes a saner behavior. When there are no difference at all
between file, index and HEAD, the file is removed both from the index and
the tree, as before.

Otherwise, if the index matches either the file on disk or the HEAD, the
file is removed from the index, but the file is kept on disk, it may
contain important data.

Otherwise, that's an error, and git-rm aborts.

The above senario becomes

$ git add foo
$ git rm foo
# back to the initial state.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-rm.txt |    9 ++++---
 builtin-rm.c             |   55 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 78f45dc..180671c 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -11,10 +11,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Remove files from the working tree and from the index.  The
-files have to be identical to the tip of the branch, and no
-updates to its contents must have been placed in the staging
-area (aka index).
+Remove files from the working tree and from the index. The content
+placed in the staging area (aka index) must match either the content
+of the file on disk, or the tip of the branch. If it matches only one
+of them, the file is kept on disk for safety, but is still removed
+from the index.
 
 
 OPTIONS
diff --git a/builtin-rm.c b/builtin-rm.c
index 4a0bd93..d2a8998 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -12,18 +12,27 @@
 static const char builtin_rm_usage[] =
 "git-rm [-f] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...";
 
+struct file_info {
+	const char *name;
+	int local_changes;
+	int staged_changes;
+};
+
 static struct {
 	int nr, alloc;
-	const char **name;
+	struct file_info * files;
 } list;
 
 static void add_list(const char *name)
 {
 	if (list.nr >= list.alloc) {
 		list.alloc = alloc_nr(list.alloc);
-		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
+		list.files = xrealloc(list.files, list.alloc * sizeof(const char *));
 	}
-	list.name[list.nr++] = name;
+	list.files[list.nr].name = name;
+	list.files[list.nr].local_changes  = 0;
+	list.files[list.nr].staged_changes = 0;
+	list.nr++;
 }
 
 static int remove_file(const char *name)
@@ -46,6 +55,26 @@ static int remove_file(const char *name)
 	return ret;
 }
 
+static int remove_file_maybe(const struct file_info fi, int quiet)
+{
+	const char *path = fi.name;
+	if (!fi.local_changes && !fi.staged_changes) {
+		/* The file matches either the index or the HEAD.
+		 * It's content exists somewhere else, it's safe to
+		 * delete it.
+		 */
+		return remove_file(path);
+	} else {
+		if (!quiet)
+			fprintf(stderr, 
+				"note: file '%s' not removed "
+				"(doesn't match %s).\n",
+				path,
+				fi.local_changes?"the index":"HEAD");
+		return 0;
+	}
+}
+
 static int check_local_mod(unsigned char *head)
 {
 	/* items in list are already sorted in the cache order,
@@ -62,7 +91,7 @@ static int check_local_mod(unsigned char *head)
 		struct stat st;
 		int pos;
 		struct cache_entry *ce;
-		const char *name = list.name[i];
+		const char *name = list.files[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
 
@@ -87,13 +116,17 @@ static int check_local_mod(unsigned char *head)
 			continue;
 		}
 		if (ce_match_stat(ce, &st, 0))
-			errs = error("'%s' has local modifications "
-				     "(hint: try -f)", ce->name);
+			list.files[i].local_changes = 1;
+
 		if (no_head
 		     || get_tree_entry(head, name, sha1, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || hashcmp(ce->sha1, sha1))
-			errs = error("'%s' has changes staged in the index "
+			list.files[i].staged_changes = 1;
+
+		if (list.files[i].local_changes && 
+		    list.files[i].staged_changes)
+			errs = error("'%s' doesn't match neither HEAD nor the index "
 				     "(hint: try -f)", name);
 	}
 	return errs;
@@ -201,7 +234,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
-		const char *path = list.name[i];
+		const char *path = list.files[i].name;
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
@@ -224,13 +257,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
-			const char *path = list.name[i];
-			if (!remove_file(path)) {
+			if (!remove_file_maybe(list.files[i], quiet)) {
 				removed = 1;
 				continue;
 			}
 			if (!removed)
-				die("git-rm: %s: %s", path, strerror(errno));
+				die("git-rm: %s: %s", 
+				    list.files[i].name, strerror(errno));
 		}
 	}
 
-- 
1.5.3.rc0.63.gc956-dirty



-- 
Matthieu
