From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] read-cache: plug small memory leak
Date: Thu, 30 May 2013 06:58:54 -0500
Message-ID: <1369915136-4248-3-git-send-email-felipe.contreras@gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 14:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1XW-0001Vv-SE
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab3E3MAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:00:49 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:39965 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab3E3MAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:00:45 -0400
Received: by mail-ye0-f170.google.com with SMTP id r5so23480yen.1
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=44qmNz8Vdw7zJOUufRzQysjy6P1TRNrod+6Xcw7UNpc=;
        b=zgwWCb9G9sF1T6BbLfMzYUQrBaqCEJBUA0fcumltYd85PhF8IYp7BpVXSnhfZqkQ++
         iMb/88mETyzo2Knwrn5IJQU8sIy+EjDt+nCfVdDiK4zS2TRCSewzDt/lU26IAH0RuGy7
         86m6JDoRkcZo/bzC5n8mIis7k02yawceTE9WMWFGs3IC9cxeRSKDE/GVvqAIsMirTVFn
         aks9F6ABU+mTRx0GAGLF4d1ONH794xMz2cAtnGSvOVU6y9ZsPXNN1x3dZx/JcpFrlMaS
         0FmoGtOme6y56OOiG3TCpLqBy/fKKm/lnYAJqEhWGun2h2ITLcuMh3xCpCN7NlJw+1bd
         uSFw==
X-Received: by 10.236.1.233 with SMTP id 69mr3482141yhd.127.1369915245193;
        Thu, 30 May 2013 05:00:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z65sm59424526yhc.9.2013.05.30.05.00.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 05:00:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225970>

We free each entry, but not the array of entries themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 04ed561..9d9b886 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1510,6 +1510,8 @@ int discard_index(struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
+	free(istate->cache);
+	istate->cache = NULL;
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
-- 
1.8.3.rc3.312.g47657de
