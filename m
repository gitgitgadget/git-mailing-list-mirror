From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/3] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 21:22:41 +1000
Message-ID: <1285413763-25082-2-git-send-email-jon.seymour@gmail.com>
References: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 13:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzSnh-0002GO-M3
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 13:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab0IYLT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 07:19:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55544 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab0IYLTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 07:19:55 -0400
Received: by pxi10 with SMTP id 10so1012477pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hWchxGSCqsRvdnIy402lfFHP7eNw+tPcgq6+HVZG5YI=;
        b=g8T3NFbCjUN8IYwXDQl3KshV93q2RDsSUACvT1ZETxmhNfKuLK1TNfrFdJPzPFHPxb
         DjjyZhnEa1g3J5rjdMzJlnDuPm/hXbYL+lcrdea6OF1zFRDkYvtu/UGCFicnQxdnceak
         kVxjYgYtgFb4YSCMVvlbEcAmexS7MbKaKp/B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SKkfsGJH7AnQeigHcoDk+UU/2pq6aD+6t3g54/pWA+xJPl10pu8h/yGmDb/jVidFP7
         +LNyxW1W1WBuNCh2cJA8uwZYoFzVyJwBUt0m0fhiG2DwuPlM5vlwDAP9j3QJbfxXdzRU
         1dr0Eym4CXWo2aohmCP6qqPzO2blqfZ7gRTS0=
Received: by 10.142.248.9 with SMTP id v9mr3918931wfh.250.1285413594774;
        Sat, 25 Sep 2010 04:19:54 -0700 (PDT)
Received: from localhost.localdomain ([120.16.63.67])
        by mx.google.com with ESMTPS id o16sm3755003wfh.7.2010.09.25.04.19.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 04:19:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.g216ca.dirty
In-Reply-To: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157145>

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
1.7.3.2.g216ca.dirty
