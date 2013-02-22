From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] git-commit: populate the edit buffer with 2 blank lines before s-o-b
Date: Fri, 22 Feb 2013 01:25:58 -0800
Message-ID: <1361525158-3648-1-git-send-email-drafnel@gmail.com>
References: <7vobfdtl1n.fsf@alter.siamese.dyndns.org>
Cc: pclouds@gmail.com, jrnieder@gmail.com, john@keeping.me.uk,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 22 10:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8otl-0002WC-HX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 10:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab3BVJ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 04:26:08 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:65512 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3BVJ0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 04:26:06 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so307134pbc.15
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KtlOpByhKnr1KD/f+1UEqMHzi99066/Xl24AOI+6gaE=;
        b=buouiT74Btp1hrG9kBCDk9faP/PBcf0qDfajxHjYYYOb51Wk4svW6c5IG5Y0u6ARXc
         cOfgSUDHS1e//X9mLAL2YJvRw2e1k9XvjOa8rLz18IJWIE//oPI0hJNp7VHyyIPNNMXY
         io2cT2Q6YuF1Rg263qM0xw3ApIvTrjw8/Ww6AZZ2UoGKM9jCLGIIguzqu9utDaebPBqH
         o3ANncIzYjCeEHyrXBKlzOeZ2GmJf3nxb4YNChaVc44Fnnu7x+7m2R/iVDQzTGV7+9Th
         Bn5j561Y0Bf5niQbDUXcprlEDQVRpxxagRAQ9Ku9YYoBhf5wE8BLUGRqO662eXMR/+nQ
         E2kg==
X-Received: by 10.68.224.169 with SMTP id rd9mr1908713pbc.199.1361525165401;
        Fri, 22 Feb 2013 01:26:05 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id j7sm2361198pay.10.2013.02.22.01.26.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 01:26:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <7vobfdtl1n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216826>

Before commit 33f2f9ab, 'commit -s' would populate the edit buffer with
a blank line before the Signed-off-by line.  This provided a nice
hint to the user that something should be filled in.  Let's restore that
behavior, but now let's ensure that the Signed-off-by line is preceded
by two blank lines to hint that something should be filled in, and that
a blank line should separate it from the Signed-off-by line.

Plus, add a test for this behavior.

Reported-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Ok.  Here's a patch on top of 959a2623 bc/append-signed-off-by.  It
implements the "2 blank lines preceding sob" behavior.

-Brandon

 sequencer.c       |  5 +++--
 t/t7502-commit.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 53ee49a..2dac106 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,9 +1127,10 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 		const char *append_newlines = NULL;
 		size_t len = msgbuf->len - ignore_footer;
 
-		if (len && msgbuf->buf[len - 1] != '\n')
+		/* ensure a blank line precedes our signoff */
+		if (!len || msgbuf->buf[len - 1] != '\n')
 			append_newlines = "\n\n";
-		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
+		else if (len == 1 || msgbuf->buf[len - 2] != '\n')
 			append_newlines = "\n";
 
 		if (append_newlines)
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index deb187e..a53a1e0 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -349,6 +349,18 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 '
 
+test_expect_success 'commit -s places sob on third line after two empty lines' '
+	git commit -s --allow-empty --allow-empty-message &&
+	cat <<-EOF >expect &&
+
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+
+	EOF
+	egrep -v '^#' .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 write_script .git/FAKE_EDITOR <<\EOF
 mv "$1" "$1.orig"
 (
-- 
1.8.0.1.253.gfcb57d5.dirty
