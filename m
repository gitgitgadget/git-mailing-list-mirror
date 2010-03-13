From: Dave Olszewski <cxreg@pobox.com>
Subject: [PATCH] don't use default revision if a rev was specified
Date: Sat, 13 Mar 2010 14:47:05 -0800
Message-ID: <1268520425-31889-1-git-send-email-cxreg@pobox.com>
References: <4B9C086D.10004@lsrfire.ath.cx>
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Mar 13 23:47:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqa7P-0000df-5F
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398Ab0CMWre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:47:34 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:59200 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759393Ab0CMWrd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Mar 2010 17:47:33 -0500
X-Envelope-From: count@genericorp.net
Received: from bokonon.genericorp.net (c-76-104-180-27.hsd1.wa.comcast.net [76.104.180.27])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2DMlGgU022399
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Sat, 13 Mar 2010 16:47:22 -0600
Received: from count by bokonon.genericorp.net with local (Exim 4.71)
	(envelope-from <count@bokonon.genericorp.net>)
	id 1Nqa6w-0008Ir-NU; Sat, 13 Mar 2010 14:47:10 -0800
X-Mailer: git-send-email 1.7.0.2.202.g4e870.dirty
In-Reply-To: <4B9C086D.10004@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142120>

If a revision is specified, it happens not to have any commits, don't
use the default revision.  By doing so, surprising and undesired
behavior can happen, such as showing the reflog for HEAD when a branch
was specified.

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
>> I was testing a patch along the lines of
>> what Vladimir proposed, which was simply to not set the default rev if a
>> valid user-specified argument was found, whether or not it contains
>> commits.
>
>Sounds more like it.  How did the tests go?  Does it result in empty
>output (which is what I would expect from an empty reflog, now that I
>stopped and thought about it for a second)?

It seems to work ok(tm)

 revision.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 29721ec..490b484 100644
--- a/revision.c
+++ b/revision.c
@@ -1334,7 +1334,7 @@ static void append_prune_data(const char ***prune_data, const char **av)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
-	int i, flags, left, seen_dashdash, read_from_stdin;
+	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
 
 	/* First, search for "--" */
@@ -1460,6 +1460,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			append_prune_data(&prune_data, argv + i);
 			break;
 		}
+		else
+			got_rev_arg = 1;
 	}
 
 	if (prune_data)
@@ -1469,7 +1471,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		revs->def = def;
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr) {
+	if (revs->def && !revs->pending.nr && !got_rev_arg) {
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-- 
1.7.0.2.202.g4e870.dirty
