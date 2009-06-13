From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] am: teach quiet option
Date: Sat, 13 Jun 2009 13:21:39 -0700
Message-ID: <1244924500-27391-2-git-send-email-bebarino@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZjf-0007Uf-7Q
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 22:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757845AbZFMUVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 16:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbZFMUVq
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 16:21:46 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:50269 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869AbZFMUVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 16:21:45 -0400
Received: by mail-px0-f187.google.com with SMTP id 17so1257966pxi.33
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Dw0T3zp1iTNzs5JUXH8E9tAYYBgu5Btrd70qtkYf+BI=;
        b=pTVfkbBaetpLWi1+CHjrFUI3nDU02RqiTJ3j+fRB/fEfIleWBZFLsca2x6bcmSXweX
         FQHWWtMkyR6G4kQf01zNNQNlbg4ESVI+NhR4rHs9HC74E1jYMk8VIZuKwtHhSceVs8V8
         6QxPAJSeYBqzy2+3nI+nXs3lmkomgEWQAQZJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BcyZyXqX2CibLBsjO2p/Ij3BzWLvtYhdjh2qljyuaNrqINslX8G1dbV0kWj4eZKLw6
         +4goYxW5YQqKmY7uJZFUpwhyEx4r0kDKhmFj0ZvQEi/m3QMuPhT1CzK/U3LOCdCY6RzO
         a63mcs6ghWXkSSwYVWM6mjtwK9vWLQtLiyPgY=
Received: by 10.114.112.4 with SMTP id k4mr1763603wac.140.1244924507821;
        Sat, 13 Jun 2009 13:21:47 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id g25sm3258246wag.43.2009.06.13.13.21.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 13:21:47 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 13 Jun 2009 13:21:44 -0700
X-Mailer: git-send-email 1.6.3.2.225.gb8364
In-Reply-To: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121520>

git-rebase will use this when invoked with -q.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |    6 +++++-
 git-am.sh                |   27 ++++++++++++++++++++++-----
 t/t4150-am.sh            |    7 +++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6d92cbe..32e689b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject]
+	 [--reject] [-q | --quiet]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
@@ -39,6 +39,10 @@ OPTIONS
 --keep::
 	Pass `-k` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
 
+-q::
+--quiet::
+	Be quiet. Only print error messages.
+
 -u::
 --utf8::
 	Pass `-u` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
diff --git a/git-am.sh b/git-am.sh
index 578780b..f04aca5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -11,6 +11,7 @@ git am [options] (--resolved | --skip | --abort)
 i,interactive   run interactively
 b,binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
+q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
@@ -52,6 +53,16 @@ stop_here () {
     exit 1
 }
 
+quiet=
+
+say ()
+{
+    if test -z "$quiet"
+    then
+	echo $@
+    fi
+}
+
 stop_here_user_resolve () {
     if [ -n "$resolvemsg" ]; then
 	    printf '%s\n' "$resolvemsg"
@@ -99,7 +110,7 @@ fall_back_3way () {
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "Repository lacks necessary blobs to fall back on 3-way merge."
 
-    echo Using index info to reconstruct a base tree...
+    say Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
 	git apply --cached <"$dotest/patch"
     then
@@ -115,7 +126,7 @@ It does not apply to blobs recorded in its index."
     orig_tree=$(cat "$dotest/patch-merge-base") &&
     rm -fr "$dotest"/patch-merge-* || exit 1
 
-    echo Falling back to patching base and 3-way merge...
+    say Falling back to patching base and 3-way merge...
 
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
@@ -125,6 +136,10 @@ It does not apply to blobs recorded in its index."
 
     eval GITHEAD_$his_tree='"$FIRSTLINE"'
     export GITHEAD_$his_tree
+    if test -n "$quiet"
+    then
+	    export GIT_MERGE_VERBOSITY=0
+    fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere
 	    echo Failed to merge in the changes.
@@ -181,6 +196,8 @@ do
 		committer_date_is_author_date=t ;;
 	--ignore-date)
 		ignore_date=t ;;
+	-q|--quiet)
+		quiet=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -352,7 +369,7 @@ fi
 
 if test "$this" -gt "$last"
 then
-	echo Nothing to do.
+	say Nothing to do.
 	rm -fr "$dotest"
 	exit
 fi
@@ -498,7 +515,7 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying: %s\n' "$FIRSTLINE"
+	say "Applying: $FIRSTLINE"
 
 	case "$resolved" in
 	'')
@@ -534,7 +551,7 @@ do
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			echo No changes -- Patch already applied.
+			say No changes -- Patch already applied.
 			go_next
 			continue
 		    }
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d6ebbae..f8725a9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -305,4 +305,11 @@ test_expect_success 'am into an unborn branch' '
 	test "z$result" = "z$(git rev-parse first^{tree})"
 '
 
+test_expect_success 'am -q is quiet' '
+	git checkout first &&
+	test_tick &&
+	git am -q <patch1 > output.out &&
+	test ! -s output.out
+'
+
 test_done
-- 
1.6.3.2.225.gb8364
