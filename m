From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 20:45:45 -0700
Message-ID: <20080826034544.GA32334@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 05:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXpZ8-00066c-Jg
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 05:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbYHZDpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 23:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYHZDpq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 23:45:46 -0400
Received: from george.spearce.org ([209.20.77.23]:54490 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbYHZDpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 23:45:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 11CDC38375; Tue, 26 Aug 2008 03:45:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B36BCA.8060103@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93704>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> So don't implement things as GET requests unless you genuinely can deal  
> with the request being cached.  Using POST requests throughout seems  
> like a safer bet to me; on the other hand, since the only use of GET is  
> obtaining a list of refs the worst thing that can happen, I presume, is  
> additional latency for the user behind the proxy.

This is a good point.  There is probably not any reason to cache the
refs content if we don't also support caching the pack files.  So in
this latest draft I have moved the ref listing to also be a POST.

> I do have one, very specific question: would the load on the server be  
> lower if it was using a stateful protocol (like the standard git  
> protocol)?  If there is value in the server maintaining state, then I  
> would like to suggest a slightly different protocol.

Its possible the load would be lower, but it would complicate the
server implementation considerably.  Looking at the algorithm used
to compute upload-pack the server has relatively little to do in
any request.

Validation of WANT should be just matching the requested objects
against the refs; most clients will be asking for the current tips.
A client that started the process just before a fast-forward push
may incur at most a few hundred commit walk during its last couple
of computation round-trips.

Marking commits COMMON is just a matter of looking them up in the
database and setting their flags.

Evaluation of the HAVE list avoids duplicates in a well-behaved
client.  So the server sees each candidate commit from a client
only once, even if it spans multiple upload-pack requests.

So I think the cost may actually break even with a stateful protocol
if we imagine that the server is actually a farm of systems and
simple round-robin load-balancing is being done in front of the
Git-aware server.

I'd really like to keep the protocol stateless on the server side, as
this makes it easier to embed into certain commerical server farms.

> Shawn O. Pearce wrote:
>>
>> HTTP/1.1 Preference
>
> This piece is unnecessary; it's a detail of the underlying HTTP layer.

Gone from the latest draft.

>> Detecting Smart Servers
...
> I actually suggest embedding the forwarding URL into an ordinary  
> payload.  Instead of a HEAD request here, then do a GET (or, even  
> better, POST) and get the redirected URL in return.
>
> Why?  Because it's common enough to redirect entire trees, and use of  
> HTTP-layer redirections here is an unnecessary layering violation.

This has been completely rewritten to not use URL redirection at all.

--8<--
Smart HTTP transfer protocols
=============================

Git supports two HTTP based transfer protocols.  A "dumb" protocol
which requires only a standard HTTP server on the server end of the
connection, and a "smart" protocol which requires a Git aware CGI
(or server module).  This document describes the "smart" protocol.

As a design feature smart clients can automatically translate and
upgrade "dumb" protocol URLs.  This permits all users to have the
same published URL, with the peers automatically choosing to use
the most efficient transport available to them.

HTTP Transport
--------------

All requests are encoded as HTTP POST requests to the smart service
URL, "$url/backend.git-http/$service".

All responses are encoded as 200 Ok responses, even if the server
side has "failed" the request.  Service specific success/failure
codes are embedded in the content.

Authentication
--------------

Standard HTTP authentication is used if authentication is required
to access a repository, and must be configured and enforced by the
HTTP server software itself.

Stateless
---------

The protocol, much like its underlying HTTP, is stateless, from the
perspective of the HTTP server side.  All state must be retained and
managed by the client.  This permits round-robin load-balancing on
the server side, among many other implementation details.

Content Type
------------

All requests/responses use "application/x-git" as the content type.
Action specific subtypes are specified by the parameter "service",
e.g. "application/x-git; service=upload-pack".

Detecting Smart Servers
-----------------------

HTTP clients can detect a smart Git-aware server by sending
a request to service "show-ref".

A Git-aware server will respond with a valid response (see below).
A dumb server should respond with an error message. 

Service show-ref
----------------

Obtains the available refs from the remote repository.

URL: $url/backend.git-http/show-ref
Content-Type: application/x-git; service=show-ref

The request is an empty body.

The response is a sequence of refs, one per Git packet line.
The final packet line has a length of 0 to indicate the end.

	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
	S: 003e95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
	S: 003b2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
	S: 0000

Service upload-pack
-------------------

Prepares an estimated minimal pack to transfer new objects to the
client.

URL: $url/backend.git-http/upload-pack
Content-Type: application/x-git; service=upload-pack

The computation to select the minimal pack proceeds as follows
(c = client, s = server):

 init step:
 (c) Use show-ref to obtain the advertised refs.
 (c) Place any object seen in show-ref into set ADVERTISED.

 (c) Build a set, WANT, of the objects from ADVERTISED the client
     wants to fetch, based on what it saw from show-ref.

 (c) Start a queue, C_PENDING, ordered by commit time (popping newest
     first).  Add all client refs.  When a commit is popped from the
     queue its parents should be automatically inserted back.  Commits
     should only enter the queue once.

 one compute step:
 (c) Send an upload-pack request:

	C: 0009want
	C: 0xxx<WANT list>
	C: 000bcommon
	C: 0xxx<COMMON list>
	C: 0009have
	C: 0xxx<HAVE list>
	C: 0000

     The stream is organized into "sections", where each section is
     composed of two git pkt-lines.  The first pkt-line provides the
     name of the section ("want", "have", "common").  The second
     pkt-line has the binary SHA-1 ids which compose that section.

     The "want" section is required.  The other sections ("have",
     "common") are optional.  A missing "want" section should be
     answered with an error.

     Sections must appear in the following order, if they appear
     at all in the request stream:

       * want
       * common
       * have

     Each section may appear multiple times.  Client implementions
     are encouraged to use as few sections as possible, however the
     limit of 64k per pkt-line limits the number of ids to 3,276 per
     section entry.

     The stream is terminated by a pkt-line flush ("0000").

     The HAVE list is created by popping the first 256 commits
     from C_PENDING.  Less can be supplied if C_PENDING empties.

  (s) Parse the upload-pack request:

      Verify all objects in WANT are reachable from refs.  As
      this may require walking backwards through history to
      the very beginning on invalid requests the server may
      use a reasonable limit of commits (e.g. 1000) walked
      beyond any ref tip before giving up.

      If no WANT objects are received, send an error:

	S: 0019status error no want

      If any WANT object is not reachable, send an error:

	S: 001estatus error invalid want

     Create an empty list, S_COMMON.

     If 'common' was sent:

     Load all objects into S_COMMON.

     If 'have' was sent:

     Loop through the objects in the order supplied by the client.
     For each object, if the server has the object reachable from
     a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
     do not add any ancestors, even if they also appear in HAVE.

  (s) Send the upload-pack response:

     If the server has found a closed set of objects to pack,
     it replies with the pack.

	S: 0010status pack
	S: 000c.PACK...

     The returned stream is the side-band-64k protocol supported
     by the git-upload-pack service, and the pack is embedded into
     stream 1.  Progress messages from the server side may appear
     in stream 2.

     If the server wants more information, it replies with a
     status continue response:

	S: 0014status continue
	S: 000bcommon
	S: 0xxx<S_COMMON list>
	S: 0000

     The stream formatting rules are the same as the request.

     The section "common" details the contents of S_COMMON,
     that is all objects from HAVE that the server also has.

  (c) Parse the upload-pack response:

      If the status pkt-line is "status pack:"

      Process the pack stream and update the local refs.

      If the status pkt-line is "status continue":

      Reset COMMON to the items in S_COMMON.  The new S_COMMON
      should be a superset of the existing COMMON set.

      Remove all items in S_COMMON, and all of their ancestors,
      from PENDING.

      Do another compute step.


Service receive-pack
--------------------

Uploads a pack and updates refs.

URL: $url/backend.git-http/receive-pack
Content-Type: application/x-git; service=receive-pack

The start of the stream is the commands to update the refs and
the remainder of the stream is the pack file itself.  See
git-receive-pack and its network protocol in pack-protocol.txt,
as this is essentially the same.

	C: 006395dcfa3633004da0049d3d0fa03f80589cbcaf31 d049f6c27a2244e12041955e262a404c7faba355 refs/heads/maint
	C: 0000
	C: PACK...

	S: ...<output of receive-pack>...


-- 
Shawn.
