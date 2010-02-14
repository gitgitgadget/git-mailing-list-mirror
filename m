From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 06:07:31 -0600
Message-ID: <20100214120731.GE3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgdGG-0004Jn-0L
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482Ab0BNMHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 07:07:35 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:40817 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457Ab0BNMHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:07:34 -0500
Received: by iwn39 with SMTP id 39so1364464iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ekW9YCmPjUMg5FEUCwaq8XzCA/wCLrDJJKdxh2HD/PQ=;
        b=xoN8m3ZnNL9hVyxkii8HVe7sxh9S0B6lQ743Qzx6+xca9ON9Absa9t+NPhihrw4Y1s
         J1YYrl+SRsm2QnPL2/Z3NYO/lWfftZ+R8VnUd1mzZ+nwE10a4WSy7si4a1AWZKyVrK9J
         G3xS265FRuUWGzJF9vlnVGhEagw15ery3CTvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WH2AmvYk3m1DLoXPtoS5d/AyQ87Q8oRAFFI7A+097MlEtQoqXsoVSvhzQZhygG6TZx
         mt+othn0nGYP1gmcTcJIpUupzbv5NZk6PNd0pFR3+hczUVH7+LWAie8Isg/En9NPS04q
         /O8uLrUBmCNa4Y11yNngiytSzNXE5WUMnINwI=
Received: by 10.231.160.149 with SMTP id n21mr1688545ibx.93.1266149253649;
        Sun, 14 Feb 2010 04:07:33 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5131029iwn.4.2010.02.14.04.07.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:07:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139905>

The git_pager() function used in git am has some problems:

 - It does not check if stdout is a tty, so it always paginates.

 - If $GIT_PAGER uses any environment variables, they are being
   ignored, since it does not run $GIT_PAGER through eval.

Fix them.  While at it, move the definition of git_pager() to
git-sh-setup so authors of other commands are not tempted to
reimplement it with the same mistakes.

If GIT_PAGER is set to the empty string, pagination is disabled.  This
is different from the treatment of GIT_EDITOR by git_editor(), but
consistency with the use of GIT_PAGER by git builtins is more
important.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-am.sh       |    5 +----
 git-sh-setup.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..b11af03 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -663,10 +663,7 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       : ${GIT_PAGER=$(git var GIT_PAGER)}
-		       : ${LESS=-FRSX}
-		       export LESS
-		       $GIT_PAGER "$dotest/patch" ;;
+		       git_pager "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..f3b5237 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,22 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
 
+git_pager() {
+	if test -z "${GIT_PAGER+set}"
+	then
+		if tty <&1 >/dev/null 2>/dev/null
+		then
+			GIT_PAGER=cat
+		else
+			GIT_PAGER=$(git var GIT_PAGER)
+		fi
+	fi
+	: ${LESS=-FRSX}
+	export LESS
+
+	eval "$GIT_PAGER" '"$@"'
+}
+
 sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep "$@"
 }
-- 
1.7.0
