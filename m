From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/6] line-range: fix "blame -L X,-N" regression
Date: Wed, 17 Jul 2013 17:25:27 -0400
Message-ID: <1374096332-7891-2-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEj-0003pe-2s
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab3GQV0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:07 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:36919 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3GQV0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:05 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so310479oag.22
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=D7cH1GDjd4Y8vpAqAXb8pd4vzdXhx2tSLnUsZ/u2zkc=;
        b=QrLvyXRYrQByP5+DebKeGNFYWdH1nj0lTkz4TxhH5ovuOJtXOMdrg4YVCQNlwY1QzR
         VkTI4afqjRDyan37bOgWfaWPq44iZvlqkwTFaghBUw0wEFhtijDVvAwMGgPCms1to481
         nekqYCOJ4KWou7p9qWJsPtjco44ghk1PrlMaYxfXnuxK6RTBqG5/92dgDYBYD6u6atov
         zzHA3jtvP1K4h7bJm3zGpaOx9xZFG1l406mgMyg1eR5UqJhhj+d4Pr1XkqvHZ7WVMa8o
         YfvmqobiopgELAzYTN29O121619Mb+myJfCwqhr0nhBi8K1qpZDMIRmJqFoR2UYAQC+r
         VWzA==
X-Received: by 10.60.140.168 with SMTP id rh8mr10392752oeb.17.1374096365345;
        Wed, 17 Jul 2013 14:26:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230652>

"blame -L X,-N" is documented as blaming "N lines ending at X".  In
practice, the behavior is achieved by swapping the two range endpoints
if the second is less than the first.  25ed3412 (Refactor parse_loc;
2013-03-28) broke this interpretation by removing the swapping code from
blame.c and failing to add it to line-range.c along with other code
relocated from blame.c. Thus, such a range is effectively treated as
empty.  Fix this regression.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-range.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/line-range.c b/line-range.c
index 8faf943..3942475 100644
--- a/line-range.c
+++ b/line-range.c
@@ -211,6 +211,8 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		    void *cb_data, long lines, long *begin, long *end,
 		    const char *path)
 {
+	*begin = *end = 0;
+
 	if (*arg == ':') {
 		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, begin, end, path);
 		if (!arg || *arg)
@@ -226,6 +228,11 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 	if (*arg)
 		return -1;
 
+	if (*begin && *end && *end < *begin) {
+		long tmp;
+		tmp = *end; *end = *begin; *begin = tmp;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.3.1016.g4f0baba
