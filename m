From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] apply: fix access to an uninitialized mode variable, found
 by valgrind
Date: Wed, 4 Feb 2009 02:50:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
References: <cover.1233712140u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 02:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUWv1-0004tF-Ft
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 02:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbZBDBto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 20:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZBDBto
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 20:49:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbZBDBto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 20:49:44 -0500
Received: (qmail invoked by alias); 04 Feb 2009 01:49:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 04 Feb 2009 02:49:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OcsgXDXqOdmr3MutmSNAc0hp6uR5gXDL3qg5C1I
	u2lRKhsvB+acB/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233712140u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108285>

When 'tpatch' was initialized successfully, st_mode was already taken
from the previous diff.  We should not try to override it with data
from an lstat() that was never called.

This is a companion patch to 7a07841(git-apply: handle a patch that
touches the same path more than once better).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1e7f917..f312798 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2441,7 +2441,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		return error("%s: %s", old_name, strerror(errno));
 	}
 
-	if (!cached)
+	if (!cached && !tpatch)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
-- 
1.6.1.2.582.g3fdd5
