From: David Barr <davidbarr@google.com>
Subject: [PATCH 2/7] vcs-svn: prefer strstr over memmem
Date: Fri, 25 May 2012 00:04:14 +1000
Message-ID: <1337868259-45626-3-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfY-0003mX-UF
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711Ab2EXOFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60207 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab2EXOF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:29 -0400
Received: by pbbrp8 with SMTP id rp8so302227pbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bXGXRJZcJCz+qtaB11tFpq9vMwcKzjxNP+UzxaxpFx0=;
        b=mjz5OeSrYzxLAoO6UUDK8VO/X7dOaTU2jOzxfizOzHO7e0DrIGMgrS0LSryrtaHBB8
         UemkJ7/DThW8eJ2Yls+9BmAmxAgRbIxsJk4S2JOpGg9XRAUNxHdwJZQseLUgtqAcgAbf
         uaxIw27agiuz+d0l3fyXZv9Z67uWEi5XfqXplMBCmovuXMfYubhbtbA2+ps/EnM4Y3vM
         DChUz+aN7s1jIpKO62vr5w0gu1lIjBX1Z/jzbo6UQCUvt31POliAgpokahaM83s5X+Rk
         3e7AccdfSsvm3NyfEs3CYNhYv/TMsytaO4tTx1EMXFNt+5Uh2SlcP/j4aBj0FYi+I9nb
         3Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=bXGXRJZcJCz+qtaB11tFpq9vMwcKzjxNP+UzxaxpFx0=;
        b=mVemqj2yWpG1M4Kf1pNJ0BKEr+Hs1MgICTvh17uaDpeWut2z60L5UaQrbhlLsup1rv
         iqgIzZlLsqkFGIBFbAYarvBLC3plBFJ9wds7dLCxsNk74TWO0bDtnaIP3drE5PKQagkv
         M8AISHFo/MIoTy8lEy24n2qxi7x7aZ1ikkRK8o3LPUyWT5T8PvMASQ8FQ4ZcNueBmf7r
         kjSUu1w2iKGQPwVR8J/1V17UTnnJAAYuenUJ6Aa2RO1N4xei/I8Ccshf7hZoY2f+eDMl
         Fb3R5ZtmFetMM5U/3bxDYvQTq5sBMo29h1pckJFKIk53KD2cdAqyzfMTZ8z0A0WpWWAV
         Re+w==
Received: by 10.68.238.134 with SMTP id vk6mr21408561pbc.128.1337868328572;
        Thu, 24 May 2012 07:05:28 -0700 (PDT)
Received: by 10.68.238.134 with SMTP id vk6mr21408542pbc.128.1337868328481;
        Thu, 24 May 2012 07:05:28 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQkkaiDtL5u02MvuHoXUQww4Nlkmqp3WgRAdMHb/bNDgsFzHjELvW9jObyyw5N8djNnNsnmzVE1kay1yMCZ6ofNgBO6QcWPk+jq7AZwANcpbJPKOGa3fxiB2pU8fmEGdas0I3ztDKJT/P8p5ugSTYzNEO+OlQf7TLML3OYRsN5hnCbkOeWw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198378>

The common pattern is to use strstr to match a fixed needle.
As a bonus, elimate dependency on memmem for upstream.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b823b85..cda37dd 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -163,7 +163,7 @@ static int parse_cat_response_line(const char *header, off_t *len)
 
 	if (ends_with(header, headerlen, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
-	type = memmem(header, headerlen, " blob ", strlen(" blob "));
+	type = strstr(header, " blob ");
 	if (!type)
 		return error("cat-blob header has wrong object type: %s", header);
 	n = strtoumax(type + strlen(" blob "), (char **) &end, 10);
-- 
1.7.10.2
