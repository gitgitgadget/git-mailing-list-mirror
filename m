From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v2] provide fan-in and -out traversal interface
Date: Tue,  5 Oct 2010 21:31:02 +0200
Message-ID: <1286307062-30325-1-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTi=wZUc0GnB8p0=3Hkd1xPsvqqdEMHn80GKsHUj6@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	pasky@suse.cz, Per Cederqvist <ceder@lysator.liu.se>,
	martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3DEL-0003zq-Ce
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab0JETbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:31:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58587 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab0JETbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:31:07 -0400
Received: by bwz11 with SMTP id 11so4811414bwz.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=xz3UXXb7Hz0ywojH6xpE5rk0rsLnfetEgW0f4sE7N38=;
        b=LwjdPMfCBovTZjzygzi8JJBV0TL3Ruf7lIa6II3Ew6/FyAUtlOgHx4S3xA33Mm+HAM
         DB4QzZO/SnUdyE6sznUqvaGdVhue40LJNtq2RCoHF9sR0JsZAZSpuuiHOnmjjwqGTv6I
         OJjU5DnO8Nd20qkiQCZRFwEFlD2Mmp/+9kqXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rvwlp01rYbKFe7zvhOqJpEJwzF4vfsoeCGMYHIA07kZA/9surW6tvA5nU2P/qYjhUB
         VOq/1M+VDKPZ/9qcsy6xpX56V/b1kY5HNYA3uKKlviSZpgcAL10oqy/5dvwTWkHCwZve
         R7uimS9ldnzBjhtalwe5OGJFSsJRiMQhtLX3U=
Received: by 10.204.123.136 with SMTP id p8mr8723655bkr.148.1286307065632;
        Tue, 05 Oct 2010 12:31:05 -0700 (PDT)
Received: from localhost (p5B0F75F8.dip.t-dialin.net [91.15.117.248])
        by mx.google.com with ESMTPS id 11sm5239275bkj.11.2010.10.05.12.31.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 12:31:03 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTi=wZUc0GnB8p0=3Hkd1xPsvqqdEMHn80GKsHUj6@mail.gmail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158227>

This adds general functions to get the list of all branches which
either depends on a given one (fan-in), or all dependencies of a given
one (fan-out).

Two simple users are provided which just lists the names of generates dot
input.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Note for v3: I should probably use the list_deps function, but that needs to
honor -i/-w first.

Changes:
 v2:
  * make doc consistent
  * provide $_name to FOR_EACH-commands
  * don't assign values to local variables at declaration time

 tg.sh |  184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 3718702..8fa06d3 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -351,6 +351,190 @@ setup_pager()
 	trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_pager_fifo_dir\"; wait" EXIT
 }
 
+# traverse_fan_out FOR_EACH_NAME FOR_EACH_DEP NAME HEAD_DEPS
+#
+# traverse the dependencies of NAME in bfs order and call FOR_EACH_NAME
+# on each dep (i.e. node) and FOR_EACH_DEP on all dependencies (i.e. edge)
+# with source and dest as arguments.
+#
+# FOR_EACH_NAME and FOR_EACH_DEP can refer to $_name for queried branch NAME
+#
+# NAME needs to be a TopGit controlled branch
+#
+# HEAD_DEPS specifies where to take the .topdeps from for the HEAD branch
+# empty - from the committed tree
+# '(i)' - from the index
+# '(w)' - from the working dir
+#
+traverse_fan_out()
+{
+	local for_each_name for_each_dep name head_deps deps_src head
+
+	_name="$3"
+	for_each_name="$1"
+	for_each_dep="$2"
+	head_deps=$4 || :
+	head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')" || :
+
+	branchq="$(mktemp -t tg-fan-out.XXXXXX)"
+	allbranches="$(mktemp -t -d tg-fan-out-all.XXXXXX)"
+	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
+
+	# fill queue with root name
+	echo "$_name" > "$branchq"
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
+_list_fan()
+{
+	# only print the deps
+	[ "$_name" = "$1 "] ||
+		echo "$1"
+}
+
+# prints the fan-out as name per line
+list_fan_out()
+{
+	traverse_fan_out _list_fan : "$1" $2
+}
+
+# traverse_fan_in FOR_EACH_NAME FOR_EACH_DEP NAME HEAD_DEPS
+#
+# traverse all branches which depends on NAME in bfs order and call
+# FOR_EACH_NAME on each (i.e. node) and FOR_EACH_DEP on all dependencies
+# (i.e. edge) with source and dest as arguments.
+#
+# FOR_EACH_NAME and FOR_EACH_DEP can refer to $_name for queried branch NAME
+#
+# NAME needs not to be a TopGit controlled branch
+#
+# HEAD_DEPS specifies where to take the .topdeps from for the HEAD branch
+# empty - from the committed tree
+# '(i)' - from the index
+# '(w)' - from the working dir
+#
+traverse_fan_in()
+{
+	local for_each_name for_each_dep name head_deps deps_src head
+
+	_name="$3"
+	for_each_name="$1"
+	for_each_dep="$2"
+	head_deps="$4" || :
+	head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')" || :
+
+	branchq="$(mktemp -t tg-fan-in.XXXXXX)"
+	allbranches="$(mktemp -t -d tg-fan-in-all.XXXXXX)"
+	trap "rm -rf \"$branchq\" \"$allbranches\"" 0
+
+	# fill queue with root name
+	echo "$_name" > "$branchq"
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
+	traverse_fan_in _list_fan : "$1" $2
+}
+
 ## Startup
 
 [ -d "@cmddir@" ] ||
-- 
tg: (ff59ac7..) bw/fan-in-out (depends on: master)
