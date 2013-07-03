From: Jeff King <peff@peff.net>
Subject: Re: git clone -b
Date: Wed, 3 Jul 2013 06:01:19 -0400
Message-ID: <20130703100118.GA21130@sigill.intra.peff.net>
References: <51CD7AB7.3040409@atlas-elektronik.com>
 <51D12A0E.60709@atlas-elektronik.com>
 <CABURp0oQ9MNGZecD4mkniXMEUJ5L7Xn+JFQMEgc97Mfe26JYvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJsO-0002CC-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab3GCKBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:01:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:37236 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445Ab3GCKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:01:24 -0400
Received: (qmail 5406 invoked by uid 102); 3 Jul 2013 10:02:34 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 05:02:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 06:01:19 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0oQ9MNGZecD4mkniXMEUJ5L7Xn+JFQMEgc97Mfe26JYvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229480>

On Mon, Jul 01, 2013 at 01:49:37PM -0400, Phil Hord wrote:

> It would be nice to support more generic specs for the --branch
> switch. But it is complicated because the refs have not been fetched
> yet during the clone, and so normal refs operations -- which expect to
> work on a local repository -- do not work.  So, the ref is looked up
> locally from a list in expected locations after fetching the remote
> refs but before the clone occurs.  The remote refs which are fetched
> is not configurable during clone, and so only 'refs/heads/*' is
> fetched for non-mirrors.

I think there are two problems:

  1. Our find_remote_branch function implements only half of the regular
     ref_rev_parse_rules (heads and tags). Fixing that to make "-b
     refs/heads/master" work is pretty easy. Patch is below.

  2. When we give a ref that is not going to be fetched, we should
     fetch it explicitly. It looks like --single-branch tries to do
     this, but only handles tags. I am not sure what a non-single-branch
     would want to do (since you are effectively overriding the
     default refspecs).

     So even with the patch, doing "clone -b refs/foo/bar" does not
     quite work.

diff --git a/builtin/clone.c b/builtin/clone.c
index 14b1323..5984303 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -433,24 +433,24 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 	raise(signo);
 }
 
-static struct ref *find_remote_branch(const struct ref *refs, const char *branch)
+static struct ref *find_remote_branch(const struct ref *refs, const char *name)
 {
-	struct ref *ref;
-	struct strbuf head = STRBUF_INIT;
-	strbuf_addstr(&head, "refs/heads/");
-	strbuf_addstr(&head, branch);
-	ref = find_ref_by_name(refs, head.buf);
-	strbuf_release(&head);
-
-	if (ref)
-		return ref;
-
-	strbuf_addstr(&head, "refs/tags/");
-	strbuf_addstr(&head, branch);
-	ref = find_ref_by_name(refs, head.buf);
-	strbuf_release(&head);
-
-	return ref;
+	int len = strlen(name);
+	const char **p;
+
+	for (p = ref_rev_parse_rules; *p; p++) {
+		struct ref *ref;
+
+		ref = find_ref_by_name(refs, mkpath(*p, len, name));
+		if (ref)
+			/*
+			 * optionally check for and complain about ambiguity
+			 * here, like dwim_ref does
+			 */
+			return ref;
+	}
+
+	return NULL;
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
