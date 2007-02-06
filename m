From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 6 Feb 2007 02:28:20 -0500
Message-ID: <20070206072820.GC23866@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <87y7nbdeaw.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 08:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEKke-0003VU-64
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXBFH2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXBFH2X
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:28:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1786 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750984AbXBFH2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:28:22 -0500
Received: (qmail 22690 invoked from network); 6 Feb 2007 02:28:23 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Feb 2007 02:28:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2007 02:28:20 -0500
Content-Disposition: inline
In-Reply-To: <87y7nbdeaw.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38816>

On Mon, Feb 05, 2007 at 09:51:19PM -0800, Carl Worth wrote:

> I can imagine the resolution rules are already fairly complicated, (I
> don't even know what they all are already). But when there is no
> ambiguity, and when the behavior would be backwards compatible to git
> before separate-remotes, is there any reason this would be a bad idea?

I'm not convinced that the complication is a good idea.  However, if you
would like to play with it, a patch is below (it depends on my 'add
utility functions for enumerating remotes' patch, which I just posted).

-- >8 --
sha1_name: match refs in 'refs/remotes/*/%s'

If no other matches are found for a ref, then look for it in every defined
remote. This will not complain of ambiguity, since we only do the lookup if
no other ref matches.
---
 sha1_name.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index d77f770..d9fe107 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "remotes.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -235,6 +236,30 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+struct match_ref_in_remote_data {
+	const char *ref;
+	int ref_len;
+	int count;
+	unsigned char *sha1;
+	char *resolved;
+};
+static int match_ref_in_remote(const char *remote, void *data)
+{
+	struct match_ref_in_remote_data *md = data;
+	unsigned char sha1_from_ref[20];
+	const char *r;
+
+	r = resolve_ref(
+		mkpath("refs/remotes/%s/%.*s", remote, md->ref_len, md->ref),
+		md->count ? sha1_from_ref : md->sha1,
+		1, NULL);
+	if (r) {
+		if (!md->count++)
+			md->resolved = xstrdup(r);
+	}
+	return 0;
+}
+
 static const char *ref_fmt[] = {
 	"%.*s",
 	"refs/%.*s",
@@ -264,6 +289,18 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 				break;
 		}
 	}
+
+	if (!refs_found) {
+		struct match_ref_in_remote_data md;
+		md.ref = str;
+		md.ref_len = len;
+		md.count = 0;
+		md.sha1 = sha1;
+		for_each_remote(match_ref_in_remote, &md);
+		refs_found = md.count;
+		*ref = md.resolved;
+	}
+
 	return refs_found;
 }
 
-- 
1.5.0.rc3.554.ga40e-dirty
