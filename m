From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Fri, 12 Nov 2010 20:38:28 +0100
Message-ID: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, santi@agolina.net
X-From: git-owner@vger.kernel.org Sat Nov 13 02:39:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH555-0008PZ-KC
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 02:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0KMBio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 20:38:44 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41271 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab0KMBin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 20:38:43 -0500
Received: by vws13 with SMTP id 13so1205694vws.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vNwt3WYii/x/SmgBbv+RLyFk8F6hbKuDVQks4yyQlu8=;
        b=jkeYm2KWNsQ5uUy/FrVitphVkDvIQ/jQ02uA6C2Vroydc4DN1Sk8xT1GEStkvNIfhk
         YfD0vRkqrbjjW3oTf8ZH22vrQCTDSaqivxDSzqxxEwVwTvXkDg7C/mc9DlwTLhozPtmo
         broBkQO/njXkkxE4EJOsx0A9FYNdaB7kYQECI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PRR5SstkdtSwuj0cMt2rRM40dEeU5XlHO08AV/SQ9SMKkvuWsK99e6obsSbbKqnpvs
         4g8M/n2BahKz2UI2CzzehFrYT94hxdbTIpVsdz5qiC4ZSouD3q9xRfAnWojs5Uy5DYB9
         Jjm1njE9JFoxzFugyasZLu+WAYXH4UN/FN95o=
Received: by 10.220.200.6 with SMTP id eu6mr644627vcb.133.1289612322575;
        Fri, 12 Nov 2010 17:38:42 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q3sm1108506vcr.27.2010.11.12.17.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 17:38:42 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161378>

Since c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), "git pull --rebase" has used the reflog to try to
rebase from the old upstream onto the new upstream.

Make this work if the local repository is explicitly passed on the
command line as in 'git pull --rebase . foo'.
---
I removed some seemingly unnecessary variables. I couldn't find any uses
of them in the callers' code either, so it should be safe...

I apparently introduced a call to sed as well. I think I remember seeing
some guideslines about the use of sed in Git, but I can't remember what.
I couldn't find anything in the CodingGuidelines either. Is the code
below ok?

 git-parse-remote.sh |   24 ++++++++++--------------
 t/t5520-pull.sh     |    7 +++++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..0565edd 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -63,33 +63,29 @@ get_default_remote () {
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
-	    origin="$1"
-	    default=$(get_default_remote)
-	    test -z "$origin" && origin=$default
 	    curr_branch=$(git symbolic-ref -q HEAD)
-	    [ "$origin" = "$default" ] &&
+	    test -z "$1" || test "$1" = $(get_default_remote) &&
 	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
 	    ;;
 	*)
 	    repo=$1
 	    shift
-	    ref=$1
 	    # FIXME: It should return the tracking branch
 	    #        Currently only works with the default mapping
-	    case "$ref" in
-	    +*)
-		ref=$(expr "z$ref" : 'z+\(.*\)')
-		;;
-	    esac
-	    expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
-	    remote=$(expr "z$ref" : 'z\([^:]*\):')
+	    remote=$(echo "$1" | sed -e 's|+\?\([^:]*\):\?|\1|g')
 	    case "$remote" in
 	    '' | HEAD ) remote=HEAD ;;
 	    heads/*) remote=${remote#heads/} ;;
 	    refs/heads/*) remote=${remote#refs/heads/} ;;
 	    refs/* | tags/* | remotes/* ) remote=
 	    esac
-
-	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+	    [ -n "$remote" ] && case "$repo" in
+		.)
+		    echo "refs/heads/$remote"
+		    ;;
+		*)
+		    echo "refs/remotes/$repo/$remote"
+		    ;;
+	    esac
 	esac
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0b489f5..0470a81 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -222,4 +222,11 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	)
 '
 
+test_expect_success 'git pull --rebase against local branch' '
+	git checkout -b copy2 to-rebase-orig &&
+	git pull --rebase . to-rebase &&
+	test "conflicting modification" = "$(cat file)" &&
+	test file = "$(cat file2)"
+'
+
 test_done
-- 
1.7.3.2.167.ga361b
