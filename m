From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 08/14] refs.c: only write reflog update if msg is non-NULL
Date: Mon, 17 Nov 2014 17:35:44 -0800
Message-ID: <1416274550-2827-9-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXic-0000PJ-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbaKRBgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:10 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:56832 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbaKRBgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:05 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so6338010ier.14
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BRgAM5rcU1c0RIc9c6My03y6lWzxtDuCm/uOnwVsb7o=;
        b=px1bbCX7T6Bqdhiie0nHJgAab4xOa6kLF5OnL9TDjvewT+3VMGFO5dwi8oDG91QNsi
         9UfQvArDJG6Uq06CpmtEIFXR5eEZhP3dhndoNtOxgJ5bnAfF4gq/LnSSzLXGd+8NudDN
         0qQDv6QzvQwwl29IcIRDUu1GTvTaz/ekY1Nfx4yEaKDf6oBrhDBeZew1LaX2LOnzo1Rf
         7TPAZeIfehjhBcrEmk0fUe91u73lIeSQ80m2QpNiqkVwHBgM3G3UNZVVRSHjhl/NG0Rg
         tcsqdDmApXxWg1Y44oJvjKVPqPMLz78+YOU2awJDtsubZzCSYYXSDCr02lZUQNS7uuJ3
         RRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BRgAM5rcU1c0RIc9c6My03y6lWzxtDuCm/uOnwVsb7o=;
        b=ILbLKYyYI2bd7fUKAEVETfCyVBfaKLo3sDuOJjItruSL636ZWAKlib5GbJgCWu3LQf
         gBIIIFx+2shKR4PsSz11gsAEWYSIMlieiBqeQbe/b9sWX6crHHhVkUGy6ghmhnV3iQDr
         GEYx7pc/GETb0BoAf1NDwdokjtuQrNbqCCvWb+0UJXp1i1GM+FZzsGL7UauvbAtLDx4O
         +ABMR4UpIqWvkA1K5XdQJvaKWY1YDT5khOuhWBOjdqRNullDFdc7esUOD7saqMh/uEWV
         mqqQ/zk16c8xo9Cb3ZXEGZrItNQghjfXmsWOvZmPiToNNBQMOuCZt6D5MoUgtr69gkMG
         852A==
X-Gm-Message-State: ALoCoQmbCs1lcUseZ4irVIDfR1laOS1YhrbfbIpTZAQbV1eJu1C8UiJiWLoMSqAVPjDl4gf/5BdO
X-Received: by 10.50.98.101 with SMTP id eh5mr507587igb.31.1416274564283;
        Mon, 17 Nov 2014 17:36:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id c8sm6872601igl.1.2014.11.17.17.36.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:03 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

This change only affects whether or not a reflog entry should be generated
and written. If msg==NULL then no such entry will be written.

Orthogonal to this we have a boolean flag REFLOG_TRUNCATE which is used to
tell the transaction system to "truncate the reflog and thus discard all
previous users".

At the current time the only place where we use msg==NULL is also the
place, where we use REFLOG_TRUNCATE. Even though these two settings are
currently only ever used together it still makes sense to have them through
two separate knobs.

This allows future consumers of this API that may want to do things
differently. For example someone can do:
  msg="Reflog truncated by Bob because ..." + REFLOG_TRUNCATE
and have it truncate the log and have it start fresh with an initial message
that explains the log was truncated. This API allows that.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d21ecb9..3572977 100644
--- a/refs.c
+++ b/refs.c
@@ -3895,8 +3895,9 @@ int transaction_commit(struct transaction *transaction,
 				update->reflog_fd = -1;
 				continue;
 			}
-		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
-				     update->new_sha1,
+		if (update->msg &&
+		    log_ref_write_fd(update->reflog_fd,
+				     update->old_sha1, update->new_sha1,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
diff --git a/refs.h b/refs.h
index 5075073..bf96b36 100644
--- a/refs.h
+++ b/refs.h
@@ -337,6 +337,7 @@ int transaction_delete_ref(struct transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
-- 
2.2.0.rc2.5.gf7b9fb2
