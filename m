From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 18:17:15 -0500
Message-ID: <20090129231715.GA17399@coredump.intra.peff.net>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgA2-0007RC-L9
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544AbZA2XRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756283AbZA2XRU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:17:20 -0500
Received: from peff.net ([208.65.91.99]:37473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759899AbZA2XRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:17:18 -0500
Received: (qmail 20173 invoked by uid 107); 29 Jan 2009 23:17:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 18:17:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 18:17:15 -0500
Content-Disposition: inline
In-Reply-To: <20090129223308.GB12871@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107750>

On Thu, Jan 29, 2009 at 05:33:08PM -0500, Jeff King wrote:

> So I think this patch is going about it the wrong way. Instead of
> parsing the refspec, I think you actually want to look at what we _do_
> push (or at least try to push -- probably even uptodate refs should also
> have tracking established), and use that. Then you will have wildcards
> expanded, --all handled, etc. And I suspect all you have to do is
> iterate over the result of match_refs (which we call later), which
> should be even easier (because you don't have to parse the refspecs
> yourself). But I haven't looked carefully.

Something like the patch below (which is obviously missing all of the
infrastructure for doing this optionally, but is meant to illustrate
what I'm talking about).

The downside of this is that it only works for the git protocol
transport, making dumb push even more of a second class citizen (it
looks like this is already the case for updating tracking refs). But I
think this is the right place to do it, since we have detailed
information on the matched refs. If other transports want to do the same
thing, we should abstract setup_tracking (and update_tracking_ref while
we're at it) and call them from those transports.

---
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d65d019..23b326a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -247,6 +247,31 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	}
 }
 
+static void setup_tracking(const char *remote, struct ref *ref)
+{
+	const char *name;
+	struct strbuf key = STRBUF_INIT;
+
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
+		return;
+	if (!ref->peer_ref)
+		return;
+
+	name = ref->peer_ref->name;
+	if (prefixcmp(name, "refs/heads/"))
+		return;
+	name += 11;
+
+	strbuf_addf(&key, "branch.%s.remote", name);
+	git_config_set(key.buf, remote);
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", name);
+	git_config_set(key.buf, ref->name);
+
+	strbuf_release(&key);
+}
+
 static const char *prettify_ref(const struct ref *ref)
 {
 	const char *name = ref->name;
@@ -523,6 +548,10 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		for (ref = remote_refs; ref; ref = ref->next)
 			update_tracking_ref(remote, ref);
 	}
+	if (/* args.track && */ !args.dry_run) {
+		for (ref = remote_refs; ref; ref = ref->next)
+			setup_tracking(remote ? remote->name : dest, ref);
+	}
 
 	if (!refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
