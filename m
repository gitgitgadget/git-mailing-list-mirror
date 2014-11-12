From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 1/9] builtin/notes: Fix premature failure when trying to add the empty blob
Date: Wed, 12 Nov 2014 01:40:08 +0100
Message-ID: <1415752816-22782-2-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzm-00069D-TX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaKLAkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:32 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34083 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaKLAkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:31 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so8346240lbg.7
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vte1Qi/UotYrNJbMxjhh9jIMnDSa900mNXicE4TscIQ=;
        b=XqwuGDUgFsIQKh0TwzVmroU5fwMSK4fO2Ej6jifrV5Wyj9zpr1oYVZee2yAlW6fKTy
         tZTGL0lBmDObvgeZUVUDoTTxldFsc+ALOLUSPzbR6jSSK1a2hyh14ke2ic+saHqkLZai
         2XOua6Dj4w971wLJTSfE0jcQfcrYSWYkcN6GYUR2GUtzulv1ZPZnjlanGYsaUFh8TO04
         3d+gn96w0Ca0qeqpEMP3zR27zHi+H+295anbX41NUqKu8a7ZT8eMWf3sQYPube+K0lqJ
         a8yrINxBnr9gWTkRsowBQi2neTnKU5lVg+Q0eFWjyNoTPr5J5mZMzDTdVppZP3Vdgz8+
         fOPg==
X-Received: by 10.152.203.164 with SMTP id kr4mr39104068lac.31.1415752829840;
        Tue, 11 Nov 2014 16:40:29 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:28 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a small buglet when trying to explicitly add the empty blob
as a note object using the -c or -C option to git notes add/append.
Instead of failing with a nonsensical error message indicating that the
empty blob does not exist, we should rather behave as if an empty notes
message was given (e.g. using -m "" or -F /dev/null).

The next patch contains a test that verifies the fixed behavior.

Found-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 68b6cd8..9ee6816 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -266,7 +266,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_sha1(arg, object))
 		die(_("Failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
+	if (!(buf = read_sha1_file(object, &type, &len))) {
 		free(buf);
 		die(_("Failed to read object '%s'."), arg);
 	}
-- 
2.0.0.rc4.501.gdaf83ca
