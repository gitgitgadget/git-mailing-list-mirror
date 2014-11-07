From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 07/16] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Fri,  7 Nov 2014 11:38:56 -0800
Message-ID: <1415389145-6391-8-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNX-00040T-AF
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaKGTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:23 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:39835 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so279011qgd.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBT/ci8GtsUVejbUNioUswGt9wJTkCU9CM8pAQ9Uv+k=;
        b=m53hfT7XszWSAXtT5TjMD6XjWlqKc+h1i7I15cCQIQFmZjkqCx/8TY9Vy+DA8T8YL8
         wuZoUKELAa47gJWI5i7KxXx/28A318u7TsuVj/A3FDdS7YpMumOhXLrtVb3CX3C+VtwA
         UO2ceoJv+IT4+oqkVdl58ZN1vDmUwYDle66EX9syoMXmyKNBMhvT8S+Xbk0xbqpVHzPP
         rFg+p+EJyOarRZ5VOWLakhLcoFVfGLn4xEdbKixjrO261ydatHVsb9JqlnaGlabxxo0O
         Pr2RFLwFJ0Gnz/3bJOPuN6W+KdjyVoRqvO5v19eTK+dwEcXA39GWYeqjj2ySOyyqVmS5
         q7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tBT/ci8GtsUVejbUNioUswGt9wJTkCU9CM8pAQ9Uv+k=;
        b=La9lBKGgbJT/A/5+dwaFAkCdjCX828/8nxbYPOqln/yvf92L+wdI4E4SfVHUsTADZF
         /mL4exKjxOgJDd3RZoOFWlBDwkkDWip8Sw06VTsl+Ktt+RtxLGpw+8AroNHeDPtExAdT
         aLRb2DtSm0O/5FH1Z41oAT+mQCSv6I/lfnukifDs1o/egYA7XRMx4nN+xHODNxyCZt/o
         EP8jEzqUDju9fR4m45lT26lyBM9iENEind2JHzsPY+ECEdnLdCpkMi+A11dBD0WVygth
         wxz/PfIbLd8sfI2FWfKhnG2CGsGaWx5S2+fku7Ml+pXt9aDLj26u7custEBEMD4e3AFQ
         BIkw==
X-Gm-Message-State: ALoCoQkS3a6cnlDSFJm7ehu0je5GsTuhD3zp63HtbEoWdHngy6/UnEyCHcoPTNcLO4iBdLzqDlmV
X-Received: by 10.236.39.174 with SMTP id d34mr10082152yhb.54.1415389151013;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si400508yho.7.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id rUeUKdpJ.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4257E0AD7; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9a3c7fe..5a8f3da 100644
--- a/refs.c
+++ b/refs.c
@@ -2707,8 +2707,10 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.1.0.rc2.206.gedb03e5
