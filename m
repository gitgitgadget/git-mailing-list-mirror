From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] revert: free msg in format_todo()
Date: Sun, 23 Oct 2011 00:43:42 +0530
Message-ID: <1319310826-508-2-git-send-email-artagnon@gmail.com>
References: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh3Z-0003PV-6O
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab1JVTQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:16:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62916 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1JVTQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:16:25 -0400
Received: by mail-pz0-f42.google.com with SMTP id 36so12597396pzk.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lYeQAv4uvq71vXpSQn/DDP1bSONcbibFn+QTKRuzf14=;
        b=SNq8ygPQv1h7Vnf+1xsFexWQRZFv8/0/x8XPfVNKXjj7wpn1Koru5z0q6+1f10fhvf
         xC9uqGGFl6xN9TSerq4cVycl0qkaPZa1WUS3tAccBDoo2MxSgTBATrrUkqx9knQnAiWb
         tF4YPmVULbDhhPPtwU2N1ngtgsQH0+6u6IeXg=
Received: by 10.68.28.65 with SMTP id z1mr32659689pbg.120.1319310985678;
        Sat, 22 Oct 2011 12:16:25 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm36939881pbq.10.2011.10.22.12.16.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:16:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184112>

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
index 87df70e..a6f2ea7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -689,6 +689,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		if (get_message(cur->item, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
 	return 0;
 }
-- 
1.7.6.351.gb35ac.dirty
