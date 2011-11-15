From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 14:18:32 -0500
Message-ID: <20111115191832.GA16030@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
 <7vobwdus7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQOWl-0000ms-9X
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 20:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab1KOTSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 14:18:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42756
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab1KOTSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 14:18:34 -0500
Received: (qmail 9513 invoked by uid 107); 15 Nov 2011 19:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 14:18:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 14:18:32 -0500
Content-Disposition: inline
In-Reply-To: <7vobwdus7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185482>

On Tue, Nov 15, 2011 at 10:59:47AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Junio, this bug is in 1.7.8-rc*. Do you want the one-liner fix for the
> > release, or the nicer fix?
> 
> Let's just do "static" for now, if we know the array is large enough.

OK, here it is.

I think it's correct, but I couldn't reproduce the valgrind failure
here. Thomas, can you double check that this also solves your problem?

-Peff

-- >8 --
Subject: [PATCH] upload-archive: don't return pointers to stack buffer

The prepare_argv function uses an internal stack-allocated
buffer to create the argv array that will be used to run
git-archive. Prior to c09cd77e, this was OK, as the
function passed the argv array to write_archive itself, and
the stack buffer was valid during its use.

Since c09cd77e, however, the function returns an argv array
with pointers pointing into the stack buffer. The calling
function then passes the result to start_command, which
tries to execve using pointers to a now-invalid buffer.

Fix it by making the buffer static, which is a quick and
simple fix, and works because we only run this function once
per process.

Credit for finding the bug and most of the analysis goes to
Thomas Rast.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-archive.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index c57e8bd..f47c0f0 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -22,7 +22,8 @@
 static void prepare_argv(const char **sent_argv, const char **argv)
 {
 	const char *arg_cmd = "argument ";
-	char *p, buf[4096];
+	char *p;
+	static char buf[4096];
 	int sent_argc;
 	int len;
 
-- 
1.7.7.3.8.g38efa
