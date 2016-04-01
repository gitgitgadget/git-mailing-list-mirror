From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 17:35:43 -0700
Message-ID: <1459470946-16522-2-git-send-email-sbeller@google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:35:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aln47-0007ib-LT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbcDAAfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:35:52 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35210 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbcDAAfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:35:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id n5so81097258pfn.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/x6ZTAcx/DpqMfFKO3VSiuZSWXo4VdtEpYiZdIXJVQ=;
        b=KAtUowuoX+ykUAPAGPcURWYb5maYPbbtiYS7b+Yo2Iyw+dYmQ2/ufDycq5E1ezF2r1
         w05hnNwzRTX1FTdQQdQI5Xe+YZ6JJzi2JeAS6/4dqApAcelAvYJQ3WRN67YOGIhwDXJK
         YUQxltKJvRo7Mbn+aXsWyNXnAUGDKoStDa+gzc0ULyRA/v/JRxJEJ6PJAaVXh7JkuVZj
         mctWMrAfNOUsRLZ0dq7TJ2lB+MtDif+w02BqhNLe60BT+5MWFtmDxyPBUbpCRihqhm+d
         AOvZ0e4zQz6x1Tz0GWuXDz0MHICv5uV1POeQaIq3yByFNnIj+FIRE7yS0eqJhhzjJt3+
         LY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B/x6ZTAcx/DpqMfFKO3VSiuZSWXo4VdtEpYiZdIXJVQ=;
        b=WbDgRt/0oLLM0zelNRkhHH7Pizzl6AcpMlVHTUxGZtaUlObSszbE052U0MQRC0FGTi
         VTwyQB/76OFnw2Bv8m7UIkqAg356rnSr9n4057G3+GfyIJDsRXm/Gr4hjykkAhZoBYnK
         hBznXYVznLN+5MArfyLVWPJzwcj7UgNgzZBeL1HJ40ssP5CS69MULC+AOV5ERbiG9tTI
         88pMJBzQXe2huALFAq3cu3kakPrbWkYpucdtq6BvyN05gV+mR+vC3E8HpWk5kFDLd+u+
         Fs9uB1n7wZgHR0UapRj7ioPjascXjinPZSVOhJxV9xUxjwkEQ6KCbapbcRbxi7n6fL0b
         OoIw==
X-Gm-Message-State: AD7BkJLqVpG17D4PQqruQo0sIroiUo7HabGexZv6zOdIfUlVkWUdtEc282kqwCHXXNHfxn6f
X-Received: by 10.98.68.71 with SMTP id r68mr26401520pfa.119.1459470949884;
        Thu, 31 Mar 2016 17:35:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id wb7sm16032543pab.3.2016.03.31.17.35.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:35:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459470946-16522-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290497>

`value` is just a temporary scratchpad, so we need to make sure it doesn't
leak. It is xstrdup'd in `git_config_get_string_const` and
`parse_notes_merge_strategy` just compares the string against predefined
values, so no need to keep it around longer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/notes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 52aa9af..afcfa8f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -741,13 +741,14 @@ static int merge_commit(struct notes_merge_options *o)
 static int git_config_get_notes_strategy(const char *key,
 					 enum notes_merge_strategy *strategy)
 {
-	const char *value;
+	char *value;
 
-	if (git_config_get_string_const(key, &value))
+	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
 
+	free(value);
 	return 0;
 }
 
-- 
2.5.0.264.gc776916.dirty
