From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Fri, 25 Jul 2014 09:58:41 -0700
Message-ID: <1406307521-10339-6-git-send-email-sahlberg@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:59:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAipn-0005kX-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934649AbaGYQ6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:58:52 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:35803 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934608AbaGYQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:58:49 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so1200921pab.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYJy/0J9gsCeSrJwek++l/bWHxTc916fyvuN4QpS9uU=;
        b=LxEZuAF7FtZUStqlq6Kmlj2efJ4NdYAWxCmOeuomRsKdkhAbcSTQ3lFKQhmXhCPj46
         4n+PWS2xuP291lMm9LjpeSE+gfx2CFVjjAPvkHcQyfaA6gX+wP7Mnoa3HyafILW4tN/O
         TDpBP6t6S2e6/Hvl+7gIoUBekB4SBh0y2Zqhw9/aPZwHZ+rL8SHFchIguU/PLp4jLus2
         5RrbUlgJbMOAN8MNWicSogxXY1AtUDmzmr97dT7BcNubjS+PEm2jxHKkBHbdLWmhpAud
         EcgRe5ll+NDF4fqXASI6oPXVhXP3B5d4iPQ53dDRVvKhjVGhmqlBNmkCSTIDyZO3deCA
         rMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYJy/0J9gsCeSrJwek++l/bWHxTc916fyvuN4QpS9uU=;
        b=LD0zE7nx8N3w/AjL8AsV4XOtIYgpagPkJSufw0oco0HYsCUUsVL2W4kVs5/5WNNJxy
         rpA3hyx6F7Y7fm6QQJcMHsTbShOytIpU3w+iwDcIYm5huwNwrZyywY/EIEZCqvFW5h1+
         j1Xk7EQAUeTHHrgAPQyw9mvQ7J+i4kSJCYoog95VakesRjaWgHfbCvBXxmnvqGdd8Ncy
         BnZQfhj+6O+nMEKCoEuBHcMBTN5qSAV+Fq+zTSND2jJDdsGvAi4BX1xlXskJlhgLqYOw
         Y9gcKLReR10ikD7+cIe6FCKp1q83LNPFPapYczUNkrZ+VN6nvWwdEmvvh+WpmGNi8EQB
         6EGw==
X-Gm-Message-State: ALoCoQl3FZBLguq/kzfQJlr/mtJiTyCMx0KYb3oT/zcGSn+IkViZLocWgCow1jLI4mGv6Emd8bfa
X-Received: by 10.68.195.9 with SMTP id ia9mr8445945pbc.7.1406307528649;
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v44si1291214yhv.0.2014.07.25.09.58.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 779305A42F2;
	Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0D40E0A73; Fri, 25 Jul 2014 09:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254234>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a5053bf..619725a 100644
--- a/refs.c
+++ b/refs.c
@@ -2570,8 +2570,10 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
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
2.0.1.508.g763ab16
