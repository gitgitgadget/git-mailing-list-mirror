From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: git fetch <remote> <branch> to update
 remote-tracking branch
Date: Tue, 6 Mar 2012 03:59:19 -0500
Message-ID: <20120306085919.GF21199@sigill.intra.peff.net>
References: <4F54EDC1.80608@gmail.com>
 <7vmx7v0wrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qF6-0003oO-4n
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab2CFI7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:59:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38283
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758862Ab2CFI7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:59:22 -0500
Received: (qmail 5778 invoked by uid 107); 6 Mar 2012 08:59:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 03:59:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 03:59:19 -0500
Content-Disposition: inline
In-Reply-To: <7vmx7v0wrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192319>

On Mon, Mar 05, 2012 at 09:42:43AM -0800, Junio C Hamano wrote:

> > What do people think?
> 
> I think this was discussed number of times here, and my vague
> recollection of the conclusion last time is that it would be OK to
> change the behaviour of single-shot fetch "fetch <remote> <branch>"
> against a remote where there is already a default fetch refspec that
> covers the <branch> so that such a fetch will update the remote
> tracking branch that usually copies from <branch> (and only that
> one).
> 
> We might need a proper deprecation and migration plan, though.  I
> say "might" because offhand I don't know what the extent of damages
> to existing users' habits will be if we didn't offer any.

If you (or somebody else) wants to look into it, I've had this patch
hanging around in my repo since 2009, but it does cause a bunch of
failures in the test suite. I don't think I ever investigated whether
the test failures were bad assumptions in the tests, or signs of a real
problem. Those test failures may also give a clue about how unwitting
users would be affected.

---
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..409c86c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -156,6 +156,9 @@ static struct ref *get_ref_map(struct transport *transport,
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (ref_count || tags == TAGS_SET) {
+		struct ref *tracking_refs = NULL;
+		struct ref **tracking_tail = &tracking_refs;
+
 		for (i = 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
@@ -166,6 +169,12 @@ static struct ref *get_ref_map(struct transport *transport,
 			rm->merge = 1;
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+
+		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
+			get_fetch_map(ref_map, &transport->remote->fetch[i],
+					&tracking_tail, 0);
+		*tail = tracking_refs;
+		tail = tracking_tail;
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
