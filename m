From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 09:14:25 -0700
Message-ID: <20080826161425.GG26523@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1D6-0006ac-GR
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbYHZQO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758121AbYHZQO1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:14:27 -0400
Received: from george.spearce.org ([209.20.77.23]:54802 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYHZQO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:14:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C945538375; Tue, 26 Aug 2008 16:14:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080826145857.GF26523@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93754>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >
> > I actually suggest embedding the forwarding URL into an ordinary  
> > payload.  Instead of a HEAD request here, then do a GET (or, even  
> > better, POST) and get the redirected URL in return.
> 
> Hmm.  I'm actually thinking the exact opposite here.

Here's the delta from the last draft I emailed.  Its basically just
about this redirect stuff.

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 99d7623..a3f7379 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -43,14 +43,40 @@ All requests/responses use "application/x-git" as the content type.
 Action specific subtypes are specified by the parameter "service",
 e.g. "application/x-git; service=upload-pack".
 
+Redirects
+---------
+
+If a POST request results in an HTTP 302 or 303 redirect response
+clients should retry the request by updating the URL and POSTing
+the request to the new location.
+
+If the new request is successful clients should trim off the
+trailing "/backend.git/$service" portion of the new loaction
+and use the remainder as the base URL for future requests in
+the same transaction.
+
+This redirection permits Apache's mod_rewrite (and many other
+servers) to implement a form of round-robin load balancing by
+redirecting all requests to a generic host to a specific host.
+
 Detecting Smart Servers
 -----------------------
 
 HTTP clients can detect a smart Git-aware server by sending
 a request to service "show-ref".
 
-A Git-aware server will respond with a valid response (see below).
-A dumb server should respond with an error message. 
+A Git-aware server will respond with a valid response.  Clients
+must check the following properties to prevent being fooled by
+misconfigured servers:
+
+  * HTTP status code is 200.
+  * Content-Type is "application/x-git; service=show-ref"
+  * The body can be parsed without errors.  The length of
+    each pkt-line must be 4 valid hex digits.
+
+A dumb server will respond with a non-200 HTTP status code.
+A misconfigured server may respond with a normal 200 status
+code, but an incorrect content type.
 
 Service show-ref
 ----------------

-- 
Shawn.
