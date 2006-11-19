X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr 'Patch Proxy' Baudis <pasky@ucw.cz>
Subject: [PATCH] git-fetch.sh: fix fetching of tags that point directly to commits
Date: Sun, 19 Nov 2006 03:59:21 +0100
Message-ID: <20061119025921.GU7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 03:01:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31823>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glcu8-0000RD-0b for gcvg-git@gmane.org; Sun, 19 Nov
 2006 03:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755686AbWKSC7X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 21:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755737AbWKSC7X
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 21:59:23 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46001 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755618AbWKSC7W (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 21:59:22 -0500
Received: (qmail 8952 invoked by uid 2001); 19 Nov 2006 03:59:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-fetch used to fetch only tags that pointed to tag objects,
because it required a ^{} suffix from git-ls-remote's output.

Not signed off.
---

For similar issue in Cogito, please see

	http://news.gmane.org/find-root.php?message_id=<20060427105251.AA4B2353DAC@atlas.denx.de>

Curiously enough, Junio himself posted a patch. Perhaps given his state
as of then he forgot to fix Git as well. ;-)

I did not write this patch. One fellow IRCer did, but for personal
reasons he does not wish to disclose his realname. I think the patch is
trivial enough that copyright problems should not be a issue.

 git-fetch.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 7442dd2..9074b3f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -430,9 +430,13 @@ case "$no_tags$tags" in
 	*:refs/*)
 		# effective only when we are following remote branch
 		# using local tracking branch.
-		taglist=$(IFS=" " &&
+		# If we get both refs/tags/foo and refs/tags/foo^{},
+		# use only the latter and strip the ^{} suffix.
+		taglist=$(
+		IFS=" "; export LC_COLLATE=C
 		git-ls-remote $upload_pack --tags "$remote" |
-		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
+		sed -ne 's|^\([0-9a-f]*\)[ \t]\(refs/tags/.*\)$|\1 \2|p' |
+		sort -k2 -r | sed -e 's/\^{}$//' | uniq -f1 |
 		while read sha1 name
 		do
 			git-show-ref --verify --quiet -- $name && continue

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
