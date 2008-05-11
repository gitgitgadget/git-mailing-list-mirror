From: nathan spindel <nathans@gmail.com>
Subject: [PATCH] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Sat, 10 May 2008 22:26:04 -0700
Message-ID: <1210483565-12415-2-git-send-email-nathans@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Cc: nathan spindel <nathans@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 07:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv45L-0006FW-9U
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbYEKF0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbYEKF0M
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:26:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:25249 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYEKF0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:26:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1796151wfd.4
        for <git@vger.kernel.org>; Sat, 10 May 2008 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G0vg8XRNNQ0yNdAMhgzqdBZzyuVhr5Ya7Uk7DAl0BEQ=;
        b=BZPvsk7y9J9bhrcl9v6DxScI8zP8Gfibps2MHNxJL2nOPHC0iqBfkH9HCEAIFqIfS/amRMoq+VIVaBbeEcgduG+ov/Yu/7TtsRToGYEMozFO4DwCQEUBqKkM3W0bPVn6FaDaUqMaJacO8Wi/n3bDVQLPgZPiCCplh9eUn/e6Hpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bQZwZ0DS7Sy4/5ynCH1bsKG3e5VtPGPlXE3WrJ8RatkxAdsGowECCl/03/5Z+NS+K5V1+8/TjXoxQi8F/2R1JuYbxNalnss8Yr+05az51UMS6i3XS4KUDdxx0ZjWaj0Sl92JvtRo2eU1aZKuHD/wP1MKpmysf318k1OqfWQqaVM=
Received: by 10.142.232.20 with SMTP id e20mr2697349wfh.198.1210483569215;
        Sat, 10 May 2008 22:26:09 -0700 (PDT)
Received: from localhost ( [76.14.71.118])
        by mx.google.com with ESMTPS id 30sm14539466wfg.9.2008.05.10.22.26.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 22:26:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.179.g2fe4.dirty
In-Reply-To: <1210483565-12415-1-git-send-email-nathans@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81736>

When in apache2 mode if there isn't an apache2 binary on the system but
there is a httpd command in /usr/sbin/ (like there is on Mac OS X)
use that instead.

When in apache2 mode and there isn't a module_path specified, look for
module paths in /usr/lib/apache2/modules _and_ /usr/libexec/apache2,
in that order.

Added a LockFile directive to the apache2 config because the default
location of /private/var/run is only root-writeable on Mac OS X.

Signed-off-by: nathan spindel <nathans@gmail.com>
---
 git-instaweb.sh |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b744133..1c9412c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -180,7 +180,23 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	# if there isn't an apache2 command on the system but there is a httpd
+	# command in /usr/sbin/ use that instead for Mac OS X compatibility.
+	httpd_only="`echo $httpd | cut -f1 -d' '`"
+	type $httpd_only > /dev/null 2>&1;
+	test $? != 0 && test -x /usr/sbin/httpd && httpd=${httpd/apache2/httpd}
+
+	if test -z "$module_path"
+	then
+		for path in /usr/lib/apache2/modules /usr/libexec/apache2; do
+			if test -d "$path"
+			then
+				module_path="$path"
+				break
+			fi
+		done
+	fi
+
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
@@ -190,6 +206,7 @@ ServerName "git-instaweb"
 ServerRoot "$fqgitdir/gitweb"
 DocumentRoot "$fqgitdir/gitweb"
 PidFile "$fqgitdir/pid"
+LockFile "$fqgitdir/gitweb/logs/accept.lock"
 Listen $bind$port
 EOF
 
-- 
1.5.5.1.179.g2fe4.dirty
