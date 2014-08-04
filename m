From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] pretty.c: make git_pretty_formats_config return -1 on git_config_string failure
Date: Mon,  4 Aug 2014 07:41:15 -0700
Message-ID: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 16:50:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEJaO-0001oQ-MC
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 16:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbaHDOuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 10:50:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37645 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaHDOt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 10:49:59 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so10147311pad.38
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QeKdt4wQir8cmLlbIB6VmiNAmFIo4rniw3p2brHsHWE=;
        b=ccSqAzbJQEN2KHaRVMydcvW2wE/PdrCZft9WosRw3NasQXIVkHFP7260vJCoqxiYH/
         bEvpcbyZJO6SiMl6LLNLUMCUPgnB0oifQDAHHsm5ZfOz4FNP6sbFPABrePjvXchdeDbV
         G/W+FbGtjItK7VEiNwLuPkWowxdOy5vy4u3Aqi9FCLQ57IYJOL+DNY2IxTciHWxOgS/S
         7NUbobyipgoT+FUkmbhuydDNcPtNKjZJUeMTpzbgUkb/+qTR8gcUz5oFx0u7SvQZvB96
         sbCzhJOTkZdW61i3+FJlcYGXxiYLZd03xTLnn+x07P57m5KA/lVyeZh6m3p5wMhQKQXa
         Uy7g==
X-Received: by 10.68.223.1 with SMTP id qq1mr24559933pbc.62.1407163798603;
        Mon, 04 Aug 2014 07:49:58 -0700 (PDT)
Received: from localhost.localdomain ([106.211.107.187])
        by mx.google.com with ESMTPSA id fw3sm1959421pbb.2.2014.08.04.07.49.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 07:49:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254739>

`git_pretty_formats_config()` continues without checking git_config_string's
return value which can lead to a SEGFAULT. Instead return -1 when
git_config_string fails signalling `git_config()` to die printing the location
of the erroneous variable.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 pretty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 3a1da6f..72dbf55 100644
--- a/pretty.c
+++ b/pretty.c
@@ -65,7 +65,9 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 
 	commit_format->name = xstrdup(name);
 	commit_format->format = CMIT_FMT_USERFORMAT;
-	git_config_string(&fmt, var, value);
+	if (git_config_string(&fmt, var, value))
+		return -1;
+
 	if (starts_with(fmt, "format:") || starts_with(fmt, "tformat:")) {
 		commit_format->is_tformat = fmt[0] == 't';
 		fmt = strchr(fmt, ':') + 1;
-- 
1.9.0.GIT
