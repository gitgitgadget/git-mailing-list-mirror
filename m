From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] builtin/am: make sure state files are text
Date: Mon, 24 Aug 2015 13:58:06 -0700
Message-ID: <1440449890-29490-3-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyos-0006qD-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbHXU6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34577 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbHXU6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:14 -0400
Received: by pdbfa8 with SMTP id fa8so57659948pdb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=4lLZjNlozjSCIButalJK+cFk/NWlt7GdxGg7bRrklEc=;
        b=QPibim5NfE1HwBIUd9Q+7EpAn8HKDzJiYQpul6gFRRSa0NOrHq46Go3UYEERx2unjJ
         G9QPG6odf0P5yUXmuQFFEVqgIPf2nrAT7nbuvQbM4wk66acxDDfbR0K+Dhrb+P7wjm2h
         H9EmWi74guavYHMqg5/LqbgoqyyJ12aRo/DoU/Bs/h928E5lBpn2dXa138C9rUijEWKH
         ZG3FJ3MnfarymBQhKfKquBC2Y5bkQk89Yj8AsYYh8D4ikQKjCb1yn0L25h83xFJDskzR
         CGGQ1o4warGq6zGoLnXeP8Jm6Gld+IM4ftB3VUUW9F1yr0iB/aLY525Q4nWGxo9KJqUD
         ypoA==
X-Received: by 10.70.42.110 with SMTP id n14mr49343144pdl.133.1440449893677;
        Mon, 24 Aug 2015 13:58:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id ip7sm18393035pbc.68.2015.08.24.13.58.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276481>

We forgot to terminate the payload given to write_file() with LF,
resulting in files that end with an incomplete line.  Teach the
wrappers builtin/am uses to make sure it adds LF at the end as
necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4d34dc5..f0a046b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -199,13 +199,19 @@ static inline const char *am_path(const struct am_state *state, const char *path
 static int write_state_text(const struct am_state *state,
 			    const char *name, const char *string)
 {
-	return write_file(am_path(state, name), 1, "%s", string);
+	const char *fmt;
+
+	if (*string && string[strlen(string) - 1] != '\n')
+		fmt = "%s\n";
+	else
+		fmt = "%s";
+	return write_file(am_path(state, name), 1, fmt, string);
 }
 
 static int write_state_count(const struct am_state *state,
 			     const char *name, int value)
 {
-	return write_file(am_path(state, name), 1, "%d", value);
+	return write_file(am_path(state, name), 1, "%d\n", value);
 }
 
 static int write_state_bool(const struct am_state *state,
-- 
2.5.0-568-g53a3e28
