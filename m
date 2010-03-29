From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv3 1/2] Add git alternate command
Date: Mon, 29 Mar 2010 14:39:40 -0700
Message-ID: <1269898781-18564-2-git-send-email-judge.packham@gmail.com>
References: <1269898781-18564-1-git-send-email-judge.packham@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, j.sixt@viscovery.net,
	bebarino@gmail.com, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 23:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwMj5-0006WZ-Sr
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 23:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab0C2VmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 17:42:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49392 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0C2VmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 17:42:20 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so7068685pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h6ey2OfiNuxqCJDdVTV8WbdYskEFvjOpnkWURi6uQPs=;
        b=V+dZTmlWJitHC3/vC86PuW7TtY4W9B89NG4Qbk+3WhY6hz+y/np6Z376BjNwBLnx+w
         U8kotxDpw/2jYPvjgWrhEKIkotQmmwJ9spWmeh5AGBoUGbUWCDkZQfonXVVED4OQCpZh
         pnPh2HsNwGUB7HEoV+rb60Qgm6xwLik2t3brY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Xd29FMULQIASvfbuYjTuIsjw21tnKh4nWPXtFiin9Gl6yPD+WrPe6xqrUu0cB0WIaX
         aR5QcAwOeKwQnTFlU0MsuGTHDvEcBLy3dx0wfqta36Z9VWFY3K+lKg9SSKUiuntRofj7
         dYjwZycCanW+KeN+yvWyHcbekUUn2vhWnnf2M=
Received: by 10.141.91.6 with SMTP id t6mr5097099rvl.265.1269898940469;
        Mon, 29 Mar 2010 14:42:20 -0700 (PDT)
Received: from localhost.localdomain (222-153-44-49.jetstream.xtra.co.nz [222.153.44.49])
        by mx.google.com with ESMTPS id o38sm877571rvp.15.2010.03.29.14.42.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 14:42:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1269898781-18564-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143518>

The current UI around alternates is lacking. There are commands to add
an alternate at the time of a clone (e.g. 'git clone --reference') but
no commands to see what alternates have been configured or to add an
alternate after a repository has been cloned. This patch adds a
friendlier UI for displaying and configuring alternates.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 Makefile         |    1 +
 git-alternate.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100755 git-alternate.sh

diff --git a/Makefile b/Makefile
index 3a6c6ea..0dc5e42 100644
--- a/Makefile
+++ b/Makefile
@@ -334,6 +334,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-am.sh
+SCRIPT_SH += git-alternate.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
diff --git a/git-alternate.sh b/git-alternate.sh
new file mode 100755
index 0000000..ea9925b
--- /dev/null
+++ b/git-alternate.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+#
+# This file is licensed under the GPL v2
+#
+# Copyright (c) Chris Packham
+
+dashless=$(basename "$0" | sed -e 's/-/ /')
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+$dashless [-r|--recursive]
+$dashless [-a|--add <dir>]
+$dashless [-f|--force] [-d|delete <dir>]
+--
+r,recursive                    recursively follow alternates
+a,add=                         add dir as an alternate
+d,del=                         delete dir as an alternate
+f,force                        force a delete operation
+"
+. git-sh-setup
+
+#
+# Given the path in $1, which may or may not be a relative path,
+# convert it to an absolute path
+#
+abspath()
+{
+	cd "$1"
+	pwd
+	cd - > /dev/null
+}
+
+#
+# Runs through the alternates file calling the callback function $1
+# with the name of the alternate as the first argument to the callback
+# any additional arguments are passed to the callback function.
+#
+walk_alternates()
+{
+	alternates=$GIT_DIR/objects/info/alternates
+	callback=$1
+	shift
+
+	if test -f "$alternates"
+	then
+		while read line
+		do
+			$callback "$line" "$@"
+		done< "$alternates"
+	fi
+}
+
+#
+# Walk function to display one alternate object store and, if the user
+# has specified -r, recursively call show_alternates on the git
+# repository that the object store belongs to.
+#
+show_alternates_walk()
+{
+	say "Object store $1"
+	say "    referenced via $GIT_DIR"
+
+	new_git_dir=${line%%/objects}
+	if test "$recursive" = "true" && test "$GIT_DIR" != "$new_git_dir"
+	then
+	(
+		export GIT_DIR=$new_git_dir
+		show_alternates
+	)
+	fi
+}
+
+# Display alternates currently configured
+show_alternates()
+{
+	walk_alternates show_alternates_walk
+}
+
+#
+# Walk function to check that the specified alternate does not
+# already exist.
+#
+check_current_alternate_walk()
+{
+	if test "$1" = "$2"; then
+		die "fatal: Object store $2 is already used by $GIT_DIR"
+	fi
+}
+
+# Add a new alternate
+add_alternate()
+{
+	if test ! -d "$dir"; then
+		die "fatal: $dir is not a directory"
+	fi
+
+	abs_dir=$(abspath "$dir")
+	walk_alternates check_current_alternate_walk "$abs_dir"
+
+	# At this point we know that $dir is a directory that exists
+	# and that its not already being used as an alternate. We could
+	# go further and verify that $dir has valid objects.
+
+	# if we're still going we can safely add the alternate
+	echo "$abs_dir" >> $GIT_DIR/objects/info/alternates
+	say "$abs_dir added as an alternate"
+	say "    use 'git repack -adl' to remove duplicate objects"
+}
+
+# Deletes the name alternate from the alternates file.
+# If there are no more alternates the alternates file will be removed
+del_alternate()
+{
+	if test ! $force = "true"; then
+		say "Not forced, use"
+		say "    'git repack -a' to fetch missing objects, then "
+		say "    '$dashless -f -d \"$dir\"' to remove the alternate"
+		die
+	fi
+
+	alternates=$GIT_DIR/objects/info/alternates
+	new_alternates=$alternates.tmp
+
+	grep -v -F "$dir" <"$alternates" >"$new_alternates"
+	if test -s "$new_alternates"
+	then
+		mv "$new_alternates" "$alternates"
+	else
+		# save the git from repeatedly reading a 0 length file
+		rm -f "$alternates" "$new_alternates"
+	fi
+}
+
+dir=""
+oper=""
+force="false"
+
+# Option parsing
+while test $# != 0
+do
+	case "$1" in
+	-r|--recursive)  recursive="true" ;;
+	-a|--add)        oper="add"; dir="$2"; shift ;;
+	-d|--delete)     oper="del"; dir="$2"; shift ;;
+	-f|--force)      force="true" ;;
+	--)              shift; break ;;
+	*)               usage ;;
+	esac
+	shift
+done
+
+# Now go and do it
+case "$oper" in
+	add) add_alternate ;;
+	del) del_alternate ;;
+	*)   show_alternates ;;
+esac
-- 
1.7.0.3
