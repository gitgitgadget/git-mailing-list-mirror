From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC][PATCH] Re: git-rm isn't the inverse action of git-add
Date: Sun, 08 Jul 2007 22:34:06 +0200
Message-ID: <vpq1wfi8wjl.fsf@bauges.imag.fr>
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
	<vpqd4z7q820.fsf@bauges.imag.fr> <vpqfy3yajbj.fsf_-_@bauges.imag.fr>
	<Pine.LNX.4.64.0707081855300.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7dT5-0001wF-7o
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbXGHUes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbXGHUes
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:34:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:40844 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339AbXGHUer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 16:34:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l68KY6Et025539
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2007 22:34:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I7dSI-0003fX-IU; Sun, 08 Jul 2007 22:34:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I7dSI-0005Xs-F4; Sun, 08 Jul 2007 22:34:06 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,  Jan Hudec <bulb@ucw.cz>, Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>
In-Reply-To: <Pine.LNX.4.64.0707081855300.4248@racer.site> (Johannes Schindelin's message of "Sun\, 8 Jul 2007 19\:10\:59 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 08 Jul 2007 22:34:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51915>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This patch proposes a saner behavior. When there are no difference at 
>> all between file, index and HEAD, the file is removed both from the 
>> index and the tree, as before.
>> 
>> Otherwise, if the index matches either the file on disk or the HEAD, the 
>> file is removed from the index, but the file is kept on disk, it may 
>> contain important data.
>
> However, if some of the files are of the first kind, and some are of the 
> second kind, you happily apply with mixed strategies.  IMO that is wrong.

I'm not sure whether this is really wrong. The things git should
really care about are the index and the repository itself, and the
proposed behavior is consistant regarding that (either remove all
files from the index, or remove none).

I'm not opposed to your proposal, but I'd like to have other
opinion(s) on that before changing the code.

>>  static struct {
>>  	int nr, alloc;
>> -	const char **name;
>> +	struct file_info * files;
>>  } list;
>>  
>>  static void add_list(const char *name)
>>  {
>>  	if (list.nr >= list.alloc) {
>>  		list.alloc = alloc_nr(list.alloc);
>> -		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
>> +		list.files = xrealloc(list.files, list.alloc * sizeof(const char *));
>
> This is wrong, too.  Yes, it works.  But it really should be 
> "sizeof(struct file_info *)".  Remember, code is also documentation.

You don't need to argue, that was a typo. My code is definitely wrong,
but you're wrong too ;-). That's actually sizeof(struct file_info).

>> +		if (!quiet)
>> +			fprintf(stderr, 
>> +				"note: file '%s' not removed "
>> +				"(doesn't match %s).\n",
>> +				path,
>> +				fi.local_changes?"the index":"HEAD");
>> +		return 0;
>> +	}
>> +}
>
> I suspect that this case does never fail. 0 means success for 
> remove_file().  Not good.  You should at least have a way to ensure that 
> it removed the files from the working tree from a script.  Otherwise there 
> is not much point in returning a value to begin with.

I've changed it to have exit_status = 1 if git-rm aborted before
starting, and 2 if git-rm skiped some file removals (and of course, 0
if everything is done as expected).

>> @@ -224,13 +257,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>  	if (!index_only) {
>>  		int removed = 0;
>>  		for (i = 0; i < list.nr; i++) {
>> -			const char *path = list.name[i];
>> -			if (!remove_file(path)) {
>> +			if (!remove_file_maybe(list.files[i], quiet)) {
>>  				removed = 1;
>>  				continue;
>>  			}
>>  			if (!removed)
>> -				die("git-rm: %s: %s", path, strerror(errno));
>> +				die("git-rm: %s: %s", 
>> +				    list.files[i].name, strerror(errno));
>>  		}
>>  	}
>
> Style: the old code set and used "path" for readability.  You should do 
> the same (with "file", probably).

Done.

> Additionally, since this changes semantics, you better provide test cases 
> to show what is expected to work, and _ensure_ that it actually works.

Sure. I forgot to mention it in my message, but I wanted to have
feedback before getting into the testsuite stuff.

I'm posting the updated patch for info, but it should anyway not be
merged until

* We agree on the behavior when different files have different kinds
  of changes

* I add a testcase.



>From f39ae646049b95b055e34da378ea470ef3f3caef Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sun, 8 Jul 2007 19:27:44 +0200
Subject: [PATCH] Change the behavior of git-rm to let it obey in more circumstances without -f.

In the previous behavior of git-rm, git refused to do anything in case of
a difference between the file on disk, the index, and the HEAD. As a
result, the -f flag is forced even for simple senarios like:

$ git add foo
$ git rm -f [--cached] foo

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

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-rm.txt |    9 +++--
 builtin-rm.c             |   71 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 16 deletions(-)

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
index 4a0bd93..08af5de 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -12,20 +12,30 @@
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
+	struct file_info *files;
 } list;
 
 static void add_list(const char *name)
 {
 	if (list.nr >= list.alloc) {
 		list.alloc = alloc_nr(list.alloc);
-		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
+		list.files = xrealloc(list.files, list.alloc * sizeof(struct file_info));
 	}
-	list.name[list.nr++] = name;
+	list.files[list.nr].name = name;
+	list.files[list.nr].local_changes  = 0;
+	list.files[list.nr].staged_changes = 0;
+	list.nr++;
 }
 
+/* Returns -1 on error, zero on success */
 static int remove_file(const char *name)
 {
 	int ret;
@@ -46,6 +56,30 @@ static int remove_file(const char *name)
 	return ret;
 }
 
+/* Returns 0 if the file was actually deleted, -1 if the file removal
+   was a failure, and 1 if remove_file wasn't actually called */
+static int remove_file_maybe(const struct file_info fi, int quiet)
+{
+	const char *path = fi.name;
+	if (!fi.local_changes && !fi.staged_changes)
+		/* The file matches either the index or the HEAD.
+		 * It's content exists somewhere else, it's safe to
+		 * delete it.
+		 */
+		return remove_file(path);
+	else {
+		if (!quiet)
+			fprintf(stderr, 
+				"note: file '%s' not removed "
+				"(%s).\n",
+				path,
+				fi.local_changes ? 
+				"the index doesn't match HEAD" :
+				"the file doesn't match the index");
+		return 1;
+	}
+}
+
 static int check_local_mod(unsigned char *head)
 {
 	/* items in list are already sorted in the cache order,
@@ -62,7 +96,7 @@ static int check_local_mod(unsigned char *head)
 		struct stat st;
 		int pos;
 		struct cache_entry *ce;
-		const char *name = list.name[i];
+		const char *name = list.files[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
 
@@ -87,13 +121,17 @@ static int check_local_mod(unsigned char *head)
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
@@ -108,6 +146,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	int ignore_unmatch = 0;
 	const char **pathspec;
 	char *seen;
+	int exit_status = 0;
 
 	git_config(git_default_config);
 
@@ -201,7 +240,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
-		const char *path = list.name[i];
+		const char *path = list.files[i].name;
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
@@ -224,13 +263,21 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
-			const char *path = list.name[i];
-			if (!remove_file(path)) {
+			struct file_info file = list.files[i];
+			int status = remove_file_maybe(file, quiet);
+			if (status == 0) {
 				removed = 1;
 				continue;
+			} else if (status == 1) {
+				/* Let the user know from a script
+				 * that a file was not deleted on disk
+				 */
+				exit_status = 2;
+				continue;
 			}
 			if (!removed)
-				die("git-rm: %s: %s", path, strerror(errno));
+				die("git-rm: %s: %s", 
+				    file.name, strerror(errno));
 		}
 	}
 
@@ -240,5 +287,5 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			die("Unable to write new index file");
 	}
 
-	return 0;
+	return exit_status;
 }
-- 
1.5.3.rc0.64.gf4f4a-dirty



-- 
Matthieu
