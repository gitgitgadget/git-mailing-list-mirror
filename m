From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/9] revert: free msg in format_todo()
Date: Fri,  9 Dec 2011 21:11:58 +0530
Message-ID: <1323445326-24637-2-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bZ-00010h-H9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1LIPnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:13 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41561 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1LIPnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:11 -0500
Received: by qcqz2 with SMTP id z2so2223292qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=k4FScRwcqxh7Ms7Iwn6/2W380WRvmwyORfX1cllcLAQ=;
        b=wtGv58xrIHbMe45glPIxgTa+ER6ecbM5+GgpNR7RlpiX5DH/DVFCTQedfyxx5H1iRs
         umVCy+D4MieHzjgaTrn1PzsbFUhZNFlOAjOvciKVqa2IatwKuD/6JtHtKtxvXmNZPzxY
         aw6u+CwHc0/0/ezembESfdkKSBvyIMLbM2MA8=
Received: by 10.50.77.194 with SMTP id u2mr3983398igw.2.1323445390603;
        Fri, 09 Dec 2011 07:43:10 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:09 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186639>

Memory allocated to the fields of msg by get_message() isn't freed.
This is potentially a big leak, because fresh memory is allocated to
store the commit message for each commit.  Fix this using
free_message().

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1ea525c..0c6d3d8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -706,6 +706,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		if (get_message(cur->item, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
 	return 0;
 }
-- 
1.7.7.3
