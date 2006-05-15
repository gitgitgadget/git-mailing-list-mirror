From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] commit: allow --pretty= args to be abbreviated
Date: Sun, 14 May 2006 17:34:05 -0700
Message-ID: <20060515003405.GA5533@localdomain>
References: <11476199622462-git-send-email-normalperson@yhbt.net> <1147619963765-git-send-email-normalperson@yhbt.net> <7vwtcoyxs2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 02:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfR2M-00078w-Os
	for gcvg-git@gmane.org; Mon, 15 May 2006 02:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWEOAeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWEOAeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 20:34:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55199 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750969AbWEOAeI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 20:34:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E653C7DC005;
	Sun, 14 May 2006 17:34:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 17:34:05 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtcoyxs2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19999>

Unlike the original one, this one only does prefix matches, so
you can't do --pretty=er anymore :)

This one really works with and without the gitopt changes.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >  commit.c |   42 +++++++++++++++++++++++++++++-------------
> >  1 files changed, 29 insertions(+), 13 deletions(-)
> 
> This is applicable without the gitopt changes, but I have a
> feeling that when we think about abbreviations the users would
> expect the leading substring abbreviation, not strstr().
> 
> While "git log --pretty=lle" or "git log --pretty=or" might be
> unambiguous, I think that is trying to be too cute and
> confusing, especially if somebody picks up that habit by
> watching others type such a cute abbreviations.
> 
> That comment probably incidentally applies to your bigger
> patches.

Ok.  The current gitopt patch only uses leading substring abbreviations
by default.  GIT_ABBREV_HARDER needs to be set if you want all the
crazyness :)

 commit.c |   50 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 14 deletions(-)

d4473559924b1a5ba655cd5d5b18d39f53e25184
diff --git a/commit.c b/commit.c
index 2717dd8..2753677 100644
--- a/commit.c
+++ b/commit.c
@@ -22,23 +22,45 @@ struct sort_node
 
 const char *commit_type = "commit";
 
+struct cmt_fmt_map {
+	const char *n;
+	enum cmit_fmt v;
+} cmt_fmts[] = {
+	{ "raw",	CMIT_FMT_RAW },
+	{ "medium",	CMIT_FMT_MEDIUM },
+	{ "short",	CMIT_FMT_SHORT },
+	{ "full",	CMIT_FMT_FULL },
+	{ "fuller",	CMIT_FMT_FULLER },
+	{ "oneline",	CMIT_FMT_ONELINE },
+};
+
 enum cmit_fmt get_commit_format(const char *arg)
 {
-	if (!*arg)
+	int i, found;
+	size_t len;
+
+	if (!arg || !*arg)
 		return CMIT_FMT_DEFAULT;
-	if (!strcmp(arg, "=raw"))
-		return CMIT_FMT_RAW;
-	if (!strcmp(arg, "=medium"))
-		return CMIT_FMT_MEDIUM;
-	if (!strcmp(arg, "=short"))
-		return CMIT_FMT_SHORT;
-	if (!strcmp(arg, "=full"))
-		return CMIT_FMT_FULL;
-	if (!strcmp(arg, "=fuller"))
-		return CMIT_FMT_FULLER;
-	if (!strcmp(arg, "=oneline"))
-		return CMIT_FMT_ONELINE;
-	die("invalid --pretty format");
+	if (*arg == '=')
+		arg++;
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+		if (!strcmp(arg, cmt_fmts[i].n))
+			return cmt_fmts[i].v;
+	}
+
+	/* look for abbreviations */
+	len = strlen(arg);
+	found = -1;
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+		if (!strncmp(cmt_fmts[i].n, arg, len)) {
+			if (found >= 0)
+				die("invalid --pretty format: %s", arg);
+			found = i;
+		}
+	}
+	if (found >= 0)
+		return cmt_fmts[found].v;
+	die("invalid --pretty format: %s", arg);
 }
 
 static struct commit *check_commit(struct object *obj,
-- 
1.3.2.g58c0
