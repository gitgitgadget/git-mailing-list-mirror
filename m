From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fetch: give a hint to the user when local refs fail to
	update
Date: Fri, 27 Jun 2008 00:01:41 -0400
Message-ID: <20080627040140.GB21382@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net> <20080627035747.GC7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>
X-From: git-owner@vger.kernel.org Fri Jun 27 06:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC5AW-00088r-LC
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 06:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbYF0EBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 00:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbYF0EBo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 00:01:44 -0400
Received: from peff.net ([208.65.91.99]:4551 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYF0EBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 00:01:43 -0400
Received: (qmail 31528 invoked by uid 111); 27 Jun 2008 04:01:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 00:01:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2008 00:01:41 -0400
Content-Disposition: inline
In-Reply-To: <20080627035747.GC7144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86521>

There are basically two categories of update failures for
local refs:

  1. problems outside of git, like disk full, bad
     permissions, etc.

  2. D/F conflicts on tracking branch ref names

In either case, there should already have been an error
message. In case '1', hopefully enough information has
already been given that the user can fix it. In the case of
'2', we can hint that the user can clean up their tracking
branch area by using 'git remote prune'.

Note that we don't actually know _which_ case we have, so
the user will receive the hint in case 1, as well. In this
case the suggestion won't do any good, but hopefully the
user is smart enough to figure out that it's just a hint.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, I think there might be a third category, "bad ref format".
But that would only come from a malicious remote trying to send you a
badly formatted ref, so I think that is rare enough not to worry about
showing the extra hint there.

 builtin-fetch.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7c16d38..97fdc51 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -181,9 +181,9 @@ static int s_update_ref(const char *action,
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL, 0);
 	if (!lock)
-		return 1;
+		return 2;
 	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return 1;
+		return 2;
 	return 0;
 }
 
@@ -294,7 +294,8 @@ static int update_local_ref(struct ref *ref,
 	}
 }
 
-static int store_updated_refs(const char *url, struct ref *ref_map)
+static int store_updated_refs(const char *url, const char *remote_name,
+		struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -380,6 +381,10 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 		}
 	}
 	fclose(fp);
+	if (rc & 2)
+		error("some local refs could not be updated; try running\n"
+		      " 'git remote prune %s' to remove any old, conflicting "
+		      "branches", remote_name);
 	return rc;
 }
 
@@ -450,7 +455,9 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
-		ret |= store_updated_refs(transport->url, ref_map);
+		ret |= store_updated_refs(transport->url,
+				transport->remote->name,
+				ref_map);
 	transport_unlock_pack(transport);
 	return ret;
 }
-- 
1.5.6.1.79.g7b3a7.dirty
