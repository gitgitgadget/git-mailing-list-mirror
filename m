From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] diff: add test for --no-index executed outside repo
Date: Mon, 16 Dec 2013 21:19:23 +0100
Message-ID: <1387225164-31747-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqob4goa4t.fsf@gitster.dls.corp.google.co>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 21:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseeC-00050C-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab3LPUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:20:07 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:58009 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3LPUUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:20:05 -0500
Received: by mail-wi0-f173.google.com with SMTP id hm19so1683986wib.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+WXna8bzhgeQTV61ZyBHVWJawalu6ocZpVNbn8iRo90=;
        b=Gel9oqqwSn7X7m5GhpFxDujHdL881Ts1/5I05w1yUaQjpHJUylnHppjGeaRw4sHE/1
         7bJDaSIRlCNccfZqMO/sjAY3uLctS5KouR6z6k7pGjTuDE+lT/m+FHdoPZ/bzqlLzxoS
         ckZxpKBmx02DR9M5fi6Qa+DqiNRv7hW9ZRL2Bg3ynGCyfdN67X1VquMedkIsXPKHqRjg
         ycMIsXLGNdl2rPaCQfCD0gEodcTHwitrkmsS7M3Gg5QFfWhgvJBcMQlHNVhnU3SN1FSC
         1/IOYZ8R/ZRME7PKhuy6nPqP0NjtkHULQNF6ba21oQzJI4HkCKX0qsYA+d2SzbGbvVYp
         Magg==
X-Received: by 10.180.215.3 with SMTP id oe3mr14735498wic.35.1387225203925;
        Mon, 16 Dec 2013 12:20:03 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1b8d])
        by mx.google.com with ESMTPSA id bc5sm29033999wib.4.2013.12.16.12.20.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2013 12:20:02 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <xmqqob4goa4t.fsf@gitster.dls.corp.google.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239365>

470faf9 diff: move no-index detection to builtin/diff.c breaks the error
message for "git diff --no-index", when the command is executed outside
of a git repository and the wrong number of arguments are given. 6df5762
diff: don't read index when --no-index is given fixes the problem.

Add a test to guard against similar breakages in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> Perhaps use CEILING, like this (untested)?

Thanks, this makes sense, here is the new version.

 t/t4053-diff-no-index.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 077c775..2ab3c48 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -44,4 +44,15 @@ test_expect_success 'git diff outside repo with broken index' '
 	)
 '
 
+test_expect_success 'git diff --no-index executed outside repo gives correct error message' '
+	(
+		GIT_CEILING_DIRECTORIES=$TRASH_DIRECTORY/non &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git diff --no-index a 2>actual.err &&
+		echo "usage: git diff --no-index <path> <path>" >expect.err &&
+		test_cmp expect.err actual.err
+	)
+'
+
 test_done
-- 
1.8.5.4.g8639e57
