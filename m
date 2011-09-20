From: Jeff King <peff@peff.net>
Subject: Re: git patch-id fails on long lines
Date: Tue, 20 Sep 2011 16:18:08 -0400
Message-ID: <20110920201808.GA18310@sigill.intra.peff.net>
References: <1316541771-sup-9996@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66lk-0007jZ-2O
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab1ITUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:18:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab1ITUSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:18:10 -0400
Received: (qmail 23593 invoked by uid 107); 20 Sep 2011 20:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Sep 2011 16:23:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Sep 2011 16:18:08 -0400
Content-Disposition: inline
In-Reply-To: <1316541771-sup-9996@pimlott.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181790>

On Tue, Sep 20, 2011 at 11:07:42AM -0700, Andrew Pimlott wrote:

> In patch-id.c, get_one_patchid uses a fixed 1000-char buffer to read a line.[1]
> This causes incorrect results on longer lines.  Pasted below is a git commit
> (from git show) that demonstrates the problem.  The result of running git
> patch-id on this commit is:
> 
> 9220f380851be9cab1a760430e3be096dcbee8c6 9b96b6fde8f7df791a1490ae18e1fa75fbab3262
> 74b8ede07628a574fd586624e0c77a4b6c9967e0 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

Hmm, yeah.  My initial impression "eh, so what, it will just add the
line contents to the sha1 patch-id in two separate hunks". But we
actually treat lines magically based on their beginnings, and it
seems we accidentally think the "aaa" is the start of the next commit
header.

I think this can be trivially converted to use strbuf_getwholeline,
something like this (completely untested):

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f821eb3..99ba2ca 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -58,11 +58,12 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 
 static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
-	static char line[1000];
+	static struct strbuf line_buf = STRBUF_INIT;
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	while (strbuf_getwholeline(&line_buf, stdin, '\n') != EOF) {
+		char *line = line_buf.buf;
 		char *p = line;
 		int len;
 

That just reuses the same heap-allocated buffer over and over, and then
eventually leaks it at the end (but then the program exits anyway). You
could get fancier and actually pass in the strbuf from generate_id_list,
and then release it when we're done.

-Peff
