From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/45] read-cache: plug a few leaks
Date: Sun,  9 Jun 2013 11:40:20 -0500
Message-ID: <1370796057-25312-9-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiH-0006Yj-Fd
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab3FIQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:16 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:58512 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FIQnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:14 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8929639obc.26
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mU8l4QZgOMkEtrldLSjKHD0GDfjU/CrnwH8CJnxPpZE=;
        b=NsxNhJZi7W289pIwUsnk3xgW654LLBzEA4ym+mFrkcZUCMMQFSn9NfMsLti4cClX+l
         8sNlHYYD17IY1gocuMi7OolEJYpMrlEVaozJ0CUi9Kr9YisLoLLHEswCZCgQPq7w6VBE
         400scdkoZ35AdesVG2Ngm/9eFR13OIW2w/Egxoprg+hiDE/N+gI3NnRUp8uQw2Y9rjUg
         U0DUG08hc/CTKfjpOe1gcS/jGRXfrb4nSYztjuyrQ0/viznpgkBf9TyAZUKjcQM2t2HV
         PEdXTj9buFTI/0gR6z8mo900PtYkU7Dr6NH9OO+jX0YrOovessS1CPiNUdXvAtGBMSpw
         mk8g==
X-Received: by 10.60.80.39 with SMTP id o7mr1010956oex.60.1370796193897;
        Sun, 09 Jun 2013 09:43:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm14932751obw.4.2013.06.09.09.43.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226978>

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
