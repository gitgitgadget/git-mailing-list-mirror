From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Wed, 27 Aug 2008 20:50:18 -0700
Message-ID: <20080828035018.GA10010@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 05:51:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYYXd-00044g-Cx
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 05:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYH1DuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 23:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYH1DuU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 23:50:20 -0400
Received: from george.spearce.org ([209.20.77.23]:43624 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYH1DuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 23:50:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 41D7138375; Thu, 28 Aug 2008 03:50:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B485F8.5030109@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94032>

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
> Looks great to me.

So this is what may be the final draft of the HTTP protocol.
I've added stuff about capability selection between the peers for
future expansion support.  The upload-pack service has a better
use of it than receive-pack.  Otherwise it is what I think you are
agreeing to above.  ;-)

I'm hoping to start implementating a prototype of this on Friday.
I may do it in JGit first; the transport infrastructure there is
a lot more modular so experimentation should be quicker.  I would
obviously also implement it in C Git, unless someone else comes
along and beats me to it.  This project is only a fraction of my
total Git time in any given week.  :-|

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

HTTP Redirects
--------------

If a POST request results in an HTTP 302 or 303 redirect response
clients should retry the request by updating the URL and POSTing
the same request to the new location.  Subsequent requests should
still be sent to the original URL.

Detecting Smart Servers
-----------------------

HTTP clients can detect a smart Git-aware server by sending
a request to service "show-ref".

A Git-aware server will respond with a valid response.  Clients
must check the following properties to prevent being fooled by
misconfigured servers:

  * HTTP status code is 200.
  * Content-Type is "application/x-git; service=show-ref"
  * The body can be parsed without errors.  The length of
    each pkt-line must be 4 valid hex digits.

A dumb server will respond with a non-200 HTTP status code.
A misconfigured server may respond with a normal 200 status
code, but an incorrect content type, or an invalid leading
4 byte sequence for a pkt-line (e.g. "<htm" or "<!DO" are
not valid lengths).

Service show-ref
----------------

Obtains the available refs from the remote repository.

URL: $url/backend.git-http/show-ref
Content-Type: application/x-git; service=show-ref

The request is an empty body.

The response is a pkt-line with "refs", followed by zero
or more ref pkt-lines ("$id $name"), and a final pkt-line
with a length of 0:

	S: 0009refs
	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
	S: 003e95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
	S: 003b2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
	S: 0000

The response may begin with an optional redirect to a new service
URL for the repository:

	S: 0028redirect http://s1.example.com/git/
	S: 0009refs
	S: 003295dcfa3633004da0049d3d0fa03f80589cbcaf31 HEAD
	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
	S: 0000

or be composed of only a redirect:

	S: 0028redirect http://s1.example.com/git/
	S: 0000

If a redirect is returned the client should update itself
to use the new URL as the location for future requests.
A server may use the redirect to request that the client
"pin" itself to a particular server for the remainder of
the current transaction.

The URL listed in any redirect should be the base URL
without any query args.  The client will automatically
append "/backend.git-http/$service" as it makes each
future request.

If no "refs" line was received in the response, but
a "redirect" was received, the client should retry
its request at the new location before giving up.

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

	C: 0011capabilities
	C: 0024thin-pack include-tag ofs-delta
	C: 0009want
	C: 0xxx<WANT list>
	C: 000bcommon
	C: 0xxx<COMMON list>
	C: 0009have
	C: 0xxx<HAVE list>
	C: 0000

     The stream is organized into "sections", where each section is
     composed of two git pkt-lines.  The first pkt-line provides the
     name of the section ("capabilities", "want", "have", "common").
     The second pkt-line has the binary SHA-1 ids which compose that
     section.

     The "want" section is required.  The other sections ("have",
     "common") are optional.  A missing "want" section should be
     answered with an error.

     Sections must appear in the following order, if they appear
     at all in the request stream:

       * capabilities
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

     If the server has found a closed set of objects to pack, it
     replies with the pack and the enabled capabilities.  The set
     of enabled capabilities is limited to the intersection of
     what the client requested and what the server supports.

	S: 0010status pack
	S: 0011capabilities
	S: 0024thin-pack include-tag ofs-delta
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

	C: 0011capabilities
	C: 0005
	C: 006395dcfa3633004da0049d3d0fa03f80589cbcaf31 d049f6c27a2244e12041955e262a404c7faba355 refs/heads/maint
	C: 0000
	C: PACK...

	S: 0011capabilities
	S: 0005
	S: ...<output of receive-pack>...

The capabilities are handled exactly as in the fetch protocol,
however the server may reject a pack and its associated commands
if an invalid capability request is made by the client, or the
client has assumed a pack capability that the server does not
have support for.  In the latter case the server must still send
the capabilities key in the response so the client can correct
itself and try again.

-- 
Shawn.
