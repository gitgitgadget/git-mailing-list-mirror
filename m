From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 1/4] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Sun, 26 Sep 2010 02:18:32 +1000
Message-ID: <1285431515-21321-2-git-send-email-jon.seymour@gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXPX-0000RJ-BO
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab0IYQPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 12:15:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63719 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0IYQPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 12:15:35 -0400
Received: by pwj6 with SMTP id 6so864227pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LUF+f2CCYGp9o+U+NaQNescsKw9Dc8L2DKnPpaTockk=;
        b=sXvU0Z7LBT92n0QdTz+qwMhRwg+OdxqcZo3brcYvGELxe7jufnoXe608wNif66lefC
         XCvPCnVueskBEi2c3f6e9zXO0/0RH8UHZ/SBfntA1tdrwntWwDQ9FbQ4TTKR4ANz4smH
         cxwIh2sWImiE2dYCmClo/t6ZKMBx0XFClJVe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MS2QEbWZ3xvUW37YlH7AYA96k+tun45ETtnZvMbsue7IM9HxBn1XvywMOa4C8vQmGu
         CPNA6Tu9LN6YmDOQMAKS0rkXGOT0lJV5pCfIY/2diG+IUoD/GyzAFOW3Yc1EhInbgbUk
         xI7yUfXHNnX8eUagMY4ys+2mXBpM/ixmNY7m0=
Received: by 10.114.109.18 with SMTP id h18mr5490774wac.66.1285431335388;
        Sat, 25 Sep 2010 09:15:35 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c24sm6056766wam.7.2010.09.25.09.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 09:15:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.g73371.dirty
In-Reply-To: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157160>

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
1.7.3.4.g73371.dirty
