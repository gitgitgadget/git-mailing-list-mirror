From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 2/2] tg-import.sh: A dump quilt queue importer
Date: Fri,  8 Aug 2008 20:19:48 +0200
Message-ID: <1218219588-6849-2-git-send-email-bert.wesarg@googlemail.com>
References: <1218219588-6849-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:21:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWaH-0007Sm-Ac
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 20:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbYHHST7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbYHHST7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 14:19:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:60704 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758880AbYHHST4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 14:19:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so610621fgg.17
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F3upHaXCMnI3v9QPJQ47U0g9cMcy0V+udkIo09NwFVE=;
        b=wfcn/AGismeZN33aaESV4jG8JguVALs51C1j88IWAmoR9nwFd7qMz1y4u0JzHRE30U
         BlJaMqmgYP8H1hAmPaqjXrcyDQWmYdyzITyvuMIJc3Nggo9mzDBwGlYbrMr5dzcUdZzO
         sg3H9nP+l7Fi9m8VHoTekjIQpi+CfRUeyOyWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e77Z06IW9zoYm8wZd3JtXcLaeHy2VRnHEXo+ZgBmZgJDw7VaprkuwgXTqJd9g77moI
         5Zao5rxR3fsWfwkFnE17z4Kfsh4aonOShjv5yizbczP8YZ5Eh431jdBbHDvAitue10uh
         a21yAcJUMBCVuP5WM2c+OJwiV8649L930Hzms=
Received: by 10.86.80.5 with SMTP id d5mr3495482fgb.19.1218219595426;
        Fri, 08 Aug 2008 11:19:55 -0700 (PDT)
Received: from localhost ( [91.15.87.97])
        by mx.google.com with ESMTPS id 4sm2703595fge.5.2008.08.08.11.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Aug 2008 11:19:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1218219588-6849-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91703>

A simple, non smart, quilt importer.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore   |    2 +
 Makefile     |    3 +-
 README       |   15 ++++++++
 tg-import.sh |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6f0727f..5f1831b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,8 @@ tg-create
 tg-create.txt
 tg-delete
 tg-delete.txt
+tg-import
+tg-import.txt
 tg-info
 tg-info.txt
 tg-patch
diff --git a/Makefile b/Makefile
index dba5f20..671beab 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,8 @@ sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-info.sh tg-patch.sh tg-summary.sh \
+              tg-update.sh tg-import.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/README b/README
index dc0045f..3fc6d18 100644
--- a/README
+++ b/README
@@ -275,6 +275,21 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
+tg import
+~~~~~~~~~
+	Import a quilt queue into TopGit. First argument is the series
+	file from quilt. Second is the prefix for the topic names
+	(i.e. "t/"). All remaining arguments are the dependencies for
+	the first patch in the series. Use '-s' if you want to strip
+	common patch suffixes from the patch file name (like .diff and
+	.patch).
+
+	TODO: be smart (merge conflicts, patch rejects, ...)
+	TODO: be interactive, let the user edit .topmsg for first commit
+	TODO: be resumable
+	TODO: use a dependency file, for creating non linear dependencies
+	      of the patches (maybe generated from quilt graph)
+
 TODO: Some infrastructure for sharing topic branches between
 	repositories easily
 TODO: tg depend for adding/removing dependencies smoothly
diff --git a/tg-import.sh b/tg-import.sh
new file mode 100644
index 0000000..f9403b9
--- /dev/null
+++ b/tg-import.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2008
+# GPLv2
+
+series= # series file of patch queue
+prefix= # prefix for branch names (i.e. "t/")
+strip_suffixes= # strip suffixes like .{diff,patch}
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"
+	case "$arg" in
+	-s)
+		strip_suffixes=1
+		shift;;
+	-*)
+		echo "Usage: tg import [-s] SERIES PREFIX [DEPS...]" >&2
+		exit 1;;
+	*)
+		break;;
+	esac
+done
+
+series="$1"
+prefix="$2"
+shift 2
+# remaining args in "$@" are deps for first patch
+
+# check series file for existens and reading
+[ -r "$series" ] ||
+	die "can't read series file '$series'"
+
+# get dir of series file
+dir="$(dirname "$series")" ||
+	die "can't parse dir of series file '$series'"
+
+# These two functions are from quilt, and we can use more from there
+patch_header()
+{
+	awk '
+	/^(---|\*\*\*|Index:)[ \t][^ \t]|^diff -/ \
+		{ exit }
+		{ print }
+	'
+}
+
+strip_diffstat()
+{
+	awk '
+	/#? .* \| / \
+		{ eat = eat $0 "\n"
+		  next }
+	/^#? .* files? changed(, .* insertions?\(\+\))?(, .* deletions?\(-\))?/ \
+		{ eat = ""
+		  next }
+		{ print eat $0
+		  eat = "" }
+	'
+}
+
+# escape $root_dir for sed expression
+root_dir_esc="$(echo "$root_dir" | sed -e 's/\//\\\\\//g')"
+
+cat "$series" |
+	sed -e 's/#.*//' \      # remove any comments
+	    -e 's/^[ \t]*//' \  # remove leading whitespace
+	    -e 's/[ \t].*//' |  # remove all after none leading whitespace
+	sed -e '/^$/d' |        # remove empty lines
+	while read patch; do
+
+		patchfile="$dir/$patch"
+		[ -r "$patchfile" ] ||
+			die "can't access patch file for '$patch'"
+
+		# strip suffixes
+		name="$patch"
+		[ -n "$strip_suffixes" ] && {
+			name="${name%.patch}"
+			name="${name%.diff}"
+		}
+
+		# for the first patch "$@" are the deps from the command line
+		# all others get zero deps
+		tg create "${prefix}${name}" "$@"
+
+		# apply patch
+		# be stupid, hard coded -p1
+		# currently no support for compressed patch files
+		patch -p1 -d "$root_dir" < "$patchfile"
+
+		# extract header from patch file and feed it into .topmsg
+		# TODO: extract mail headers
+		cat "$patchfile" |
+			patch_header |
+			strip_diffstat |
+			make_topmsg "$name" > "$root_dir/.topmsg"
+		# overwrite .topmsg from tg create in index
+		git add "$root_dir/.topmsg"
+
+		# add all modified files from patch to index
+		# (and prepending it with $root_dir)
+		# be stupid, hard coded -p1 --strip=1
+		lsdiff --strip=1 "$patchfile" |
+			sed -e "s/^/$root_dir_esc\//" |
+			xargs git add
+
+		# commit changes to git
+		git commit -m "import of quilt patch '$patch'"
+
+		# clean deps after first create
+		set --
+	done
-- 
tg: (63c1934..) t/tg-import (depends on: t/auto-generate-command-list-for-tg.sh t/check-read-permissions-of-help-files t/mkdir-bindir t/make-.topmsg-gen-a-function t/its-info-attributes)
