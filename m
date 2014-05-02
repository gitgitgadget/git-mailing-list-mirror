From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 4/7] pull: add --merge option
Date: Thu,  1 May 2014 19:00:05 -0500
Message-ID: <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14b-00015g-3h
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaEBALL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:11 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:54821 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaEBALK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:11:10 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so4343783oac.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDhv6n0qZkmboeWAU+cUIehW44t03w17PcwSD5C2zPA=;
        b=styNIS3L6pi8ty/9Tv/FPdTwzB9Y4+I+0DBL8Q6H4Cqtrop/DjO/jbHtgAew4SxUMN
         yA6EBkcybpuwmVDFlQ0p8QMfYWKNgCve7czDA15OSeJI2XFnnTYdbefQXch00F5avESB
         Wo9oBo4jiOobh6pHqZWXtV2DhQfnIk5HWSe5asl27koNs4Uq02SwsbaWdYwD2OJiAb8X
         XvNlrpLhhS/diHCVH5MCXUOGnm8qql5m47y6Md2q6B433phu1kxeHipbrjMFoDS8falm
         zvJP0a64Z8qh5ce6dT0VT5dn5RXECH1dcL8rcK4QcipT3dNamn84VfFH1hmQ3MIuRfCV
         gTGA==
X-Received: by 10.182.105.1 with SMTP id gi1mr12485475obb.9.1398989469697;
        Thu, 01 May 2014 17:11:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm62742094obh.23.2014.05.01.17.11.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:11:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247907>

Also, deprecate --no-rebase since there's no need for it any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt |  8 ++++++--
 git-pull.sh                | 10 +++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

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
index 50c612f..e7e52ec 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -15,6 +15,10 @@ require_work_tree_exists
 cd_to_toplevel
 
 
+warn () {
+	printf >&2 'warning: %s\n' "$*"
+}
+
 die_conflict () {
     git diff-index --cached --name-status -r --ignore-submodules HEAD --
     if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
@@ -142,8 +146,12 @@ do
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
1.9.2+fc1.19.g85b6256
