From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/32] sequencer: do not update/refresh index if the lock cannot be held
Date: Fri, 13 Jun 2014 19:19:22 +0700
Message-ID: <1402661991-14977-4-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTA-0002Zd-I1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbaFMMUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:23 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39700 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaFMMUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:22 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so2088948pdb.10
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lpHNb5SvAbru9gX1ZlZ4t7cdOHR7AnJDG5TVyWIz/rg=;
        b=ZicvfjGuqvWAVTYb+U0t+4FVu2XcgFbTs9brWOocpZ33HZ+6idCvwFHlhfNVj7mWM6
         pPCSEHlWjNZnoNSXWnVOEhLcZtjAnKjQf9/qo42viboLq4yaRNNCuhTYM8YqObjp7w9v
         fFa94F4PrRJR1syB6DAfj0wtoDQ680eGmmDGenfQKpOfDtPQ5tn7gdDXK8WrrmyM/yIQ
         cI4u9hYo89ly6RI6A9/iZfkD0LjYHVnSxZka76EG04CZ1k8HTaTohWAeWQSDOCVuS9+k
         TSRgyePqr2FMHo5Vxr2DzjRNq9r9mWbuJaprvl0ZrUYpVGJ1IkWBSi8fVIAAjQeU2ZUG
         aHvQ==
X-Received: by 10.66.121.168 with SMTP id ll8mr2982225pab.86.1402662021688;
        Fri, 13 Jun 2014 05:20:21 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id wq10sm20728448pac.24.2014.06.13.05.20.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:21 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251559>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..7b886a6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -679,7 +679,7 @@ static void read_and_refresh_cache(struct replay_op=
ts *opts)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("git %s: failed to read the index"), action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,=
 NULL);
-	if (the_index.cache_changed) {
+	if (the_index.cache_changed && index_fd >=3D 0) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
 			die(_("git %s: failed to refresh the index"), action_name(opts));
--=20
1.9.1.346.ga2b5940
