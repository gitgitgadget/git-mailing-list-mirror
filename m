From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sat, 14 Feb 2009 16:15:48 -0500
Message-ID: <20090214211548.GA14898@coredump.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090214175420.GA3457@coredump.intra.peff.net> <alpine.LNX.1.00.0902141503230.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRth-0004Mj-8q
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbZBNVPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbZBNVPw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:15:52 -0500
Received: from peff.net ([208.65.91.99]:57343 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbZBNVPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:15:51 -0500
Received: (qmail 2634 invoked by uid 107); 14 Feb 2009 21:16:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 14 Feb 2009 16:16:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 16:15:49 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902141503230.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109931>

On Sat, Feb 14, 2009 at 03:21:30PM -0500, Daniel Barkalow wrote:

> I haven't checked lately, but I think that what's actually needed is to 
> have the locate_head() function notice if the struct ref for HEAD actually 
> has the symref field non-NULL, and report that as the unambiguous answer. 

Indeed. Something like the patch below works (on top of Jay's patches).
But it has two shortcomings:

  1. There is no test script, since we have no infrastructure for
     testing over http. I might be able to build something on top of
     what's in the http-push tests.

     I was hoping we could do the same trick for local file repos, which
     would be easy to test. But the transport code just treats them as
     regular pack uploaders; only some specialized code in clone cares
     about the difference.

     In theory we could add a new transport for local repos. I don't
     think it would make sense for its get_remote_refs function to get
     _all_ of the refs, but it could specially peek at HEAD and set the
     symref field appropriately.

  2. The guess_remote_head function is getting a little long. I think it
     would help to refactor it into two functions; one for finding the
     remote HEAD in the refs list, and the other for guessing at a ref
     which matches the HEAD.

I will try to make something a little neater later today.

> This should also allow it to automatically pick up any other 
> disambiguation by future sources of lists of refs that include HEAD, 
> whether that's git protocol extensions, filesystem access to the repo, or 
> foreign VCSes where some branches is inherently primary, or whatever.

Yes, I think the symref field for the ref is a very sensible way of
communicating the information for that reason.

Patch is below.

---
diff --git a/remote.c b/remote.c
index 6385a22..afbaccc 100644
--- a/remote.c
+++ b/remote.c
@@ -1404,6 +1404,20 @@ const struct ref *guess_remote_head(const struct ref *refs,
 	if (!remote_head)
 		return NULL;
 
+	/* if the underlying transport can represent symrefs,
+	 * then we don't need to guess at all */
+	if (remote_head->symref) {
+		for (r = mapped_refs; r; r = r->next) {
+			if (!strcmp(r->name, remote_head->symref)) {
+				if (all_matches_p) {
+					*all_matches_p = copy_ref(r);
+					(*all_matches_p)->peer_ref = NULL;
+				}
+				return r;
+			}
+		}
+	}
+
 	/* If refs/heads/master could be right, it is. */
 	if (remote_master && !hashcmp(remote_master->old_sha1,
 				      remote_head->old_sha1))
