From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] open_istream: remove unneeded check for null pointer
Date: Tue, 23 Jul 2013 15:16:04 +0200
Message-ID: <1374585364-12159-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 15:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1cRh-0000mL-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 15:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab3GWNQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 09:16:00 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:56667 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab3GWNP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 09:15:59 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so3105460wes.16
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FnDpjIqE80miR8zdvmjyWqLTEAeM7cI/gMbT1pKEMDo=;
        b=XCep7R8e/snG9BSxTaNvszbyGYyA9YSAVdJXvI+lXu0vjGEz0jQNT7yOWKOXSpDl80
         8awcthhzF96FsjnQA4NxjWgBxVt4hcOITUfmutSCyErsYwqvJY9bBb61HTvHT45Aog8f
         B79RCkfDssiHPsKsXLIx4YSZrUvJhKLqpTRnBNsAc+hP/+gODlp7Q/9oZRQxYTJC1E3H
         rYH508hsZ/kYxCS+nnkyGhRTB/tmE09jZyXK5oXHqCm7zXl8dzZSW9l514HUbH7q54jt
         Mc4j3IYJwA0Sh+DPX7Nmz+mccWEcLMv/8uBjHnUc2mPesdAlf98POr7LRTTQqleLZusM
         IxIw==
X-Received: by 10.194.63.229 with SMTP id j5mr22555660wjs.79.1374585358327;
        Tue, 23 Jul 2013 06:15:58 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm5807893wib.10.2013.07.23.06.15.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 06:15:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1135.ge2c9e63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231034>

'st' is allocated via xmalloc a few lines before and passed to
the stream opening functions.
The xmalloc function is written in a way that either 'st' is allocated
valid memory or xmalloc already dies.
The function calls to open_istream_* do not change 'st', as the pointer is
passed by reference and not a pointer of a pointer.

Hence 'st' cannot be null at that part of the code.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 streaming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index acc07a6..debe904 100644
--- a/streaming.c
+++ b/streaming.c
@@ -144,17 +144,17 @@ struct git_istream *open_istream(const unsigned char *sha1,
 
 	st = xmalloc(sizeof(*st));
 	if (open_istream_tbl[src](st, &oi, real, type)) {
 		if (open_istream_incore(st, &oi, real, type)) {
 			free(st);
 			return NULL;
 		}
 	}
-	if (st && filter) {
+	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
 		struct git_istream *nst = attach_stream_filter(st, filter);
 		if (!nst)
 			close_istream(st);
 		st = nst;
 	}
 
 	*size = st->size;
-- 
1.8.3.3.1135.ge2c9e63
