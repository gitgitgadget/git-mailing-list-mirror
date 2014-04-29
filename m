From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 4/6] pull: add --merge option
Date: Tue, 29 Apr 2014 06:17:04 -0500
Message-ID: <1398770226-9686-5-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Cs-0004pG-6f
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911AbaD2L16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:27:58 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:59441 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933909AbaD2L15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:27:57 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so42465yho.22
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yS80FVaFIhIWDhXWjQjoMwfFBUtBjobTh+IMDfdM+bY=;
        b=KJXTyLN3nMUfDV+0H3O0OziGejKLzC7Ioi8MTOutXXHZ8ho7hncympCzYE/rOQUpoq
         prL6GP5Pg1nxudXk5iuF9QeMnOg0CemjKXhmKYC+ZBe1cbOL1MUD2FvHg16XI3jDXLFk
         oLeowKcTnPGVRq0DAgJdjql+ROm5cZP1PGJpQ+DDwEnuosdw2l1RNxSiWAK/Os/H6h4T
         eIQX0w3dOyt0wx9y2TpseF7Co6JgRIc1sCAjIWQ2znBOkvXojEP+fOSYPSLLBgw5yuvV
         0/o+PmgjkHbYvV2kpxR0Z2xP7Qr2tvz7kv2vQgmqITOVoLb5UcvAtwt1eZscM7DfBzkK
         pB1Q==
X-Received: by 10.236.113.171 with SMTP id a31mr46485683yhh.12.1398770876850;
        Tue, 29 Apr 2014 04:27:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c27sm36125001yhm.35.2014.04.29.04.27.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247571>

Also, deprecate --no-rebase since there's no need for it any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 8 ++++++--
 git-pull.sh                | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 9a91b9f..767bca3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -127,8 +127,12 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
+to make `git pull` always use `--merge`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-pull.sh b/git-pull.sh
index 3dfd856..26e4e55 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -151,8 +151,12 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		mode=rebase
 		;;
+	-m|--m|--me|--mer|--merg|--merge)
+		mode=merge
+		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		mode=
+		mode=merge
+		warn "$(gettext "--no-rebase is deprecated, please use --merge instead")"
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
-- 
1.9.2+fc1.3.gade8541
