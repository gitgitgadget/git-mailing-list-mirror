From: Stephen Boyd <bebarino@gmail.com>
Subject: [RFC/PATCH] completion: complete pretty format placeholders
Date: Sat, 16 May 2009 03:07:29 -0700
Message-ID: <1242468449-3364-1-git-send-email-bebarino@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 12:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Gnt-0002YC-Fw
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 12:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbZEPKHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 06:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbZEPKHc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 06:07:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:49582 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZEPKHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 06:07:32 -0400
Received: by wa-out-1112.google.com with SMTP id j5so839238wah.21
        for <git@vger.kernel.org>; Sat, 16 May 2009 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=lz0qrgOU6LZqHbYRQK0pdQQTajNlJfQ6uBUrdshfqzs=;
        b=DKhKnpKMafYCcNG04CxqlmLaaLhKOJLrjvlbgPG2ONPhq1tIxyoOczOGlZsF8AmzQK
         XytCDMsXIvtBmAHmFMOAUTx4bCgA/2EeGsRCDVi3K1p5mRWdvx00g5P+ekmTYZtP9cY6
         0ZMyZvaaHlsmKcO8mHVW15l9lxt9s8dnZ+wjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MX8UxqWiyQvBPuKE1VSZZ8OXxscSgKUbB5p8ZohwHZlzMz0WL+0/TSjOm3LjE8d+iK
         QQADpWjJdHTBbIFz2KD67VeQ5r3KVau5IyQMFHla+uuD37HM40rucmISE0Y7DHVeBV/E
         XTNg3G8LkWI+50U7tkN+bsGYakTBSvu/kt4pM=
Received: by 10.115.110.15 with SMTP id n15mr6736471wam.16.1242468453352;
        Sat, 16 May 2009 03:07:33 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k35sm2443960waf.22.2009.05.16.03.07.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 03:07:32 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 16 May 2009 03:07:29 -0700
X-Mailer: git-send-email 1.6.3.1.9.g95405b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119350>

---

 This seems to work most of the time.

 This
    git log --pretty=format:%ad:%<TAB>
 becomes
    git log --pretty=format:%ad:%ad:% 
 which is wrong.

 But in quotes
    git log --pretty=format:"%ad:%<TAB>
 works.

 I'm not sure why.
 
 Also git log --pretty=%<TAB> doesn't work. I'm not sure how to support
 that without encountering the same breakage as above.

 contrib/completion/git-completion.bash |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad26b7c..3819c73 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1117,6 +1117,9 @@ __git_log_shortlog_options="
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
 __git_log_date_formats="relative iso8601 rfc2822 short local default raw"
+__git_log_format_placeholders="ad aD ae aE ai an aN ar at b Cblue cd cD ce cE
+Cgreen ci cn cN cr Cred Creset ct d e f h H m n p P s t T x
+"
 
 _git_log ()
 {
@@ -1129,6 +1132,17 @@ _git_log ()
 		merge="--merge"
 	fi
 	case "$cur" in
+	--pretty=format:*%*|--format=format:*%*)
+		local pfx="${cur%\%*}%"
+		pfx="${pfx#*:}"
+		cur="${cur##*%}"
+		__gitcomp "$__git_log_format_placeholders
+			" "$pfx" "$cur"
+		return
+		;;
+	--pretty=format:*|--format=format:*)
+		return
+		;;
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=}"
@@ -1814,6 +1828,17 @@ _git_show ()
 
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	--pretty=format:*%*|--format=format:*%*)
+		local pfx="${cur%\%*}%"
+		pfx="${pfx#*:}"
+		cur="${cur##*%}"
+		__gitcomp "$__git_log_format_placeholders
+			" "$pfx" "$cur"
+		return
+		;;
+	--pretty=format:*|--format=format:*)
+		return
+		;;
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=}"
-- 
1.6.3.1.9.g95405b
