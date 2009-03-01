From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH 1/2] git-rebase: Add --stat and --no-stat for producing diffstat on rebase
Date: Sun,  1 Mar 2009 22:28:27 +0100
Message-ID: <1235942908-5419-2-git-send-email-torarnv@gmail.com>
References: <1235942908-5419-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtBm-0004Gx-T5
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbZCAVZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755986AbZCAVZh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:25:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:36600 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbZCAVZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:25:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so868652fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AykKsPuvFyjV+anH/6Hvae6INjJybd1/ijBLkiWRJqs=;
        b=sfHgWT3nhobT2y5XLa9aZZR+Aq7p0FXJuiKBrpC92mSbn3GCN+szf/qGYy7/IvhlLw
         EIEJAGb/pEsWDQFVQk83/u19xe9hJQNQtmgEUXylPJW4y5jb4B3wKsb1yWccpieeXBDv
         ikXuTP4CX5cndqBYiyYu9/CPWbC2ANKgzxQwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NSAaODAC9fq+tzTbRWXIbzsR0Wj9kw6RA71AViJjfLbunYSemu9fFhWIbCEUH4NXg2
         zTAtQNdAloUlYt0DLv9q4MeRsoky7QGj+rBL3Twu1mZxsTdMpjRVPU9uhQYCxCKhjM08
         IKwsBNLo0o6+gS0AJsYeq/KpmT9r7h4u4ogcc=
Received: by 10.86.50.8 with SMTP id x8mr5778876fgx.14.1235942730586;
        Sun, 01 Mar 2009 13:25:30 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l12sm5984245fgb.31.2009.03.01.13.25.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 13:25:29 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 88393178009; Sun,  1 Mar 2009 22:28:27 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.11.g80931
In-Reply-To: <1235942908-5419-1-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111876>

The behavior of --verbose is unchanged, but uses a different state
variable internally, so that the meaning of verbose output may be
expanded without affecting the diffstat. This is also reflected in
the documentation.

The configuration option rebase.stat works the same was as merg.stat,
but the default is currently false.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 Documentation/git-rebase.txt |   17 ++++++++++++++++-
 git-rebase.sh                |   25 ++++++++++++++++++-------
 t/t3406-rebase-message.sh    |   23 ++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index da3c38c..57bd333 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -192,6 +192,13 @@ Alternatively, you can undo the 'git-rebase' with
=20
     git rebase --abort
=20
+CONFIGURATION
+-------------
+
+rebase.stat::
+	Whether to show a diffstat of what changed upstream since the last
+	rebase. False by default.
+
 OPTIONS
 -------
 <newbase>::
@@ -232,7 +239,15 @@ OPTIONS
=20
 -v::
 --verbose::
-	Display a diffstat of what changed upstream since the last rebase.
+	Be verbose. Implies --stat.
+
+--stat::
+	Show a diffstat of what changed upstream since the last rebase. The
+	diffstat is also controlled by the configuration option rebase.stat.
+
+-n::
+--no-stat::
+	Do not show a diffstat as part of the rebase process.
=20
 --no-verify::
 	This option bypasses the pre-rebase hook.  See also linkgit:githooks[=
5].
diff --git a/git-rebase.sh b/git-rebase.sh
index 368c0ef..26d7566 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -46,6 +46,7 @@ do_merge=3D
 dotest=3D"$GIT_DIR"/rebase-merge
 prec=3D4
 verbose=3D
+diffstat=3D$(git config --bool rebase.stat)
 git_am_opt=3D
 rebase_root=3D
=20
@@ -289,8 +290,15 @@ do
 		esac
 		do_merge=3Dt
 		;;
+	-n|--no-stat)
+		diffstat=3D
+		;;
+	--stat)
+		diffstat=3Dt
+		;;
 	-v|--verbose)
 		verbose=3Dt
+		diffstat=3Dt
 		;;
 	--whitespace=3D*)
 		git_am_opt=3D"$git_am_opt $1"
@@ -426,18 +434,21 @@ then
 	exit 0
 fi
=20
-if test -n "$verbose"
-then
-	echo "Changes from $mb to $onto:"
-	# We want color (if set), but no pager
-	GIT_PAGER=3D'' git diff --stat --summary "$mb" "$onto"
-fi
-
 # Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $branch
=20
+if test -n "$diffstat"
+then
+	if test -n "$verbose"
+	then
+		echo "Changes from $mb to $onto:"
+	fi
+	# We want color (if set), but no pager
+	GIT_PAGER=3D'' git diff --stat --summary "$mb" "$onto"
+fi
+
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
 if test "$mb" =3D "$branch"
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5391080..85fc7c4 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -22,7 +22,8 @@ test_expect_success setup '
 	git checkout topic &&
 	quick_one A &&
 	quick_one B &&
-	quick_one Z
+	quick_one Z &&
+	git tag start
=20
 '
=20
@@ -41,4 +42,24 @@ test_expect_success 'rebase -m' '
=20
 '
=20
+test_expect_success 'rebase --stat' '
+        git reset --hard start
+        git rebase --stat master >diffstat.txt &&
+        grep "^ fileX |  *1 +$" diffstat.txt
+'
+
+test_expect_success 'rebase w/config rebase.stat' '
+        git reset --hard start
+        git config rebase.stat true &&
+        git rebase master >diffstat.txt &&
+        grep "^ fileX |  *1 +$" diffstat.txt
+'
+
+test_expect_success 'rebase -n overrides config rebase.stat config' '
+        git reset --hard start
+        git config rebase.stat true &&
+        git rebase -n master >diffstat.txt &&
+        ! grep "^ fileX |  *1 +$" diffstat.txt
+'
+
 test_done
--=20
1.6.2.rc2.11.g80931
