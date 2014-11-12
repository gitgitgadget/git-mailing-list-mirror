From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 2/9] t3301: Verify that 'git notes' removes empty notes by default
Date: Wed, 12 Nov 2014 01:40:09 +0100
Message-ID: <1415752816-22782-3-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:41:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzn-00069D-FH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbaKLAlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:41:08 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:55425 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaKLAkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:33 -0500
Received: by mail-lb0-f175.google.com with SMTP id n15so8408175lbi.20
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUwJF+j3ZzW1rimxChgGrvsctWXJCFc2MN220EhpFu0=;
        b=MNFR4YKhJxm4lbpnbvVOiXdiPK7P0XV/1aH0p4vNbJR4zXvKeNrkr3v2pfoHdg/3dP
         9Ipk8LyhyencPk9R/TNuSOs6UlOJby66MC1AjidM2qVI5iKgIXD0zHzQ6B38nGeM6WL7
         HU2lMaq/8Rr00Nf/pAhJ1LIJupIHlJvu0B+68EmtVSZ0lATx5qqyEB+QqkEJzWNqXD1P
         NgGwIa76aXbWGeM92za1bfvsKjiBEZV9Bb/OL74kkCwdyXhi9kOli64/PoDqR55yjPfN
         AO/+dl3D4pheobeK3QhQfx8QBCdyFtUB3Z19pSVTG8Zx4Z1fS83Zr1GnESNg4f/glL5U
         FKRQ==
X-Received: by 10.152.36.33 with SMTP id n1mr38998907laj.6.1415752831684;
        Tue, 11 Nov 2014 16:40:31 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:30 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases documenting the current behavior when trying to
add/append/edit empty notes. This is in preparation for adding
--allow-empty; to allow empty notes to be stored.

Improved-by: Eric Sunshine <sunshine@sunshineco.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cfd67ff..f74b3fa 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1239,4 +1239,31 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
 '
 
+test_expect_success 'setup testing of empty notes' '
+	test_unconfig core.notesRef &&
+	test_commit 16th &&
+	empty_blob=$(git hash-object -w /dev/null)
+'
+
+while read cmd
+do
+	test_expect_success "'git notes $cmd' removes empty note" "
+		test_might_fail git notes remove HEAD &&
+		MSG= git notes $cmd &&
+		test_must_fail git notes list HEAD
+	"
+done <<\EOF
+add
+add -F /dev/null
+add -m ""
+add -c "$empty_blob"
+add -C "$empty_blob"
+append
+append -F /dev/null
+append -m ""
+append -c "$empty_blob"
+append -C "$empty_blob"
+edit
+EOF
+
 test_done
-- 
2.0.0.rc4.501.gdaf83ca
