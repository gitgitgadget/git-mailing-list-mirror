From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 9/9] svn-fe: reuse import-marks in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:53 +0600
Message-ID: <1310570813-16648-10-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LD-0002iX-9C
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab1GMP0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56795 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab1GMP0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:45 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112143eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DHhCYTLbN78jANW1PC+WP8L/D27Bm8KyEejy+j2Qi6w=;
        b=T0h8y8nju+aTvUF2IoZZhgRTBcLEyC58s9PLzDFdRRgYxJQuXMnht6m18F0sy+ku/j
         imPW53Fvorp3XG7K6LPcJixZTR+2OUa6CSErFyNr9J8A2sy0vib3DQAJyVWqcy5YcKzK
         xJs65nL9oL1H0dz4ft5BjlyMxW4cqhL/DVJGA=
Received: by 10.14.98.207 with SMTP id v55mr356379eef.49.1310570803974;
        Wed, 13 Jul 2011 08:26:43 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177051>

remote-svn-alpha needs to prepare import marks file when doing an
incremental import. This file can be left after previous imports.

Take the last imported commit and a note with corresponding svn
revision number. If the marks file exists and defines a :revision
mark pointing to the last imported commit, consider it valid.
It may accidentally contain newer revisions, they are silently
ignored. In practice the check for :revision last_commit should
be sufficient to rely on this file defining any lesser revision
marks needed correctly.

So if the import marks file looks valid, do not regenerate it from
the notes tree and have save some performance saved.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index f4e737d..8096ef2 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -78,14 +78,31 @@ do_gen_marks () {
 prepare_marks () {
 	dst=$1 notes=$2 rev=$3
 	test "z$git_dir" != "$z" || die "we were not told the gitdir"
-	mkdir -p "$git_dir/$marks_dir"
-	if test ! -f "$git_dir/$marks_dir/marks"; then
-		touch "$git_dir/$marks_dir/marks"
+	path="$git_dir/$marks_dir"
+	mkdir -p "$path"
+	path="$path/marks"
+
+	if test ! -f "$path"; then
+		touch "$path"
 	fi
 	if test "$rev" = "-1"; then
 		return 0
 	fi
-	do_gen_marks "$notes" >"$git_dir/$marks_dir/marks"
+	mark_sha=""
+	{
+		while read -r m sha
+		do
+			if test "$m" = ":$rev"; then
+				mark_sha="$sha"
+			fi
+		done
+	} <"$path"
+	dst_sha=$( git rev-parse "$dst" )
+	if test -n "$mark_sha"; then
+		test "$mark_sha" = "$dst_sha" || die "latest mark and note diverge"
+	else
+		do_gen_marks "$notes" >"$path"
+	fi
 }
 
 last_imported_rev () {
@@ -110,6 +127,7 @@ do_import () {
 	revs="$start_rev:HEAD"
 	prepare_marks $dst $notes $rev
 	echo "feature import-marks=$git_dir/$marks_dir/marks"
+	echo "feature export-marks=$git_dir/$marks_dir/marks"
 	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --notes-ref="$notes" --incremental --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
-- 
1.7.3.4
