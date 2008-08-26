From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 19:34:50 -0700
Message-ID: <48B36BCA.8060103@zytor.com>
References: <20080826012643.GD26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 04:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXoPz-0002T3-8M
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 04:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbYHZCe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 22:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYHZCe7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 22:34:59 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58103 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbYHZCe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 22:34:58 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7Q2Yu09019253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 19:34:56 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7Q2YuZn004602;
	Mon, 25 Aug 2008 19:34:56 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7Q2Yo8t023955;
	Mon, 25 Aug 2008 19:34:51 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080826012643.GD26523@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8088/Mon Aug 25 13:49:45 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93701>

This is a bit more detailed review than I have done in the past (I'm 
actually in town...) so please pardon me for commenting on things that 
has been dealt with in the past.

Overall, I really keeping in mind that you're doing a layer on top of 
HTTP, and resist the temptation to delve into details how things are to 
be implemented at the HTTP level.

The HTTP layer, furthermore, has a couple of important properties:

- GET requests may be cached, even if you tell it not to.
   (Some proxies, transparent or not, ignore caching directives.)
- POST requests generally will not.

So don't implement things as GET requests unless you genuinely can deal 
with the request being cached.  Using POST requests throughout seems 
like a safer bet to me; on the other hand, since the only use of GET is 
obtaining a list of refs the worst thing that can happen, I presume, is 
additional latency for the user behind the proxy.

Again, please don't take this as anything other than technical review 
type criticism.  I'm obviously really happy about the project and want 
to see it happen.

I do have one, very specific question: would the load on the server be 
lower if it was using a stateful protocol (like the standard git 
protocol)?  If there is value in the server maintaining state, then I 
would like to suggest a slightly different protocol.

	-hpa


Shawn O. Pearce wrote:
> 
> HTTP/1.1 Preference
> -------------------
> 
> For performance reasons the HTTP/1.1 chunked transfer encoding
> is used whenever possible to transfer variable length objects.
> This avoids needing to produce large results in memory to compute
> the proper content-length.
> 

This piece is unnecessary; it's a detail of the underlying HTTP layer.

> Detecting Smart Servers
> -----------------------
> 
> HTTP clients can detect a smart Git-aware server by HEADing
> $repo/backend.git-http and looking for a 302 redirect to the
> repository's smart service URL:
> 
> 	C: HEAD /path/to/repository.git/backend.git-http HTTP/1.1
> 
> 	S: HTTP/1.1 302 Found
> 	S: Location: /git/path/to/repository.git
> 
> A dumb server would respond with a 304 Not Found (or 200 OK).
> 
> Smart servers may send a redirect to any URL that does not
> contain query args (e.g. "foo?repo=path.git" is invalid).
> The URL must be sufficient to provide the location of the
> repository to the smart service code.
> 
> A valid redirect can be to yourself, for example:
> 
> 	C: HEAD /path/to/repository.git/backend.git-http HTTP/1.1
> 
> 	S: HTTP/1.1 302 Found
> 	S: Location: /path/to/repository.git/backend.git-http/.
> 
> All subsequent communcation for this transaction is done through
> the smart service URL ($ssurl), not the original URL.

I actually suggest embedding the forwarding URL into an ordinary 
payload.  Instead of a HEAD request here, then do a GET (or, even 
better, POST) and get the redirected URL in return.

Why?  Because it's common enough to redirect entire trees, and use of 
HTTP-layer redirections here is an unnecessary layering violation.

If you insist on using a HTTP status code, I would claim that 303 is a 
better status code.

> GET $ssurl/refs
> ---------------
> 
> Obtains the available refs from the remote repository.  The response
> is a sequence of refs, one per Git packet line.  The final packet
> line has a length of 0 to indicate the end.  This is basically
> the same protocol that is used by the git-upload-pack service to
> advertise the available refs.
> 
> 	C: GET $ssurl/refs HTTP/1.1
> 
> 	S: HTTP/1.1 200 OK
> 	S: Content-Type: application/x-git-refs
> 	S:
> 	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
> 	S: 003e95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
> 	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
> 	S: 003b2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
> 	S: 0000
> 
> POST $ssurl/upload-pack
> -----------------------
> 
> Prepares an estimated minimal pack to transfer new objects to the
> client.
> 
> The computation to select the minimal pack proceeds as follows
> (c = client, s = server):
> 
>  init step:
>  (c) Use /refs to obtain the advertised refs.
>  (c) Place any object seen in /refs into set ADVERTISED.
> 
>  (c) Build a set, WANT, of the objects from ADVERTISED the client
>      wants to fetch, based on what it saw from /refs.
> 
>  (c) Start a queue, C_PENDING, ordered by commit time (popping newest
>      first).  Add all client refs.  When a commit is popped from the
>      queue its parents should be automatically inserted back.  Commits
>      should only enter the queue once.
> 
>  one compute step:
>  (c) Send a /upload-pack request:
> 
> 	C: POST $ssurl/upload-pack HTTP/1.1
> 	C: Content-Type: application/x-git-uploadpack

Instead of "application/x-git-blah" I would suggest using 
"application/x-git; action=blah"; that way we can probably even register 
application/git with IANA.

> 	C: Content-Length: ...
> 	C:
> 	C: 0009want
> 	C: 0xxx<WANT list>
> 	C: 000bcommon
> 	C: 0xxx<COMMON list>
> 	C: 0009have
> 	C: 0xxx<HAVE list>
> 	C: 0000
> 
>      The stream is organized into "sections", where each section is
>      composed of two git pkt-lines.  The first pkt-line provides the
>      name of the section ("want", "have", "common").  The second
>      pkt-line has the binary SHA-1 ids which compose that section.
> 
>      The "want" section is required.  The other sections ("have",
>      "common") are optional.  A missing "want" section should be
>      answered with a "400 Bad Request".
> 
>      Sections must appear in the following order, if they appear
>      at all in the request stream:
> 
>        * want
>        * common
>        * have
> 
>      Each section may appear multiple times.  Client implementions
>      are encouraged to use as few sections as possible, however the
>      limit of 64k per pkt-line limits the number of ids to 3,276 per
>      section entry.
> 
>      The stream is terminated by a pkt-line flush ("0000").
> 
>      The HAVE list is created by popping the first 256 commits
>      from C_PENDING.  Less can be supplied if C_PENDING empties.
> 
>   (s) Parse the /upload-pack request.
> 
>       Verify all objects in WANT are reachable from refs.  As
>       this may require walking backwards through history to
>       the very beginning on invalid requests the server may
>       use a reasonable limit of commits (e.g. 1000) walked
>       beyond any ref tip before giving up.
> 
>       If any WANT object is not reachable, send a 409 error:

Again, I think the 409 error code here is an unnecessary layering 
violation.  It's simply Yet Another Thing that an HTTP proxy can screw 
up.  Having the HTTP server return a normal 200 reply (meaning that the 
*transport* succeeded) and have the error embedded in a lower layer 
should avoid that class of problems.

> 	S: HTTP/1.1 409 Conflict
> 	S: Content-Type: application/x-git-error
> 	S:
> 	S: %s not reachable
> 
>      Create an empty list, S_COMMON.
> 
>      If 'common' was sent:
> 
>      Load all objects into S_COMMON.
> 
>      If 'have' was sent:
> 
>      Loop through the objects in the order supplied by the client.
>      For each object, if the server has the object reachable from
>      a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
>      do not add any ancestors, even if they also appear in HAVE.
> 
>   (s) Send the /upload-pack response:
> 
> 	S: HTTP/1.1 200 OK
> 	S: Content-Type: application/x-git-uploadpack
> 
> 	S: 000bcommon
> 	S: 0xxx<S_COMMON list>
> 	S: 0000
> 
>      The stream formatting rules are the same as the request.
> 
>      The section "common" details the contents of S_COMMON,
>      that is all objects from HAVE that the server also has.
> 
>      If the server has found a closed set of objects to pack,
>      it replies with the pack and not x-git-uploadpack response.
> 
> 	S: HTTP/1.1 200 OK
> 	S: Content-Type: application/x-git-pack
> 
> 	S: 000c.PACK...
> 
>      The returned stream is the side-band-64k protocol supported
>      by the git-upload-pack service, and the pack is embedded into
>      stream 1.  Progress messages from the server side may appear
>      in stream 2.
> 
>   (c) Parse the /upload-pack response:
> 
>       If the Content-Type is application/x-git-uploadpack:
> 
>       Reset COMMON to the items in S_COMMON.  The new S_COMMON
>       should be a superset of the existing COMMON set.
> 
>       Remove all items in S_COMMON, and all of their ancestors,
>       from PENDING.
> 
>       Do another /compute-common step.
> 
>       If the Content-Type is application/x-git-pack:
> 
>       Process the pack stream and update the local refs.
> 
> 
> POST $ssurl/receive-pack
> ------------------------
> 
> TBD: Still a work in progress.
> 
> Uploads a pack and updates refs.  The start of the stream is the
> commands to update the refs and the remainder of the stream is the
> pack file itself.  See git-receive-pack and its network protocol
> in pack-protocol.txt, as this is essentially the same.
> 
> 	C: POST /path/to/repository.git/receive-pack HTTP/1.0
> 	C: Content-Type: application/x-git-receivepack
> 	C: Transfer-Encoding: chunked
> 	C:
> 	C: 103
> 	C: 006395dcfa3633004da0049d3d0fa03f80589cbcaf31 d049f6c27a2244e12041955e262a404c7faba355 refs/heads/maint
> 	C: 4
> 	C: 0000
> 	C: 12
> 	C: PACK
> 	...
> 	C: 0
> 
> 	S: HTTP/1.0 200 OK
> 	S: Content-type: application/x-git-receive-pack-status
> 	S: Transfer-Encoding: chunked
> 	S:
> 	S: ...<output of receive-pack>...
> 
> 
