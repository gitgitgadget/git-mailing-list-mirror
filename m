From: Greg Price <price@ksplice.com>
Subject: [PATCH 1/4] pretty: Add %D for script-friendly decoration
Date: Tue, 22 Dec 2009 17:22:18 -0500
Message-ID: <20091222222217.GV30538@dr-wily.mit.edu>
References: <20091222222032.GU30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 23:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NND7d-0003OC-EG
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 23:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbZLVWWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbZLVWWW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 17:22:22 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:41859 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173AbZLVWWV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 17:22:21 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBMMLiIG007223;
	Tue, 22 Dec 2009 17:21:44 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBMMMU3B028734;
	Tue, 22 Dec 2009 17:22:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091222222032.GU30538@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135602>

When in a script or porcelain one wants to identify what refs point to
which commits in a series, the functionality of 'git log --decorate'
is extremely useful.  This is available with the %d format code in a
form optimized for humans, but for scripts a more raw format is better.
Make such a format available through a new format code %D.

Signed-off-by: Greg Price <price@ksplice.com>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 53a9168..b6b840e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -119,6 +119,7 @@ The placeholders are:
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
+- '%D': full ref names, like the --decorate=full option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
diff --git a/pretty.c b/pretty.c
index 8f5bd1a..18ce2ff 100644
--- a/pretty.c
+++ b/pretty.c
@@ -582,21 +582,35 @@ static void parse_commit_message(struct format_commit_context *c)
 	c->commit_message_parsed = 1;
 }
 
-static void format_decoration(struct strbuf *sb, const struct commit *commit)
+
+static void format_decoration(struct strbuf *sb, const struct commit *commit,
+			      int decoration_style, const char *affixes[3])
 {
 	struct name_decoration *d;
-	const char *prefix = " (";
+	const char *affix = affixes[0];
 
-	load_ref_decorations(DECORATE_SHORT_REFS);
+	load_ref_decorations(decoration_style);
 	d = lookup_decoration(&name_decoration, &commit->object);
 	while (d) {
-		strbuf_addstr(sb, prefix);
-		prefix = ", ";
+		strbuf_addstr(sb, affix);
+		affix = affixes[1];
 		strbuf_addstr(sb, d->name);
 		d = d->next;
 	}
-	if (prefix[0] == ',')
-		strbuf_addch(sb, ')');
+	if (affix == affixes[1])
+		strbuf_addstr(sb, affixes[2]);
+}
+
+static void format_decoration_short(struct strbuf *sb, const struct commit *commit)
+{
+	const char *affixes[3] = {" (", ", ", ")"};
+	format_decoration(sb, commit, DECORATE_SHORT_REFS, affixes);
+}
+
+static void format_decoration_full(struct strbuf *sb, const struct commit *commit)
+{
+	const char *affixes[3] = {"", " ", ""};
+	format_decoration(sb, commit, DECORATE_FULL_REFS, affixes);
 }
 
 static void strbuf_wrap(struct strbuf *sb, size_t pos,
@@ -756,7 +770,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		                 : '>');
 		return 1;
 	case 'd':
-		format_decoration(sb, commit);
+		format_decoration_short(sb, commit);
+		return 1;
+	case 'D':
+		format_decoration_full(sb, commit);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
-- 
1.6.6.rc1.9.g2ad41.dirty
