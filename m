From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/15] ls-files: fix a memleak
Date: Fri, 20 Mar 2015 17:28:12 -0700
Message-ID: <1426897692-18322-16-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HO-0001p5-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbbCUA2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:37 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32801 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbbCUA2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:34 -0400
Received: by ignm3 with SMTP id m3so1310149ign.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJytlmr4OZTQ5PRsyowIQdZLOVGzGOQuKMu+z71kvqI=;
        b=bXRu4rQ6tZ2v5jTzqG1RUrpHifiPvm+ieH375NXPjjTHkgIoQGjdOM++pU9tKcZwv2
         cdl9c7u+frBDbOMpK6uhEzDBITQRcRPZ93yQgR63wqdkTcfRgCLa00pLiR0/tUF+7jnL
         xGA/27BtLdec2XwNqVZ88MnabUZAAmQSOan2lknxPBNhqncHvcbDZB3ug+PuR4FQolfN
         2iRrcAL9C+2XyHnBqynI0TZzDdkrJkuPp7000DRnQo2+RqnUAV5kUYmpohfPDR3ml1sn
         ND2NnjrvCiz9kfLhGVrIphKpJye8USS9DBmXTIyFQxMUexXin+zBYNFREFnqtftLH27A
         VytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJytlmr4OZTQ5PRsyowIQdZLOVGzGOQuKMu+z71kvqI=;
        b=UHic9Ftw/jf5dop8ae08hVwEB51Bt94KJsUykA7E36J55DrZptGzyvVPq/0zsRiZaz
         RlFFwyZ2pvIP5yR7Px9Ktgg9FIpNqtAlhzdvI5lFaV+bBB/vk/MuniXsTUIiumvaEK0Y
         4Fi3EUB0u4NU4s0hXw/Z5eGMsUEOLVl8UrUBiDLYbpJvr/81ggzMnHu8lFmeslnAgTPK
         eQ4sJM17nVJpd41ixNG+FE6tMObI2XhtxDJuPXPX8xDDktE3CIcB9Gitdrdp2MRc62Lu
         QY9AxrVdTBplLk3SKzS6JqLM+lNVL0QBfg8ULCOYwe5LtzjXD/5Mbmi5lQpVHFgIfbYG
         TbwQ==
X-Gm-Message-State: ALoCoQlw7o2IVUHiXpfd/ZOm7YLs+JYEdxfNLfEEZ2XRcLkTf8jQ2fyp0+Qy946mYoD7uAQXNPw/
X-Received: by 10.107.164.140 with SMTP id d12mr105838790ioj.13.1426897713813;
        Fri, 20 Mar 2015 17:28:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id q78sm4230909ioi.28.2015.03.20.17.28.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:33 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265986>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    see discussion

 builtin/ls-files.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 914054d..306defa 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -590,6 +590,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
+		free(ps_matched);
 		return bad ? 1 : 0;
 	}
 
-- 
2.3.0.81.gc37f363
