From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 05/27] update-ref.c: log transaction error from the update_ref
Date: Mon, 28 Apr 2014 15:54:20 -0700
Message-ID: <1398725682-30782-6-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTb-0007iM-Kh
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbaD1W4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:30 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:41670 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbaD1Wyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:47 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so1612080obc.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJZDLvgoB7LzjoiVkX1h2ReJEIdzOT3ohXyvwHVl2N0=;
        b=YbfPGXfu5lha/VjsUUcA2ZUxKO14ZVvS3iqKZDS/w5YZXDp3NBogqQypmQe+KnSGzU
         jlUsbWy4/yzQuS2iPPK3eOmbGFWIz/FgTka8K4AZyX5dp/32v4oFF78HZDxgzGDrrpF/
         4TQDabGMeHPpVygUp+LheWmdc/NNhCWYWM2btjvICCSwreRArI06D1oAolKVtIBspqkx
         A/GTX7wueAfo5/6+wR02TzCEpNmqFhOVFLUT1H82GytU1f3scwgThapxobnRwt9ZMs+P
         UsXuZT6+uKuwGb1x5t4h9x8cttxmgERR1bvaDhmwQTyJtprgKEyfxUJCay13ONhdYeuE
         nQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJZDLvgoB7LzjoiVkX1h2ReJEIdzOT3ohXyvwHVl2N0=;
        b=gWEO7FfvwY5z61/+eyjJ3pyIoIAhLEiK8R/DhGqVStAcmBhOSiPwykjpR3f+/BdHW5
         oUTOdmrE3ABsiw+Utkvr0uuxZarqaG7bPfD56hvlrYcVWaWkjs6vaEg1QN8jleXHZajm
         5IO9fDEdqmyJGBLK0AwKolQ5YQo93CQba5WMWJ0IMFWtQAhLWW+SDwxhd9G1Nt3f6y7K
         +WXMZC7F7Yt/P7UjznGUa95SxvtoXPq6zpSXg/SloHMwFlUO2rGaJrD19+1ansDoprYb
         RA/CTxo4WsJ4nhuzxmPG/kp+b+kKpZCxSNSs8hGFkDny3B9YNc2LSkVnnvy5l8stqgHD
         /zgg==
X-Gm-Message-State: ALoCoQm9FqqSBJN1nxZD+ia5SCS6/p2X7/tZsQpErU8xQx5FWPMitTxoDs5J2QgxhGWfHHS8JY/Zk07mNvF3ILJqWmt56+DwRMOEE8zYa9k4GGUPA9hGRJVd0GXhJ+9SKL4wE1WMnB78U7oDSUcdGsFjLUJUjB95aVGkT4Wr+iAi4i70HqaxW0fFHqwHSgTlBeFhfxC7Rq9x
X-Received: by 10.182.196.8 with SMTP id ii8mr14512137obc.5.1398725687390;
        Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si1011481yhh.0.2014.04.28.15.54.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 241B031C20B;
	Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DA221E080D; Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247486>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..207e24d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
+		return 0;
 	}
 
 	if (end_null)
-- 
1.9.1.528.g98b8868.dirty
