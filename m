From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 2/9] svn-fe: avoid error on no-op imports in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:46 +0600
Message-ID: <1310570813-16648-3-git-send-email-divanorama@gmail.com>
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
	id 1Qh1LA-0002iX-NE
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab1GMP0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1GMP0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:31 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112126eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bW3GEc7WzgGxi3N2qQPK3hVofsygJ8aiI4zsWZQP1oU=;
        b=FzamjIQhbAYJZN7BXL9ToQMYm0bCgiqMhBUO9luEWETIT4w2ScR5GSQfFgyO9PBAWr
         aVfWRI949TM7y9Y5RFIH7qTF4atsTYlRF722AVG0PT6nXFt4q2w2MAVXiGKY4ASXr4wY
         XEnBP1NeULoiOAXR6FiT96ZFuwbsNd2kfkMd8=
Received: by 10.213.113.198 with SMTP id b6mr1685265ebq.48.1310570790586;
        Wed, 13 Jul 2011 08:26:30 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177045>

Currently helpers' exit codes are not checked by transport_helper.
But a proper helper should check for all possible internal errors
anyway. svnrdump dump --incremental considers -rX:HEAD range as bad
if X is greater than the actual HEAD revision. And there is no option
to change this behavior.

One way to address this issue is to fire one more svn command to get
the HEAD value, but it is one more connection, one more tool (ok,
we can svnrdump HEAD but it looks slow) and possibly one more
password prompt, and maybe even a race condition (if we talk to a
svn servers farm frontend for example).

Another one is to patch svnrdump to report the revision, because
internally it asks svn for it anyway before doing a dump. Longer
term it looks nice, moreover it can be used to display percentage
progress.

Add a wrapper around svnrdump that captures stderr and exit code.
If stderr matches a hardcoded "LOWER cannot be greater than UPPER."
and the exit code is non-zero, don't produce any dump and emulate
exit 0, otherwise the wrapper is transparent. The only side effect
is dup2-ing stdout to fd=6, ugly but fine as only standard
descriptors are used currently.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index 61c9b07..2eac7d4 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -12,10 +12,25 @@ usage () {
 	exit 129
 }
 
+svnrdump_wrap () {
+	exec 6<&1 &&
+
+	EX=$(
+		(svnrdump dump --non-interactive --username=Guest --password= \
+			--quiet "$1" "$2" >&6) 2>&1; test $? -ne 0 || echo Success
+	) &&
+	if test "z$EX" != "zSuccess"; then
+		if test "z$EX" = "zLOWER cannot be greater than UPPER."; then
+			return 0
+		fi
+		echo "$EX" >&2
+		return 1
+	fi
+}
+
 do_import () {
 	revs=$1 url=$2
-	(svnrdump dump --non-interactive --username=Guest --password= \
-		-r"$revs" "$url" --quiet | svn-fe) 3<&0 || die "FAILURE"
+	(svnrdump_wrap "$url" -r"$revs" | svn-fe) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
