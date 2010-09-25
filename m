From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Sat, 25 Sep 2010 17:19:16 +1000
Message-ID: <1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 09:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzOzo-0004LU-EA
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab0IYHQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 03:16:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43802 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab0IYHQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 03:16:16 -0400
Received: by pvg2 with SMTP id 2so854214pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tVB0GQt7SP2xpkRjUfsC3SvNLqpMMuqu3ljis8ek0bY=;
        b=LDPRGybvEiEuHdd29tTFiJGF0Z166U//OWKNE9wS0p7CoTQF9QoCKIgRMw6AqCV9I9
         wkhcO64Og3ExswNXwmFAOmtK3LHeeGeocqs0Hbxd3wtOFjPerKC9noskPMDwKA0h9K7P
         PppY//R04Ob53nx8ZDHQbzNGo4bzx64u8txz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IWjWoyArbiENS3DuAMlYyxKOmaPogqkVF5YPzddPsJzHYM0XbGLP10HfiaKw0auW6U
         0SSMj2wMmmZw6BVIrZUo8DTHd1PBqtoQ4Z8t6Rwk24xzKRrDzfM7FddV7ajjlM3PLvbE
         Zi4u30OvRZTdDKuf2HbiNSHiIbprMD9tG9yqI=
Received: by 10.114.80.10 with SMTP id d10mr4902296wab.180.1285398975608;
        Sat, 25 Sep 2010 00:16:15 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c10sm5142075wam.1.2010.09.25.00.16.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 00:16:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.14.gbde03.dirty
In-Reply-To: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157126>

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
1.7.2.14.gbde03.dirty
