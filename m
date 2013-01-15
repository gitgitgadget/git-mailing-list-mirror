From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 08/19] reset.c: share call to die_if_unmerged_cache()
Date: Mon, 14 Jan 2013 21:47:40 -0800
Message-ID: <1358228871-7142-9-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:57:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzWB-0005MS-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3AOF4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:56:44 -0500
Received: from mail-yh0-f73.google.com ([209.85.213.73]:42946 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3AOF4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:56:43 -0500
Received: by mail-yh0-f73.google.com with SMTP id 47so588096yhr.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=R8dq1f44VeS+kB8w7Oy1kxfe/bGuUTI3AHWkbtHnvSQ=;
        b=Juc+WfQmcqAUd6idzZXCCE5b/6/T5+Iy++Z7KSdjfW7Fi0sPp3ltbZD8JtF++3eX1q
         Q1i2PZLi+4PLfKA+/xosZ09pWOoxDzBRZE1yOj0PFXw1CfNzlBcqn8Mulazjj+rkCI7l
         IW3p+Hw5MtV3H7mF39k0+1OjyTLN41yk+ECtRYK9ScJHh6oqIEA6Sidnf+wFBa7Svh3k
         mGA667u4vsQFe4mMjG7rEwP4Lxo57oSNpxhCyUaoREVv2dbin80F8stAZFoWSQFA6pH2
         ofLtSrFGiDfPfElhsnglPv5Px2FeJu7RvLMWxvl30drDkEwmBb9hXC0OEyh+rx9/SgJE
         eFHQ==
X-Received: by 10.236.156.227 with SMTP id m63mr7704516yhk.17.1358228906616;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id x63si231838yhl.2.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 81DB7820050;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 17291101779; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQk6O+6pa4mA8EvU2roTr8K0GRUTJz8TcF4bBbPhqE9nXgysQzN2Yf93e1upjazvo856aG9nxqoLsIzpLrxUk3VkJw1BFKFOpSJpPfjPO/Y1An/PfOJEy6LMa5AqaVCNgOC9KMI6XBUVn37YyOTqYlCha/FUed47X0A/0ty6cYNz5QTn0RFyJiJJjJ//vRc6RZeHvJEa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213593>

Use a single condition to guard the call to die_if_unmerged_cache for
both --soft and --keep. This avoids the small distraction of the
precondition check from the logic following it.

Also change an instance of

  if (e)
    err = err || f();

to the almost as short, but clearer

  if (e && !err)
    err = f();

(which is equivalent since we only care whether exit code is 0)

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 2187d64..4e34195 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -337,15 +337,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-	if (reset_type == SOFT)
+	if (reset_type == SOFT || reset_type == KEEP)
 		die_if_unmerged_cache(reset_type);
-	else {
-		int err;
-		if (reset_type == KEEP)
-			die_if_unmerged_cache(reset_type);
-		err = reset_index_file(sha1, reset_type, quiet);
-		if (reset_type == KEEP)
-			err = err || reset_index_file(sha1, MIXED, quiet);
+
+	if (reset_type != SOFT) {
+		int err = reset_index_file(sha1, reset_type, quiet);
+		if (reset_type == KEEP && !err)
+			err = reset_index_file(sha1, MIXED, quiet);
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
 	}
-- 
1.8.1.1.454.gce43f05
