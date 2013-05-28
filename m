From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] rebase: fix cherry-pick invocations
Date: Tue, 28 May 2013 08:29:17 -0500
Message-ID: <1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzz-0007qu-6U
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934173Ab3E1NbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:18 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35336 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934138Ab3E1NbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:15 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so9714821oag.25
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bW8x3LyFCW2Lu/z3Qa2p9f0IOSBCa9dubBntO8+y2lE=;
        b=nrUULfeMkd/cKtUc82toGCW8eaqHfTLXJp/EVoa3mLomtBudBySjO1nfeFlzd60JAn
         Vw2VNGv0gnMHhPUSnee9PjmIORLckJs2FtdVZ0Qtm/J/i2ygn6fNt6hHlFxa37QzPTZ4
         fXRMOZJx8BJtmyf7O+ymE8rucGcDFMilPMHzVWZ5o8bJFZ+XZdpy56KyBWORTDkmKMnN
         dgW8egNRIDqkBbhlcj4ByxZVO7x+K2I2PjTspq0ygo3yt9hT1KB34RFWnUZQb8MHzBEQ
         KVQL/ylD4eqT1ljkRPg7yphSS/5WKxObwLFidKJH4vy+jPJDMERn+avxWFOcaKqBW5cy
         OJTQ==
X-Received: by 10.60.37.33 with SMTP id v1mr20950243oej.96.1369747874767;
        Tue, 28 May 2013 06:31:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm34646410obc.2.2013.05.28.06.31.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:31:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225650>

So that all the tests pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherry.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
index ca78b1b..c3a2ac9 100644
--- a/git-rebase--cherry.sh
+++ b/git-rebase--cherry.sh
@@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
 mkdir "$state_dir" || die "Could not create temporary $state_dir"
 : > "$state_dir"/cherry || die "Could not mark as cherry"
 
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
 # we have to do this the hard way.  git format-patch completely squashes
 # empty commits and even if it didn't the format doesn't really lend
 # itself well to recording empty patches.  fortunately, cherry-pick
 # makes this easy
-git cherry-pick --allow-empty "$revisions"
+if test -n "$keep_empty"
+then
+	extra="--allow-empty"
+else
+	extra="--skip-empty --cherry-pick"
+fi
+test -n "$GIT_QUIET" && extra="$extra -q"
+test -z "$force_rebase" && extra="$extra --ff"
+git cherry-pick --no-merges --right-only --topo-order --do-walk --copy-notes $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.rc3.312.g47657de
