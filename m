From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/5] svn-fe: allow svnadmin instead of svnrdump in svn helper
Date: Tue,  5 Jul 2011 22:45:47 +0600
Message-ID: <1309884350-13415-3-git-send-email-divanorama@gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8jw-0002em-AJ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318Ab1GEQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49913 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab1GEQoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:37 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4899798bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IFEmlW95ZSN8ssmDF/e3ZlaRq11C3yU5TDcL9NT+ZdE=;
        b=RR1xRrFagL9a+Yi9KcQWsWSL922YmiZq4pJzPQWI8iO5+J4ftpHXYGefu2YG1n3Wgn
         seSyLhcqWWIa5d4o0VOQuys5FtrU/ADrRKiZWee5b+uime/AYRx/RVYLl5iMfjNolWEs
         /kF3pAxR5nDlz0nrO8GswWyab4SM8FLFeJ46g=
Received: by 10.204.131.214 with SMTP id y22mr3348589bks.202.1309884276284;
        Tue, 05 Jul 2011 09:44:36 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176612>

svnrdump produces the same stream as svnadmin dump. svnrdump is able
to do it via any svn remote protocol while svnadmin needs access to
the repository filesystem and can't produce subdirectory dumps.
But svnrdump is a newer tool and may be unavailable on some systems.

Try to use svnadmin dump for file:// repository urls if there is no
svnrdump in the PATH. First of all this is to be used in tests, where
the repository is indeed local most of the time.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index 61c9b07..84d841e 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -12,10 +12,32 @@ usage () {
 	exit 129
 }
 
+try_svnrdump () {
+	command -v svnrdump >/dev/null &&
+	echo "svnrdump dump --non-interactive --username=Guest --password= \
+		--quiet --incremental" ||
+	true
+}
+
+svnadmin_wrap () {
+	path=${1##file://} &&
+	test "z$path" != "z$1" &&
+	svnadmin dump --incremental --deltas --quiet "$path" "$2"
+}
+
+try_svnadmin () {
+	command -v svnadmin >/dev/null &&
+	echo svnadmin_wrap ||
+	true
+}
+
+SVNDUMP=""
+SVNDUMP=${SVNDUMP:-`try_svnrdump`}
+SVNDUMP=${SVNDUMP:-`try_svnadmin`}
+
 do_import () {
 	revs=$1 url=$2
-	(svnrdump dump --non-interactive --username=Guest --password= \
-		-r"$revs" "$url" --quiet | svn-fe) 3<&0 || die "FAILURE"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
