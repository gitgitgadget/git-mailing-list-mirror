From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 3/9] svn-fe: allow svnadmin instead of svnrdump in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:47 +0600
Message-ID: <1310570813-16648-4-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LA-0002iX-6k
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab1GMP0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:35 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64618 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab1GMP0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:34 -0400
Received: by ewy4 with SMTP id 4so2202601ewy.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BfP12b4D9+3AS+ttPNhv6p2xqFVuARl32XMuCk6XzoI=;
        b=kAXypnOW4A8ouoY9Xz23G8SMUeqnvUTwjZOuitqphSnoYx0pTw5Zn5XlkO/e7w78Sh
         yEfjTXcT29PJFjqhFyM0KxQtTLM2dZyiAEzbClVt50GY5e/04BGUwxTpXm4fBwG/P5ap
         +NmYSEZkqC1FWSk+6NCKsdv65cynRu/Dp9NPA=
Received: by 10.213.33.199 with SMTP id i7mr445652ebd.42.1310570792529;
        Wed, 13 Jul 2011 08:26:32 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177046>

svnrdump dump and svnadmin dump share a dump format. Their dump
streams representation may be different but they should have the
same effect on a dump consumer. One more difference is svnrdump being
able to dump via any svn remote protocol while svnadmin needs access
to the repository filesystem and also can't produce subdirectory dumps.
But svnrdump is a newer tool and may be unavailable on some systems.

Try to use svnadmin dump for file:// repository urls if there is no
svnrdump in the PATH. First of all this is to be used in tests, where
the repository is indeed local most of the time. Also require svnlook
utility as a lightweight option to get the youngest repository revision.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index 2eac7d4..ca9d431 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -28,9 +28,38 @@ svnrdump_wrap () {
 	fi
 }
 
+try_svnrdump () {
+	command -v svnrdump >/dev/null &&
+	echo svnrdump_wrap ||
+	true
+}
+
+svnadmin_wrap () {
+	path=${1##file://} &&
+	test "z$path" != "z$1" &&
+	latest=$(svnlook youngest "$path") &&
+	future=$(( $latest + 1 )) &&
+	asked=${2#-r} &&
+	asked=${asked%:*} &&
+	test "$asked" -eq "$future" ||
+	svnadmin dump --incremental --deltas --quiet "$path" "$2"
+}
+
+try_svnadmin () {
+	command -v svnadmin >/dev/null &&
+	command -v svnlook >/dev/null &&
+	echo svnadmin_wrap ||
+	true
+}
+
+SVNDUMP=""
+SVNDUMP=${SVNDUMP:-`try_svnrdump`}
+SVNDUMP=${SVNDUMP:-`try_svnadmin`}
+test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
+
 do_import () {
 	revs=$1 url=$2
-	(svnrdump_wrap "$url" -r"$revs" | svn-fe) 3<&0 || die "FAILURE"
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
