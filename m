From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] revert: Free memory after get_message call
Date: Sun, 14 Aug 2011 14:03:03 +0530
Message-ID: <1313310789-10216-2-git-send-email-artagnon@gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWBB-0000EZ-Au
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab1HNIgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:36:16 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63576 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1HNIgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:36:13 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1545680pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zGO/1h0D4vI/qOUYGXKwdexHc1V3gS6OmBeCPnFYvwc=;
        b=MrqFnfzqBYHkVThxTzMOHiTlsCCWGorx2GEvT4CrE9C1K9ybPFaHoW8pOOHbetJl49
         m3AamOZukP4ZYoJhaM/w1eHbDI+6pj9wl6h6q0b/X6uAsyEN3JwDjbY3VOxyfiEHu3sV
         VmqlNy+YzYIJEuuBYqTVUsHlTRXS9crKZS8nA=
Received: by 10.142.150.5 with SMTP id x5mr1228236wfd.59.1313310973621;
        Sun, 14 Aug 2011 01:36:13 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.36.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:36:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179305>

The format_todo function leaks memory because it forgets to call
free_message after get_message.  It is a potentially big leak, because
fresh memory is allocated to store the commit message message for each
commit.  Fix this.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b452e8..8a35bfd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -687,6 +687,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		if (get_message(cur->item, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
 	return 0;
 }
-- 
1.7.6.351.gb35ac.dirty
