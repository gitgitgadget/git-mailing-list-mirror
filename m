From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] fetch: do not leak a refspec
Date: Wed, 08 Jun 2011 22:06:33 +0200
Message-ID: <87vcwgxf3q.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:06:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUP1g-0003M0-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab1FHUGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 16:06:47 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51512 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab1FHUGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 16:06:47 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C710994010F
	for <git@vger.kernel.org>; Wed,  8 Jun 2011 22:06:34 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2B0B76007C; Wed,  8 Jun 2011 22:06:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175454>



Signed-off-by: Jim Meyering <meyering@redhat.com>
---
Coverity spotted this.

 builtin/fetch.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f9c41da..93c9938 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -875,6 +875,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 {
 	int i;
 	static const char **refs = NULL;
+	struct refspec *refspec;
 	int ref_nr = 0;
 	int exit_code;

@@ -915,8 +916,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)

 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
-	exit_code = do_fetch(transport,
-			parse_fetch_refspec(ref_nr, refs), ref_nr);
+	refspec = parse_fetch_refspec(ref_nr, refs);
+	exit_code = do_fetch(transport, refspec, ref_nr);
+	free(refspec);
 	transport_disconnect(transport);
 	transport = NULL;
 	return exit_code;
--
1.7.6.rc0.293.g40857
