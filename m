From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Use "get_default_remote" from git-parse-remote
Date: Sun, 24 Aug 2008 14:46:10 -0400
Message-ID: <1219603570-516-1-git-send-email-mlevedahl@gmail.com>
References: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 24 20:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKcT-0000V6-No
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbYHXSqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYHXSqR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:46:17 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:14354 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYHXSqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:46:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so183481and.103
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hiHOmYL6FrYRiXmhD+Y+j/xNz+9PQRIc98MCAiiKyU8=;
        b=N56DUwZEbkHVXMniMmerOrbWfY4k93ES2PnAujylZxjBxF14XT/SDG/Esz3sc0pRIC
         YYaPttZnTvfn5DFYh8omfGBdge++DI88kOB11ZhyaRtLluiUOora93mq7dHaub/88w9t
         MYXjjxWwgGJIahidgvfQIleh5gN6Ls+3YYF3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=srg6SughXlZvbh0FiP/Pd6Xh6WyAkFeWQ/npWHO0figPC5GNDqreSgig/NncBhZMsc
         ZPAvTG5dNLkpKI6glok21Jul04NLjVRxAfpbjJgUOoNmZdHL4vdO7mIAFwlkgXaHWU8D
         NH+vmtvtDHxWGcOijl2DvM2VnNz8ojV+hX+Rk=
Received: by 10.100.58.2 with SMTP id g2mr3221544ana.6.1219603575193;
        Sun, 24 Aug 2008 11:46:15 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id b14sm6114353ana.23.2008.08.24.11.46.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 11:46:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.127.gf1d7c
In-Reply-To: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93546>

Resolve_relative_url was using its own code for this function, but
this is duplication with the best result that this continues to work.
Replace with the common function provided by git-parse-remote.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---

I think it makes more sense to use the facility provided elsewhere rather
than duplicate. (I've had this patch in my tree for quite a while, never
really had a reason to submit it.)


 git-submodule.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a3a197..59fe7b3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,6 +9,7 @@ USAGE="[--quiet] [--cached] \
 [--] [<path>...]|[foreach <command>]"
 OPTIONS_SPEC=
 . git-sh-setup
+. git-parse-remote
 require_work_tree

 command=
@@ -30,9 +31,7 @@ say()
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
-	branch="$(git symbolic-ref HEAD 2>/dev/null)"
-	remote="$(git config branch.${branch#refs/heads/}.remote)"
-	remote="${remote:-origin}"
+	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
--
1.6.0.127.gf1d7c
