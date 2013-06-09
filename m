From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 08/36] read-cache: plug a few leaks
Date: Sun,  9 Jun 2013 14:24:22 -0500
Message-ID: <1370805890-3453-9-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllIZ-0004R2-KF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab3FIT1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:11 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35235 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3FIT1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:07 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so3548154oag.16
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mU8l4QZgOMkEtrldLSjKHD0GDfjU/CrnwH8CJnxPpZE=;
        b=YUPXSeO8FjKugEujyT20q4YA/iI+TbIBDYMhrnBvfqvSuRpw5hGUnd8oHDIiakWQug
         12zgyTfPrdqbmuXvkRV/fg4IGkL0KPaH7EwFC5Uv0xim4AVz1kXBNEOjfuIXVO8xFh9i
         2ZelCCbkbuqwAwaYQ6XOTx1o+pzcv9fjo3MH7bxTFqnnJ1OGUSX33seV9n1LY+eJZ8Mp
         tsckV41A9uyF63CqKfVgniTtIY9awSpmrgve5j+r4eu/gQ6MCwwJm87m0Id4zx/HtXFB
         VcMDQ2KdMUf78UWjkYHUh6mEnM4d7l5mR77acOvrstKulPTdPYPl7alloOg5XwqDWJiv
         G1Fw==
X-Received: by 10.182.108.194 with SMTP id hm2mr5674199obb.71.1370806026528;
        Sun, 09 Jun 2013 12:27:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm16051712obc.0.2013.06.09.12.27.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227146>

We are not freeing 'istate->cache' properly.

We can't rely on 'initialized' to keep track of the 'istate->cache',
because it doesn't really mean it's initialized. So assume it always has
data, and free it before overwriting it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5e30746..a1dd04d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1451,6 +1451,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	free(istate->cache);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
 
@@ -1512,6 +1513,9 @@ int discard_index(struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
+	free(istate->cache);
+	istate->cache = NULL;
+	istate->cache_alloc = 0;
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
-- 
1.8.3.698.g079b096
