From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 17:31:30 +0000
Message-ID: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:00:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4e9B-0005pV-OD
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab1C2TAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:00:01 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58076 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab1C2TAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:00:00 -0400
Received: by qwk3 with SMTP id 3so340888qwk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id;
        bh=SBUIdNmmbk+z3vGArpwb+ITLKref8Em4xKWTq+HxxUg=;
        b=nRrWbtI/wCX1sucI60kC2fLdIhts+jP/dPhOmwlchAnQCCKftVTxtLsUlfqsFebdLF
         iXCX88hanfwXfYmAKQuPMQJXFL/xNPKtqz2beihT74hvqG4N+VAPMwTH3p9BOjYkL50n
         Kx/FYGphlWOuHzr77yoYxDyIRiHZg9QiknZhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id;
        b=QbszOncircarUixNJLTZFHeAldh3Br2Ol6KBmsjJ1l24Cel+jEbEadnwffK+h9Z6aG
         1/gjEKFZ9a6xw3B5qJ1An6/Ye5MnK+TMIbtlbbw13qbh/yfn3Y+LdOaDq3dvpiPNnG5L
         R8C8aT2emcRGwlriXG08t7XlCsYpRthevg69M=
Received: by 10.224.188.82 with SMTP id cz18mr197598qab.130.1301425199464;
        Tue, 29 Mar 2011 11:59:59 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id l17sm3608446qck.20.2011.03.29.11.59.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:59:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170307>

Currently, building git with:

  CFLAGS="-std=c99 -pedantic -Wall -Werror -g -02"

causes gcc 4.5.2 to fail with:

  vcs-svn/svndump.c:217:3: error: ISO C forbids 'return' with
                                  expression, in function
                                  returning void

The line in question is this:

  return repo_delete(node_ctx.dst);

Because repo_delete returns void (vcs-svn/repo_tree.h:19):

  void repo_delete(uint32_t *path);

it would seem like it would be OK, but I guess the
C99 standard is quite particular:

  6.8.6.4.1:
  A return statement with an expression shall not appear in
  a function whose return type is void. A return statement
  without an expression shall only appear in a function
  whose return type is void.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 vcs-svn/svndump.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index eef49ca..572a995 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -214,7 +214,8 @@ static void handle_node(void)
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		return repo_delete(node_ctx.dst);
+		repo_delete(node_ctx.dst);
+		return;
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
 		repo_delete(node_ctx.dst);
-- 
1.7.4.2.417.g32d76d
