From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/13] prune_remote(): use delete_refs()
Date: Mon,  8 Jun 2015 13:45:41 +0200
Message-ID: <2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVP-0005EK-JH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbFHLqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58253 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752470AbbFHLqF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:05 -0400
X-AuditID: 12074413-f79386d000000d23-37-557580799f91
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B6.32.03363.97085755; Mon,  8 Jun 2015 07:46:01 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop4017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:00 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqFvZUBpqMOmKikXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M972TmEq2MlR8e81ewPjG7YuRk4OCQETid+vpkHZYhIX7q0Hsrk4hAQuM0p8ub+XBcI5
	wSRx8+IKFpAqNgFdiUU9zUwgtoiAmsTEtkNgRcwCHYwSF5ZvYwdJCAtYSBz/PZkRxGYRUJVo
	7vnIDGLzCkRJbF9ymQlinZzE+eM/weKcQPV3/18AO0NIwFzi47Z2xgmMvAsYGVYxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISU8A7GXSflDjEKcDAq8fAeWFQSKsSaWFZc
	mXuIUZKDSUmUt6usNFSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCC+TBVCONyWxsiq1KB8mJc3B
	oiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB+7EOqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1
	LyW1KLG0JCMeFBvxxcDoAEnxAO1VqQfZW1yQmAsUhWg9xagoJc77GGSuAEgiozQPbiwsUbxi
	FAf6UphXF6SdB5hk4LpfAQ1mAhr8/WsxyOCSRISUVAPjBsVM34lJkcbG11QLez5qN8TsYg1Z
	Nqsg97wm94IIP56lt5bs+XeXOYvvMdPp6ybinSWPHIzmtkWcO89XXsJ89JjEBY493pzqqhcO
	5xVsV4pdMGHTnP87y5p3K7JvPsu4/cCOypntnZqLN/+1MnNwrSqNOur3/V6Pp2ra 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271016>

This will result in errors being emitted for references that can't be
deleted, but that is a good thing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c8dc724..cc3c741 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1314,19 +1314,12 @@ static int prune_remote(const char *remote, int dry_run)
 		string_list_append(&refs_to_prune, item->util);
 	string_list_sort(&refs_to_prune);
 
-	if (!dry_run) {
-		struct strbuf err = STRBUF_INIT;
-		if (repack_without_refs(&refs_to_prune, &err))
-			result |= error("%s", err.buf);
-		strbuf_release(&err);
-	}
+	if (!dry_run)
+		result |= delete_refs(&refs_to_prune);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
 
-		if (!dry_run)
-			result |= delete_ref(refname, NULL, 0);
-
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
 			       abbrev_ref(refname, "refs/remotes/"));
-- 
2.1.4
