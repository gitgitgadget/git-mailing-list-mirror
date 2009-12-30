From: Jeff King <peff@peff.net>
Subject: [PATCH] textconv: stop leaking file descriptors
Date: Wed, 30 Dec 2009 04:02:53 -0500
Message-ID: <20091230090253.GA24049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 10:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPuSQ-0007Uq-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 10:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZL3JC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 04:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZL3JC5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 04:02:57 -0500
Received: from peff.net ([208.65.91.99]:48258 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbZL3JC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 04:02:56 -0500
Received: (qmail 4612 invoked by uid 107); 30 Dec 2009 09:07:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 04:07:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 04:02:53 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135874>

We read the output from textconv helpers over a pipe, but we
never actually closed our end of the pipe after using it.

Signed-off-by: Jeff King <peff@peff.net>
---
This should go onto 'maint'. Now I'll just go find a brown paper bag...

 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index d14a575..aad4b39 100644
--- a/diff.c
+++ b/diff.c
@@ -3823,11 +3823,13 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	if (start_command(&child) != 0 ||
 	    strbuf_read(&buf, child.out, 0) < 0 ||
 	    finish_command(&child) != 0) {
+		close(child.out);
 		strbuf_release(&buf);
 		remove_tempfile();
 		error("error running textconv command '%s'", pgm);
 		return NULL;
 	}
+	close(child.out);
 	remove_tempfile();
 
 	return strbuf_detach(&buf, outsize);
-- 
1.6.6.320.g7c9b3
