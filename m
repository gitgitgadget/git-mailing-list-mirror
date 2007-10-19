From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 10:59:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191049400.26902@woody.linux-foundation.org>
References: <20071018203106.GA13518@fries.net>
 <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org>
 <20071019060624.GK14735@spearce.org> <200710190719.21660.todd@fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiw8U-0005h3-2I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765617AbXJSR7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765512AbXJSR7k
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:59:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44676 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754950AbXJSR7j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 13:59:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JHxPYn019048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 10:59:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JHxMwX012810;
	Fri, 19 Oct 2007 10:59:25 -0700
In-Reply-To: <200710190719.21660.todd@fries.net>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61738>



On Fri, 19 Oct 2007, Todd T. Fries wrote:
> 
> If DT_UNKNOWN exists, then we have to do a stat() of some form to
> find out the right type.
> 
> This is difficult to fix properly to avoid the extra stat() since
> inside the switch logic we do the recursion, but we might have
> avoided it earlier because of the exclusion.
> 
> I'll send a separate diff for an updated link() vs rename() diff.
> 
> I've attached an updated diff that should address concerns of everyone
> who gave me feedback on my dir.c changes.
> 
> Better?

Yes. I think this is ok, although I also did this alternate patch that is 
anal about not bothering to call "lstat()" if it can decide that the path 
is ignored even before that.

That happened in the case of a pathname that was ignored, and we did not 
ask for "dir->show_ignored". That test used to be *together* with the 
"DTYPE(de) != DT_DIR", but splitting the two tests up means that we can do 
that (common) test before we even bother to calculate the real dtype.

Of course, that optimization only matters for systems that don't have, or 
don't fill in DTYPE properly, but I get a bit anal about these kinds of 
optimizations.

I also clarified the real relationship between "exclude" and 
"dir->show_ignored". It used to do

	if (exclude != dir->show_ignored) {
		..

which wasn't exactly obvious, because it triggers for two different cases:

 - the path is marked excluded, but we are not interested in ignored 
   files: ignore it

 - the path is *not* excluded, but we *are* interested in ignored files: 
   ignore it unless it's a directory, in which case we might have ignored 
   files inside the directory and need to recurse into it).

so this splits them into those two cases, since the first case doesn't 
even care about the type.

I also made a the DT_UNKNOWN case a separate helper function, and added 
some commentary to the cases.

Does this patch work for you?

		Linus

---
 dir.c |   52 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index eb6c3ab..f843c4d 100644
--- a/dir.c
+++ b/dir.c
@@ -443,6 +443,24 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
+static int get_dtype(struct dirent *de, const char *path)
+{
+	int dtype = DTYPE(de);
+	struct stat st;
+
+	if (dtype != DT_UNKNOWN)
+		return dtype;
+	if (lstat(path, &st))
+		return dtype;
+	if (S_ISREG(st.st_mode))
+		return DT_REG;
+	if (S_ISDIR(st.st_mode))
+		return DT_DIR;
+	if (S_ISLNK(st.st_mode))
+		return DT_LNK;
+	return dtype;
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -466,7 +484,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 		exclude_stk = push_exclude_per_directory(dir, base, baselen);
 
 		while ((de = readdir(fdir)) != NULL) {
-			int len;
+			int len, dtype;
 			int exclude;
 
 			if ((de->d_name[0] == '.') &&
@@ -486,24 +504,30 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (exclude && dir->collect_ignored
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
-			if (exclude != dir->show_ignored) {
-				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
+
+			/*
+			 * Excluded? If we don't explicitly want to show
+			 * ignored files, ignore it
+			 */
+			if (exclude && !dir->show_ignored)
+				continue;
+
+			dtype = get_dtype(de, fullname);
+
+			/*
+			 * Do we want to see just the ignored files?
+			 * We still need to recurse into directories,
+			 * even if we don't ignore them, since the
+			 * directory may contain files that we do..
+			 */
+			if (!exclude && dir->show_ignored) {
+				if (dtype != DT_DIR)
 					continue;
-				}
 			}
 
-			switch (DTYPE(de)) {
-			struct stat st;
+			switch (dtype) {
 			default:
 				continue;
-			case DT_UNKNOWN:
-				if (lstat(fullname, &st))
-					continue;
-				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
-					break;
-				if (!S_ISDIR(st.st_mode))
-					continue;
-				/* fallthrough */
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
