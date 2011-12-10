From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 11/13] strbuf: add strbuf_add*_urlencode
Date: Sat, 10 Dec 2011 15:09:09 -0500
Message-ID: <20111210200909.GC17999@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103420.GK16529@sigill.intra.peff.net>
 <m3iplohc6s.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 21:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZTFZ-0004ge-5o
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 21:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab1LJUJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 15:09:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47244
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab1LJUJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 15:09:11 -0500
Received: (qmail 17960 invoked by uid 107); 10 Dec 2011 20:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 15:15:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 15:09:09 -0500
Content-Disposition: inline
In-Reply-To: <m3iplohc6s.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186791>

On Sat, Dec 10, 2011 at 03:57:59AM -0800, Jakub Narebski wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
> > +			  int reserved)
> > +{
> > +	strbuf_grow(sb, len);
> 
> What is this `reserved` flag for, and when should one use it?
> It would be nice to have a short comment...

It indicates whether one should encode rfc3986 reserved characters. You
want to use it when encoding the host, username, and password portions
of a URL (i.e., before the "/"), but not the path (since you don't want
to encode all of the slashes). If you were breaking down the path more
(e.g., into a "query" and "fragment" portion), you would care about more
specific quoting there, but we don't; we treat everything after the
slash as an opaque blob of path.

Patch to the strbuf api documentation is below. I think it should be
squashed into patch 12/13.

> BTW. was it meant to be aligned like this?
> 
> > +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
> > +			     int reserved)

It is aligned correctly. When you ident by tabs, the "+" of the diff
gets soaked in the first tabstop, so it is off-by-one with respect to
non-tabbed input (it is off even more in the quoted section above,
because "> > +" gets soaked into the first tabstop). You can see your
version above also is misaligned when I quote it. :)

If you apply the diff, the result is as you expected.

-Peff

---
diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index afe2759..e1ab6c5 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -270,3 +270,14 @@ same behaviour as well.
 	third argument can be used to set the environment which the editor is
 	run in. If the buffer is NULL the editor is launched as usual but the
 	file's contents are not read into the buffer upon completion.
+
+`strbuf_add_urlencode`::
+
+	Copy data to the end of the buffer, percent-encoding it as per
+	rfc3986. If the reserved flag is non-zero, then characters in
+	the rfc3986 reserved list are percent-encoded; otherwise, they
+	are copied literally. Characters in the rfc3986 unreserved list
+	are always copied literally. All other characters are
+	percent-encoded. Typically, one would use the reserved flag for
+	the host and user-info sections of a URL, but leave special
+	characters in the path untouched.
