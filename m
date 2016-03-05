From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] mailmap: do not resolve blobs in a non-repository
Date: Sat, 5 Mar 2016 17:13:29 -0500
Message-ID: <20160305221329.GD31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:13:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKS8-0000VU-WE
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbcCEWNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:13:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:55324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750781AbcCEWNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:13:32 -0500
Received: (qmail 13143 invoked by uid 102); 5 Mar 2016 22:13:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:13:31 -0500
Received: (qmail 12174 invoked by uid 107); 5 Mar 2016 22:13:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:13:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:13:29 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288332>

The mailmap code may be triggered outside of a repository by
git-shortlog. There is no point in looking up a name like
"HEAD:.mailmap" there; without a repository, we have no
refs.

This is unlikely to matter much in practice for the current
code, as we would simply fail to find the ref. But as the
refs code learns about new backends, this is more important;
without a repository, we do not even know which backend to
look at.

Signed-off-by: Jeff King <peff@peff.net>
---
I debated whether ".mailmap" in the $PWD should be respected in a
non-repository. If it were 2005, I think I could go either way. But it's
not, and changing it now seems like a pointless and unnecessary
regression, even if there is some grounds to argue for it.

 mailmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index f4a0f1c..9726237 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -250,7 +250,8 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 		git_mailmap_blob = "HEAD:.mailmap";
 
 	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
-	err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
+	if (startup_info->have_repository)
+		err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
 	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
 	return err;
 }
-- 
2.8.0.rc1.318.g2193183
