From: =?utf-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>
Subject: [PATCH] First crude implementation of git-svn-externals
Date: Fri, 29 Aug 2008 03:02:58 +0300
Message-ID: <1219968179-14156-2-git-send-email-eddy.petrisor@gmail.com>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
 <1219968179-14156-1-git-send-email-eddy.petrisor@gmail.com>
Cc: Eddy Petrisor <eddy@epetrisor.dsd.ro>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 02:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrTK-0003cd-3V
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbYH2ADG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYH2ADF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:03:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:29494 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbYH2ADC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:03:02 -0400
Received: by fk-out-0910.google.com with SMTP id 18so408964fkq.5
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=funvIioxEJwIXHEY9ivpu7Q/N34vvU/7QOieMj5eIDg=;
        b=OQGhE55s9SNfoMq3vgGYixE2L2Ji07z32ODFXO8TZNSmDDXEzdXcFDOOTr7/Wot1fz
         hKtCgXOzLcCwFS2Bg1sN2OTzSP18Jr/uk0CyhFSJ4C0gMjFvMYbDthl9z4aDpw9XX/NG
         6f8NPqeUEz8NMi8Cj16YqWvbQ9xaU7XuweIkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Iip7dZFrDHxL9ZhyGKNLwov4fj+/yZNHd5wiX6R7AzbvOILmL7eBEB58JaIHhfCOF5
         nHOxq/R6c+Dr3oioi2IZQckUmywxauV9l5pq01q/+JLumse6Ju50FSG0/Xx3Cxkn3O/Z
         vUEt7CfmqzwaBqlFs8R4WCeCGc2zVdY6q/BKE=
Received: by 10.180.203.3 with SMTP id a3mr2916091bkg.83.1219968181631;
        Thu, 28 Aug 2008 17:03:01 -0700 (PDT)
Received: from eddy.petrisor@gmail.com ( [78.97.158.176])
        by mx.google.com with ESMTPS id d13sm1374418fka.3.2008.08.28.17.02.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 17:03:00 -0700 (PDT)
Received: by eddy.petrisor@gmail.com (sSMTP sendmail emulation); Fri, 29 Aug 2008 03:03:03 +0300
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219968179-14156-1-git-send-email-eddy.petrisor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94224>

From: Eddy Petrisor <eddy@epetrisor.dsd.ro>

Current functionality:
 - fetches all the externals of an already svn-fetched repo
 - support for svn:externals refresh
 - if the location of the external has changed, the current working
   copy will be placed aside and a new directory will be created
   instead
 - if the remote URI is the same (maybe a verison bump, there will
   be a 'git svn rebase'
 - remove support (useful for testing purposes or clean restarts)
 - avoid zombie externals at all costs - in some repos empty
   svn:externals might exist; svn ignores such externals, so git should
   do the same

TODO:
 - take into account the revision of an external, if it exists
 - do not do deep svn cloning, to avoid legthy operations, just pull HEAD
 - add shallow copies to git svn repos (one revision should be enough
   for most externals)
 - use submodules for externals
---
 .gitignore           |    1 +
 Makefile             |    1 +
 git-svn-externals.sh |  158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100755 git-svn-externals.sh

diff --git a/.gitignore b/.gitignore
index bbaf9de..cd2c47d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@ git-status
 git-stripspace
 git-submodule
 git-svn
+git-svn-externals
 git-symbolic-ref
 git-tag
 git-tar-tree
diff --git a/Makefile b/Makefile
index bf400e6..b130244 100644
--- a/Makefile
+++ b/Makefile
@@ -265,6 +265,7 @@ SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-svn-externals.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
diff --git a/git-svn-externals.sh b/git-svn-externals.sh
new file mode 100755
index 0000000..38b7af6
--- /dev/null
+++ b/git-svn-externals.sh
@@ -0,0 +1,158 @@
+#!/bin/sh
+
+set -e
+
+GIT_SVN_LAST_DIR="$(pwd)"
+trap "cd '$GIT_SVN_LAST_DIR'" INT EXIT KILL
+
+
+USAGE='[help|init|refresh|show]'
+
+LONG_USAGE='git svn externals help
+	print this long help message.
+git svn externals init [<pathspec>...]
+	pull all externals according to current repo state.
+git svn externals refresh [<pathspec>...]
+	removes current externals and repulls them.
+'
+
+
+SUBDIRECTORY_OK=Sometimes
+OPTIONS_SPEC=
+. git-sh-setup
+cd_to_toplevel
+# this should never fail
+require_work_tree
+
+
+GIT_SVN_TOP_DIR="$(pwd)"
+
+svn_revision_to_numrevision ()
+#$1 - repository URI
+#$2 - the revision to be transformed
+{
+	local REVSPEC
+	[ "$2" ] && REVSPEC="-r $2" || REVSPEC=''
+	[ "$1" ] || die "Internal error: no repository given in svn_revision_to_numrevision"
+	LANG=C svn info "$1" "$REVSPEC" | grep 'Revision' | cut -f 2 -d ':' | sed 's#^\ \ *##g'
+}
+
+prune_inital_slashes ()
+{
+	echo "$1" | sed 's#^//*##g'
+}
+
+git_svn_externals_remove ()
+{
+	local LASTDIR="$(pwd)"
+	cd_to_toplevel && TOPLEVELDIR="$(pwd)"
+	git svn show-externals | grep -vE '^(#.*|)$' | while read EXT_DIR REV EXT_SRC ; do
+		if [ -z "$REV" ] ; then
+			echo "Skipping illegal external '$EXT_DIR' which has no value" >&2
+			continue
+		fi
+		EXT_DIR="$(prune_inital_slashes "$EXT_DIR")"
+
+		if [ -z "$EXT_SRC" ] ; then
+			EXT_SRC="$REV"
+			REV="-rHEAD"
+		fi
+		REV=${REV#-r}
+
+		echo "Removing local copy for external '$EXT_DIR' ( $EXT_SRC@$REV )"
+		rm -fr "$EXT_DIR"
+	done
+
+	cd "$LASTDIR"
+}
+
+git_svn_init_dir_repo ()
+# assumes is ran from the parent dir of the repo
+# $1 EXT_DIR
+# $2 EXT_SRC
+# $3 REV
+{
+	local LASTDIR="$(pwd)"
+
+	mkdir -p "$1"
+	cd "$1"
+	git svn init "$2"
+	git svn fetch
+
+	cd "$LASTDIR"
+}
+
+git_svn_externals_refresh_external ()
+#$1 directory where the external is locally
+#$2 remote url
+#$3 revision at which the external is pinned at
+{
+	local LASTDIR="$GIT_SVN_TOP_DIR"
+
+	local EXT_SRC="$2"
+	local EXT_DIR="$1"
+
+	if cd "$EXT_DIR" 2>/dev/null; then
+		local OLDDIREXISTS=yes
+		local OLD_EXT_SRC=$(git config --get svn-remote.svn.url)
+		local OLD_EXT_REV=$(git config --get svn-remote.svn.revision || svn_revision_to_numrevision $OLD_EXT_SRC HEAD)
+		cd -
+	else
+		local OLDDIREXISTS=no
+		local OLD_EXT_SRC="${EXT_SRC}"
+		local OLD_EXT_REV=$(svn_revision_to_numrevision $EXT_SRC HEAD)
+	fi
+
+	if [ "$OLD_EXT_SRC" != "$EXT_SRC" ] ; then
+		echo "External URI definition changed. Moving away the old repo and pulling a new one."
+		cd "$LASTDIR"
+		local SUBDIR="$(basename "$EXT_DIR")"
+		local DIRNAME="$(dirname "$EXT_DIR")"
+		NEWDIR="$(mktemp -p "$DIRNAME" "$SUBDIR.obsolete.XXXXXX")" && rm -f "$NEWDIR"
+		mv "$EXT_DIR" "$NEWDIR"
+		echo "  Old copy moved to '$NEWDIR'."
+		git_svn_init_dir_repo "$EXT_DIR" "$EXT_SRC" "$REV"
+	elif [ "$OLDDIREXISTS" = "no" ] ; then
+		git_svn_init_dir_repo "$EXT_DIR" "$EXT_SRC" "$REV"
+	else
+		cd "$EXT_DIR"
+		git svn rebase
+	fi
+
+	cd "$LASTDIR"
+	return 0
+}
+
+git_svn_externals_refresh ()
+{
+	git svn show-externals | grep -vE '^(#.*|)$' | while read EXT_DIR REV EXT_SRC ; do
+		if [ -z "$REV" ] ; then
+			echo "Skipping illegal external '$EXT_DIR' which has no value" >&2
+			continue
+		fi
+		EXT_DIR="$(prune_inital_slashes "$EXT_DIR")"
+
+		if [ -z "$EXT_SRC" ] ; then
+			EXT_SRC="$REV"
+			REV="-rHEAD"
+		fi
+		REV=${REV#-r}
+
+		echo "Refreshing local copy for external '$EXT_DIR' ( $EXT_SRC@$REV )"
+		cd "$GIT_SVN_TOP_DIR"
+		git_svn_externals_refresh_external "$EXT_DIR" "$EXT_SRC" "$REV"
+	done
+
+	cd "$GIT_SVN_TOP_DIR"
+}
+
+
+case $1 in
+	--remove)
+		git_svn_externals_remove
+		;;
+	-r|--refresh|*)
+		git_svn_externals_refresh
+		;;
+esac
+
-- 
1.5.6.3
