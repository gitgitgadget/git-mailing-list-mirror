From: Thomas Rast <trast@student.ethz.ch>
Subject: [TopGit TOY PATCH] tg-graft: forge tip--base--<deps...> history for a subcommand
Date: Tue, 12 Aug 2008 23:10:16 +0200
Message-ID: <1218575416-16711-1-git-send-email-trast@student.ethz.ch>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 23:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT199-0005sK-Dd
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYHLVKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 17:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYHLVKN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:10:13 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:51517 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbYHLVKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 17:10:12 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 23:10:10 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 23:10:10 +0200
X-Mailer: git-send-email 1.6.0.rc2.53.gfa6b9
X-OriginalArrivalTime: 12 Aug 2008 21:10:10.0472 (UTC) FILETIME=[CDF9EA80:01C8FCBF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92140>

Adds a command 'tg graft <command>' that evaluates <command> with a
special GIT_GRAFT_FILE: the parent of each patch head is its patch
base, and the parents of the patch base are the dependencies of the
patch.

Try, for example, 'tg graft "gitk --all"'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Mainly sending this so someone can turn it into a useful feature, and
maybe build a few subcommands on top of it (that might call gitk or
'git log --graph', for example).

The one big issue with the resulting history is that the commit
messages at the tip aren't very interesting and may even be completely
irrelevant (for a base merge).  I don't see a good solution for that.

 Makefile    |    2 +-
 tg-graft.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100755 tg-graft.sh

diff --git a/Makefile b/Makefile
index 6eade1e..57745c0 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh tg-graft.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/tg-graft.sh b/tg-graft.sh
new file mode 100755
index 0000000..b6d0458
--- /dev/null
+++ b/tg-graft.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+if [ -z "$1" -o -n "$2" ]; then
+	echo "Usage: tg graft <command>" >&2
+	exit 1
+fi
+
+mkdir -p "$git_dir"/info
+
+grafts_file="$(mktemp)"
+
+if [ -f "$git_dir"/info/grafts ]; then
+	cp "$git_dir"/info/grafts "$grafts_file"
+fi
+
+mapdir="$(mktemp -d)"
+
+git for-each-ref refs/top-bases |
+	while read rev name ref; do
+		name="${ref#refs/top-bases/}"
+		tip=$(git rev-parse "$name")
+		base=$(git rev-parse "$ref")
+		if [ "$tip" != "$base" ]; then
+			echo $base >> "$mapdir"/$tip
+		fi
+		git cat-file blob "$name:.topdeps" |
+			while read dep; do
+				if git rev-parse --verify "$dep" >/dev/null 2>&1; then
+					rev=$(git rev-parse "$dep")
+					[ $rev != $base ] && echo $rev >> "$mapdir"/$base
+				fi
+			done
+	done
+
+for sha in $(cd "$mapdir" && ls); do
+	echo $sha $(cat "$mapdir"/$sha | sort -u) >> "$grafts_file"
+done
+
+rm -rf "$mapdir"
+
+export GIT_GRAFT_FILE="$grafts_file"
+eval "$1"
+
+rm "$grafts_file"
-- 
1.6.0.rc2.53.gfa6b9
