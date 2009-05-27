Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 14346 invoked by uid 107); 27 May 2009 08:17:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Wed, 27 May 2009 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758822AbZE0IRD (ORCPT <rfc822;peff@peff.net>);
	Wed, 27 May 2009 04:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758670AbZE0IRD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:17:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:20245 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598AbZE0IRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 04:17:01 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1108246eyd.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:17:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=4TLK8P0LdSjKSMv31CmA0s8T+/9OYHCUd+K1UWg7Ooc=;
        b=qJobmyw57vt07yjZpvvN3oerJL/h2cZy/j05ITvi6U+ymaSmUTtU9qunDS4S17fhg+
         PIv/gEXOV23BTIaZHLKcXdE7tnxzu8R5r3wUSLHcVarmONvyyzii+032MaKl0TQv5VNs
         w+2A+68TAgQ6K7qfd9VptQDpSO2AyFweFZ5M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AlQoB0TrKhIi2dftcwyjRdNmMId8NxQ5JfDS5/5XZbNbjIfgnsptDUfYjdr6APmdQR
         46Z0LGN5KZ+8JzkmthN4GAgzJ/PLrGYkNdhfPwrJn1Yk9HmDmnbZqh8xZAXDJksujFAx
         d9XMsrcPmdzyo027EyvQjqGShA5qd0LUxfrGA=
Received: by 10.216.0.206 with SMTP id 56mr3553073web.102.1243412222462;
        Wed, 27 May 2009 01:17:02 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id 5sm8262565eyf.38.2009.05.27.01.17.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 01:17:01 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marc Weber <marco-oweber@gmx.de>
Subject: [TopGit PATCH v2 3/3] tg-push: handle non-tgish branches
Date:	Wed, 27 May 2009 10:17:01 +0200
Message-Id: <1243412221-2844-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.3.1.143.g17592
In-Reply-To: <1243412195-29841-1-git-send-email-bert.wesarg@googlemail.com>
References: <1243412195-29841-1-git-send-email-bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

tg push dies if you give it a non-tgish branch:

$ tg push -r push-test master
fatal: Not a valid object name refs/top-bases/master
fatal: ambiguous argument '^{tree}': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name master:.topdeps

Fix this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-push.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index 8e1b43f..cd208a0 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -67,8 +67,8 @@ for name in $branches; do
 		_dep_is_tgish=
 	push_branch "$name"
 
-	# deps
-	$recurse_deps &&
+	# deps but only if branch is tgish
+	$recurse_deps && [ -n "$_dep_is_tgish" ] &&
 		no_remotes=1 recurse_deps push_branch "$name"
 
 	# remove multiple occurrences of the same branch
-- 
tg: (cbca164..) bw/push-fixes-2 (depends on: bw/push-fixes)
