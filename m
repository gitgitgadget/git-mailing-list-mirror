From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix "git tag -u" breakage
Date: Tue, 30 Jan 2007 20:00:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301957320.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 05:00:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC6e9-000322-HM
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 05:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbXAaEA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 23:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbXAaEA3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 23:00:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36162 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803AbXAaEA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 23:00:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0V40N9V006982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 20:00:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0V40MS8006838;
	Tue, 30 Jan 2007 20:00:23 -0800
X-Spam-Status: No, hits=-0.476 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38225>


The recent cleanup to understand

	[user]
		signingkey = ..

sadly broke the old "-u signingkey" syntax. Admittedly the config file 
approach is nicer, and I should probably use it, but even so, there's 
really no reason to break the old syntax either.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This fixes it for me, and _looks_ obvious enough, but I didn't actually 
test the other cases (ie tagger name and the config file). Caveat patchor.

diff --git a/git-tag.sh b/git-tag.sh
index 988bf4c..c2c57d5 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -115,6 +115,7 @@ tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
 keyid=$(git-repo-config user.signingkey) ||
 	keyid=$(expr "z$tagger" : 'z\(.*>\)')
+username=${username:-$keyid}
 
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 
@@ -141,7 +142,7 @@ if [ "$annotate" ]; then
       cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
     rm -f "$GIT_DIR"/TAG_TMP.asc "$GIT_DIR"/TAG_FINALMSG
     if [ "$signed" ]; then
-	gpg -bsa -u "$keyid" "$GIT_DIR"/TAG_TMP &&
+	gpg -bsa -u "$username" "$GIT_DIR"/TAG_TMP &&
 	cat "$GIT_DIR"/TAG_TMP.asc >>"$GIT_DIR"/TAG_TMP ||
 	die "failed to sign the tag with GPG."
     fi
