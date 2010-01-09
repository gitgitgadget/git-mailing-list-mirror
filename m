From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Sat, 9 Jan 2010 00:42:40 -0500
Message-ID: <20100109054240.GA13321@coredump.intra.peff.net>
References: <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
 <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 06:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTU6H-0005uC-MW
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 06:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab0AIFmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 00:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069Ab0AIFmw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 00:42:52 -0500
Received: from peff.net ([208.65.91.99]:40382 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab0AIFmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 00:42:52 -0500
Received: (qmail 27109 invoked by uid 107); 9 Jan 2010 05:47:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 09 Jan 2010 00:47:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jan 2010 00:42:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136516>

On Fri, Jan 08, 2010 at 05:07:46PM -0800, Linus Torvalds wrote:

> > But I am starting to wonder if we might be better off restructuring
> > read_directory_recursive().  Currently it assumes that the path it was
> > given _must_ be of interest (i.e. not ignored) and runs excluded() on
> > subdirectories it finds to make that same decision before recursing into
> > them or skipping them.  It might make more sense if it first checked if
> > the path given by the caller should be ignored and act accordingly.
> 
> Hmm. I can't make myself care one way or the other, I have to admit.  I 
> assume you mean basically taking the path and using the first component of 
> it _instead_ of doing a readdir() - and getting rid of the simplification 
> up front?
> 
> I agree that that should work. Would it be simpler and cleaner? Perhaps. 
> I'd have to see both patches to be able to tell. I do admit that while I 
> acked your patch, it sure ain't _pretty_ to do that special odd 
> "has_leading_ignored_dir()" thing.

It would look something like this:

diff --git a/dir.c b/dir.c
index 3a8d3e6..306d354 100644
--- a/dir.c
+++ b/dir.c
@@ -811,12 +811,19 @@ static void free_simplify(struct path_simplify *simplify)
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
+	int d_type = DT_DIR;
+	int exclude;
 
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
-	read_directory_recursive(dir, path, len, 0, simplify);
+	exclude = excluded(dir, path, &d_type);
+	if (exclude && (dir->flags & DIR_COLLECT_IGNORED) &&
+	    in_pathspec(path, len, simplify))
+		dir_add_ignored(dir, path, len);
+	if (!exclude || (dir->flags & DIR_SHOW_IGNORED))
+		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);

But unfortunately excluded() is not happy with the trailing slash on the
path given to read_directory, so we also need on top:

diff --git a/dir.c b/dir.c
index 306d354..6045a84 100644
--- a/dir.c
+++ b/dir.c
@@ -813,12 +813,17 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 	struct path_simplify *simplify;
 	int d_type = DT_DIR;
 	int exclude;
+	char *path_without_slash;
 
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
-	exclude = excluded(dir, path, &d_type);
+	path_without_slash = xstrdup(path);
+	if (path_without_slash[strlen(path_without_slash)-1] == '/')
+		path_without_slash[strlen(path_without_slash)-1] = '\0';
+	exclude = excluded(dir, path_without_slash, &d_type);
+	free(path_without_slash);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED) &&
 	    in_pathspec(path, len, simplify))
 		dir_add_ignored(dir, path, len);

And that does fix the case that triggered this whole discussion, but I
haven't tested thoroughly to make sure we are not adversely affecting
other cases.

-Peff
