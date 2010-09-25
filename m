From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v1] stash show: fix breakage in 1.7.3
Date: Sat, 25 Sep 2010 13:32:01 +1000
Message-ID: <1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 05:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzLRj-0004o0-Jc
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 05:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0IYD3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 23:29:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44490 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0IYD3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 23:29:00 -0400
Received: by pzk34 with SMTP id 34so790145pzk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bB+ggPkspAJW/jXBjT5ejEcMWcslHZoZ/y96oawHibQ=;
        b=o001d6TjhUds4V+7R3UFbKMry0wYTkUglxDCWrBQTqa9WvizgoSwovd44QIC53EVZf
         px42q90itcascSk8xUBMNTnUcnEEZoHXR/yQ1j0Kzd3bkjjXmawgwYe/xKRxPamvI+0G
         0Lm8d64aPRbyiQEQeiwxuFpy4YpSzmPtkoKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F6d/ShMc1AH25/Io9O0YPdBMa+c/QjI8inOZTgzFedwk8vSrW7Z3KWMUIaRvnKnQN8
         TmAjT6r6B22oOSfdTEUgDc+JjInHr4uXKlPIEOP/9pqG5G+fRwE+NbaB+V3JoXVREY8j
         GHuV6Jg5zB0QEm6VRpPjny+SXDovQ3chf37v4=
Received: by 10.142.249.19 with SMTP id w19mr3570694wfh.189.1285385340055;
        Fri, 24 Sep 2010 20:29:00 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id u16sm3185762wfg.20.2010.09.24.20.28.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 20:28:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.14.g132f5.dirty
In-Reply-To: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157111>

The detached-stash series regressed support for
   git stash show stash@{0}

due to a faulty assumption that:
   git rev-parse --no-revs -- stash@{0}

would treat stash@{0} as a revision reference and
thus not output it.

This patch restores the behaviour of git stash show
so that git rev-parse is not used for parsing flags
and only flag like options are assigned to
the FLAGS variable.

It has been tested with Brandon Casey's improved t3903 tests.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

This revision further simplifies the parsing code
by removing use of git rev-parse for FLAGS parsing
altogether.

diff --git a/git-stash.sh b/git-stash.sh
index 7ce818b..8b18bb5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -265,9 +265,6 @@ parse_flags_and_rev()
 	i_tree=
 
 	REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
-	FLAGS=$(git rev-parse --no-revs -- "$@" 2>/dev/null)
-
-	set -- $FLAGS
 
 	FLAGS=
 	while test $# -ne 0
@@ -282,7 +279,7 @@ parse_flags_and_rev()
 			--)
 				:
 			;;
-			*)
+			-*)
 				FLAGS="${FLAGS}${FLAGS:+ }$1"
 			;;
 		esac
-- 
1.7.2.14.g132f5.dirty
