From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 15:56:38 -0500
Message-ID: <20160208205637.GA13732@sigill.intra.peff.net>
References: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
 <20160208150709.GA13664@sigill.intra.peff.net>
 <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
 <20160208195230.GA30693@sigill.intra.peff.net>
 <20160208202043.GA6002@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:56:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsrV-0003Ci-S6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbcBHU4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 15:56:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:39461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755218AbcBHU4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 15:56:40 -0500
Received: (qmail 20802 invoked by uid 102); 8 Feb 2016 20:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 15:56:40 -0500
Received: (qmail 9194 invoked by uid 107); 8 Feb 2016 20:56:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 15:56:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 15:56:38 -0500
Content-Disposition: inline
In-Reply-To: <20160208202043.GA6002@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285805>

On Mon, Feb 08, 2016 at 03:20:43PM -0500, Jeff King wrote:

> On Mon, Feb 08, 2016 at 02:52:30PM -0500, Jeff King wrote:
> 
> > Here is my patch again, with that part removed, and the tests fixed up.
> > Though on reflection, I do think it would be better if we could simply
> > expand the wildcard globs to say "does this match anything in the file
> > system". That makes a nice, simple rule that follows the spirit of the
> > original. I'm not sure if it would be easy to apply magic like ":(top)"
> > there, but even if we don't, we're not worse off than we are today
> > (where that requires "--" unless it happens to have a wildcard, as
> > above).
> 
> So here is a hacky attempt at that. It uses glob(), which is not quite
> right for the reasons below, though I suspect works OK in practice.
> 
> I think doing it correctly would require actually calling our
> read_directory() function. That feels kind of heavy-weight for this
> case, but I guess in theory the pathspec limits it (and it's not like
> glob() does not have to walk the filesystem, too). So maybe it's not so
> bad.

And here that is. It does end up traversing quite a bit for something as
simple as "*.foo", because that doesn't let fill_directory() limit us at
all.

But having looked at this, I can't help but wonder if the rule should
not be "does the file exist" in the first place, but "is the file in the
index". This dwimmery is about commands like "log" that are reading
existing commits. I cannot think of a case where we would want to
include something that exists in the filesystem but not in the index.

---
diff --git a/setup.c b/setup.c
index 2c4b22c..1a40516 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "pathspec.h"
 #include "string-list.h"
 
 static int inside_git_dir = -1;
@@ -130,6 +131,33 @@ int path_inside_repo(const char *prefix, const char *path)
 	return 0;
 }
 
+/*
+ * Return true if a file exists that matches the pattern
+ * glob.
+ */
+static int pathspec_exists(const char *one_pathspec)
+{
+	struct dir_struct dir;
+	const char *pathspec_v[] = { one_pathspec, NULL };
+	struct pathspec pathspec;
+	int ret = 0;
+	int i;
+
+	memset(&dir, 0, sizeof(dir));
+	parse_pathspec(&pathspec, 0, 0, "", pathspec_v);
+
+	fill_directory(&dir, &pathspec);
+	for (i = 0; i < dir.nr; i++) {
+		if (dir_path_match(dir.entries[i], &pathspec, 0, NULL)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	free(dir.entries);
+	return ret;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
@@ -139,12 +167,14 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (!no_wildcard(arg))
-		return 1;
-	else if (prefix)
+	} else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
 	else
 		name = arg;
+
+	if (!no_wildcard(arg))
+		return pathspec_exists(name);
+
 	if (!lstat(name, &st))
 		return 1; /* file exists */
 	if (errno == ENOENT || errno == ENOTDIR)
