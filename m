From: Jeff King <peff@peff.net>
Subject: [PATCH] allow git-am to run in a subdirectory
Date: Sat, 1 Mar 2008 01:22:55 -0500
Message-ID: <20080301062255.GA27538@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVL8A-0006HP-1B
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 07:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbYCAGW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 01:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbYCAGW6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 01:22:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3725 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbYCAGW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 01:22:57 -0500
Received: (qmail 5225 invoked by uid 111); 1 Mar 2008 06:22:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 01:22:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 01:22:55 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75625>

We just move to the top of the tree and proceed. This
shouldn't break any existing callers, since the behavior was
previously disallowed.

Signed-off-by: Jeff King <peff@peff.net>
---
I can't imagine anyone would be confused by this behavior. The only
other behavior that would make sense is perhaps trying to apply from the
given prefix rather than moving to the toplevel, but that just seems
crazy and useless to me.

It will fail to find your mbox file if you specified a relative path
and it had to change directories. I don't know if that case is worth
handling.

My use case, btw, is that I have an "apply this patch" macro in my MUA.
For some messages, it's easy to guess "cd /my/git/repo && git am". But
for others, the repo is not obvious, so I apply in the current
directory. If I am at the root of the repo, it works fine. If I'm not,
then it fails annoyingly.

 git-am.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2ecebc4..a2c6fea 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
+SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git-am [options] <mbox>|<Maildir>...
@@ -25,6 +26,7 @@ skip            skip the current patch"
 . git-sh-setup
 set_reflog_action am
 require_work_tree
+cd_to_toplevel
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
-- 
1.5.4.3.422.g55194
