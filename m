From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2] clone: support cloning full bundles
Date: Fri, 29 Feb 2008 20:16:19 +0100
Message-ID: <1204312579-8303-1-git-send-email-sbejar@gmail.com>
References: <1204165372-12175-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 20:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVAjJ-0001CD-Vw
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 20:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbYB2TQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYB2TQg
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 14:16:36 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:45227 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYB2TQe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 14:16:34 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5622629fkz.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=byJSeBKQQdWsDvuQC1wee2263/ziDTad3VyMNWaMDWI=;
        b=Hc+/MrWZiaQmqnDW+BA0FzbAvMaxVuGqtYlyaxN1oPKPcK0s7/Ej7pmocL2j6SnB8PRGlCDO3357na0i43KxDsrsNrACYKmfiQEN813LUKe1EH6dNZo8PBa12Ltds97rMZpBR8iBAZfk18zVbClyl86sef/e2oI5FI17B+5tTlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=i7EMfOZ0Oxh0osSJpWGRfr2Wzc2wh0EAnUvA6vcERCcJ6/JesUZpWN2vxB8eQBUlkM3Bpz322BETK2lNaX3SxUaa+w7HWo81XS/GAJm3NZ40AqsyL3jqoOXZfy8KpOlQk7jhmq7RBj+9tF1pAZdRF3KhN1tMBZQ9gm7k/eWiJFg=
Received: by 10.82.112.3 with SMTP id k3mr9558833buc.6.1204312592469;
        Fri, 29 Feb 2008 11:16:32 -0800 (PST)
Received: from localhost ( [91.13.94.95])
        by mx.google.com with ESMTPS id s10sm6424896muh.11.2008.02.29.11.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 11:16:31 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.393.g5540
In-Reply-To: <1204165372-12175-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75551>

The "humanish" part of a bundle is made removing the ".bundle" suffix.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi,

  changes since v3:

  * rewrite "humanish" part to be more readable
    as requested by Junio
  * Fix a typo in one test

  Santi

 git-clone.sh           |   36 +++++++++++++++++++++++++++++-------
 t/t5701-clone-local.sh |   45 ++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0d686c3..9ae9646 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -210,11 +210,27 @@ if base=3D$(get_repo_base "$repo"); then
 	then
 		local=3Dyes
 	fi
+elif [ -f "$repo" ] ; then
+	case "$repo" in /*);; *) repo=3D"$PWD/$repo" ; esac
+fi
+
+# Decide the directory name of the new repository
+if test -n "$2"
+then
+	dir=3D"$2"
+else
+	# Derive one from the repository name
+	# Try using "humanish" part of source repo if user didn't specify one
+	if test -f "$repo"
+	then
+		# Cloning from a bundle
+		dir=3D$(echo "$repo" | sed -e 's|/*\.bundle$||' -e 's|.*/||g')
+	else
+		dir=3D$(echo "$repo" |
+			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+	fi
 fi
=20
-dir=3D"$2"
-# Try using "humanish" part of source repo if user didn't specify one
-[ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.gi=
t$||' -e 's|.*[/:]||g')
 [ -e "$dir" ] && die "destination directory '$dir' already exists."
 [ yes =3D "$bare" ] && unset GIT_WORK_TREE
 [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
@@ -364,11 +380,17 @@ yes)
 		fi
 		;;
 	*)
-		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress=
 "$repo" ;;
-		esac >"$GIT_DIR/CLONE_HEAD" ||
+		if [ -f "$repo" ] ; then
+			git bundle unbundle "$repo" > "$GIT_DIR/CLONE_HEAD" ||
+			die "unbundle from '$repo' failed."
+		else
+			case "$upload_pack" in
+			'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
+			*) git-fetch-pack --all -k \
+				$quiet "$upload_pack" $depth $no_progress "$repo" ;;
+			esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
+		fi
 		;;
 	esac
 	;;
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 59a165a..8dfaaa4 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -11,6 +11,11 @@ test_expect_success 'preparing origin repository' '
 	git clone --bare . x &&
 	test "$(GIT_CONFIG=3Da.git/config git config --bool core.bare)" =3D t=
rue &&
 	test "$(GIT_CONFIG=3Dx/config git config --bool core.bare)" =3D true
+	git bundle create b1.bundle --all HEAD &&
+	git bundle create b2.bundle --all &&
+	mkdir dir &&
+	cp b1.bundle dir/b3
+	cp b1.bundle b4
 '
=20
 test_expect_success 'local clone without .git suffix' '
@@ -71,4 +76,44 @@ test_expect_success 'local clone of repo with nonexi=
stent ref in HEAD' '
 	git fetch &&
 	test ! -e .git/refs/remotes/origin/HEAD'
=20
+test_expect_success 'bundle clone without .bundle suffix' '
+	cd "$D" &&
+	git clone dir/b3 &&
+	cd b3 &&
+	git fetch
+'
+
+test_expect_success 'bundle clone with .bundle suffix' '
+	cd "$D" &&
+	git clone b1.bundle &&
+	cd b1 &&
+	git fetch
+'
+
+test_expect_success 'bundle clone from b4' '
+	cd "$D" &&
+	git clone b4 bdl &&
+	cd bdl &&
+	git fetch
+'
+
+test_expect_success 'bundle clone from b4.bundle that does not exist' =
'
+	cd "$D" &&
+	if git clone b4.bundle bb
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		echo happy
+	fi
+'
+
+test_expect_success 'bundle clone with nonexistent HEAD' '
+	cd "$D" &&
+	git clone b2.bundle b2 &&
+	cd b2 &&
+	git fetch
+	test ! -e .git/refs/heads/master
+'
+
 test_done
--=20
1.5.4.3.393.g5540

