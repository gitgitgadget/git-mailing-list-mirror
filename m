From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] receive-pack.c: don't miss exporting unsolicited push certificates
Date: Fri,  9 Jan 2015 16:31:14 -0800
Message-ID: <1420849874-32013-1-git-send-email-sbeller@google.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 10 01:31:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9jxd-0007D9-Sp
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 01:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbbAJAbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 19:31:20 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60405 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbAJAbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 19:31:18 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so17860834ier.6
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2hypC+zqJi7QPRiTzP0CySmIxqUGRfdPzJRFdVRXSA=;
        b=BRd8dls+6VVIJyiQ0GIl2yUNCwKTu/+iS2b+uu91miaBINCM/OHpPhvjkVqWogvXqb
         uyDIDrBHGuCAgO1M304wqpkJ88gsgua4g+WHm6/hpOyv+wrp4u0+tcKG02uw5M4Q4EPl
         dDdJ/2MnPR628YMnfZuB6YK++TRo4ZBaKFCF9WJuOdiMhrsn6fsYaXffaPMZD9t8s1fx
         hgoWbXST+73wtJhW/fXmpa5n2H/kC7BrPCvVsalgaX2Rytgo1UeXULGvp427dugz6llp
         QRgXk79Ivppc2eb4izosqit4/eakuFfglo5WcP5tV06U3aF3EFsILEG0LvGp7C7uUXHT
         aBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2hypC+zqJi7QPRiTzP0CySmIxqUGRfdPzJRFdVRXSA=;
        b=Uu+FAF55g/9RE8RIwls8FBg+8LQ/9gZP6hDmAt5Rg6B3qpY6au6JgbsdRlPALPjjuP
         Mzkc7fJBiYTrmvV2yFw3APu6aSx+90vZ4yl5gjf5t52u13EcMRLxfGVsMHzcCEzXhNXB
         9GHY+nIoSzRKyRR4UxQ59gCrA9Ifnj+N3RU4/L2ur8Ktgp8bPCuHPNr1INuR7/MKmKwg
         qVrhyhpme2SsKBrmhz5yn6BCBLylmJRtsRTaH+2BRCfw95QwfruTXnMQefcC7PM/iAAk
         eyCxFbT4jZNRdgqjOeCs/6xDMynOaLcmNGfdk0xBwtELfI4jQ0YcJ5OWRdjaue8pINm5
         zE9w==
X-Gm-Message-State: ALoCoQmClatkC+W11NrMp4H3rtg7AVsXR9XSzshF2KlY2lWms/TUs89rtQv3jH2FRjgdDVPKdrt8
X-Received: by 10.107.26.15 with SMTP id a15mr11124716ioa.15.1420849877500;
        Fri, 09 Jan 2015 16:31:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:60c6:3f0a:318f:e7c0])
        by mx.google.com with ESMTPSA id n4sm244894igr.15.2015.01.09.16.31.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 16:31:17 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262253>

If the server is configured to not advertise push certificates,
a push certificate that gets pushed nevertheless will not be fully
recorded because push_cert_nonce is NULL.

The recording of GIT_PUSH_CERT_NONCE_STATUS should be dependent on
the status being there instead of push_cert_nonce being non NULL.

Without this patch an unsolicited nonce never makes to the stage when
being exported with GIT_PUSH_CERT_NONCE_STATUS, because in the unsolicited
case push_cert_nonce is always NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 628d13a..0e4878e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -504,18 +504,18 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 				 sigcheck.key ? sigcheck.key : "");
 		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
 				 sigcheck.result);
-		if (push_cert_nonce) {
+		if (push_cert_nonce)
 			argv_array_pushf(&proc->env_array,
 					 "GIT_PUSH_CERT_NONCE=%s",
 					 push_cert_nonce);
+		if (nonce_status)
 			argv_array_pushf(&proc->env_array,
 					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
 					 nonce_status);
-			if (nonce_status == NONCE_SLOP)
-				argv_array_pushf(&proc->env_array,
-						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
-						 nonce_stamp_slop);
-		}
+		if (nonce_status == NONCE_SLOP)
+			argv_array_pushf(&proc->env_array,
+					 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
+					 nonce_stamp_slop);
 	}
 }
 
-- 
2.2.1.62.g3f15098
