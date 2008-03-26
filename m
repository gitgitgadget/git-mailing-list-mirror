From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Wed, 26 Mar 2008 01:42:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803260130390.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211148120.19665@iabervon.org> <7vlk4boh6v.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803251841420.2775@woody.linux-foundation.org> <7vod92jh3u.fsf@gitster.siamese.dyndns.org>
 <7vfxuejf9d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 06:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeOPa-00014Q-Lc
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 06:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbYCZFmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 01:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYCZFmG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 01:42:06 -0400
Received: from iabervon.org ([66.92.72.58]:48792 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbYCZFmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 01:42:05 -0400
Received: (qmail 13585 invoked by uid 1000); 26 Mar 2008 05:42:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2008 05:42:02 -0000
In-Reply-To: <7vfxuejf9d.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78257>

On Tue, 25 Mar 2008, Junio C Hamano wrote:

> This however has unintended side effect of allowing 
> 
> 	[remote "bour"]
>         	url = ../neighbour
>                 fetch = refs/heads/*
> 
> at the syntax level.  I do not know offhand the fetch backends are
> prepared to deal with such wildcard patterns.
> 
> Daniel?

It's not a matter of the backends, which don't implement any of the 
control flow in the fetch direction; it's get_expanded_map(), which needs 
to be told that you can have something match a pattern but not have a 
local tracking ref.

OTOH, the only use for such a pattern is an octopus merge of whatever 
branches a remote happens to have, right? I remember thinking this was a 
non-useful refspec when I was dealing with the fetch code (and then 
forgetting that it was useful for push). It might be better to just 
disallow it in the direction-specific semantic checks.

Here's the patch to make it work, anyway:
----

commit 6a8bcb917e1aa9b3c972f14f618ab573e457ebee
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Wed Mar 26 01:39:07 2008 -0400

    Support fetching refspecs like "refs/heads/*"
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/remote.c b/remote.c
index a027bca..f8f4b34 100644
--- a/remote.c
+++ b/remote.c
@@ -998,22 +998,24 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	struct ref **tail = &ret;
 
 	int remote_prefix_len = strlen(refspec->src);
-	int local_prefix_len = strlen(refspec->dst);
+	int local_prefix_len = refspec->dst ? strlen(refspec->dst) : 0;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (!prefixcmp(ref->name, refspec->src)) {
-			const char *match;
 			struct ref *cpy = copy_ref(ref);
-			match = ref->name + remote_prefix_len;
-
-			cpy->peer_ref = alloc_ref(local_prefix_len +
-						  strlen(match) + 1);
-			sprintf(cpy->peer_ref->name, "%s%s",
-				refspec->dst, match);
-			if (refspec->force)
-				cpy->peer_ref->force = 1;
+
+			if (refspec->dst) {
+				const char *match = ref->name + 
+					remote_prefix_len;
+				cpy->peer_ref = alloc_ref(local_prefix_len +
+							  strlen(match) + 1);
+				sprintf(cpy->peer_ref->name, "%s%s",
+					refspec->dst, match);
+				if (refspec->force)
+					cpy->peer_ref->force = 1;
+			}
 			*tail = cpy;
 			tail = &cpy->next;
 		}
