From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] instaweb: restart server if already running
Date: Sun, 22 Nov 2009 23:09:12 -0800
Message-ID: <1258960152-24444-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 08:09:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCT3C-0004QK-I3
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 08:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZKWHJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 02:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbZKWHJM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 02:09:12 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64953 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZKWHJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 02:09:11 -0500
X-Greylist: delayed 8228 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2009 02:09:11 EST
Received: by ywh12 with SMTP id 12so4923041ywh.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=7iRUO2yB7kblJUbUalzgXsGJoxa0ncj3GomdmBtLDf0=;
        b=hUNjWApDxNwQKifqzwC0Fkv6p/xiPugSL8QVXpKsTL/eslxWiv9KiV6eCzWkxKdSh6
         pJxDbK9Rkv46ggX/CaYpZRBB+VLxJa8wJR2cKiWD3iY/sahomtPafIIm+HpBifNHUJSK
         7lVXCvky3X55q0XGvrf7LOqhVrbZtmc40l/qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dxMRHRppwaOm3lM+H3TSB8S3LYUL5gFW09HprsF78OZGPETVNl3PRf4kNzUR2tTmee
         zzJi1nYN3WgUQCdzYEFzgroFshN/KoM6MZLgGA9vkKaEL27UPGLDIbgo9FRcbLhmdDBb
         kPmX8JMsh8i+Kqmjy86LjPwnFUD0pZLChbhxQ=
Received: by 10.150.76.6 with SMTP id y6mr7929396yba.60.1258960157603;
        Sun, 22 Nov 2009 23:09:17 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 20sm1390765ywh.32.2009.11.22.23.09.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 23:09:16 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Nov 2009 23:09:12 -0800
X-Mailer: git-send-email 1.6.5.3.299.gb65c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133486>

Running 'git instaweb' when an instaweb server is already running will
fail (at least when the port is the same) and overwrite the pid file
used to track the currently running server. This turns out to be
especially annoying when the user tries to stop the previously running
server with 'git instaweb --stop' and is instead greeted with an error
message because the pid file has been destroyed.

Instead of allowing a user to start two instaweb servers, stop the
currently running server first and then start the new one. This should
be fine because it was never really possible to start two instaweb
servers in the first place due to the pid file issue outlined above.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-instaweb.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 622a5f0..ffc2ab6 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -73,6 +73,11 @@ resolve_full_httpd () {
 }
 
 start_httpd () {
+	if test -f "$fqgitdir/pid"; then
+		say "Instance already running. Restarting..."
+		stop_httpd
+	fi
+
 	# here $httpd should have a meaningful value
 	resolve_full_httpd
 
-- 
1.6.5.3.299.gb65c9
