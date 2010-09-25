From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 1/4] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 19:04:11 +1000
Message-ID: <1285405454-12521-3-git-send-email-jon.seymour@gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:01:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQdq-0001ne-IN
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab0IYJBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:01:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab0IYJBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:01:43 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so815188pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ae1V3/Z5NfYNbRL9JQEfLhq80APv0HHFoZHVsfFn8Pw=;
        b=oyyMXFs05lvMoGCJRTPwXCbe7+V8C5o1u8gqsrlTgsCBQj7bjUl6D4Gkjqgsl+PKKW
         IhVulx2NZyFSNEr7pr1YlBMhjsE/brVFKWXk3SbqP9wCN497R00OV4jlt5E0iqA95nE1
         DZaChqZ0dpoiNbOHClLbeFKF+ss25mRgNPCcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sg+7oEn5hR3qapAEVdAa+qn19IyOH1udDjkRODbd2yPl+/yWu4LJ1r6p4RjSwhjhkr
         p1gU5o6ZCebher0FfFNO2CK9verDSXQdnPx8cbLZP74b+CNBsHFZGW6LMUvT9u9feYca
         ZsLHiRu9VOo8pRs+qnHE/F6d4Ewo5kOx/Z0D4=
Received: by 10.142.51.21 with SMTP id y21mr3830503wfy.173.1285405303037;
        Sat, 25 Sep 2010 02:01:43 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:01:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
In-Reply-To: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157135>

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

Tests will follow in subsequent iterations of this patch, if the consensus
is that the approach is correct.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/rev-parse.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..9e340c7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -497,8 +497,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
+				if (!(filter & DO_NONFLAGS)) {
+					return 0;
+				}
 				continue;
 			}
+			if (!(filter & DO_NONFLAGS)) {
+				 show_flag(arg);
+				 continue;
+			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[i+1];
 				i++;
-- 
1.7.3.1.gc81ce.dirty
