From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 3/9] fetch: Fix minor memory leak
Date: Mon, 15 Mar 2010 23:18:48 +0100
Message-ID: <b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKc-0002C7-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab0CRLzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:53036 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab0CRLz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:27 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D86BE93A00
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:26 +0100 (CET)
In-Reply-To: <f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142463>

A temporary struct ref is allocated in store_updated_refs() but not
freed.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 660af84..957be9f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -389,9 +389,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				fputc(url[i], fp);
 		fputc('\n', fp);
 
-		if (ref)
+		if (ref) {
 			rc |= update_local_ref(ref, what, note);
-		else
+			free(ref);
+		} else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
-- 
1.7.0.2.273.gc2413
