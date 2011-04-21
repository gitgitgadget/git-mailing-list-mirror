From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] submodule update: continue when an update fails
Date: Thu, 21 Apr 2011 10:53:21 +0200
Message-ID: <20110421085321.GA14057@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 10:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCpQE-0004Yz-G7
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 10:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab1DUIj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2011 04:39:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62623 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab1DUIj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 04:39:27 -0400
Received: by eyx24 with SMTP id 24so444624eyx.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:subject:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wVXb4sVSsdPrxMe4vOx93GVN4o8W0n2zoFnkHUcC6kk=;
        b=OzaJ1rszJrNpncHjHS8SL7HjAlruyyQuLGRUMTXErQS0J5pxDzQlxHvD9RkqnFH+0N
         XVdM1HA/s0NED05sjzINdnhe+gMaXujHOvm3gGzFwWtB0RS1tECryWaz+OEWen69yCx3
         rNEtTOvvoxqbuTBZkyFH+PtlJ0lFKDPMtkJow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=RtrIeQaaugFcudNZqCTkjkBF8JDBFpa1pZmJsdzbPDwt5jW5QcoY7uQ3RPkZKpNTA7
         bI+tPMEMuRD1uUEeT7OTvBkYwdKe4Wl51hp31jWB/lG2uH2khMA249tVrCyUj1JyrNjX
         n/XWmr5h7KPDl8d+CifjdFfl4JTdkKYQWCriY=
Received: by 10.14.13.194 with SMTP id b42mr2929516eeb.31.1303375165888;
        Thu, 21 Apr 2011 01:39:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id k51sm1200180eei.3.2011.04.21.01.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 01:39:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QCpdZ-0003ik-5Z
	for git@vger.kernel.org; Thu, 21 Apr 2011 10:53:21 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171895>

Hi,
when running git submodule update the scripts stop after failing to
fetch an submodule. This is errornous because this implies that if a
submodule 'a' isn't availiable then submodule 'x' shouldn't be loaded.
This implies a relationship that isn't definied within git.

There's three different ways to solve this (because the script is runne=
d
as a childprocess of the git-submodule.sh script):

1. use a global variable (via the export command) to share data between
 processes.
2. Print outdata from the childprocess to stdout and read it via a pipe
 in the parent process.
3. Do all error handling in the child process

I've choosen alternative 3 as it seams to have the smallest impact.


=46rom 7ba07dcfdd99c14522946e923ec63bd0bcd60021 Mon Sep 17 00:00:00 200=
1
=46rom: Fredrik Gustafsson <iveqy@iveqy.com>
Date: Mon, 18 Apr 2011 23:08:59 +0200
Subject: [PATCH] submodule update: continue when an update fails

git submodule update dies when a remote reference isn't a tree. Instead
of dying, print an error message and continue update the next submodule
(and die when all modules are done if there was any errors).

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b010a67..06ff7f2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -441,7 +441,8 @@ cmd_update()
 	fi
=20
 	cloned_modules=3D
-	module_list "$@" |
+	err=3D
+	module_list "$@" | {
 	while read mode sha1 stage path
 	do
 		if test "$stage" =3D U
@@ -521,17 +522,32 @@ cmd_update()
 				;;
 			esac
=20
-			(clear_local_git_env; cd "$path" && $command "$sha1") ||
-			die "Unable to $action '$sha1' in submodule path '$path'"
-			say "Submodule path '$path': $msg '$sha1'"
+			if (clear_local_git_env; cd "$path" && $command "$sha1")
+			then
+				   say "Submodule path '$path': $msg '$sha1'"
+			else
+				   say "Unable to $action '$sha1' in submodule path '$path'"
+				   err=3D"Failed to $action one or more submodule(s)"
+				   continue
+			fi
 		fi
=20
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") =
||
-			die "Failed to recurse into submodule path '$path'"
+			if !(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flag=
s")
+			then
+				say "Failed to recurse into submodule path '$path'"
+				continue
+			fi
 		fi
+
+	if test -n "$err"
+	then
+		die $err
+	fi
+
+	}
 }
=20
 set_name_rev () {
--=20
1.7.5.rc0.133.gcc4dd.dirty

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
