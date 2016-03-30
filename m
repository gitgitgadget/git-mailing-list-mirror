From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] notes: don't leak memory in git_config_get_notes_strategy
Date: Tue, 29 Mar 2016 17:38:50 -0700
Message-ID: <1459298333-21899-4-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4AG-00046b-WE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcC3AjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:04 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35154 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcC3AjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:02 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so26232988pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mb4giZhYfVEg0i9zKNmc9pZI+IO4JSijBRJuAiC8vIk=;
        b=NsbBeX9CTvh/U0NUnkgngsu1470X+/Ddo14IwO8umFS86hqu6LW6Z6BwLa67pD4DsQ
         1H4lL26VO8iZkQ+8C10rA3WhqJ7bIYt+sYd7g6z7Fy9TnN2DKqpgdMJSLv11L9YVOT8I
         rX/gqvFWHv5OPfRkDrCz8Mqe3lnfEmkxClEJrM+Zcwvd6SpjhYbWmp0NZIe4/jEfKiBa
         DGAC06GmaOPnSGPTTxksHHsToc9aaGoJWxAOZOCJhIl8VIUo5TMvSG+Yi2uFK9bj3Gh1
         IkmUS0XQd6jv8tzfHdCVi0WmAsDxOz4rGoxKu/96mzioswGhvVdehdPh+Ie7rP8tC2Cn
         Gcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mb4giZhYfVEg0i9zKNmc9pZI+IO4JSijBRJuAiC8vIk=;
        b=YSGFPZYRNBuuRrhc3CUWwI0oY6Oa/N1wMG9xwtmDrEbd1Si+1/fNwc8kInPzLNPMbP
         1JcKrtmI+2jLYppkND3Ac0un+uNyLv1CLOW6zpp9WCjpcDHmSzxxTY9goFjGGZ3GajEv
         J7mpt2ewRVCYPe68tygApsVH4z81XgaGZWMWG+mLpwmn7EnBggZtDTzH5Rl19b3zuL19
         LjrKYRdVQ18UuI7hyvbQtK2ot+jAgObBAf5Z5nNmqXV+whuGlwv4khKKRGnaI1ekXlXd
         Z8F+Zy/uQutQcM7Dm6kFKFmKp2m4uq1Q6ogBLGEMRh6oBIMYrj9z4JnHaLbxCpWQVatU
         Na3A==
X-Gm-Message-State: AD7BkJLGzt5j65p11ldXdn4Et5O24VzOXC2/t3VKH5GYYur8BMbQLKctoLSx9eqXGHlGR9RY
X-Received: by 10.66.139.199 with SMTP id ra7mr8245664pab.74.1459298341442;
        Tue, 29 Mar 2016 17:39:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id e1sm1039915pas.1.2016.03.29.17.39.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:39:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290235>

`value` is just a temporary scratchpad, so we need to make sure it doesn't
leak. It is xstrdup'd in `git_config_get_string_const` and
`parse_notes_merge_strategy` just compares the string against predefined
values, so no need to keep it around longer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/notes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..d6bab17 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -751,6 +751,7 @@ static int git_config_get_notes_strategy(const char *key,
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
 
+	free((void*)value);
 	return 0;
 }
 
-- 
2.8.0.8.g27a27a6.dirty
