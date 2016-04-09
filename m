From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 07/16] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sun, 10 Apr 2016 00:15:06 +0530
Message-ID: <1460227515-28437-8-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxt9-0003Zh-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbcDISpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:41 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34428 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758990AbcDISpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:39 -0400
Received: by mail-ig0-f196.google.com with SMTP id qu10so6553019igc.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vfs5xJA67g1OTF6tq/0aBYh6jmeB+nbe9DR8EwNxj34=;
        b=GGbg6TFSgf5sEVkDKC1StPkGuqTk6ano1TY/uorW71CYE8lC02aRiDwGvkuxkq2zVz
         qG8kqCdHC8O0FNFmvt2uuGeIaveEiokCZrkh+maFtikHTqKGo3tWOuPkcUibWbaTs755
         Mm1FByxtqsMKXMt1an41WOk35xNTY2TClPaHKhN0BbTKKgzfXeEJUlHnnOpJbjXUZaO2
         GXYqdS4QO/PGyT0OpZiNI7YHF7h4dBwtpix4nWWCfQpBH6j8EHcoc+Waw+gBKpw6wPuc
         GbsI4zoKU4AnJHo7gv+srcEtL6T06IrzetwA+Z0/7Ntwpew4SMBcbtP/Z9v8816aNxTX
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vfs5xJA67g1OTF6tq/0aBYh6jmeB+nbe9DR8EwNxj34=;
        b=JS246/kJBSaECUpwhtOp5Oy8Hl0yS6zQylQoFW+6KIhMHArw+CQaZvfclDSlo02quJ
         xBdOJSNPu3u39IZ8EtfV9EjpV1Cq33ugKiaK+RBePBzdntybM98nHKRUSSXU53bjSirL
         xDrFJQWDhCffZRroMrlwLJS8AxpA5hHgBPYq7+/xQJhuf2pNEE6qeAiN6rDixxjXVTSM
         g4lA4QYvmQvk8ycptZMkU1N5u1W/mX8yoPh1CdNhxiYDEuZORp+33nvli0AqCHjMnihn
         NzgFjQ0V7NTOjl3o6Nj9i/V3LqYPMD5BGGNUySmpupQeoZWeonJScJDAk2QtHRXCpsw6
         Pakg==
X-Gm-Message-State: AD7BkJJ74SwIIyecLyIZi88CKyjHwfALuOSTYfEYzh4gzn8xM1YjilZJD3YKCPljIm+/Hw==
X-Received: by 10.50.241.13 with SMTP id we13mr10203879igc.66.1460227537432;
        Sat, 09 Apr 2016 11:45:37 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291113>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d3223a2..85ac2a8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -119,7 +119,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 3bb474f..4d7e0c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1049,8 +1049,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2be0a3f..a92b36f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.8.0
