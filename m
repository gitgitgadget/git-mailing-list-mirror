From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 22:52:56 -0400
Message-ID: <20070406025255.GA31909@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com> <20070405134954.GA18402@coredump.intra.peff.net> <17941.655.192938.792088@lisa.zopyra.com> <20070405204604.GA24779@coredump.intra.peff.net> <7vodm2o6yl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 04:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZeZl-00061O-MU
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 04:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767515AbXDFCxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 22:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767517AbXDFCxA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 22:53:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4963 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767515AbXDFCw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 22:52:58 -0400
Received: (qmail 31684 invoked from network); 6 Apr 2007 02:53:33 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 6 Apr 2007 02:53:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2007 22:52:56 -0400
Content-Disposition: inline
In-Reply-To: <7vodm2o6yl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43896>

On Thu, Apr 05, 2007 at 02:18:58PM -0700, Junio C Hamano wrote:

> IIRC "git push" without explicit refspecs push the matching
> refs, but I am a bit under the weather and feverish, so don't
> take my word literally but look at git-push manual page please.

Ah, yes you're right. It really doesn't make sense to push
refs/remotes/* in most cases, since they're just tracking branches, and
if the destination _does_ have them, then it is unlikely to be in sync
with you (leading to Bill's problem).  OTOH, you might want to be able
to push them explicitly if you are doing a strict mirror of a
repository.

The patch below turns off refs/remotes/ sending for "git-push" and
"git-push --all", but still allows "git-push origin
remotes/origin/master". I'm not sure about the semantics; maybe --all
should imply even remotes?

It also only impacts send-pack; I suspect pushing over dumb transports
now has different behavior, but I haven't looked. My testing was light,
so I may have totally broken something else, too. Input from more
clueful people would be helpful.

Does this seem like a sane direction to take? It just seems silly to be
pushing refs/remotes, which 99% of the time should be a purely local
thing.

-Peff

---
diff --git a/send-pack.c b/send-pack.c
index d5b5162..39829e3 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -131,6 +131,8 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 {
 	struct ref *ref;
 	int len = strlen(refname) + 1;
+	if (!prefixcmp(refname, "refs/remotes/"))
+		return 0;
 	ref = xcalloc(1, sizeof(*ref) + len);
 	hashcpy(ref->new_sha1, sha1);
 	memcpy(ref->name, refname, len);
