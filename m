From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] repack: Add --version parameter
Date: Thu, 26 Sep 2013 10:32:29 +0200
Message-ID: <1380184349-26380-1-git-send-email-stefanbeller@googlemail.com>
References: <1380162409-18224-10-git-send-email-pclouds@gmail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: pclouds@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 10:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP702-0005gz-D6
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 10:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299Ab3IZIcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 04:32:33 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42015 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3IZIcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 04:32:31 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so366469eek.27
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uOZk49PX/UXtPDT63vHVl5R9nGh9tsYuUAr3FZaf/rM=;
        b=zTzN2c55Q/kmuSggnH8puRcDFfhMZ7w4DWB4RDbKXPH8S4YGiqnjncKKbJoN8ngCpQ
         AZSZ2Dc6T6apimoFSeTJzPyzxN7XCQa/OBDZnTibOCfavTs0HT1bC58e/BRbX3KZu7C+
         NW9E4BFim93GEyQVdDnywpOlmr3zdfM9gIPLwq5n5CLCtCD9iNKXS8NGPvxvKU040gfD
         /9ae9P44z/rmOpZ8S1Fz1IQ6EwgqAv4o8E4kQFLZIxbYz8Yp2FdDD+CIpy7+ajoUyLLx
         ELBYOnSjAlKUnd5J4anDyomRH1D+KcWRk8PIbwW9TtmDYNLs4illp7CtS2C0yAUR/DA2
         ES8g==
X-Received: by 10.14.210.8 with SMTP id t8mr61954082eeo.39.1380184349841;
        Thu, 26 Sep 2013 01:32:29 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm1289656eem.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 01:32:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.474.g128a96c
In-Reply-To: <1380162409-18224-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235404>

This is just a direct translation of
http://article.gmane.org/gmane.comp.version-control.git/235396
So I don't consider this is ready for inclusion.

Some notes:
We need to have more error checking, repack shall be 0, 2 or 4 but nothing
else. If 0 is given, no argument is passed to pack-objects, in case of
2 or 4 --version=<n> is passed.

Do we really want to call it "--version"? This parameter sounds so much
like questioning for the program version, similar to
	git --version
	1.8.4
So I'd rather use "--repack-version".
---
 builtin/repack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 3e56614..fd05e9a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -9,6 +9,7 @@
 #include "argv-array.h"
 
 static int delta_base_offset = 1;
+static int pack_version;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -22,6 +23,9 @@ static int repack_config(const char *var, const char *value, void *cb)
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.preferredPackVersion")) {
+		pack_version = git_config_int(var, value);
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -165,6 +169,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum delta depth")),
 		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
 				N_("maximum size of each packfile")),
+		OPT_INTEGER(0, "pack-version", &pack_version,
+				N_("format version of the output pack")),
 		OPT_END()
 	};
 
@@ -220,6 +226,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd_args,  "--quiet");
 	if (delta_base_offset)
 		argv_array_push(&cmd_args,  "--delta-base-offset");
+	if (pack_version)
+		argv_array_pushf(&cmd_args, "--version=%u", pack_version);
 
 	argv_array_push(&cmd_args, packtmp);
 
-- 
1.8.4.474.g128a96c
