From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] checkout: do not write full sha1 to reflog
Date: Sat, 15 Jun 2013 23:08:26 +0530
Message-ID: <1371317906-3991-3-git-send-email-artagnon@gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 19:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnuSq-0002G9-75
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 19:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3FORkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 13:40:32 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62235 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab3FORkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 13:40:21 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so1594709pad.18
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kZ95dvKL6jmTfNBfX8ebm6ghvHiF1v2qrQ8YyZHJoIs=;
        b=qx3EJ1uhs7S7+TzPybtfYAa6lAtTFirW+Mmo5HY23rxw+/ynSieWbxTlq0Ww9bHJ+8
         34Wm+Wk3nq49iZtiIp6kSljnec7lPEZH3hS3cuFjzabfmzZxfXtS8Rf07BzkHqgQI4GT
         RPdz2vjv+q8dvXG5Cl3dX2duOlEuAsOQ4FtTmzWFLIR5VBs75hkv1lya2OiuAABuu+KV
         5x4g4TDRzWldm/jxMno62c9bYY+H1hMM62jN4Ebi1eL+ZrcaGv1iGYO+8fzXj0N7w7Nt
         BGTjUGlRAr00tpBXxtzjsPMVfEycZLmoYLHxjf43NNdDYxPYpP5RetRZnkOvYaRtichu
         uCRg==
X-Received: by 10.68.247.226 with SMTP id yh2mr6834312pbc.164.1371318020591;
        Sat, 15 Jun 2013 10:40:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id ri8sm7032290pbc.3.2013.06.15.10.40.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 10:40:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.438.g96d34e8
In-Reply-To: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227964>

A snippet from a typical git session may look like this:

  $ git checkout @~3
  ...
  $ git checkout -

The reflog entries corresponding to the two checkouts look like:

  f855138: checkout: moving from bdff0e3a374617dce784f801b97500d9ba2e4705 to co-reflog
  bdff0e3: checkout: moving from co-reflog to HEAD~3

There is no need to write the full SHA-1 to the user-visible reflog; use
find_unique_abbrev() to shorten the first line like:

  f855138: checkout: moving from bdff0e3 to co-reflog

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5b50e5..41b1929 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -619,7 +619,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	old_desc = old->name;
 	if (!old_desc && old->commit)
-		old_desc = sha1_to_hex(old->commit->object.sha1);
+		old_desc = find_unique_abbrev(old->commit->object.sha1, DEFAULT_ABBREV);
 	strbuf_addf(&msg, "checkout: moving from %s to %s",
 		    old_desc ? old_desc : "(invalid)", new->name);
 
-- 
1.8.3.1.438.g96d34e8
