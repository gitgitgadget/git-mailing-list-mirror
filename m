From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 2/4] fix 'git add' to skip submodules configured as
 ignored
Date: Wed, 4 Dec 2013 23:21:05 +0100
Message-ID: <20131204222105.GC7326@sandbox-ub>
References: <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKoj-0008W5-73
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3LDWVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:21:09 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:48562 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3LDWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:21:08 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoKod-00086p-2s; Wed, 04 Dec 2013 23:21:07 +0100
Content-Disposition: inline
In-Reply-To: <20131204221659.GA7326@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238818>

If submodules are configured as ignore=all they are not shown by status.
Lets also ignore them when adding files to the index. This avoids that
users accidentially add ignored submodules with: git add .

We achieve this by reading the submodule config and thus correctly
initializing the infrastructure to take the ignore decision.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/add.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 226f758..2d0d2ef 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -15,6 +15,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
+#include "submodule.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [options] [--] <pathspec>..."),
@@ -378,6 +379,10 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+
+	if (!prefixcmp(var, "submodule."))
+		return parse_submodule_config_option(var, value);
+
 	return git_default_config(var, value, cb);
 }
 
@@ -415,6 +420,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int implicit_dot = 0;
 	struct update_callback_data update_data;
 
+	gitmodules_config();
 	git_config(add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
-- 
1.8.5.1.43.gf00fb86
