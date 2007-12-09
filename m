From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sun, 09 Dec 2007 12:26:22 -0800
Message-ID: <7vtzmrobrl.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
	<7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712082346310.5349@iabervon.org>
	<7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
	<20071209162632.a16bfd6e.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sun Dec 09 21:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1SkS-0004Md-EA
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 21:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXLIU1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbXLIU1O
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 15:27:14 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:43855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXLIU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 15:27:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BC05BE6;
	Sun,  9 Dec 2007 15:27:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F27EF5B5A;
	Sun,  9 Dec 2007 15:26:28 -0500 (EST)
In-Reply-To: <20071209162632.a16bfd6e.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Sun, 9 Dec 2007 16:26:32 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67659>

Sergey Vlasov <vsu@altlinux.ru> writes:

> This still does not match the behavior of the old shell implementation
> completely - because $pat was not quoted, shell pattern characters in
> $pat worked, and things like "git ls-remote . 'refs/heads/something--*'"
> were possible (and used in some of my scripts), so a full fnmatch()
> call is still needed.

Sigh...

-- >8 --
Subject: [PATCH] Re-fix ls-remote

An earlier attempt in 2ea7fe0 (ls-remote: resurrect pattern limit support) forgot
that the user string can also be a glob.  This should finally fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-ls-remote.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index e5d670a..c2caeea 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -7,30 +7,22 @@ static const char ls_remote_usage[] =
 "git-ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
 
 /*
- * pattern is a list of tail-part of accepted refnames.  Is there one
- * among them that is a suffix of the path?  Directory boundary must
- * be honored when checking this match.  IOW, patterns "master" and
- * "sa/master" both match path "refs/hold/sa/master".  On the other
- * hand, path "refs/hold/foosa/master" is matched by "master" but not
- * by "sa/master".
+ * Is there one among the list of patterns that match the tail part
+ * of the path?
  */
-
 static int tail_match(const char **pattern, const char *path)
 {
-	int pathlen;
 	const char *p;
+	char pathbuf[PATH_MAX];
 
-	if (!*pattern)
+	if (!pattern)
 		return 1; /* no restriction */
 
-	for (pathlen = strlen(path); (p = *pattern); pattern++) {
-		int pfxlen = pathlen - strlen(p);
-		if (pfxlen < 0)
-			continue; /* pattern is longer, will never match */
-		if (strcmp(path + pfxlen, p))
-			continue; /* no tail match */
-		if (!pfxlen || path[pfxlen - 1] == '/')
-			return 1; /* fully match at directory boundary */
+	if (snprintf(pathbuf, sizeof(pathbuf), "/%s", path) > sizeof(pathbuf))
+		return error("insanely long ref %.*s...", 20, path);
+	while ((p = *(pattern++)) != NULL) {
+		if (!fnmatch(p, pathbuf, 0))
+			return 1;
 	}
 	return 0;
 }
@@ -77,12 +69,23 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			usage(ls_remote_usage);
 		}
 		dest = arg;
+		i++;
 		break;
 	}
 
 	if (!dest)
 		usage(ls_remote_usage);
-	pattern = argv + i + 1;
+
+	if (argv[i]) {
+		int j;
+		pattern = xcalloc(sizeof(const char *), argc - i + 1);
+		for (j = i; j < argc; j++) {
+			int len = strlen(argv[j]);
+			char *p = xmalloc(len + 3);
+			sprintf(p, "*/%s", argv[j]);
+			pattern[j - i] = p;
+		}
+	}
 	remote = nongit ? NULL : remote_get(dest);
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
-- 
1.5.3.7-1142-gbb4e
