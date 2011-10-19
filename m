From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] revert: free msg in format_todo()
Date: Thu, 20 Oct 2011 02:33:23 +0530
Message-ID: <1319058208-17923-2-git-send-email-artagnon@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdKw-0000CW-NM
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1JSVF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:05:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52807 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1JSVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:05:58 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so2083069gyb.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gsZ2/I5nv7/2IlkrwivYZyviO7FOTy6etvTSthbVoAw=;
        b=Nf9aox4b6sxeGwXrcBlBOFx+6U6VjZD5FKJGLGzZzZpNxAZIvPhgLSh/eBUaVM6bs2
         q7ps5uL3ix2RLUR5L8O+OuOV+9IQJI9BxTIzyCTLJXOjMwBiSO6DutfyIPFqlZ85KhUq
         QijZexo3M4NcvS9VlNiVf0Hi7Eovx4+j/Ezg8=
Received: by 10.68.36.131 with SMTP id q3mr7335384pbj.3.1319058357319;
        Wed, 19 Oct 2011 14:05:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.05.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:05:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183963>

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
index 010508d..94b7c50 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -680,6 +680,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		if (get_message(cur->item, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
 	return 0;
 }
-- 
1.7.6.351.gb35ac.dirty
