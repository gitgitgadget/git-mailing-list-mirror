From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] git: ensure 0/1/2 are open in main()
Date: Tue, 16 Jul 2013 11:27:37 +0200
Message-ID: <65e2cdb28e76de8f669f3d58556fa9b8da944c5b.1373966758.git.trast@inf.ethz.ch>
References: <1fe4ff3df32aa1836ed3672e749f582047745bc9.1373966758.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1Xr-0006fZ-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3GPJ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:27:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27822 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab3GPJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:27:37 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:27:32 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:27:36 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <1fe4ff3df32aa1836ed3672e749f582047745bc9.1373966758.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230555>

Not having an open FD in the 0--2 range can lead to strange results,
for example, a subsequent open() may return 2 (stderr) and then a
die() would clobber this file.

git-daemon and git-shell already guarded against this, but apparently
users also manage to trip over it in other git commands.  So we call
sanitize_stdfds() during main git startup.

Since these FDs are inherited, this covers all use of 'git foo ...',
and all internal C commands when called directly.  It does not fix
shell/perl commands called directly.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 git.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git.c b/git.c
index 4359086..6104d5e 100644
--- a/git.c
+++ b/git.c
@@ -525,6 +525,13 @@ int main(int argc, char **av)
 	if (!cmd)
 		cmd = "git-help";
 
+	/*
+	 * Always open file descriptors 0/1/2 to avoid clobbering files
+	 * in die().  It also avoids messing up when the pipes are dup'ed
+	 * onto stdin/stdout/stderr in the child processes we spawn.
+	 */
+	sanitize_stdfds();
+
 	git_setup_gettext();
 
 	/*
-- 
1.8.3.2.998.g1d087bc
