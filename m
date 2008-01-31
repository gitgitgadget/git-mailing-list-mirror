From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match
	directory "foo"
Date: Thu, 31 Jan 2008 04:41:25 -0500
Message-ID: <20080131094124.GA25546@coredump.intra.peff.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com> <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org> <47A06EF9.60704@users.sourceforge.net> <7vprvjgi9v.fsf@gitster.siamese.dyndns.org> <47A1733E.9040103@users.sourceforge.net> <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org> <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Piatyszek <ediap@users.sourceforge.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:42:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVvl-00055B-B3
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbYAaJl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbYAaJl3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:41:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4549 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbYAaJl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:41:28 -0500
Received: (qmail 27948 invoked by uid 111); 31 Jan 2008 09:41:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 04:41:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 04:41:25 -0500
Content-Disposition: inline
In-Reply-To: <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72115>

On Thu, Jan 31, 2008 at 01:17:48AM -0800, Junio C Hamano wrote:

> A downside is that the recursive directory walk may need to run
> lstat(2) more often on systems whose "struct dirent" do not give
> the type of the entry; earlier it did not have to do so for an
> excluded path, but we now need to figure out if a path is a
> directory before deciding to exclude it.  This is especially bad

You can at least lazily do the stat so that only users of foo/ need to
pay the penalty. Something like this (completely untested):

diff --git a/dir.c b/dir.c
index a4f8c25..9487908 100644
--- a/dir.c
+++ b/dir.c
@@ -17,6 +17,7 @@ struct path_simplify {
 static int read_directory_recursive(struct dir_struct *dir,
 	const char *path, const char *base, int baselen,
 	int check_only, const struct path_simplify *simplify);
+static int get_dtype(struct dirent *de, const char *path, int try_stat);
 
 int common_prefix(const char **pathspec)
 {
@@ -288,9 +289,12 @@ static int excluded_1(const char *pathname,
 			const char *exclude = x->pattern;
 			int to_exclude = x->to_exclude;
 
-			if ((x->flags & EXC_FLAG_MUSTBEDIR) &&
-			    (dtype != DT_DIR))
-				continue;
+			if (x->flags & EXC_FLAG_MUSTBEDIR) {
+				if (dtype == DT_UNKNOWN)
+					dtype = get_dtype(NULL, pathname, 1);
+				if (dtype != DT_DIR)
+					continue;
+			}
 
 			if (x->flags & EXC_FLAG_NODIR) {
 				/* match basename */
@@ -527,13 +531,15 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
-static int get_dtype(struct dirent *de, const char *path)
+static int get_dtype(struct dirent *de, const char *path, int try_stat)
 {
-	int dtype = DTYPE(de);
+	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
+	if (!try_stat)
+		return DT_UNKNOWN;
 	if (lstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
@@ -581,7 +587,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			if (simplify_away(fullname, baselen + len, simplify))
 				continue;
 
-			dtype = get_dtype(de, fullname);
+			dtype = get_dtype(de, fullname, 0);
 			exclude = excluded(dir, fullname, dtype);
 			if (exclude && dir->collect_ignored
 			    && in_pathspec(fullname, baselen + len, simplify))
