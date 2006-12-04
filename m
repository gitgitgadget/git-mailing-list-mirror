X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <loeffler@ls-itc.de>
Subject: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Mon, 04 Dec 2006 20:38:22 +0100
Message-ID: <1165261102.20055.9.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:38:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33227>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJe9-00004z-G4 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759339AbWLDTif (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759442AbWLDTie
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:38:34 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:46116 "EHLO mx01.ap-wdsl.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759339AbWLDTie
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:38:34 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The trailing / is enough to decide if this should map everything under
refs/heads/ to refs/somewhere/.

The "*" should be reserved for the use as regex operator.

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---
I want to use regular expressions to match remote refs, so I try to
implement this. But the current globfetch syntax needs the '*'.

Maybe it is not to late to change the syntax to this:
Pull: refs/heads/:refs/remotes/origin/

What do you think?


diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index da064a5..38af4cb 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -101,13 +101,13 @@ expand_refs_wildcard () {
 	do
 		lref=${ref#'+'}
 		# a non glob pattern is given back as-is.
-		expr "z$lref" : 'zrefs/.*/\*:refs/.*/\*$' >/dev/null || {
+		expr "z$lref" : 'zrefs/.*/:refs/.*/$' >/dev/null || {
 			echo "$ref"
 			continue
 		}
 
-		from=`expr "z$lref" : 'z\(refs/.*/\)\*:refs/.*/\*$'`
-		to=`expr "z$lref" : 'zrefs/.*/\*:\(refs/.*/\)\*$'`
+		from=`expr "z$lref" : 'z\(refs/.*/\):refs/.*/$'`
+		to=`expr "z$lref" : 'zrefs/.*/:\(refs/.*/\)$'`
 		local_force=
 		test "z$lref" = "z$ref" || local_force='+'
 		echo "$ls_remote_result" |
-- 
1.4.4


