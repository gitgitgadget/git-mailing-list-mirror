From: Jeff King <peff@peff.net>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 15:38:30 -0400
Message-ID: <20101012193830.GB8620@sigill.intra.peff.net>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
 <20101012193204.GA8620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chase Brammer <cbrammer@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5kg3-0002gy-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714Ab0JLTiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 15:38:17 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52286 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab0JLTiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 15:38:17 -0400
Received: (qmail 24460 invoked by uid 111); 12 Oct 2010 19:38:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 12 Oct 2010 19:38:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Oct 2010 15:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20101012193204.GA8620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158872>

On Tue, Oct 12, 2010 at 03:32:04PM -0400, Jeff King wrote:

> It looks like transport_set_verbosity gets called correctly, and then
> sets the "progress" flag for the transport. But for the push side, I
> don't see any transports actually looking at that flag. I think there
> needs to be code in git_transport_push to handle the progress flag, and
> it just isn't there.

Here's a quick 5-minute patch. It works on my test case:

  rm -rf parent child
  git init parent &&
  git clone parent child &&
  cd child &&
  echo content >file && git add file && git commit -m one &&
  git push --progress origin master:foo >foo.out 2>&1 &&
  cat foo.out

but I didn't even run the test suite. Maybe somebody more clueful in the
area can pick it up?

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..efd9be6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--delta-base-offset";
 	if (args->quiet)
 		argv[i++] = "-q";
+	if (args->progress)
+		argv[i++] = "--progress";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/send-pack.h b/send-pack.h
index 60b4ba6..fcf4707 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -4,6 +4,7 @@
 struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
+		progress:1,
 		porcelain:1,
 		send_mirror:1,
 		force_update:1,
diff --git a/transport.c b/transport.c
index 4dba6f8..0078660 100644
--- a/transport.c
+++ b/transport.c
@@ -789,6 +789,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.use_thin_pack = data->options.thin;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
+	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
