From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] git pull cannot find remote refs.
Date: Mon, 27 Feb 2006 22:49:37 +0100
Organization: -no organization-
Message-ID: <20060227214936.GA7205@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 27 22:49:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDqFT-0007Zd-64
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 22:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWB0Vtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 16:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWB0Vtk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 16:49:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:2242 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751196AbWB0Vtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 16:49:40 -0500
Received: from [84.134.64.161] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu9) with ESMTP (Nemesis),
	id 0ML2xA-1FDqFO2KJt-0003O2; Mon, 27 Feb 2006 22:49:39 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3) with ESMTP id k1RLnbEI012097
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 22:49:37 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id k1RLnbfu012094
	for git@vger.kernel.org; Mon, 27 Feb 2006 22:49:37 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88/1305/Mon Feb 27 20:07:49 2006 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16886>

[PATCH] git pull cannot find remote refs.

When getting new data from an archive with 'git pull' I sometimes got the
message

fatal: unexpected EOF
Failed to find remote refs
Already up-to-date.

Tracking it down, I found a gap between how git-ls-remote prints out the tags
and git-fetch scans them with sed. Looking at the code of git-ls-remote the
there is an tab character between the sha1 and the refname, while there is a
space and a tab character in the regular expression for th sed command.

As a result the while where all is piped in cannot read the two values.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

---

I'm not sure if the solution is the best, because info sed say '\t' is not portable,
so perhaps it will be better to correct it another way?

Comments?

 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

92905634295ea29a59c773c634197cc029839883
diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..c7b38b2 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -375,7 +375,7 @@ case "$no_tags$tags" in
 		# using local tracking branch.
 		taglist=$(IFS=" " &&
 		git-ls-remote $upload_pack --tags "$remote" |
-		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
+		sed -ne 's|^\([0-9a-f]*\)[\t]\(refs/tags/.*\)^{}$|\1 \2|p' |
 		while read sha1 name
 		do
 			test -f "$GIT_DIR/$name" && continue
-- 
1.2.3.gc55f


-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
