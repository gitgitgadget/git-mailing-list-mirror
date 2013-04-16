From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] read_revisions_from_stdin: make copies for handle_revision_arg
Date: Tue, 16 Apr 2013 11:57:45 +0200
Message-ID: <c68f7df5367d254360ddf184fa1eaf6b8c3bef18.1366106134.git.trast@inf.ethz.ch>
References: <516C4FB6.8060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Miklos Vajna <vmiklos@suse.cz>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US2eD-0006Fc-7j
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935081Ab3DPJ5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:57:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34766 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934696Ab3DPJ5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 05:57:52 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Apr
 2013 11:57:44 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Apr
 2013 11:57:48 +0200
X-Mailer: git-send-email 1.8.2.1.703.g2535f49
In-Reply-To: <516C4FB6.8060703@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221404>

read_revisions_from_stdin() has passed pointers to its read buffer
down to handle_revision_arg() since its inception way back in 42cabc3
(Teach rev-list an option to read revs from the standard input.,
2006-09-05).  Even back then, this was a bug: through
add_pending_object, the argument was recorded in the object_array's
'name' field.

Fix it by making a copy whenever read_revisions_from_stdin() passes an
argument down the callchain.  The other caller runs handle_revision_arg()
on argv[], where it would be redundant to make a copy.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

> So I changed my mind.  Your "easy fix" looks to me the right thing
> to do.

So here's the same with a commit message and signoff.  I hope I got my
history right; I didn't look too long if it had any users, but it was
definitely recorded.


 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 3a20c96..181a8db 100644
--- a/revision.c
+++ b/revision.c
@@ -1277,7 +1277,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
+		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
+					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
-- 
1.8.2.1.703.g2535f49
