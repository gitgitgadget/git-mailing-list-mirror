From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] revert: Free memory after get_message call
Date: Sat,  8 Oct 2011 23:06:42 +0530
Message-ID: <1318095407-26429-2-git-send-email-artagnon@gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:37:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCapq-0004l3-Fa
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab1JHRhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:37:03 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35970 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab1JHRhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:37:01 -0400
Received: by pzk1 with SMTP id 1so12271226pzk.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U18K+OzxeANMEvdsC9hlC3UpVahfNpOhuNG2dqU/ju8=;
        b=SPXy7BtjCah4rM/nlf6RU53UHhBUErNK0JalO5nZwT2abK3YobrRyODUywPdf2G1Ys
         Ue6G0QouM/8HOrD4eO87zH4bJ3ZZ7XyI5MKHNw6D6BUM+YgL0FLW0nnaCVl9eJJJrg3U
         no0PpYmkj/pf9Qs6dsQAQC1HSi4UvsIpHSVmg=
Received: by 10.68.72.73 with SMTP id b9mr17169388pbv.100.1318095420884;
        Sat, 08 Oct 2011 10:37:00 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.157])
        by mx.google.com with ESMTPS id h5sm45151528pbq.11.2011.10.08.10.36.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 10:36:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183158>

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
index ba27cf1..a2c304d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -682,6 +682,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		if (get_message(cur->item, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
 	return 0;
 }
-- 
1.7.4.1
