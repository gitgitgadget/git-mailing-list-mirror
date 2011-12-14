From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/10] revert: free msg in format_todo()
Date: Wed, 14 Dec 2011 22:24:28 +0530
Message-ID: <1323881677-11117-2-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras6h-0004US-H4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563Ab1LNQyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:54:53 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1LNQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:54:53 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so774122vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GkFeSAkLFQei3IuuDRtyiUzxv2f78YJJRriXJS19vjs=;
        b=lqZb1XRjvxDMMAEBlqM4hFLWxYgaOL9OJWoN/3eV6CuB3ovH6ZJwAzQA4tlc64BSLr
         mLpa5WPu8Uk9F5RGs+jgBy3WEEvMn2dGj89GA+Bq+YAzGVbkDvlKJ9Dg8L3XeZgW9tk/
         BtB7TNVA1yEPbLguJrrk8+DX73s0Mwdzi2thg=
Received: by 10.52.97.35 with SMTP id dx3mr5370558vdb.2.1323881692937;
        Wed, 14 Dec 2011 08:54:52 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.54.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:54:51 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187145>

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
1.7.4.1
