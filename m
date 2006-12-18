X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Mon, 18 Dec 2006 03:09:41 -0500
Message-ID: <20061218080941.GA3857@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 08:09:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34727>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDZD-0002cu-It for gcvg-git@gmane.org; Mon, 18 Dec
 2006 09:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753494AbWLRIJo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbWLRIJo
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 03:09:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:41749
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1753494AbWLRIJn (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 03:09:43 -0500
Received: (qmail 26463 invoked from network); 18 Dec 2006 03:09:42 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 18 Dec 2006 03:09:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec
 2006 03:09:41 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Bash and dash parse "${name%'^{}'}" differently, with bash quoting the
^{}, and dash assuming the first } is the end of the variable (and thus
tacking '} to the end). Instead, use backslash to quote the closing
brace.

Signed-off-by: Jeff King <peff@peff.net>
---
Please sanity check that I understand what the code is supposed to be
doing. The bug I was getting was this:

$ readlink /bin/sh
dash
$ git-clone git://git.kernel.org/pub/scm/git/git.git
[...]
$ cd git && git-pull
Warning: No merge candidate found because value of config option
         "branch.master.merge" does not match any remote branch fetched.

A shell trace showed lots of tests against strings like
"refs/heads/master'}". Expand_refs_wildcard returned no entries, so it
couldn't match the branch.master.merge field.

 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index f27c3c2..ab79042 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -116,7 +116,7 @@ expand_refs_wildcard () {
 			while read sha1 name
 			do
 				mapped=${name#"$from"}
-				if test "z$name" != "z${name%'^{}'}" ||
+				if test "z$name" != "z${name%'^{\}'}" ||
 					test "z$name" = "z$mapped"
 				then
 					continue
-- 
