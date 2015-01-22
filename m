From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] refs.c: write values to lock files early for committing
Date: Thu, 22 Jan 2015 15:11:37 -0800
Message-ID: <1421968297-25407-6-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
 <1421968297-25407-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQuq-0001Wa-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbbAVXLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:52 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42950 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbAVXLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:47 -0500
Received: by mail-ie0-f178.google.com with SMTP id rp18so4282826iec.9
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8ryX9UBxmhHlH7WOx1kwHAg5ufRf313zDt6dbM0v4E=;
        b=SYPJYPtfgVDxlhoKGu5W9O5HJVf62jLtPGsdjuBK64/YvCVwZN18/BPbHLrz/NPMoR
         EU1U473amYpXXC5KoYllo6Mfkxhbo7BS6H245jNeUnQAb2mvb9PF/b4loOpsnhL1KEvg
         MBrYaPaGVdYIvWpHaCxLkcLNWp0VJh/mY5LvaX2wOZMJLB1EaaDZefyH5H+IvFjU8QtY
         eGX4XQ254a4yHgObddQMtupDyzbKtLKBGBSBwGYe3pgML9tuvtJAsNvkEG0z8xyHck0N
         +C3CobQGLJ1l7UHRQpH7QXXxZVab5q5AxnAX4wnXHUIFAjbdaOOjAxKoKjL0ZmbtP0qR
         7eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W8ryX9UBxmhHlH7WOx1kwHAg5ufRf313zDt6dbM0v4E=;
        b=Zy5fYgfz5X/eOEnc6OEL7nG9Ogg1hYrLBzd81KgrFjpaJim1iMXCmsbMdLjarTmrzQ
         o/Dzk5etZlH31dExc4GcveXWlV/hxoTGmLQFaLPk9GOhPqaR79u7pVOTFGPJSuof0xAb
         h6d+LPoRI2ztDNGcr7cPwhp6F18PC+LhmQG+AXnSBj0vZDAjYo+4yuPLqfTsqLVIJ17F
         8UnNmVYD18CCFvgZSfsaLpPslTmeIozKK6RnA0cny2+hcRQyWoV9FjXihfgEBW+EuiUN
         f68HVKc1VP+JcW7smy20kyu2Guq6ToGwxX8dzOuCR+e9Agoav84IstL04ALb+JgpCqnW
         vpPA==
X-Gm-Message-State: ALoCoQlvCTtSWHYyuPt19g6ybxB9Df78VIisrxVyuMkrfykGeVj/+T1xvYhgQlYmg4XAiMEZSWWY
X-Received: by 10.50.79.161 with SMTP id k1mr7408434igx.14.1421968306565;
        Thu, 22 Jan 2015 15:11:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id b1sm3893175igl.7.2015.01.22.15.11.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:46 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421968297-25407-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262889>

By writing the values to the lock file early we have a better sequence
of system calls. Before this commit we had

    open(), close(), open(), fdopen(), write(), fclose(), rename()

Now there is:

    open(), fdopen(), write(), fclose(), rename()

The first four operations are performed in the first loop of
ref_transaction_commit ("/* Acquire all locks while verifying
old values */"), while the renameing is left to the next loop.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c108c95..3d1890f 100644
--- a/refs.c
+++ b/refs.c
@@ -3767,6 +3767,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (!is_null_sha1(update->new_sha1)) {
+			if (write_ref_sha1(update->lock, update->new_sha1,
+					   update->msg)) {
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+		}
 		/* Do not keep all lock files open at the same time. */
 		close_ref(update->lock);
 	}
@@ -3776,9 +3785,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)
-			    || commit_ref(update->lock, update->new_sha1)) {
+			if (commit_ref(update->lock, update->new_sha1)) {
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
-- 
2.2.1.62.g3f15098
