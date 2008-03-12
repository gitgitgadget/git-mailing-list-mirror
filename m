From: Jeff King <peff@peff.net>
Subject: [PATCH 14/16] filter-branch: use $SHELL_PATH instead of 'sh'
Date: Wed, 12 Mar 2008 17:41:39 -0400
Message-ID: <20080312214139.GO26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYig-0002rw-0l
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbYCLVlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYCLVlm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:41:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYCLVlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:41:42 -0400
Received: (qmail 3683 invoked by uid 111); 12 Mar 2008 21:41:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:41:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:41:39 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77005>

On some systems, 'sh' isn't very friendly. In particular,
t7003 fails on Solaris because it doesn't understand $().
Instead, use the specified SHELL_PATH to run shell code.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this makes sense regardless of the Solaris shell. We should be
consistent about which SHELL_PATH we use in scripts.

 Makefile             |    1 +
 git-filter-branch.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8e80225..bd5a623 100644
--- a/Makefile
+++ b/Makefile
@@ -874,6 +874,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index efef732..22b6ed4 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -309,7 +309,7 @@ while read commit parents; do
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
-	sh -c "$filter_commit" "git commit-tree" \
+	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		$(git write-tree) $parentstr < ../message > ../map/$commit
 done <../revs
 
-- 
1.5.4.4.543.g30fdd.dirty
