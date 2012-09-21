From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] receive-pack: redirect unpack-objects stdout to /dev/null
Date: Fri, 21 Sep 2012 01:32:52 -0400
Message-ID: <20120921053252.GA9863@sigill.intra.peff.net>
References: <20120921053057.GA9768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 07:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEvrL-0000gj-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2IUFcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:32:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52297 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab2IUFcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:32:55 -0400
Received: (qmail 29453 invoked by uid 107); 21 Sep 2012 05:33:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 01:33:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 01:32:52 -0400
Content-Disposition: inline
In-Reply-To: <20120921053057.GA9768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206106>

The unpack-objects command should not generally produce any
output on stdout. However, if it's given extra input after
the packfile, it will spew the remainder to stdout. When
called by receive-pack, this means we will break protocol,
since our stdout is connected to the remote send-pack.

Signed-off-by: Jeff King <peff@peff.net>
---
I've never actually seen this bug in practice, but I noticed it while
auditing the outputs of receive-pack's children recently.

 builtin/receive-pack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9145f1a..5ba0c98 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -815,6 +815,7 @@ static const char *unpack(void)
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
+		struct child_process child;
 		const char *unpacker[5];
 		unpacker[i++] = "unpack-objects";
 		if (quiet)
@@ -823,7 +824,11 @@ static const char *unpack(void)
 			unpacker[i++] = "--strict";
 		unpacker[i++] = hdr_arg;
 		unpacker[i++] = NULL;
-		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
+		memset(&child, 0, sizeof(child));
+		child.argv = unpacker;
+		child.no_stdout = 1;
+		child.git_cmd = 1;
+		code = run_command(&child);
 		if (!code)
 			return NULL;
 		return "unpack-objects abnormal exit";
-- 
1.7.11.7.15.g085c6bd
