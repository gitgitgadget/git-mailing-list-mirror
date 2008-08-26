From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 10:26:48 -0700
Message-ID: <20080826172648.GK26523@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Kg-0003Jl-GZ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbYHZR0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYHZR0t
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:26:49 -0400
Received: from george.spearce.org ([209.20.77.23]:58802 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbYHZR0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:26:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F2AA38375; Tue, 26 Aug 2008 17:26:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B4303C.3080409@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93775>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> Hmm.  I'm actually thinking the exact opposite here.  My rationale
>> for putting the response as a standard HTTP 302/303 style redirect
>> is to permit hardware load balancers [...]
>> to implement simple load balancing with a HTTP redirect.
>
> No, you're thinking backwards.  What you want is the standard HTTP  
> redirect load balancing to take effect *before* the initial request is  
> serviced.
...
> Please keep in mind I'm not talking hypotheticals at all.  What you have  
> proposed is actually a lot uglier for kernel.org to implement, simply  
> because we try to stay with strict IP-based vhosting

Discard my prior patch from today.

This is a patch to last night's full document edition
(http://article.gmane.org/gmane.comp.version-control.git/93704)
and addresses only the issue of redirects.

--8<--
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 99d7623..99dc88d 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -43,14 +43,34 @@ All requests/responses use "application/x-git" as the content type.
 Action specific subtypes are specified by the parameter "service",
 e.g. "application/x-git; service=upload-pack".
 
+HTTP Redirects
+--------------
+
+If a POST request results in an HTTP 302 or 303 redirect response
+clients should retry the request by updating the URL and POSTing
+the same request to the new location.  Subsequent requests should
+still be sent to the original URL.
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
+code, but an incorrect content type, or an invalid leading
+4 byte sequence for a pkt-line (e.g. "<htm" or "<!DO" are
+not valid lengths).
 
 Service show-ref
 ----------------
@@ -62,15 +82,46 @@ Content-Type: application/x-git; service=show-ref
 
 The request is an empty body.
 
-The response is a sequence of refs, one per Git packet line.
-The final packet line has a length of 0 to indicate the end.
+The response is a pkt-line with "refs", followed by zero
+or more ref pkt-lines ("$id $name"), and a final pkt-line
+with a length of 0:
 
+	S: 0009refs
 	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
 	S: 003e95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
 	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
 	S: 003b2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
 	S: 0000
 
+The response may begin with an optional redirect to a new service
+URL for the repository:
+
+	S: 0028redirect http://s1.example.com/git/
+	S: 0009refs
+	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
+	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
+	S: 0000
+
+or be composed of only a redirect:
+
+	S: 0028redirect http://s1.example.com/git/
+	S: 0000
+
+If a redirect is returned the client should update itself
+to use the new URL as the location for future requests.
+A server may use the redirect to request that the client
+"pin" itself to a particular server for the remainder of
+the current transaction.
+
+The URL listed in any redirect should be the base URL
+without any query args.  The client will automatically
+append "/backend.git-http/$service" as it makes each
+future request.
+
+If no "refs" line was received in the response, but
+a "redirect" was received, the client should retry
+its request at the new location before giving up.
+
 Service upload-pack
 -------------------
 
-- 
Shawn.
