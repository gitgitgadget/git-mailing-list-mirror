Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1744C54FD0
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23BE2084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDYCVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:21:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:47708 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgDYCU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:56 -0400
IronPort-SDR: c1EuJqRoJ4XblqqeNzkrQRDpgI66h7dnLaTkds+VwqPUCWScxN8yBbjRrMKRDhyfXn5HdOfr7Z
 eEB7JMBUTV2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:53 -0700
IronPort-SDR: zDMwSIXmr8yxy6kwqay+YM1IUA7Y399GUngAP6xFpbr9pi+x9orcp7YcoPVdLpkkfSAyQ2Fren
 F5Py7p5xWztQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056785"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:53 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 08/11] completion: perform DWIM logic directly in __git_complete_refs
Date:   Fri, 24 Apr 2020 19:20:42 -0700
Message-Id: <20200425022045.1089291-10-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

__git_complete_refs is the main function used for completing references.
It is primarily used as a wrapper around __git_refs, and is easier to
extend since its arguments are option-like.

One major downside of __git_complete_refs and __git_refs currently, is
the lack of ability to complete only a subset of refs such as branches
(refs/heads) or tags (refs/tags).

Normally, a caller might just decide to use __git_heads() or
__git_tags(). However, in the case of git-switch, it is useful to
complete both branches *and* DWIM remote branch names.

Due to the complexity and implementation of __git_refs, it is not easy
to extend it to support listing only a subset of references.

Instead, we can extend __git_complete_refs to do this. For this to be
done, we must first ensure that "--dwim" support is not tied to calling
__git_refs.

Instead of passing $dwim into __git_refs, we can implement
a __gitcomp_direct_append function which can append to COMPREPLY after
a call to __gitcomp_direct.

If --dwim is passed to __git_complete_refs, use __gitcomp_direct_append
to add the output of __git_dwim_remote_heads to the completion list.

In this way, --dwim support is now independent of calling __git_refs.

A future change will add an additional option to control what set of
references __git_complete_refs will output.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f1ee25f05690..c582e070711f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -301,6 +301,19 @@ __gitcomp_direct ()
 	COMPREPLY=($1)
 }
 
+# Similar to __gitcomp_direct, but appends to COMPREPLY instead.
+# Callers must take care of providing only words that match the current word
+# to be completed and adding any prefix and/or suffix (trailing space!), if
+# necessary.
+# 1: List of newline-separated matching completion words, complete with
+#    prefix and suffix.
+__gitcomp_direct_append ()
+{
+	local IFS=$'\n'
+
+	COMPREPLY+=($1)
+}
+
 __gitcompappend ()
 {
 	local x i=${#COMPREPLY[@]}
@@ -787,7 +800,11 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_direct "$(__git_refs "$remote" "$dwim" "$pfx" "$cur_" "$sfx")"
+	__gitcomp_direct "$(__git_refs "$remote" "" "$pfx" "$cur_" "$sfx")"
+
+	if [ "$dwim" = "yes" ]; then
+		__gitcomp_direct_append "$(__git_dwim_remote_heads "$pfx" "$cur_" "$sfx")"
+	fi
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
-- 
2.25.2

