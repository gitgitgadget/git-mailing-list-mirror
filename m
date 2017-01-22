Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4755820A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbdAVTxP (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:53:15 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:57497 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdAVTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VOCIcRFMZHGLwVOCKca3TP; Sun, 22 Jan 2017 19:53:08 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=sMjzwCt7R3vnje7UmKgA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.org>
Subject: [PATCH v3 2/4] git gui: cope with duplicates in _get_recentrepo
Date:   Sun, 22 Jan 2017 19:52:59 +0000
Message-Id: <20170122195301.1784-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170122195301.1784-1-philipoakley@iee.org>
References: <20170122195301.1784-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfHcCY32gOz322x4H+mlPFThsn+7IqxU03m1vvwZSOvhgzwQ5t40fP+R3Beh9JRSggt0ZmRB1qGP+XXfl8ZQHMZcsZFp9mNCeMXmA7fg7vFuwxmrZ2HrI
 AGbAZzZ80M5RsWOvjVwLmMDbuqq9f0P7sxBnq45UsU+zeiE4StsRemh9e0G8vGsygUrV6KrfmI3B6KZwEINmHhpf9e4S3YBtTjg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

_get_recentrepo will fail if duplicate invalid entries are present
in the recentrepo config list. The previous commit fixed the
'git config' limitations in _unset_recentrepo by unsetting all config
entries, however this code would fail on the second attempt to unset it.

Refactor the code to pre-sort and de-duplicate the recentrepo list to
avoid a potential second unset attempt.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 lib/choose_repository.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 133ca0a..aa87bcc 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -235,14 +235,14 @@ method _invoke_next {} {
 
 proc _get_recentrepos {} {
 	set recent [list]
-	foreach p [get_config gui.recentrepo] {
+	foreach p [lsort -unique [get_config gui.recentrepo]] {
 		if {[_is_git [file join $p .git]]} {
 			lappend recent $p
 		} else {
 			_unset_recentrepo $p
 		}
 	}
-	return [lsort $recent]
+	return $recent
 }
 
 proc _unset_recentrepo {p} {
-- 
2.9.0.windows.1.323.g0305acf

