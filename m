From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 2/9] send-pack: Attempt to retrieve remote status even if
 pack-objects fails
Date: Sun, 15 May 2011 23:37:13 +0200
Message-ID: <1305495440-30836-3-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:38:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj0j-0000Bl-NY
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab1EOVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:37:56 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab1EOVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:37:55 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009P1AQU0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:42 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 44A361EA5F83_DD047A6B	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:42 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 8DE991EA3155_DD047A5F	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:41 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KSQAQK8000@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1305495440-30836-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173669>

When pushing, send-pack uses pack-objects to write the pack data to the
receive-pack process running on the remote end. The scenarios where
pack-objects dies unexpectedly, can be roughly divided based whether the
reason for the failure is _local_ (i.e. something in pack-objects caused
it to fail of its own accord), or _remote_ (i.e. something in the remote
receive-pack process caused it to fail, leaving the local pack-objects
process with a broken pipe)

If the reason for the failure is local, we expect pack-objects to report
an appropriate error message to the user.

However, if the reason for the failure is remote, pack-objects will merely
abort because of the broken pipe, and the user is left with no clue as to
the reason why the remote receive-pack process died.

In certain cases, though, the receive-pack process on the other end may have
produced an error message immediately before exiting. This error message may
be currently waiting to be read by the local send-pack process.

Therefore, we should try to read from the remote end, even when pack-objects
dies unexepectedly. We accomplish this by _always_ calling receive_status()
after pack_objects(). If the remote end managed to produce a well-formed
status report before exiting, then receive_status() simply presents that to
the user. Even if the data from the remote end cannot be understood by
receive_status(), it will print that data as part of its error message. In
any case, we give the user as much information about the failure as possible.

Signed-off-by: Johan Herland <johan@herland.net>
---

I first wrote this patch on a base where e07fd15 (Peff's "send-pack:
unbreak push over stateless rpc") was not present, and then resolved
a conflict when rebasing this patch onto current master. I hope Peff
or Johannes (Sixt) can verify that my patch does not reintroduce the
deadlock they fixed.


...Johan

 builtin/send-pack.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4ac2ca9..f571917 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -251,7 +251,7 @@ int send_pack(struct send_pack_args *args,
 	int status_report = 0;
 	int use_sideband = 0;
 	unsigned cmds_sent = 0;
-	int ret;
+	int ret = 0;
 	struct async demux;
 
 	/* Does the other end support the reporting? */
@@ -339,23 +339,15 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (new_refs && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref = remote_refs; ref; ref = ref->next)
-				ref->status = REF_STATUS_NONE;
-			if (args->stateless_rpc)
-				close(out);
-			if (use_sideband)
-				finish_async(&demux);
-			return -1;
-		}
+		ret = pack_objects(out, remote_refs, extra_have, args);
+		if (ret && args->stateless_rpc)
+			close(out);
 	}
 	if (args->stateless_rpc && cmds_sent)
 		packet_flush(out);
 
 	if (status_report && cmds_sent)
-		ret = receive_status(in, remote_refs);
-	else
-		ret = 0;
+		ret |= receive_status(in, remote_refs);
 	if (args->stateless_rpc)
 		packet_flush(out);
 
-- 
1.7.5.rc1.3.g4d7b
