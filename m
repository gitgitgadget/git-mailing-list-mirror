From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Simplify packing public repositories
Date: Tue, 16 May 2006 14:46:35 +0300
Message-ID: <20060516144635.010bb65f.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 13:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffxys-0005cV-Pg
	for gcvg-git@gmane.org; Tue, 16 May 2006 13:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWEPLos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 07:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWEPLos
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 07:44:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:22433 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751791AbWEPLor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 07:44:47 -0400
Received: by nf-out-0910.google.com with SMTP id y38so53283nfb
        for <git@vger.kernel.org>; Tue, 16 May 2006 04:44:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HrxclQToTrBatTb3jxzcpVfOM3EInpl3iEHjkQIR5puy6O31SDMTpgpobs5CJd0zl2THMNenAKHlNB/vmzT1HEaMGwP7BnpJfUoS+tIwb5gDAfsUUN1YbIH7i/CU1ulWgManRDFlKN3VvNlv9xdwtVFRmfK9E7IK4rhYWsOwoMs=
Received: by 10.49.41.5 with SMTP id t5mr4376251nfj;
        Tue, 16 May 2006 04:44:45 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id m15sm41263nfc.2006.05.16.04.44.44;
        Tue, 16 May 2006 04:44:45 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20117>

Support "git repack project.git" syntax which is more intuitive than
using the GIT_DIR environment variable.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 git-repack.sh |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

c09c41750023e5b502312ddaa21bf5a2371e66ac
diff --git a/git-repack.sh b/git-repack.sh
index 4fb3f26..b24cd1a 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,8 +3,8 @@ #
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
-. git-sh-setup
+unset CDPATH
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [GIT_DIR]'
 
 no_update_info= all_into_one= remove_redundant=
 local= quiet= no_reuse_delta= extra=
@@ -19,11 +19,32 @@ do
 	-l)	local=--local ;;
 	--window=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
-	*)	usage ;;
+	-h|--h|--he|--hel|--help)
+		echo "Usage: $0 $USAGE"
+		exit
+		;;
+	*)
+		if test "$#" -gt 1
+		then
+			echo >&2 "Usage: $0 $USAGE"
+			exit 1
+		fi
+		export GIT_DIR="$1"
+		;;
 	esac
 	shift
 done
 
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+
+# Make sure we are in a valid repository of a vintage we understand.
+GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
+if test $? = 128
+then
+    exit
+fi
+
 rm -f .tmp-pack-*
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
 
-- 
1.3.3.g8701-dirty
