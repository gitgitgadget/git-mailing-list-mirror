From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/15] builtin/cat-file: free memleak
Date: Fri, 20 Mar 2015 17:28:11 -0700
Message-ID: <1426897692-18322-15-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HW-0001vV-Gh
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbCUA2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:43 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34372 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbbCUA2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:33 -0400
Received: by iedfl3 with SMTP id fl3so2127492ied.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wM5pNYLXa7oQ7LdSMzymKSimlRP99wTAb2NeADs/jIc=;
        b=ZNTMDywcWqbYmAhQLA9os8OIWZyDhiDMJPXBETnYYBLxG0r7CDkKUvrRW2u1r4sBgs
         Jvm+WGCZppqtXVfnYXl/Bg1es0lieG3ItdLpCdz8wY4h/XhQ22Z9jXqqOndwiiaPDtj1
         lJSjx0sUW+0XnxDjkVjf/I0ThrTx1J5wrvm1A7+iaaBuvgBjcEGEMQT3kF+fzfUZ8dbN
         Jw58Dg3/PFzA338ksMgSOIL4p6hf3rwI6idDmsFF/dO/j8FUnx044aS/tYzxbmDF2Mf7
         aStdDW5mfCDvlCvEzqt6hW/N+unnzlHhC8vXPTPirc7kUCfsX81xnyOEmlRODhdKJW5V
         fcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wM5pNYLXa7oQ7LdSMzymKSimlRP99wTAb2NeADs/jIc=;
        b=GOj2iRNYxUMbI/JCk1rer++fyL3jwIvsHEsyU3drnqnvWTuJG5/Cmf6yQ0fE+KmYlV
         ZGy3eRwcOQOIKgFyQkin/nCZu1yYpNBOoYjx27SEKv5GYYdPzWOR8ULwAOIU7gLnf7ws
         7RZ7B5ZrrrLKmjTEc3mfppJpXgUyk9e7NiE6GZUyN5NUISED45A/XLl9p2rbqItWQFwo
         v0PAQwcXnB9bY/75fZZLz9AroqdVxoRkCD4kQNwV7DVTNVVkPjMFn2cyJkk/J17cBYC7
         XJFswbWSp5na/NRywuVtBTnOBrM+7mk04b8gfc1wsfQTCj6NDMkj4CaBXSEMsGnka9YP
         JYLA==
X-Gm-Message-State: ALoCoQlsqzv5oh7pDPUWUP7aPLQ+mN/GO20VdjCI+WtezvV026ytFWqlhxwBYjGvZuHjvebI77Ph
X-Received: by 10.50.29.109 with SMTP id j13mr522935igh.2.1426897712820;
        Fri, 20 Mar 2015 17:28:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id w9sm191347igp.3.2015.03.20.17.28.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:32 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265991>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    see discussion

 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..8de6b0d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -104,6 +104,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	free(buf);
 	return 0;
 }
 
-- 
2.3.0.81.gc37f363
