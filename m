From: Tzvetan Mikov <tmikov@gmail.com>
Subject: [PATCH] line-log: fix crash when --first-parent is used
Date: Fri, 31 Oct 2014 12:43:56 -0700
Message-ID: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tzvetan Mikov <tmikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 20:44:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkI7J-0007Pf-JB
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 20:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbaJaToJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 15:44:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62332 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbaJaToH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 15:44:07 -0400
Received: by mail-pa0-f54.google.com with SMTP id rd3so8276463pab.41
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tlMM/ZCDg/+SeDmIcaeRekZVPFLP6e063GtN1La5QI4=;
        b=UH5jhNqtWk6VKAJsxjmDzMvbn00AmF15BM1ZO9TjyOqiM14hMsTefpdEMhS2XIer55
         zAw0lVgBWr9ui7ZuwTUMaDXUezb8c0AzLegPiNLeA3500Ss8IJLgwRfEPS9IxlTz7nYv
         47SZDjBTNNBtEpcfYqcHCHgQxkrXyyx4VX2TIuydDO5Ehu35MFfI4bMw5xJqzXFZK6Kt
         uOuSvNyNrovfqmreTUZo2zFGzhjAl20KIO8OvRjjFY88sWORBSCjsXsQcQjPdWWivUNB
         BGccFxQa4FJJTSok/s/QTkTwQDE3tCgSJdUhItm2fPsjRYQZ4NEATumrMoEzcO/Hdov7
         eiBw==
X-Received: by 10.66.139.134 with SMTP id qy6mr15941466pab.128.1414784647117;
        Fri, 31 Oct 2014 12:44:07 -0700 (PDT)
Received: from localhost.localdomain ([199.47.77.98])
        by mx.google.com with ESMTPSA id rb2sm10693442pab.5.2014.10.31.12.44.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Oct 2014 12:44:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

line-log tries to access all parents of a commit, but only the first
parent has been loaded if "--first-parent" is specified, resulting
in a crash.

Limit the number of parents to one if "--first-parent" is specified.

Reported-by: Eric N. Vander Weele <ericvw@gmail.com>
Signed-off-by: Tzvetan Mikov <tmikov@gmail.com>
---
 line-log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/line-log.c b/line-log.c
index 1008e72..86e7274 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,6 +1141,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	int i;
 	int nparents = commit_list_count(commit->parents);
 
+	if (nparents > 1 && rev->first_parent_only)
+	    nparents = 1;
+
 	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
 	cand = xmalloc(nparents * sizeof(*cand));
 	parents = xmalloc(nparents * sizeof(*parents));
-- 
1.9.1
