From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Introduce light weight commit annotations
Date: Sat, 9 Jun 2007 18:55:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5Ck-00014F-U1
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 19:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913AbXFIR6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbXFIR6Y
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 13:58:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:52200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000AbXFIR6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 13:58:23 -0400
Received: (qmail invoked by alias); 09 Jun 2007 17:58:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 09 Jun 2007 19:58:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p4CxxAJFp1LGXo/Ldhc2+tDjPfhuZjzDfBA/+ph
	jO7bR948WDu1pT
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49588>


With the provided script, edit-commit-annotations, you can add
after-the-fact annotations to commits, which will be shown by
the log if the config variable core.showannotations is set.

The annotations are tracked in a new ref, refs/annotations/commits,
in the same fan-out style as .git/objects/??/*, only that they only
exist in the object database now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have the hunch that this will be relatively fast and scalable,
	since the tree objects are sorted by name (the name being the
	object name of the to-be-annotated commit).

	I'm on the run for 15 hours now, but please feel free to discuss
	and / or trash it while I'm away.

 cache.h                       |    1 +
 commit.c                      |   48 ++++++++++++++++++++++++++++++++++++++++-
 config.c                      |    5 ++++
 environment.c                 |    1 +
 git-edit-commit-annotation.sh |   46 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 1 deletions(-)
 create mode 100755 git-edit-commit-annotation.sh

diff --git a/cache.h b/cache.h
index bc6b8e8..4166888 100644
--- a/cache.h
+++ b/cache.h
@@ -288,6 +288,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int show_commit_annotations;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/commit.c b/commit.c
index 4ca4d44..409ebc8 100644
--- a/commit.c
+++ b/commit.c
@@ -911,6 +911,48 @@ static long format_commit_message(const struct commit *commit,
 	return strlen(buf);
 }
 
+static unsigned long show_annotations(const struct commit *commit,
+		char *buf, unsigned long space)
+{
+	char name[80];
+	const char *hex = sha1_to_hex(commit->object.sha1);
+	unsigned char sha1[20];
+	char *msg;
+	unsigned long offset = 0, msgoffset = 0, msglen;
+	enum object_type type;
+
+	snprintf(name, sizeof(name),
+			"refs/annotations/commits:%.*s/%.*s",
+			2, hex, 38, hex + 2);
+	if (get_sha1(name, sha1))
+		return 0;
+
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen)
+		return 0;
+	/* we will end the annotation by a newline anyway. */
+	if (msg[msglen - 1] == '\n')
+		msglen--;
+
+	offset += snprintf(buf + offset, space - offset - 1,
+			"\nAnnotation:\n");
+
+	for (msgoffset = 0; msgoffset < msglen;) {
+		int linelen = get_one_line(msg + msgoffset, msglen);
+
+		offset += snprintf(buf + offset, space - offset - 1,
+			"    %.*s", linelen, msg + msgoffset);
+
+		if (offset + 1 >= space)
+			break;
+
+		msgoffset += linelen;
+	}
+	buf[offset++] = '\n';
+	free(msg);
+
+	return offset;
+}
+
 unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const struct commit *commit,
 				  unsigned long len,
@@ -1098,8 +1140,12 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	 */
 	if (fmt == CMIT_FMT_EMAIL && !body)
 		buf[offset++] = '\n';
-	buf[offset] = '\0';
 
+	if (fmt != CMIT_FMT_ONELINE && show_commit_annotations)
+		offset += show_annotations(commit,
+				buf + offset, space - offset);
+
+	buf[offset] = '\0';
 	free(reencoded);
 	return offset;
 }
diff --git a/config.c b/config.c
index 58d3ed5..34db9b2 100644
--- a/config.c
+++ b/config.c
@@ -356,6 +356,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.showannotaions")) {
+		show_commit_annotations = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 8b9b89d..c649f19 100644
--- a/environment.c
+++ b/environment.c
@@ -32,6 +32,7 @@ size_t delta_base_cache_limit = 16 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+int show_commit_annotations;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
diff --git a/git-edit-commit-annotation.sh b/git-edit-commit-annotation.sh
new file mode 100755
index 0000000..2abcd34
--- /dev/null
+++ b/git-edit-commit-annotation.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+USAGE="[commit-name]"
+. git-sh-setup
+
+test -n "$2" && usage
+COMMIT=$(git rev-parse --verify --default HEAD "$@")
+NAME=$(echo $COMMIT | sed "s/^../&\//")
+
+MESSAGE="$GIT_DIR"/COMMIT_ANNOTATION.$$
+git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
+
+GIT_INDEX_FILE="$MESSAGE".idx
+export GIT_INDEX_FILE
+
+TIPNAME=refs/annotations/commits
+OLDTIP=$(git show-ref $TIPNAME | cut -f 1 -d ' ')
+if [ -z "$OLDTIP" ]; then
+	OLDTIP=0000000000000000000000000000000000000000
+else
+	PARENT="-p $OLDTIP"
+	git read-tree $TIPNAME || die "Could not read index"
+	git cat-file blob :$NAME >> "$MESSAGE" 2> /dev/null
+fi
+
+${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+
+grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
+mv "$MESSAGE".processed "$MESSAGE"
+if [ -z "$(cat "$MESSAGE")" ]; then
+	case $OLDTIP in 0000000000000000000000000000000000000000)
+		echo "Will not initialise with empty tree"
+		exit 1
+	esac
+	git update-index --force-remove $NAME ||
+		die "Could not update index"
+else
+	BLOB=$(git hash-object -w "$MESSAGE") ||
+		die "Could not write into object database"
+	git update-index --add --cacheinfo 0644 $BLOB $NAME ||
+		die "Could not write index"
+fi
+
+TREE=$(git write-tree) || die "Could not write tree"
+NEWTIP=$(date | git commit-tree $TREE $PARENT) || die "Could not annotate"
+git update-ref $TIPNAME $NEWTIP $OLDTIP
-- 
1.5.2.1.2713.gbb6a-dirty
