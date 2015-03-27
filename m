From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 6/6] WIP/RFC/entry.c: fix a memleak
Date: Fri, 27 Mar 2015 15:32:49 -0700
Message-ID: <1427495569-10863-7-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, john@keeping.me.uk
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcol-0005m7-3c
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbC0WdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:22 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33924 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbC0WdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:11 -0400
Received: by iedfl3 with SMTP id fl3so91484271ied.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OtS2/gQIjLasUeF4sp8J+nLdEFXVyjrZgBWTQDaHYPc=;
        b=EZJ5NeuAoBnSEopdT7iJwqVZQpkso8Bkxuj7G8FIHelmOab45Fxg8pqgTsjokHQx4/
         Yir603Pcqhxe4bqzwMbKSv06aQFOhLVaItsUhpf/XiFLNvEayPEqVuSBZ+HNwDoByGyp
         7auK7UUzFxp5UEjLLd98gfUm0Y+XbLyb2pOXcshhSlcsjeL3Qj4clWr5rwCrVsbeGU+5
         4UajMv/EUVZq+T+y8N4FB4CTotmJ1d7xdqfEo5iPdqrZA5frM3z6iBgWZtGRuU8LbSRL
         kMnu4FMtzGiucqMY7hlz85QNJnUZVhAf8b9VJatiyH/5atkmGSKdbvSztdQn7Y1Qo9g2
         x5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtS2/gQIjLasUeF4sp8J+nLdEFXVyjrZgBWTQDaHYPc=;
        b=RLztFZ23uuaOKkKAvW8q8/SuD263W/euyzP83pXRNf8JeI/i36bR+jM9r6dKG1nTDb
         3GYmFIYab3WyyNnxNWtcCQLoXFl8PkQMjc085oWLeRZTZ4V4dhHZIOsl98PIrU4hYVp/
         JS5nnlF+g3YxFPIPg7TYMiuiO0fbzK8uHrughkY70obFgPl/1cNIfgp2FNP1ba+VAGZW
         rmU96R0WmiwIMXAw8ckGSYYLhW88rXo4ovpCfBkiSZF0vNjP5mIX8OM8j9sCv9xl5stF
         K6gD7rMuaTlhkM14oXH09a7Qbe0/7Clo6SQqWdBEqEcOl+l/FS1zn+p4Yw9JuU33AIII
         lQbQ==
X-Gm-Message-State: ALoCoQm9eaTbVG5jlHwYvcKB51UHy7W/g/eKA8XKP2cAzTmkFq+JMcHpxk8OtGgFbggglPeataRU
X-Received: by 10.43.90.199 with SMTP id bj7mr47652028icc.35.1427495591094;
        Fri, 27 Mar 2015 15:33:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id b137sm2171341ioe.36.2015.03.27.15.33.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:10 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266398>

I  observe that filter is going out of scope, but the
implementation proposed in this patch produces just a
crash instead of any helpful fix.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 1eda8e9..5383001 100644
--- a/entry.c
+++ b/entry.c
@@ -152,8 +152,10 @@ static int write_entry(struct cache_entry *ce,
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
-					   &fstat_done, &st))
+					   &fstat_done, &st)) {
+			free_stream_filter(filter);
 			goto finish;
+		}
 	}
 
 	switch (ce_mode_s_ifmt) {
-- 
2.3.0.81.gc37f363
