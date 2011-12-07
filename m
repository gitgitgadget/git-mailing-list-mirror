From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] revert: free msg in format_todo()
Date: Wed,  7 Dec 2011 12:07:53 +0530
Message-ID: <1323239877-24101-2-git-send-email-artagnon@gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYB9v-0000Kw-M6
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1LGGjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:39:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51429 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab1LGGjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:39:06 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so437161iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=k4FScRwcqxh7Ms7Iwn6/2W380WRvmwyORfX1cllcLAQ=;
        b=I9oWtGEGl/xnfZIFYECfWAIiaXO9b5w4PlkJumIK2yfVycLCkQ4YK+tFCvkkcyB0UT
         c+KjcEVNOwy3MXS3pYkQf/i0S7R4+YDtiQxp32wQON3R8aJKHTRoAvWEZeVMLQ7hp1kA
         sCe6aXxDmjt9nOzs0yhITWphNQpb3BmT04TG8=
Received: by 10.50.207.40 with SMTP id lt8mr17079386igc.43.1323239946012;
        Tue, 06 Dec 2011 22:39:06 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id eb23sm3166839ibb.2.2011.12.06.22.39.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:39:04 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186426>

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
