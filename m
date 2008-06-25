From: Jeff King <peff@peff.net>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 12:08:15 -0400
Message-ID: <20080625160814.GA3321@sigill.intra.peff.net>
References: <48625DAD.5040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXYq-0001TL-1F
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYFYQIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbYFYQIS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:08:18 -0400
Received: from peff.net ([208.65.91.99]:3438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYFYQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:08:17 -0400
Received: (qmail 15379 invoked by uid 111); 25 Jun 2008 16:08:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 25 Jun 2008 12:08:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2008 12:08:15 -0400
Content-Disposition: inline
In-Reply-To: <48625DAD.5040404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86294>

On Wed, Jun 25, 2008 at 05:01:01PM +0200, Lea Wiemann wrote:

> Try the following on a repository with tag objects in it:
>
> git for-each-ref --format='%(object)'
> git for-each-ref --format='%(type)'
>
> Each command prints only newlines.  The %(type) and %(object) options are 
> not rejected with an error message (like "%(doesnotexist)"), but they 
> don't seem to be implemented.  "%(tag)" works though.
>
> Anyone care to implement the missing options?  Or should they rather be  
> removed from the documentation?

Looks like they were part of the original set of atoms, but they just
never ended up implemented. Clearly nobody has actually cared in the
intervening time, but it is easy enough to add them. See below.

Since you seem to be testing for-each-ref, maybe it would make sense to
put together a test script that exercises each of the atoms?

-- >8 --
for-each-ref: implement missing tag values

The "type" and "object" fields for tags were accepted as
valid atoms, but never implemented. Consequently, they
simply returned the empty string, even for valid tags.

Noticed by Lea Wiemann.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-for-each-ref.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 07d9c57..fef93d7 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -234,6 +234,13 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 			name++;
 		if (!strcmp(name, "tag"))
 			v->s = tag->tag;
+		else if (!strcmp(name, "type") && tag->tagged)
+			v->s = typename(tag->tagged->type);
+		else if (!strcmp(name, "object") && tag->tagged) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(tag->tagged->sha1));
+			v->s = s;
+		}
 	}
 }
 
-- 
1.5.6.129.g8dea5.dirty
