From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/12] submodule--helper: Do not emit submodules to process directly.
Date: Thu, 15 Oct 2015 18:52:12 -0700
Message-ID: <1444960333-16003-12-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCB-0002He-Cw
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbJPBwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:31 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35875 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbJPBw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:29 -0400
Received: by pacfv9 with SMTP id fv9so5815920pac.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=seb/Soka8WRUauw0rIZpWDPnAQcAW4G2cU4bS5cOoPA=;
        b=NOBMTlQ7saJovZgk6+2DHFExR1aJn/uiqPi6/+YLK6Z+ncJJ5JdRUvSZi8axRF6EHk
         VrLvW9gnUopSo61AwlQ3Elx6MQY4scx2VpxmCdpJhqd9skAFQyOpbP+/amjfigMqamIX
         pP3WpgXW3jZiH3ZunJW25nAEdw/XQX8uyla4Nv815N2vXRdMrIVWKR4fwpsz1fnsnSMy
         ZQkNJjcK/63m3xJ+27L/46A9Jm46S6TIDYI7pNewmxGveKBGXho5+VKdS4KMaSRKYLMR
         ACGBS6NT5Z5xv3vADsroIqyX+Ji+6yz0euR1EAAt1QiLLONJ9LUBOmt6DE6CIULpByAA
         snAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=seb/Soka8WRUauw0rIZpWDPnAQcAW4G2cU4bS5cOoPA=;
        b=S814SoC9ta8u7Z699dgyLnI9+he7Yalc5t+z5eYrsdSA4MKtPGld8L/N8I6FMTKnqV
         4BVlA2xLBLz8aYlJ7yBR3/glRSjrQ3nC1bazx2lStoZP1esmk1qUMF75K5qQrBb1dpNg
         5oTPKjcQL5C7cTkQtwFK2BdZLarhRQPhNbqJKMVAb5hGDPBN+2iRcYIB+XIYTKZGvKz4
         6p/wPWF5qDbK7W2lU/goGHuT8Bqf9vZy3kNBb2ClmuPUIH955RbxUWS/klOEz+efFA+W
         BwHUFZekMX/hkMiNS9Yl2v/Ai41oyPS2TkSco7fuc5afWpKOsizs9VX5gDMd2pAcf3/k
         DYJg==
X-Gm-Message-State: ALoCoQn2srnJnbbtWQS8ytN9Txd0clFsX6GJLJjr3Wl6LgOAHWx/r/29ZTkW2W3x+Wvs14uHdCdi
X-Received: by 10.68.180.131 with SMTP id do3mr13439138pbc.133.1444960348627;
        Thu, 15 Oct 2015 18:52:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id rp5sm17922257pab.0.2015.10.15.18.52.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279715>

This will allow us to refactor the loop to use the parallel process
API.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d1684cf..fa8c008 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -297,6 +297,8 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 	char *update = NULL;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
+	struct string_list projectlines = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
 	struct option module_list_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -403,9 +405,15 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 				return 1;
 			}
 		}
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
+				sha1_to_hex(ce->sha1), ce_stage(ce),
+				just_cloned, ce->name);
+		string_list_append(&projectlines, sb.buf);
+	}
 
-		printf("%06o %s %d %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce), just_cloned);
-		utf8_fprintf(stdout, "%s\n", ce->name);
+	for_each_string_list_item(item, &projectlines) {
+		utf8_fprintf(stdout, "%s", item->string);
 	}
 	return 0;
 }
-- 
2.5.0.277.gfdc362b.dirty
