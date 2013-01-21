From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822 continuation in footer
Date: Mon, 21 Jan 2013 00:40:18 -0800
Message-ID: <1358757627-16682-2-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwD-0002rK-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab3AUIkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:42 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:33441 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab3AUIkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:40 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so2619505dad.10
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1IZHwaacinYy8V/fg6LlbW5GoLuo6viig4U39E7WS/A=;
        b=MSIojP4WVC7xjJ9Q77pWcvLu0KqJ2b85QYTUr9f80eic7EQoWmwkc706r3HzhDjaFi
         QR7NUovun4S0YZgCIQpDYgJT1hvBGm/4hw8MJ2B8qp6SvCd/nm0dXs/EE81ovS1qKqam
         BsBgWF8WWQATHDYS3o9u70uGmUXAa19CNrFuUIEyvrCTk1OdSjLESNGDmBJvzS43IiQ2
         3DX16G6/1kddqdlfPpnfdSgCmWOa3IStD58VrP/SKlveZCjuv2JOn7zbGbTQ5tK6WoRe
         cp9UuQ1J2PNebLzHuC+d38g620+JBNRCaTx15Oh8fYy7iBAYgpinxu+3KTKj63QiRw4v
         LFXw==
X-Received: by 10.68.143.162 with SMTP id sf2mr27770776pbb.137.1358757639987;
        Mon, 21 Jan 2013 00:40:39 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.38
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:39 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214095>

Commit c1e01b0c generalized the detection of the last paragraph
signed-off-by footer and used rfc2822 as a guideline.  Support for rfc2822
style continuation lines was also implemented, but not correctly, so it has
never detected a line beginning with space or tab as a continuation of the
previous line.

Since a commit message is not governed by the line length limits imposed
by rfc2822 for email messages, and it does not seem like this functionality
would produce "better" commit messages anyway, let's remove this broken
functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aef5e8a..fe25ef4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1027,7 +1027,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 	int hit = 0;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
-	int first = 1;
 	const char *buf = sb->buf;
 
 	for (i = len - 1; i > 0; i--) {
@@ -1044,11 +1043,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
-			continue;
-
-		first = 0;
-
 		for (j = 0; i + j < len; j++) {
 			ch = buf[i + j];
 			if (ch == ':')
-- 
1.8.1.1.252.gdb33759
