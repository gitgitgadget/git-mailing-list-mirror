From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] diff: fix textconv error zombies
Date: Tue, 30 Mar 2010 19:36:03 +0200
Message-ID: <201003301936.03394.j6t@kdbg.org>
References: <20100328145301.GA26213@coredump.intra.peff.net> <201003282023.00913.j6t@kdbg.org> <20100330163004.GC17763@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 19:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwfOO-0002rz-TB
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab0C3RiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:38:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:24877 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752011Ab0C3RiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:38:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B92E4CDF84;
	Tue, 30 Mar 2010 19:38:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A268D19F6BF;
	Tue, 30 Mar 2010 19:36:03 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100330163004.GC17763@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143584>

To make the code simpler, run_textconv lumps all of its
error checking into one conditional. However, the
short-circuit means that an error in reading will prevent us
from calling finish_command, leaving a zombie child.
Clean up properly after errors.

Based-on-work-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Jeff,

> Yes, there are clever ways to make this shorter, but I think it is
> clearer just written out.

Thanks for your work, but I'm worried that in your version the close()
call is not before the finish_command (but that's really not _that_
important in this case). My version is perhaps not as easy to read, but
has a slightly better diff-stat.

Oh, I removed the error messages after start_command and finish_command,
because these two print one themselves; Junio, if you disagree with
this change, ditch my version and take Jeff's.

-- Hannes

 diff.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index dfdfa1a..b96faea 100644
--- a/diff.c
+++ b/diff.c
@@ -3874,6 +3874,7 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	const char **arg = argv;
 	struct child_process child;
 	struct strbuf buf = STRBUF_INIT;
+	int err = 0;
 
 	temp = prepare_temp_file(spec->path, spec);
 	*arg++ = pgm;
@@ -3884,16 +3885,20 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	child.use_shell = 1;
 	child.argv = argv;
 	child.out = -1;
-	if (start_command(&child) != 0 ||
-	    strbuf_read(&buf, child.out, 0) < 0 ||
-	    finish_command(&child) != 0) {
-		close(child.out);
-		strbuf_release(&buf);
+	if (start_command(&child)) {
 		remove_tempfile();
-		error("error running textconv command '%s'", pgm);
 		return NULL;
 	}
+
+	if (strbuf_read(&buf, child.out, 0) < 0)
+		err = error("error reading from textconv command '%s'", pgm);
 	close(child.out);
+
+	if (finish_command(&child) || err) {
+		strbuf_release(&buf);
+		remove_tempfile();
+		return NULL;
+	}
 	remove_tempfile();
 
 	return strbuf_detach(&buf, outsize);
-- 
1.7.0.2.250.ge5578
