From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 18/31] refs.c: return immediately from _commit if the transaction has an error
Date: Wed, 14 May 2014 15:13:17 -0700
Message-ID: <1400105610-21194-19-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQs-0006EC-1L
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaENWNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:43 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:65302 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaENWNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:39 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so47550qcv.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKbdSBRFLNgorLKDtOgwLz/L+n/axW6mroVyLatIaGw=;
        b=heWynxaC25DYEET1yJlxGr4conIcyU4FqmLIHjlL7gjchJZBjwctD7ZWG75OGpNGaV
         9tYc9VCx4D7Vy6PKHDqCd8Ft/Lb0BE/eygNxOqHtO6CspgXwsApQCaH7QG4FextDMzey
         i5eDXMn36Bg7TdH+hpXNYu0scbJhSAH/oksCzBszexzpF5UV/3eNYvMQSh3+GhbxQPhd
         cjKrpY8sXF2GLDimqq05VFgav5QaV6EH/BwXr3akTrYkHHMT7rVud9VhYIDo18I9nE5+
         xUSLlD5kwEV/Qfxi520iv5RtnmF7KWvCZb4cbtITjk7b49YIWlH1kxqlo45RzC+kWGBw
         WIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKbdSBRFLNgorLKDtOgwLz/L+n/axW6mroVyLatIaGw=;
        b=BBNzN8qGwIChZ+eds2bA5xzsm1J7igVy4VIlFyOR8vmq1KiNrdeny5z1DFzpD1XtBC
         QtyeFqze96oMc7mHPkMkZXvoq9ZZk3oXH5vhVFeLhvnYM+xgkDR6z9wwsE6Th9FeF6G1
         Yans2uhhyQZ1Xs6fLALAFP592gsWz2zVHKyms1+hfsuaXerKPGjumtZv2N2YX3X2gt9l
         zjPFdyys5iLLttR2uVkkGTC+1ngAfOPhbRuBnejIk+Zx29S27Zg0qC8A7x+IN4LDyKoQ
         jsZN7QnigVckGDY1cBo6v2bVe/aWZRkaWMiruWn854beGkBH5IvIopBohxalVCMXb5rp
         x1wQ==
X-Gm-Message-State: ALoCoQnv+GcQ3zip5pPwYifBactIWy3tRRNsptD86N8arU53cXTHtPzh0UfbTF+2emHSUAssUc4Y
X-Received: by 10.58.94.232 with SMTP id df8mr3021102veb.23.1400105618553;
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si150756yhl.7.2014.05.14.15.13.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6808031C1F8;
	Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2CB16E0973; Wed, 14 May 2014 15:13:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249012>

If a previous transaction operation has failed and flagged a transaction
as having an error, then return immediately from commit and indicate failure.
Once we move checks from _commit to _update, _update will already have updated
the error string so the caller will know what failed. Thus we don't need to do
anything at all in _commit than return failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 8b09258..93f01e8 100644
--- a/refs.c
+++ b/refs.c
@@ -3558,6 +3558,9 @@ int transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
+	if (transaction->status == REF_TRANSACTION_ERROR)
+		return 1;
+
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: commit on transaction that is not open");
 
-- 
2.0.0.rc3.506.g3739a35
