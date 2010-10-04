From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 1/4] provide fan-in and -out traversal interface
Date: Tue,  5 Oct 2010 00:28:17 +0200
Message-ID: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tWO-0000QR-3W
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab0JDW22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:28:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0JDW21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:28:27 -0400
Received: by bwz11 with SMTP id 11so4091341bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0aRcAhtZTJnChvttC0BUQmeBkP+EAjU/n3UdSQ8IcLs=;
        b=BH1xw6NYKMSY9JFQPJDoepsZZLmVb7BMvQdUgc66BQd91QxWlxqkHJVHcOC7tsVpEa
         SqBimD7BZsaSY3Zpatbvc9KoTJG2Oew/YGTFC5Ax/LBX1ou9iWKdJC/MPvL0XkycLWjQ
         i5zEgtybT2y8ox45TkTmVs4KwgYd6qzmiTnEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CRF+Jadh1An7aRTA1SybvEQSybcwai4laXB5jwS+WyaIg6XPJISy4OQT8wnyx7OXAs
         iaFW2mUAs1VwpaCaTPY0cqDdbZq8TLTu5Idmn8YH2h0bE/NT2bPPLZleeUdCbArAtMt2
         dhpUX3ARltLNl0ykULiigGOAJAhEtxt5iULAA=
Received: by 10.204.69.74 with SMTP id y10mr82742bki.60.1286231304375;
        Mon, 04 Oct 2010 15:28:24 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id f10sm4256900bkl.5.2010.10.04.15.28.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158130>

This adds general functions to get the list of all offending branches for
a given one. Either which depends on the given branch (fan-in) or all
dependencies (fan-out).

Two simple users are provided which just lists the names or generates dot
input.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 170 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 3718702..926b31b 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -351,6 +351,176 @@ setup_pager()
 	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wait" EXIT
 }
 
+# traverse_fan_out(for_each_name, for_each_dep, name, head_deps)
+#
+# traverse the dependencies of @name in bfs order and call @for_each_name
+# on each dep (i.e. node) and @for_each_dep on all dependencies (i.e. edge)
+# with source and dest as arguments.
+#
+# @name' needs to be a TopGit controlled branch
+#
+# @head_deps specifies where to take the .topdeps from for the HEAD branch
+# empty - from the committed tree
+# '(i)' - from the index
+# '(w)' - from the working dir
+#
+traverse_fan_out()
+{
+	local for_each_name=$1
+	local for_each_dep=$2
+	local name=$3
+	local head_deps=$4 || :
+	local deps_src
+	local head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')" || :
+
+	branchq="$(mktemp -t tg-fan-out.XXXXXX)"
+	allbranches="$(mktemp -t -d tg-fan-out-all.XXXXXX)"
+	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
+
+	# fill queue with root name
+	echo "$name" > "$branchq"
+
+	while [ -s "$branchq" ]; do
+		# dequeue
+		{
+			read name
+			cat > "$branchq.headless"
+		} < "$branchq"
+		mv -f "$branchq.headless" "$branchq"
+
+		# eval name
+		eval "$for_each_name \"$name\""
+
+		# don't travers non-tgish branches
+		ref_exists "refs/top-bases/$name" ||
+			continue
+
+		deps_src=$name
+		# select .topdeps source for HEAD branch
+		[ "x$name" = "x$head" -a -n "$head_deps" ] &&
+			deps_src=$head_deps
+
+		old_IFS="$IFS"
+		IFS=""
+		cat_file "$deps_src:.topdeps" |
+		while read dep; do
+
+			# eval dep
+			eval "$for_each_dep \"$name\" \"$dep\""
+
+			[ -d "$allbranches/$dep" ] || {
+				mkdir -p "$allbranches/$dep"
+				echo "$dep" >> "$branchq"
+			}
+		done
+		IFS="$old_IFS"
+
+	done
+}
+
+_graph_dep_edge()
+{
+	printf "\t\"%s\" -> \"%s\";\n" "$1" "$2"
+}
+
+# prints the fan-out as a dot graph with edges
+graph_fan_out()
+{
+	printf "digraph G {\n"
+
+	traverse_fan_out : _graph_dep_edge "$1" $2
+
+	printf "}\n"
+}
+
+# prints the fan-out as name per line
+list_fan_out()
+{
+	traverse_fan_out echo : "$1" $2
+}
+
+# traverse_fan_in(for_each_name, for_each_dep, name, head_deps)
+#
+# traverse all branches which depends on @name in bfs order and call
+# @for_each_name on each (i.e. node) and @for_each_dep on all dependencies
+# (i.e. edge) with source and dest as arguments.
+#
+# @name' needs not to be a TopGit controlled branch
+#
+# @head_deps specifies where to take the .topdeps from for the HEAD branch
+# empty - from the committed tree
+# '(i)' - from the index
+# '(w)' - from the working dir
+#
+traverse_fan_in()
+{
+	local for_each_name=$1
+	local for_each_dep=$2
+	local name=$3
+	local head_deps=$4 || :
+	local deps_src
+	local head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')" || :
+
+	branchq="$(mktemp -t tg-fan-in.XXXXXX)"
+	allbranches="$(mktemp -t -d tg-fan-in-all.XXXXXX)"
+	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
+
+	echo "$name" > "$branchq"
+
+	while [ -s "$branchq" ]; do
+		# dequeue
+		{
+			read name
+			cat > "$branchq.headless"
+		} < "$branchq"
+		mv -f "$branchq.headless" "$branchq"
+
+		[ ! -d "$allbranches/$name" ] ||
+			continue;
+		mkdir -p "$allbranches/$name"
+
+		# eval branch
+		eval "$for_each_name \"$name\""
+
+		old_IFS="$IFS"
+		IFS=""
+		git for-each-ref --format='%(refname)' refs/top-bases |
+			while read ref; do
+				parent="${ref#refs/top-bases/}"
+
+				deps_src=$parent
+				# select branch/index/worktree for HEAD branch
+				[ "x$parent" = "x$head" -a -n "$head_deps" ] &&
+					deps_src=$head_deps
+				cat_file "$deps_src:.topdeps" | fgrep -qx "$name" ||
+					continue
+
+				# eval dep
+				eval "$for_each_dep \"$parent\" \"$name\""
+
+				echo "$parent" >> "$branchq"
+			done
+		IFS="$old_IFS"
+
+	done
+}
+
+# prints the fan-in as a dot graph with edges
+graph_fan_in()
+{
+	printf "digraph G {\n"
+
+	traverse_fan_in : _graph_dep_edge "$1" $2
+
+	printf "}\n"
+}
+
+# prints the fan-in as name per line
+list_fan_in()
+{
+	traverse_fan_in echo : "$1" $2
+}
+
 ## Startup
 
 [ -d "@cmddir@" ] ||
-- 
tg: (ff59ac7..) bw/fan-in-out (depends on: master)
