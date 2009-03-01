From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH v2] git-rebase: Add --stat and --no-stat for producing diffstat on rebase
Date: Sun,  1 Mar 2009 23:11:38 +0100
Message-ID: <1235945498-12631-1-git-send-email-torarnv@gmail.com>
References: <m3zlg4ud9v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtrQ-0000AO-DJ
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbZCAWIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbZCAWIn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:08:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:29961 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZCAWIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 17:08:43 -0500
Received: by fg-out-1718.google.com with SMTP id 16so871633fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LqBq7oraFwHjMN2WPR6sDzSQ0aF+hKu1kjTQJ1NwqG8=;
        b=lYFM0z/7WUuEYRNH0wWZfCAK2LVbH6aE8iPQUThIHjXAIVNzfXAIwi/wwe3NM0XpOD
         YiW19O1IrsW8lRZFpq1VXVEvFzVkvtHgpuzbhokca6xO5/2x6MNI3XEnXLaqSVa5H0X7
         zaSmwej00YugZiNCaQvWSFnctyWZBNquQ2cFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qLUlpnDMatdobwRbyK/KxHEz6tyzxCCYDgkBze1fpPDky2jROA/P1OIyMC8/SwWhFh
         2riGmUX5IrspP1uxFX2X7Mp1iaMmzO/jE85n8DxoyHaglv0PdnznwAzhjGvMx34btWz3
         CVHGqpSuurtVTP1x4LmL2ckS8LP5QTLChkAeo=
Received: by 10.86.57.9 with SMTP id f9mr1582711fga.38.1235945319269;
        Sun, 01 Mar 2009 14:08:39 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l19sm9036861fgb.47.2009.03.01.14.08.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 14:08:39 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 2E835468001; Sun,  1 Mar 2009 23:11:38 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.11.g80931
In-Reply-To: <m3zlg4ud9v.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111888>

The behavior of --verbose is unchanged, but uses a different state
variable internally, so that the meaning of verbose output may be
expanded without affecting the diffstat. This is also reflected in
the documentation.

The configuration option rebase.stat works the same was as merg.stat,
but the default is currently false.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---

Thanks Jakub, I knew there was a reason that git-config.txt was so empt=
y ;)

And sorry for the double post, --cc to git-send-email seems to override
what's in the config, not compliment it.

 Documentation/config.txt     |    4 ++++
 Documentation/git-rebase.txt |   17 ++++++++++++++++-
 git-rebase.sh                |   25 ++++++++++++++++++-------
 t/t3406-rebase-message.sh    |   23 ++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5152c5..6be2e99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1160,6 +1160,10 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
=20
+rebase.stat::
+	Whether to show a diffstat of what changed upstream since the last
+	rebase. False by default.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
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
