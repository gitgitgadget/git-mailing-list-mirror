From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetools/meld: make usage of `--output` configurable and more robust
Date: Wed, 15 Oct 2014 21:45:14 -0700
Message-ID: <1413434714-20424-1-git-send-email-davvid@gmail.com>
References: <xmqqh9z5w38h.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Andrey Novoseltsev <novoselt@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 06:44:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xecvh-0000Lx-JB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 06:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaJPEoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 00:44:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40200 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaJPEop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 00:44:45 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so2517330pde.36
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gcxgA47h9Z2jJCNNFrH7eBBN0d5WqDZotzW3p/Mv3+o=;
        b=sm1TQngz+Z7erffKB2sAqyxPGcQ7AK6jUwdkwlI7cMIdFvZ/CqOB+geU0i7jPV4Oi5
         kqVrO/phe/HWX03ZZZw5zF6ib3qBCdLBdQmW/WURm0dbbl8hHD1AQ30SRfE+yoCXnQXs
         Vk2+m/OsAaawariC4fiGm8fmWo6a6wecGjumApyUhJfoOkfe2ClvrSWUd9o33MWWX+hf
         KTRhcJ6X8rSMyhkJLpZLXwIKSvrj1QD5nnBh37NT1VZ60Pz+1WHFUY4R/nMSuCsRREyy
         2DvZ9AP56J2WQ02HegQnx+uMdLYpEuzD1/o+DIrG+XYdu46d3ELELItb2kcmwbG17vmT
         aqhQ==
X-Received: by 10.68.89.3 with SMTP id bk3mr17152288pbb.73.1413434684803;
        Wed, 15 Oct 2014 21:44:44 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cl1sm17592507pbb.92.2014.10.15.21.44.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 21:44:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.444.g0cfad43
In-Reply-To: <xmqqh9z5w38h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Older versions of meld listed --output in `meld --help`.
Newer versions only mention `meld [OPTIONS...]`.
Improve the checks to catch these newer versions.

Add a `mergetool.meld.hasOutput` configuration to allow
overriding the heuristic.

Reported-by: Andrey Novoseltsev <novoselt@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:

This uses Junio's improved approach of checking for both --help
styles and uses more focused name for the configuration variable.
The documentation was reworded accordingly.

 Documentation/config.txt | 9 +++++++++
 mergetools/meld          | 9 +++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04a1e2f..0f823eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1755,6 +1755,15 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.meld.hasOutput::
+	Older versions of `meld` do not support the `--output` option.
+	Git will attempt to detect whether `meld` supports `--output`
+	by inspecting the output of `meld --help`.  Configuring
+	`mergetool.meld.hasOutput` will make Git skip these checks and
+	use the configured value instead.  Setting `mergetool.meld.hasOutput`
+	to `true` tells Git to unconditionally use the `--output` option,
+	and `false` avoids using `--output`.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index cb672a5..83ebdfb 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -18,13 +18,18 @@ merge_cmd () {
 	check_unchanged
 }
 
-# Check whether 'meld --output <file>' is supported
+# Check whether we should use 'meld --output <file>'
 check_meld_for_output_version () {
 	meld_path="$(git config mergetool.meld.path)"
 	meld_path="${meld_path:-meld}"
 
-	if "$meld_path" --help 2>&1 | grep -e --output >/dev/null
+	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
 	then
+		: use configured value
+	elif "$meld_path" --help 2>&1 |
+		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
+	then
+		: old ones mention --output and new ones just say OPTION...
 		meld_has_output_option=true
 	else
 		meld_has_output_option=false
-- 
2.1.2.444.g0cfad43
