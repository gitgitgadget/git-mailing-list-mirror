From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Thu, 27 Feb 2014 20:01:18 +0700
Message-ID: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 14:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0aJ-0005ka-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbaB0NBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 08:01:03 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44341 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaB0NBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 08:01:01 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so2466536pab.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=paIjbzFp/Ht2LyiDs0ZVVMvtIyg7/uFI1QXpfsamunM=;
        b=RmNHnpA1fDMPJJJtMD89HrLYdY6ps23O41enbmCKRcMghSV70IvNELXnmUZDKVtS8O
         KafTJ3wMSsYOV9GnwAKwFdjoxkEVCii349M55lFQ97Qh7RLP1/YDZud7A8NhYrQI50ml
         tQkRceP+jmnnEBhly9A/72Zy92KAzAOCl00tkKur3bXeexpD8fhVMOybjk/W9n7Epkh1
         zMRDmYFRBUJHF8qW73zzRuBQhYsK7hhzB5MVsqXhfS7fNBBBi5EKw59q5DkM1tbZ38c9
         +0cQaVZtb4ywDxf/vPIcuAuy0JFr8+0pe5TuHaK0rCWRPhbVw1VymCF+HNIO8u22Y2c/
         v9eQ==
X-Received: by 10.68.113.68 with SMTP id iw4mr12922358pbb.119.1393506061051;
        Thu, 27 Feb 2014 05:01:01 -0800 (PST)
Received: from lanh ([115.73.212.235])
        by mx.google.com with ESMTPSA id xs1sm30860467pac.7.2014.02.27.05.00.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 05:01:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 27 Feb 2014 20:01:23 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242817>

I find myself often do "git rebase -i xxx" and replace one "pick" line
with "edit" to amend just one commit when I see something I don't like
in that commit. This happens often while cleaning up a series. This
automates the "replace" step so it sends me straight to that commit.

"commit --fixup" then "rebase --autosquash" would work too but I still
need to edit todo file to make it stop after squashing so I can test
that commit. So still extra steps.

Or is there a better way to do this?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-rebase--interactive.sh | 17 ++++++++++++++---
 git-rebase.sh              | 10 ++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d741b04..0988b5c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1027,9 +1027,20 @@ fi
 has_action "$todo" ||
 	die_abort "Nothing to do"
=20
-cp "$todo" "$todo".backup
-git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+if test -n "$edit_one"
+then
+	edit_one=3D"`git rev-parse --short $edit_one`"
+	sed "1s/pick $edit_one /edit $edit_one /" "$todo" > "$todo.new" ||
+		die_abort "failed to update todo list"
+	grep "^edit $edit_one " "$todo.new" >/dev/null ||
+		die_abort "expected to find 'edit $edit_one' line but did not"
+	mv "$todo.new" "$todo" ||
+		die_abort "failed to update todo list"
+else
+	cp "$todo" "$todo".backup
+	git_sequence_editor "$todo" ||
+		die_abort "Could not execute editor"
+fi
=20
 has_action "$todo" ||
 	die_abort "Nothing to do"
diff --git a/git-rebase.sh b/git-rebase.sh
index 1cf8dba..98796cc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -31,6 +31,7 @@ verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflict=
s
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -=
i
+1,edit-one!        generate todo list to edit this commit
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
 whitespace=3D!       passed to 'git apply'
@@ -249,6 +250,10 @@ do
 	-i)
 		interactive_rebase=3Dexplicit
 		;;
+	-1)
+		interactive_rebase=3Dexplicit
+		edit_one=3Dt
+		;;
 	-k)
 		keep_empty=3Dyes
 		;;
@@ -450,6 +455,11 @@ then
 		;;
 	*)	upstream_name=3D"$1"
 		shift
+		if test -n "$edit_one"
+		then
+			edit_one=3D"$upstream_name"
+			upstream_name=3D"$upstream_name^"
+		fi
 		;;
 	esac
 	upstream=3D$(peel_committish "${upstream_name}") ||
--=20
1.9.0.66.g14f785a
