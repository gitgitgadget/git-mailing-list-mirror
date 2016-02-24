From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Try harder to fetch needed sha1 by direct fetching sha1
Date: Tue, 23 Feb 2016 19:32:13 -0800
Message-ID: <1456284733-28003-1-git-send-email-sbeller@google.com>
References: <xmqqmvqs2ao4.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:32:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQBb-0005Vl-KX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbcBXDcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:32:19 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33519 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcBXDcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:32:19 -0500
Received: by mail-pf0-f178.google.com with SMTP id q63so4521284pfb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kN6KZHauA9siW23P5kbhtpAtN7wZFlKxf1nxM/ILyZY=;
        b=EmRiQQYR3XWCwC99c4cq3nm3v9s0nAzo8v0JzB/TYWraRVLKy1j00yotjniMgDiqTr
         5dSphbVakxV7BpGZR06JR/ezy3exhQn6cXK7jWhaJpAwq5nmMj+lzfpEhpflttJbfQvq
         iJMG48zHVTST42w+hIGMjHTQpb0GM64/yEVKIpHnkZmgpclSIi7XQCau5AlYxZlSsaRt
         GydMJ+UTG/+QsZZFlLZ3nBWbZ6mFwIjtTUiEyqowTb8loZykUckBFb+lvftQmF+Ailhw
         UNDJ1Q871najhWBBecVNimzof5iImTfQwSLUrMu5EHVhByvhTgT01QiSSSyRsjRZFTB3
         C2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kN6KZHauA9siW23P5kbhtpAtN7wZFlKxf1nxM/ILyZY=;
        b=jE0lDDaKH/5QMxk5tPiYz1HsASJdawtDMpkBOb3J9jGMpvCATUbZ5wEovyj4C+Mw+x
         QaHDcSofy1ouDmEiol0orb5bf8/1H7BT7dbYtQt0lS9opBtNhcL2rIOkXLTOKr2GVXhe
         ILRAMOdkQp6YBEB4GegzP7vwCSUhtIstl/hJkZmTZ1UR8weRiIreDQEaBaVc1CkiEAmh
         JFOypR19NVTSNunO/SbLBEY7t7EMHZuhw8/rrGXdA7a9XwqtPIXxjJqroIBNn74+Syxj
         vqoKGXMRIzmMoiu2XXFnv0T6px24a0DlGDWYoW8DkdwXel7pshuaACxFEcVkU2F4bsSV
         Pypg==
X-Gm-Message-State: AG10YOQOUpv1mNXgQC0W4TiVVDS/OdKPx7sMe2ZCAfkGxBRdj9sdY7ShJTHtQJSOCoLKwkqS
X-Received: by 10.98.72.133 with SMTP id q5mr51889672pfi.166.1456284738493;
        Tue, 23 Feb 2016 19:32:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id x88sm762367pfi.66.2016.02.23.19.32.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:32:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <xmqqmvqs2ao4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287169>

When reviewing a change in Gerrit, which also updates a submodule,
a common review practice is to download and cherry-pick the patch
locally to test it. However when testing it locally, the 'git
submodule update' may fail fetching the correct submodule sha1 as
the corresponding commit in the submodule is not yet part of the
project history, but also just a proposed change.

If $sha1 was not part of the default fetch, we try to fetch the $sha1
directly. Some servers however do not support direct fetch by sha1,
which leads git-fetch to fail quickly. We can fail ourselves here as
the still missing sha1 would lead to a failure later in the checkout
stage anyway, so failing here is as good as we can get.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Junio, I took your patch and reworded the error message, so 25 / 26
 lines of the code are still originally authored by you. But as "it is
 my itch not yours" I am resending it. If you changed your mind, take
 authorship of this.
 
 Thanks,
 Stefan

 git-submodule.sh | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..babfc64 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -591,6 +591,24 @@ cmd_deinit()
 	done
 }
 
+is_tip_reachable () (
+	clear_local_git_env
+	cd "$1" &&
+	rev=$(git rev-list -n 1 "$2" --not --all 2>/dev/null) &&
+	test -z "$rev"
+)
+
+fetch_in_submodule () (
+	clear_local_git_env
+	cd "$1" &&
+	case "$2" in
+	'')
+		git fetch ;;
+	*)
+		git fetch $(get_default_remote) "$2" ;;
+	esac
+)
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -745,10 +763,15 @@ Maybe you want to use 'update --init'?")"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
-					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
+				is_tip_reachable "$sm_path" "$sha1" ||
+				fetch_in_submodule "$sm_path" ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+
+				# Now we tried the usual fetch, but $sha1 may
+				# not be reachable from any of the refs
+				is_tip_reachable "$sm_path" "$sha1" ||
+				fetch_in_submodule "$sm_path" "$sha1" ||
+				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain $sha1. Direct fetching of that commit failed.")"
 			fi
 
 			# Is this something we just cloned?
-- 
2.7.0.rc0.34.ga06e0b3.dirty
