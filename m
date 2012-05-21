From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] fetch-pack: sort the list of incoming refs
Date: Mon, 21 May 2012 18:19:51 -0400
Message-ID: <20120521221951.GD22914@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWaxL-0006iB-0q
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab2EUWTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:19:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51148
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2EUWTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:19:54 -0400
Received: (qmail 7046 invoked by uid 107); 21 May 2012 22:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:20:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:19:51 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198139>

Having the list sorted means we can avoid some quadratic
algorithms when comparing lists.

These should typically be sorted already, but they do come
from the remote, so let's be extra careful. Our ref-sorting
implementation does a mergesort, so we do not have to care
about performance degrading in the common case that the list
is already sorted.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 3522d8e..bee329f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -777,6 +777,8 @@ static struct ref *do_fetch_pack(int fd[2],
 	struct ref *ref = copy_ref_list(orig_ref);
 	unsigned char sha1[20];
 
+	sort_ref_list(&ref, ref_compare_name);
+
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
-- 
1.7.10.1.19.g711d603
