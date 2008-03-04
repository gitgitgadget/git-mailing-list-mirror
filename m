From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix 'git remote show' regression on empty repository in 1.5.4
Date: Tue, 4 Mar 2008 01:00:36 -0500
Message-ID: <20080304060036.GA17106@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 07:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWQDN-0007Sr-2E
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 07:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbYCDGAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 01:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYCDGAl
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 01:00:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33337 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYCDGAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 01:00:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWQCb-00060q-44; Tue, 04 Mar 2008 01:00:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D61720FBAE; Tue,  4 Mar 2008 01:00:36 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76036>

Back in 18f7c51c we switched git-ls-remote/git-peek-remote to
use the transport backend, rather than do everything itself.

As part of that switch we started to produce a non-zero exit
status if no refs were received from the remote peer, which
happens when the remote peer has no commits pushed to it yet.
(E.g. "git --git-dir=foo.git init; git ls-remote foo.git")

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This patch is built against `maint`.

 It will cause a merge conflict against `master` as there is a
 change there to invoke transport_disconnect(transport) before
 displaying the refs.

 Since the disconnect patch is not in maint, but this is a current
 regression in 1.5.4.3, I'm sending you a conflicting patch.  :)

 As far as resolving this when it merges to master, the return value
 of transport_disconnect() is probably what should be checked to
 signal a non-zero exit status to the caller, not the empty ref list.

 builtin-ls-remote.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 6dd31d1..720280e 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -94,10 +94,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
 	ref = transport_get_remote_refs(transport);
-
-	if (!ref)
-		return 1;
