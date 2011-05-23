From: Jeff King <peff@peff.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 19:49:34 -0400
Message-ID: <20110523234934.GC10488@sigill.intra.peff.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <BANLkTikAS63wZ=VP9s6LE44MBd5T1X3gMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 01:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOesY-0007Zp-Hr
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab1EWXti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:49:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757888Ab1EWXth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:49:37 -0400
Received: (qmail 25046 invoked by uid 107); 23 May 2011 23:51:41 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 19:51:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 19:49:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikAS63wZ=VP9s6LE44MBd5T1X3gMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174295>

On Mon, May 23, 2011 at 07:31:02PM -0400, Jay Soffian wrote:

> 1. The temporary path git generates loses the original file extension.
> At least in the case of Mac OS X, ibtool gets angry when the ".xib"
> isn' there. I worked around this with a wrapper, but maybe git could
> preserve the extension.

Hmm, I thought we did preserve the extension. I think it may actually be
related to me making a fake filespec and not passing the path in.

Does the (totally untested) patch below fix it for you?

> 2. It's not really clear to me when one should use textconv vs a
> custom diff driver. (Also, --no-textconv isn't documented...).

The motivation for textconv was originally a combination of "when you
are too lazy to write a full diff driver" and "when you like how git
formats the diff with pretty colors and word-diff". But now I think we
can add to that:

  1. When you want something fancy and git-ish like combined diff.

  2. When you want free caching to speed up repeated log viewing (try
     setting diff.*.cachetextconv to true).

Maybe it is worth adding an "advantages of textconv" section to
gitattributes(5) (the advantage of a full external diff command is that
it can be more flexible, or even graphical in nature).

Anyway, here's the patch.

---
diff --git a/combine-diff.c b/combine-diff.c
index fbed374..a4f2ff5 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -94,7 +94,8 @@ struct sline {
 };
 
 static char *grab_blob(const unsigned char *sha1, unsigned int mode,
-		       unsigned long *size, struct userdiff_driver *textconv)
+		       unsigned long *size, struct userdiff_driver *textconv,
+		       const char *path)
 {
 	char *blob;
 	enum object_type type;
@@ -110,7 +111,7 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 	} else if (textconv) {
 		/* yuck, the textconv code is linked heavily with
 		 * filespecs */
-		struct diff_filespec *df = alloc_filespec("");
+		struct diff_filespec *df = alloc_filespec(path);
 		fill_filespec(df, sha1, mode);
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
@@ -214,7 +215,8 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
-			 struct userdiff_driver *textconv)
+			 struct userdiff_driver *textconv,
+			 const char *path)
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask = (1UL << n);
@@ -227,7 +229,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	if (result_deleted)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, mode, &sz, textconv);
+	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
@@ -793,7 +795,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, elem->mode, &result_size,
-				   textconv);
+				   textconv, elem->path);
 	else {
 		/* Used by diff-tree to read from the working tree */
 		struct stat st;
@@ -817,10 +819,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
 				result = grab_blob(elem->sha1, elem->mode,
-						   &result_size, NULL);
+						   &result_size, NULL, NULL);
 			else
 				result = grab_blob(sha1, elem->mode,
-						   &result_size, NULL);
+						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
 			fill_filespec(df, null_sha1, st.st_mode);
@@ -893,7 +895,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			unsigned long size;
 			buf = grab_blob(elem->parent[i].sha1,
 					elem->parent[i].mode,
-					&size, NULL);
+					&size, NULL, NULL);
 			if (buffer_is_binary(buf, size))
 				is_binary = 1;
 			free(buf);
@@ -955,7 +957,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
-				     textconv);
+				     textconv, elem->path);
 	}
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
