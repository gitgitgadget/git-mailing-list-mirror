From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/16] checkout: die_if_checked_out: simplify strbuf management
Date: Fri, 10 Jul 2015 20:05:34 -0400
Message-ID: <1436573146-3893-5-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp90-000763-PL
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbGKHYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:24:08 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35518 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbbGKHYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:24:07 -0400
Received: by igcqs7 with SMTP id qs7so27133557igc.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ES944gBMJbXMRxaaw4mmYfgsobNmANirxpHHuIqTVmM=;
        b=NVaHAWME7hCRhclrXfAxIc6Vwv1rG1NiuvBM1fm+6jln+KPNKbUe35m4OmSM5DL0Wr
         TzQOvgO5sZ8WlYvBms0vre5yx5nUFD8pJUy916dNrrdUYOHMFOqlh79l4qj+Ml4f9KZx
         cwdDWoWDhESWlGxymkquTa+XLGmwezo+KXVQbHx033eyKJv7LG0QXlWRVPBTh2xGLbw/
         Gr5PY+gQDNc0hul1h/pmIHe6cxv16epkgof5f8vqETzKOR0lNCc8f6CkrbcPX4Lchz/X
         OwFL4HgzSTaRmiQAeKRop8QIIo00IzmLWffGyb5LxxRJOohcIW7pMZpQSKyKLnzqUVWn
         MAfQ==
X-Received: by 10.107.15.153 with SMTP id 25mr35768050iop.44.1436573191472;
        Fri, 10 Jul 2015 17:06:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273864>

There is no reason to keep the strbuf active long after its last use.
By releasing it as early as possible, resource management is simplified
and there is less worry about future changes resulting in a leak.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc8bd79..ee33a20 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -924,17 +924,16 @@ static void die_if_checked_out(struct branch_info *new)
 	check_linked_checkout(new, NULL);
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-	if ((dir = opendir(path.buf)) == NULL) {
-		strbuf_release(&path);
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (!dir)
 		return;
-	}
 
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 		check_linked_checkout(new, d->d_name);
 	}
-	strbuf_release(&path);
 	closedir(dir);
 }
 
-- 
2.5.0.rc1.201.ga12d9f8
