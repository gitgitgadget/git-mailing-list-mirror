From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] read-cache: plug a few leaks
Date: Thu, 30 May 2013 08:34:19 -0500
Message-ID: <1369920861-30030-2-git-send-email-felipe.contreras@gmail.com>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui31q-0006yY-Km
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab3E3NgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:36:16 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:54439 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339Ab3E3NgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:36:08 -0400
Received: by mail-ye0-f179.google.com with SMTP id l3so47405yen.24
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7yMj9zmKSxhmKUVyu1qRwulLfItdV+J9yjZXIg/w4jA=;
        b=lXd2fxrab/vWyfMIKlNGAvd7bsAJw/nxkkHSM1+BZ3F69LUvcVExGmWrRqWiCe1RwE
         tPuftBZnmt7uXz9dGkXrsgwYXWaL+2iaryAiwIOHQCFr6fKFw2VDSfvOgoMhTApS0Qf5
         BlC3aAB7nvgc1/QruUkBd4+TVrOj6dNbyu1rGODhIdoRrENr78Bw1gaXWJTTViOb97OW
         u5uZNNVQwKrY7xF8ig4/QOAPNxShxMVmKdTLEqFVkJSFV4V3aS5AWrz4U2OlRdKYvrpW
         LvTd1dPBQXWJwsVIaFoD7gZI5zQs5hcU5Sv7NF/M2Gdc7URwGoPBQOCI+LVtURtEMbF0
         RlKQ==
X-Received: by 10.236.220.138 with SMTP id o10mr3772480yhp.149.1369920967732;
        Thu, 30 May 2013 06:36:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm59968001yhj.12.2013.05.30.06.36.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:36:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225986>

We don't free 'istate->cache' properly.

Apparently 'initialized' doesn't really mean initialized, but loaded, or
rather 'not-empty', and the cache can be used even if it's not
'initialized', so we can't rely on this variable to keep track of the
'istate->cache'.

So assume it always has data, and free it before overwriting it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 04ed561..e5dc96f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1449,6 +1449,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
+	free(istate->cache);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 	istate->initialized = 1;
 
@@ -1510,6 +1511,9 @@ int discard_index(struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
+	free(istate->cache);
+	istate->cache = NULL;
+	istate->cache_alloc = 0;
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
-- 
1.8.3.rc3.312.g47657de
