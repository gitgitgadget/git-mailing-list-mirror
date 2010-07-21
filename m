From: public_vi@tut.by
Subject: [PATCH] contrib: Add update-http-moderated hook
Date: Wed, 21 Jul 2010 04:23:07 +0300
Message-ID: <1279675387-15280-1-git-send-email-public_vi@tut.by>
Cc: public_vi@tut.by
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 03:26:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObO4o-0000pm-ST
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 03:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761925Ab0GUB0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 21:26:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64982 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0GUB0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 21:26:21 -0400
Received: by eya25 with SMTP id 25so1511664eya.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 18:26:19 -0700 (PDT)
Received: by 10.213.3.70 with SMTP id 6mr5528533ebm.8.1279675579581;
        Tue, 20 Jul 2010 18:26:19 -0700 (PDT)
Received: from vi-notebook ([93.125.18.114])
        by mx.google.com with ESMTPS id v8sm52477619eeh.14.2010.07.20.18.26.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 18:26:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151385>

From: Vitaly _Vi Shukela <public_vi@tut.by>

If the user of http-backend is "mod", allow everything.
Else prevent editing history or deleting refs.
Can be used to set up "anarchic" repositories with anonymous push access,
but also with moderator account that can do "push --force" and "push --delete".

Signed-off-by: Vitaly _Vi Shukela <public_vi@tut.by>
---
 contrib/hooks/update-http-moderated |  121 +++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 contrib/hooks/update-http-moderated

diff --git a/contrib/hooks/update-http-moderated b/contrib/hooks/update-http-moderated
new file mode 100755
index 0000000..cff4fd7
--- /dev/null
+++ b/contrib/hooks/update-http-moderated
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# If the user of http-backend is "mod", allow everything. Else prevent editing history or deleting refs.
+# 
+# Apache configuration example:
+#
+#       SetEnv GIT_PROJECT_ROOT /var/www/git
+#       ScriptAlias /git/ /usr/local/libexec/git-core/git-http-backend/
+#       ScriptAlias /gitmod/ /usr/local/libexec/git-core/git-http-backend/
+#       
+#       
+#       <Location /gitmod/>
+#           AuthName "Git forced push access"
+#           AuthType Basic
+#           AuthUserFile /var/www/git/.htpasswd
+#           AuthGroupFile /dev/null
+#           Require User mod
+#       </Location>
+#
+# Can be used to set up "anarchic" repositories with anonymous push access,
+# but also with moderator account that has "push --force" and "push --delete" permissions.
+#
+# Based on update.sample.
+
+if [ "$REMOTE_USER" == "mod" ]; then exit 0; fi
+
+# --- Command line
+refname="$1"
+oldrev="$2"
+newrev="$3"
+
+# --- Safety check
+if [ -z "$GIT_DIR" ]; then
+	echo "Don't run this script from the command line." >&2
+	echo " (if you want, you could supply GIT_DIR then run" >&2
+	echo "  $0 <ref> <oldrev> <newrev>)" >&2
+	exit 1
+fi
+
+if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
+	echo "Usage: $0 <ref> <oldrev> <newrev>" >&2
+	exit 1
+fi
+
+# check for no description
+projectdesc=$(sed -e '1q' "$GIT_DIR/description")
+case "$projectdesc" in
+"Unnamed repository"* | "")
+	echo "*** Project description file hasn't been set" >&2
+	exit 1
+	;;
+esac
+
+# --- Check types
+# if $newrev is 0000...0000, it's a commit to delete a ref.
+zero="0000000000000000000000000000000000000000"
+if [ "$newrev" = "$zero" ]; then
+	newrev_type=delete
+else
+	newrev_type=$(git-cat-file -t $newrev)
+
+	m="`git merge-base $newrev $oldrev`"
+	if [ "$oldrev" != "$zero" -a "$m" != "$oldrev" ] ; then
+	    echo "Non-fast-forward!" >&2;
+	    exit 1;
+	fi;
+fi
+
+
+case "$refname","$newrev_type" in
+	refs/tags/*,commit)
+		# un-annotated tag
+		short_refname=${refname##refs/tags/}
+		    echo "*** The un-annotated tag, $short_refname, is not allowed in this repository" >&2
+		    echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
+		    exit 1
+		;;
+	refs/tags/*,delete)
+		# delete tag
+		    echo "*** Deleting a tag is not allowed in this repository" >&2
+		    exit 1
+		;;
+	refs/tags/*,tag)
+		# annotated tag
+		if git rev-parse $refname > /dev/null 2>&1
+		then
+			echo "*** Tag '$refname' already exists." >&2
+			echo "*** Modifying a tag is not allowed in this repository." >&2
+			exit 1
+		fi
+		;;
+	refs/heads/*,commit)
+		# create branch
+		if [ "$oldrev" = "$zero" ]; then
+			#exit 1  # Uncomment it to disallow creating new branches
+			:;
+		fi
+		;;
+	refs/heads/*,delete)
+		# delete branch
+		echo "*** Deleting a branch is not allowed in this repository" >&2
+		exit 1
+		;;
+	refs/remotes/*,commit)
+		# tracking branch
+		exit 1;
+		;;
+	refs/remotes/*,delete)
+		# delete tracking branch
+		echo "*** Deleting a tracking branch is not allowed in this repository" >&2
+		exit 1
+		;;
+	*)
+		# Anything else (is there anything else?)
+		echo "*** Update hook: unknown type of update to ref $refname of type $newrev_type" >&2
+		exit 1
+		;;
+esac
+
+# --- Finished
+exit 0
-- 
1.7.1
