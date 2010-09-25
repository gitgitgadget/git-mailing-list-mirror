From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 1/4] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 23:33:50 +1000
Message-ID: <1285421633-22684-2-git-send-email-jon.seymour@gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 15:31:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUqP-00027D-RM
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0IYNbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:31:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55724 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IYNbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:31:10 -0400
Received: by pwj6 with SMTP id 6so844960pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xWfsZODUa62lWCSX2M9IwWTC7AHx+HA78HcEJAr0Z8A=;
        b=nha6zmIC6Ds4DPDhTp8jr4RLYnzdnuZWshamxSoZZzj85h+JqY4g0151lkVzakMs9F
         cwa/n+JdXuPIjyYpbyWgUYtOs27epW2Qq8QR3xyLsRH4WvqxNzuP//7hdjIgN0RBGsVR
         92giKBmy0hxLRmYGbNZ/aKELl4QEzU1/nXFcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MBy/CbZbIjZPIEr+P9hijuHrzkEtFROsmX7c6CTnh6zLfXztTmbqKTYw+n7T3vn055
         jxiIM5tWTQbP9SQ6RKHeuLid8tt9ub5w+m0Rfa9/psq9WeuUOXrZ5K07O6bGfm0sjNK0
         K+ARi5gRHpCp7EP139552zzCIIKODZUKH/niQ=
Received: by 10.142.148.12 with SMTP id v12mr4047508wfd.21.1285421469496;
        Sat, 25 Sep 2010 06:31:09 -0700 (PDT)
Received: from localhost.localdomain ([120.16.118.189])
        by mx.google.com with ESMTPS id l42sm3924235wfa.9.2010.09.25.06.31.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 06:31:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.ge900b
In-Reply-To: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157151>

Current git rev-parse behaviour makes --flags hard to use if the remaining
arguments to git rev-parse contain an option that would otherwise be interpreted
as an option by git rev-parse itself.

So, for example:

  $> git rev-parse --flags -q -X
  -X

Normally one might expect to use -- to prevent -q being interpreted:

  $> git rev-parse --flags -- -q -X
  -q -X

But we can't really use -- in this way, because commands that use
git rev-parse might reasonably expect:

  $> git rev-parse --flags -Y -- -q -X
  -Y

That is, -Y to be regarded as a flag but everything after -- to be uninterpreted.

This proposed change modifies git rev-parse so that git rev-parse stops
interpreting flag arguments as options to git rev-parse once --flags is
interpreted. We also exit early once -- is found.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/rev-parse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..2ad269a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -497,8 +497,16 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
+				if (!(filter & DO_NONFLAGS)) {
+					return 0;
+				}
 				continue;
 			}
+			if (!(filter & DO_NONFLAGS)) {
+				/* once we see --flags, we stop interpreting other flags */
+				 show_flag(arg);
+				 continue;
+			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[i+1];
 				i++;
-- 
1.7.3.3.gc4c52.dirty
