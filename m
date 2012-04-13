From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v9 2/9] Stop starting pager recursively
Date: Fri, 13 Apr 2012 17:54:34 +0700
Message-ID: <1334314481-14470-3-git-send-email-pclouds@gmail.com>
References: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 12:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIeAT-0006me-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935241Ab2DMKzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:55:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35185 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935209Ab2DMKzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 06:55:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3501433pbc.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tB+6GIbDn5lUhstUtXt/gsxtU/RI99wa+PcSbW0irBw=;
        b=utPe1I4AMm0aB1dF/rsZdQ0wbDV5TafW1McCXucJMXkuoZTlzS2TNGSJNo7SA66fVU
         Wa7auTH0xPN6iQee0E3Up0HhTnxAYVgSR71TFpromSb7xYO7yzcx35WeeNCUyWeIqQb5
         qDe5RkNHxokmmVGEDbayx2y090EzqwFr7gmmn+BjifqbsC2Xb1ZYlpy0gy/MUCocT5Cp
         QHBHkkY8vvbKaHq1zjrqI1gk8CoIDWXWtEaBPfJdWVCXKaNMj1Ra+kBPnQMzshDT6gkc
         b4EMqpl84PfEyTgC9GtkpZVwa19AXX/bt3tYa0ecyzcCUOxW9kSiB63mI08M6m9yN42O
         pRWA==
Received: by 10.68.221.35 with SMTP id qb3mr3795499pbc.136.1334314549357;
        Fri, 13 Apr 2012 03:55:49 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id h10sm8436699pbe.12.2012.04.13.03.55.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 03:55:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Apr 2012 17:55:01 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195412>

git-column can be used as a pager for other git commands, something
like this:

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

The problem with this is that "git -p column" also has $GIT_PAGER set s=
o
the pager runs itself again as another pager. The end result is an
infinite loop of forking. Other git commands have the same problem if
being abused this way.

Check if $GIT_PAGER is already set and stop launching another pager.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 05584de..4dcb08d 100644
--- a/pager.c
+++ b/pager.c
@@ -73,7 +73,7 @@ void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
=20
-	if (!pager)
+	if (!pager || pager_in_use())
 		return;
=20
 	/*
--=20
1.7.3.1.256.g2539c.dirty
