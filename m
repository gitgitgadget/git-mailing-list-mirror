From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 05:39:12 -0400
Message-ID: <20111003093912.GA16078@sigill.intra.peff.net>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <4E8975E7.2040804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAeza-0003Vh-6s
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1JCJjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 05:39:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51502
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054Ab1JCJjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:39:16 -0400
Received: (qmail 26466 invoked by uid 107); 3 Oct 2011 09:44:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 05:44:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 05:39:12 -0400
Content-Disposition: inline
In-Reply-To: <4E8975E7.2040804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182642>

On Mon, Oct 03, 2011 at 10:44:23AM +0200, Johannes Sixt wrote:

> Am 10/3/2011 9:42, schrieb Jeff King:
> > I still think push-over-git:// is a bit insane, and especially now with
> > smart-http, you'd be crazy to run it. And in that sense, I wouldn't mind
> > seeing it deprecated.
> 
> You must be kidding ;) It is so much easier to type
> 
>   git daemon --export-all --enable=receive-pack
> 
> for a one-shot, temporary git connection compared to setting up a
> smart-http, ssh, or even a rsh server.

Ah, yeah, I didn't think about one-shot invocations like that (I think
the original motivation was somebody actually running it all the time).

So yeah, that makes it even worse for the client to start refusing this
without even contacting the server. I forgot that we added the "ERR"
response way back in a807328 (connect.c: add a way for git-daemon to
pass an error back to client, 2008-11-01).

GitHub uses it to make nice messages:

  $ git push origin
  fatal: remote error:
    You can't push to git://github.com/gitster/git.git
    Use git@github.com:gitster/git.git

We should maybe do something like the patch below:

diff --git a/daemon.c b/daemon.c
index 4c8346d..c1fa55f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -255,6 +255,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	loginfo("Request %s for '%s'", service->name, dir);
 
 	if (!enabled && !service->overridable) {
+		packet_write(1, "ERR %s: service not enabled", service->name);
 		logerror("'%s': service not enabled.", service->name);
 		errno = EACCES;
 		return -1;
@@ -288,6 +289,8 @@ static int run_service(char *dir, struct daemon_service *service)
 			enabled = service_enabled;
 	}
 	if (!enabled) {
+		packet_write(1, "ERR %s: service not enabled for '%s'",
+		       service->name, path);
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
 		errno = EACCES;

but:

  1. There is some information leakage there. In particular, one can
     tell the difference now between "repo does not exist" and
     "receive-pack is not turned on". Personally, I think the tradeoff
     to have actual error messages is worth it. HTTP has had real error
     codes for decades, and I don't think anybody is too up-in-arms that
     I can probe which pages are 404, and which are 401.

  2. It probably makes sense to have a more human-friendly error
     message.

  3. It may be worth adding error messages for lots of other conditions
     (e.g., no such repo). Assuming we accept the information leakage
     for (1).

-Peff
