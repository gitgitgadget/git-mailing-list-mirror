From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Fri, 1 Feb 2013 13:58:27 -0500
Message-ID: <20130201185827.GA22919@sigill.intra.peff.net>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <20130201085248.GA30644@sigill.intra.peff.net>
 <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Lp8-0005eO-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab3BAS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:58:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035Ab3BAS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:58:30 -0500
Received: (qmail 30968 invoked by uid 107); 1 Feb 2013 18:59:54 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 13:59:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 13:58:27 -0500
Content-Disposition: inline
In-Reply-To: <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215251>

On Fri, Feb 01, 2013 at 10:09:26AM -0800, Junio C Hamano wrote:

> > so I do not think the patch makes anything worse. However, should we
> > take this opportunity to make the "did we get a smart response" test
> > more robust? That is, should we actually be checking the content-type
> > in the outer conditional, and going down the smart code-path if it is
> > application/x-%s-advertisement, and otherwise treating the result as
> > dumb?
> 
> Does the outer caller that switches between dumb and smart actually
> know what service type it is requesting (I am not familiar with the
> callchain involved)?  Even if it doesn't, it may still make sense.

I was specifically thinking of this (on top of your patch):

diff --git a/remote-curl.c b/remote-curl.c
index e6f3b63..63680a8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -134,14 +134,12 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
+	strbuf_addf(&exp, "application/x-%s-advertisement", service);
+	if (maybe_smart && !strbuf_cmp(&exp, &type)) {
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		strbuf_addf(&exp, "application/x-%s-advertisement", service);
-		if (strbuf_cmp(&exp, &type))
-			die("invalid content-type %s", type.buf);
 		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
 			die("%s has invalid packet header", refs_url);
 		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')

To just follow the dumb path if we don't get the content-type we expect.
We may want to keep the '#' format check in addition (packet_get_line
will check it and die, anyway, but we may want to drop back to
considering it dumb, just to protect against a badly configured dumb
server which uses our mime type, but I do not think it likely).

> > As a side note, should we (can we) care about the content-type for dumb
> > http? It should probably be text/plain or application/octet-stream, but
> > I would not be surprised if we get a variety of random junk in the real
> > world, though.
> 
> The design objective of dumb http protocol was to allow working with
> any dumb bit transfer thing, so I'd prefer to keep it lenient and
> allow application/x-git-loose-object-file and somesuch.

Yeah, I do not think it really buys us anything in practice, and we have
no way of knowing what kind of crap is in the wild. Not worth it.

-Peff
