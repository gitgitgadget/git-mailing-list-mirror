From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/32] sequencer: do not update/refresh index if the lock cannot be held
Date: Mon, 28 Apr 2014 17:55:24 +0700
Message-ID: <1398682553-11634-4-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDB-0000tI-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbaD1Kyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:54:51 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61247 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbaD1Kyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:49 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so5720588pbc.35
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lpHNb5SvAbru9gX1ZlZ4t7cdOHR7AnJDG5TVyWIz/rg=;
        b=FAy4ujqJa/oNDNRCgE2tpbuvjge4Yw2myDufAYZV7grCU10Ybjz527XwU2lsyNfjdu
         rDfN9wmYUM+vjge3uhIGAz67rA8HxH5jjDAW+WDm7QNNLlrQjopIebHSoYioeHqIRH2W
         kCXo+TnkYSdwFeGg2mI9rpFl44+2JNPFJ9mOhofggvQfeSzn3Q9rO236xeUU/84K2x/6
         dDYx3zqebLACWAV+R6F4AjU+l/HSLr3fWJ373RCFBvGe+eW3mzuO+xgsSxMMExN7leKh
         qAQ0ZISa2epYlKC3AqW2no0g3pexrFRxbgptKsItaUc2SlTkhMbc9pKh58P66Es8nKnP
         102w==
X-Received: by 10.66.250.161 with SMTP id zd1mr3075695pac.136.1398682488791;
        Mon, 28 Apr 2014 03:54:48 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id gv11sm34155489pbd.76.2014.04.28.03.54.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:16 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247270>

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
