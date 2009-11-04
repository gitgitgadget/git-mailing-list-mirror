From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Allow curl helper to work without a local repository
Date: Tue, 3 Nov 2009 21:52:35 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911032149390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 03:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5VzG-0000y4-IQ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZKDCwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 21:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZKDCwc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:52:32 -0500
Received: from iabervon.org ([66.92.72.58]:39705 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbZKDCwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 21:52:31 -0500
Received: (qmail 23405 invoked by uid 1000); 4 Nov 2009 02:52:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 02:52:35 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132027>

It's okay to use the curl helper without a local repository, so long
as you don't use "fetch". There aren't any git programs that would try
to use it, and it doesn't make sense to try it (since there's nowhere
to write the results), but we may as well be clear.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This is the simple change to let remote-curl work without a local 
repository for git ls-remote; it leave the transport-helper code assuming 
that all helpers can list without a local repo, which happens to be true 
of this helper, the only one in current git.

 remote-curl.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2faf1c6..ebdab36 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -82,9 +82,10 @@ int main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	const char *url;
 	struct walker *walker = NULL;
+	int nongit;
 
 	git_extract_argv0_path(argv[0]);
-	setup_git_directory();
+	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		fprintf(stderr, "Remote needed\n");
 		return 1;
@@ -103,6 +104,8 @@ int main(int argc, const char **argv)
 			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			char *obj = buf.buf + strlen("fetch ");
+			if (nongit)
+				die("Fetch attempted without a local repo");
 			if (!walker)
 				walker = get_http_walker(url, remote);
 			walker->get_all = 1;
-- 
1.6.5.2.142.g063c5.dirty
