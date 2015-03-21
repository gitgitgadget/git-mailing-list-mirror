From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/15] commit.c: fix a memory leak
Date: Fri, 20 Mar 2015 17:28:07 -0700
Message-ID: <1426897692-18322-11-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HE-0001gw-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbCUA2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36093 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbbCUA23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:29 -0400
Received: by igbud6 with SMTP id ud6so1551106igb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T416E1Zv/9RBSNTsD3bhQUDIbDCbCJwinYF4EVlakzQ=;
        b=aemRsNrVeZx2kjIX9Qk4K3vunVxr0asjzGMfAyhNpqcTXD1rr4gZWcFzJkfmOQmE/P
         VBqU+bFRFc9u9y5FhFt8ErP6uYx6qVVqWZNG3V1w+e7sy7LseZMikplAn4vIMA0Mx/4g
         NSP1T0OQvCIAOA1vf/rxei99AA5BziiSnM8UahfUkPLuwqtsbS7yK+NNEBp/xxjNNYfB
         yBkv/b9V9Qqakn9I+En0BhLRGPb8PHiikYWNIW5kVYqnSBXiUzf83sL/i+AgVcS1U/UG
         bZl5/jym0dFw+PU78lDG0PYK5tlLsWOWCnjcTjMUbwuJWsT2Xwg+6gD/xGF7DZKQnX2R
         PWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T416E1Zv/9RBSNTsD3bhQUDIbDCbCJwinYF4EVlakzQ=;
        b=YWCzgoX7iEGT025ZL7G/0l4RPvT+h1qF/OiZu/p+L3wChmyQmWti3IPv9PoJVz3EKB
         ZqpcgcyQTaOURALfoVJoUAxO3szKpXoH1sDfk1Vo9XqZxhFUXhoazN81DbmSLe0lnCW9
         iKK9GpteUgAEfZNN7e4X/ru2qZwHHkhFx++WFBH8IWf5/KOgAYtZ/+zc+WpMjee17ygR
         e0Hgbfm7/0S9YNj3ga36si3MEkmQLnp1kehQsWm533bHnLJHQPlfzoaOL3uwRCHVvbur
         w2cEy/0dlp/aR9yiyr7+F0trFCD+iEDpzkF78EHPx6PNwx+/TSWqlRwOdkUBkGo3ksr6
         FegA==
X-Gm-Message-State: ALoCoQlGEMp+F+WKkwOOl4z5DOzYVphuq9W3iEyXc1NKIJN4HNQbtF2BW63iCqv17PyJB/QIehb9
X-Received: by 10.107.25.68 with SMTP id 65mr54191205ioz.44.1426897708420;
        Fri, 20 Mar 2015 17:28:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id j126sm3596480ioe.22.2015.03.20.17.28.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:28 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265985>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 961e467..da79ac4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -229,7 +229,7 @@ static int commit_index_files(void)
 static int list_paths(struct string_list *list, const char *with_tree,
 		      const char *prefix, const struct pathspec *pattern)
 {
-	int i;
+	int i, ret;
 	char *m;
 
 	if (!pattern->nr)
@@ -256,7 +256,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			item->util = item; /* better a valid pointer than a fake one */
 	}
 
-	return report_path_error(m, pattern, prefix);
+	ret = report_path_error(m, pattern, prefix);
+	free(m);
+	return ret;
 }
 
 static void add_remove_files(struct string_list *list)
-- 
2.3.0.81.gc37f363
