From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] clone --mirror: avoid storing repeated tags
Date: Fri, 8 Aug 2008 04:29:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808080428520.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <489B9A8B.9050807@cesarb.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Fri Aug 08 04:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRHg7-0004mU-3w
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 04:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbYHHCZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 22:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbYHHCZE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 22:25:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:41697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754182AbYHHCZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 22:25:03 -0400
Received: (qmail invoked by alias); 08 Aug 2008 02:25:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 08 Aug 2008 04:25:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Fl7QVi5XFgwqedCU9lNzMmHAqZxY5aNIvAVAU3r
	Ca9fTzLR0c2TRZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <489B9A8B.9050807@cesarb.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91618>


With --mirror, clone asks for refs/* already, so it does not need to
ask for ref/tags/*, too.

Noticed by Cesar Eduardo Barros.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-clone.c  |    3 ++-
 t/t5601-clone.sh |   12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 8612d59..c0e3086 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -330,7 +330,8 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	struct ref *r;
 
 	get_fetch_map(refs, refspec, &tail, 0);
-	get_fetch_map(refs, tag_refspec, &tail, 0);
+	if (!option_mirror)
+		get_fetch_map(refs, tag_refspec, &tail, 0);
 
 	for (r = local_refs; r; r = r->next)
 		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a13b6f9..59c65fe 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -95,4 +95,16 @@ test_expect_success 'clone --bare names the local repository <name>.git' '
 
 '
 
+test_expect_success 'clone --mirror does not repeat tags' '
+
+	(cd src &&
+	 git tag some-tag HEAD) &&
+	git clone --mirror src mirror2 &&
+	(cd mirror2 &&
+	 git show-ref 2> clone.err > clone.out) &&
+	test_must_fail grep Duplicate mirror2/clone.err &&
+	grep some-tag mirror2/clone.out
+
+'
+
 test_done
-- 
1.6.0.rc1.112.gebbe4
