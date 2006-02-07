From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 3/3] cg-patch: Add -d option to apply patch directory
Date: Tue, 7 Feb 2006 23:44:41 +0100
Message-ID: <20060207224441.GC24790@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 23:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6baF-0003Cw-71
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 23:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWBGWox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWBGWox
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 17:44:53 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:27083 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030223AbWBGWoo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 17:44:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1B77752D5A2;
	Tue,  7 Feb 2006 23:44:44 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20023-02; Tue,  7 Feb 2006 23:44:42 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1A8CE52D5A3;
	Tue,  7 Feb 2006 23:44:42 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 19D496DF84F; Tue,  7 Feb 2006 23:43:57 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0856F61AD6; Tue,  7 Feb 2006 23:44:42 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15718>

It tries to do some minimal sanity checking on the individual patch
files, to ensure that they are created with cg-mkpatch. This includes
checking that the filename starts with [0-9]*-, the patch is non-empty,
and it contains author information from git-cat-file output.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
commit 35f920438f1c9f7413d708eeb57da7ea3dd8909a
tree 602514ba6eed872f936fdd133f17a12933fce38b
parent 77defc166986330f4285db8faf206c1176a6c4ae
author Jonas Fonseca <fonseca@diku.dk> Tue, 07 Feb 2006 23:30:42 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Tue, 07 Feb 2006 23:30:42 +0100

 cg-patch |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/cg-patch b/cg-patch
index 90dfd30..e783985 100755
--- a/cg-patch
+++ b/cg-patch
@@ -12,6 +12,11 @@
 #
 # OPTIONS
 # -------
+# -d DIRNAME:: Apply all patches in directory
+#	Instead of applying the patch from stdin, apply all patches in the
+#	specified directory. This can be used to import a range of patches
+#	made with cg-mkpatch -d.
+#
 # -R:: Apply in reverse
 #	Applies the patch in reverse (therefore effectively unapplies it)
 #
@@ -68,11 +73,32 @@ redzone_border()
 	redzone_reset
 }
 
+apply_directory() {
+	directory="$1"
+	patch="$(mktemp -t gitpatch.XXXXXX)"
+
+	find "$directory" -name '[0-9]*-*' | while read file; do
+		sed -n '/^---$/,$p' < "$file" > "$patch"
+		[ -s "$patch" ] || die "No patch found in '$file'"
+
+		author="$(sed -n '/^author /p' < "$patch")"
+		[ "$author" ] || die "No author info found in '$file'"
+
+		eval "$(echo "$author" | pick_author)"
+		echo "Applying ${file#$directory/}"
+		cg-patch < "$patch"
+		sed '/^---$/,$d' < "$file" | cg-commit
+	done
+}
 
 reverse=
 while optparse; do
 	if optparse -R; then
 		reverse=1
+	elif optparse -d=; then
+		[ -d "$OPTARG" ] || die "Not a directory '$OPTARG'."
+		apply_directory "$(echo "$OPTARG" | sed 's,/*$,,')"
+		exit
 	else
 		optfail
 	fi

-- 
Jonas Fonseca
