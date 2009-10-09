From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu,  8 Oct 2009 22:22:45 -0700
Message-ID: <1255065768-10428-2-git-send-email-spearce@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 07:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw80D-0001sK-58
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 07:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZJIFXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 01:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbZJIFX3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 01:23:29 -0400
Received: from george.spearce.org ([209.20.77.23]:37230 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbZJIFX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 01:23:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9981938221; Fri,  9 Oct 2009 05:22:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 138A8381FE
	for <git@vger.kernel.org>; Fri,  9 Oct 2009 05:22:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc3.193.gdf7a
In-Reply-To: <1255065768-10428-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129734>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/technical/http-protocol.txt |  542 +++++++++++++++++++++++++++++
 1 files changed, 542 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/http-protocol.txt

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
new file mode 100644
index 0000000..316d9b6
--- /dev/null
+++ b/Documentation/technical/http-protocol.txt
@@ -0,0 +1,542 @@
+HTTP transfer protocols
+=======================
+
+Git supports two HTTP based transfer protocols.  A "dumb" protocol
+which requires only a standard HTTP server on the server end of the
+connection, and a "smart" protocol which requires a Git aware CGI
+(or server module).  This document describes both protocols.
+
+As a design feature smart clients can automatically upgrade "dumb"
+protocol URLs to smart URLs.  This permits all users to have the
+same published URL, and the peers automatically select the most
+efficient transport available to them.
+
+
+URL Format
+----------
+
+URLs for Git repositories accessed by HTTP use the standard HTTP
+URL syntax documented by RFC 1738, so they are of the form:
+
+  http://<host>:<port>/<path>
+
+Within this documentation the placeholder $GIT_URL will stand for
+the http:// repository URL entered by the end-user.
+
+Both the "smart" and "dumb" HTTP protocols used by Git operate
+by appending additional path components onto the end of the user
+supplied $GIT_URL string.
+
+Clients MUST strip a trailing '/', if present, from the user supplied
+$GIT_URL string to prevent empty path tokens ('//') from appearing
+in any URL sent to a server.  Compatible clients must expand
+'$GIT_URL/info/refs' as 'foo/info/refs' and not 'foo//info/refs'.
+
+
+Authentication
+--------------
+
+Standard HTTP authentication is used if authentication is required
+to access a repository, and MAY be configured and enforced by the
+HTTP server software.
+
+Because Git repositories are accessed by standard path components
+server administrators MAY use directory based permissions within
+their HTTP server to control repository access.
+
+Clients SHOULD support Basic authentication as described by RFC 2616.
+Servers SHOULD support Basic authentication by relying upon the
+HTTP server placed in front of the Git server software.
+
+Servers MUST NOT require HTTP cookies for the purposes of
+authentication or access control.
+
+Clients and servers MAY support other common forms of HTTP based
+authentication, such as Digest authentication.
+
+
+SSL
+---
+
+Clients and servers SHOULD support SSL, particularly to protect
+passwords when relying on Basic HTTP authentication.
+
+
+Session State
+-------------
+
+The Git over HTTP protocol (much like HTTP itself) is stateless
+from the perspective of the HTTP server side.  All state must be
+retained and managed by the client process.  This permits simple
+round-robin load-balancing on the server side, without needing to
+worry about state mangement.
+
+Clients MUST NOT require state management on the server side in
+order to function correctly.
+
+Servers MUST NOT require HTTP cookies in order to function correctly.
+Clients MAY store and forward HTTP cookies during request processing
+as described by RFC 2616 (HTTP/1.1).  Servers SHOULD ignore any
+cookies sent by a client.
+
+
+pkt-line Format
+---------------
+
+Much (but not all) of the payload is described around pkt-lines.
+
+A pkt-line is a variable length binary string.  The first four bytes
+of the line indicates the total length of the line, in hexadecimal.
+The total length includes the 4 bytes used to denote the length.
+A line SHOULD BE terminated by an LF, which if present MUST be
+included in the total length.
+
+A pkt-line MAY contain binary data, so implementors MUST ensure all
+pkt-line parsing/formatting routines are 8-bit clean.  The maximum
+length of a pkt-line's data is 65532 bytes (65536 - 4).
+
+Examples (as C-style strings):
+
+  pkt-line          actual value
+  ---------------------------------
+  "0006a\n"         "a\n"
+  "0005a"           "a"
+  "000bfoobar\n"    "foobar\n"
+  "0004"            ""
+
+A pkt-line with a length of 0 ("0000") is a special case and MUST
+be treated as a message break or terminator in the payload.
+
+
+General Request Processing
+--------------------------
+
+Except where noted, all standard HTTP behavior SHOULD be assumed
+by both client and server.  This includes (but is not necessarily
+limited to):
+
+If there is no repository at $GIT_URL, the server MUST respond with
+the '404 Not Found' HTTP status code.
+
+If there is a repository at $GIT_URL, but access is not currently
+permitted, the server MUST respond with the '403 Forbidden' HTTP
+status code.
+
+Servers SHOULD support both HTTP 1.0 and HTTP 1.1.
+Servers SHOULD support chunked encoding for both
+request and response bodies.
+
+Clients SHOULD support both HTTP 1.0 and HTTP 1.1.
+Clients SHOULD support chunked encoding for both
+request and response bodies.
+
+Servers MAY return ETag and/or Last-Modified headers.
+
+Clients MAY revalidate cached entities by including If-Modified-Since
+and/or If-None-Match request headers.
+
+Servers MAY return '304 Not Modified' if the relevant headers appear
+in the request and the entity has not changed.  Clients MUST treat
+'304 Not Modified' identical to '200 OK' by reusing the cached entity.
+
+Clients MAY reuse a cached entity without revalidation if the
+Cache-Control and/or Expires header permits caching.  Clients and
+servers MUST follow RFC 2616 for cache controls.
+
+
+Discovering References
+----------------------
+
+All HTTP clients MUST begin either a fetch or a push exchange by
+discovering the references available on the remote repository.
+
+Dumb Clients
+~~~~~~~~~~~~
+
+HTTP clients that only support the "dumb" protocol MUST discover
+references by making a request for the special info/refs file of
+the repository.
+
+Dumb HTTP clients MUST NOT include search/query parameters when
+fetching the info/refs file.  (That is, '?' must not appear in the
+requested URL.)
+
+	C: GET $GIT_URL/info/refs HTTP/1.0
+
+	S: 200 OK
+	S:
+	S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+	S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+	S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+	S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+
+The Content-Type of the returned info/refs entity SHOULD be
+"text/plain; charset=utf-8", but MAY be any content type.
+Clients MUST NOT attempt to validate the returned Content-Type.
+Dumb servers MUST NOT return a return type starting with
+"application/x-git-".
+
+Cache-Control headers MAY be returned to disable caching of the
+returned entity.
+
+When examining the response clients SHOULD only examine the HTTP
+status code.  Valid responses are '200 OK', or '304 Not Modified'.
+
+The returned content is a UNIX formatted text file describing
+each ref and its known value.  The file SHOULD be sorted by name
+according to the C locale ordering.  The file SHOULD NOT include
+the default ref named 'HEAD'.
+
+	info_refs     = *( ref_record )
+	ref_record    = any_ref | peeled_ref
+
+	any_ref       = id HT name LF
+	peeled_ref    = id HT name LF
+	                id HT name "^{}" LF
+	id            = 40*HEX
+
+	HEX           = "0".."9" | "a".."f"
+	LF            = <US-ASCII LF, linefeed (10)>
+	HT            = <US-ASCII HT, horizontal-tab (9)>
+
+Smart Clients
+~~~~~~~~~~~~~
+
+HTTP clients that support the "smart" protocol (or both the
+"smart" and "dumb" protocols) MUST discover references by making
+a paramterized request for the info/refs file of the repository.
+
+The request MUST contain exactly one query parameter,
+'service=$servicename', where $servicename MUST be the service
+name the client wishes to contact to complete the operation.
+The request MUST NOT contain additional query parameters.
+
+	C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
+
+	dumb server reply:
+	S: 200 OK
+	S:
+	S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+	S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+	S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+	S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+
+	smart server reply:
+	S: 200 OK
+	S: Content-Type: application/x-git-upload-pack-advertisement
+	S: Cache-Control: no-cache
+	S:
+	S: ....# service=git-upload-pack
+	S: ....95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0 multi_ack
+	S: ....d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
+	S: ....2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0
+	S: ....a3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}
+
+Dumb Server Response
+^^^^^^^^^^^^^^^^^^^^
+Dumb servers MUST respond with the dumb server reply format.
+
+See the prior section under dumb clients for a more detailed
+description of the dumb server response.
+
+Smart Server Response
+^^^^^^^^^^^^^^^^^^^^^
+Smart servers MUST respond with the smart server reply format.
+
+If the server does not recognize the requested service name, or the
+requested service name has been disabled by the server administrator,
+the server MUST respond with the '403 Forbidden' HTTP status code.
+
+Cache-Control headers SHOULD be used to disable caching of the
+returned entity.
+
+The Content-Type MUST be 'application/x-$servicename-advertisement'.
+Clients SHOULD fall back to the dumb protocol if another content
+type is returned.  When falling back to the dumb protocol clients
+SHOULD NOT make an additional request to $GIT_URL/info/refs, but
+instead SHOULD use the response already in hand.  Clients MUST NOT
+continue if they do not support the dumb protocol.
+
+Clients MUST validate the status code is either '200 OK' or
+'304 Not Modified'.
+
+Clients MUST validate the first five bytes of the response entity
+matches the regex "^[0-9a-f]{4}#".  If this test fails, clients
+MUST NOT continue.
+
+Clients MUST parse the entire response as a sequence of pkt-line
+records.
+
+Clients MUST verify the first pkt-line is "# service=$servicename".
+Servers MUST set $servicename to be the request parameter value.
+Servers SHOULD include an LF at the end of this line.
+Clients MUST ignore an LF at the end of the line.
+
+Servers MUST terminate the response with the magic "0000" end
+pkt-line marker.
+
+The returned response is a pkt-line stream describing each ref and
+its known value.  The stream SHOULD be sorted by name according to
+the C locale ordering.  The stream SHOULD include the default ref
+named 'HEAD' as the first ref.  The stream MUST include capability
+declarations behind a NUL on the first ref.
+
+	smart_reply    = PKT-LINE("# service=$servicename" LF)
+	                 ref_list
+	                 "0000"
+	ref_list       = empty_list | populated_list
+
+	empty_list     = PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
+
+	non_empty_list = PKT-LINE(id SP name NUL cap_list LF)
+	                 *ref_record
+
+	cap_list      = *(SP capability) SP
+	ref_record    = any_ref | peeled_ref
+
+	any_ref       = PKT-LINE(id SP name LF)
+	peeled_ref    = PKT-LINE(id SP name LF)
+	                PKT-LINE(id SP name "^{}" LF
+	id            = 40*HEX
+
+	HEX           = "0".."9" | "a".."f"
+	NL            = <US-ASCII NUL, null (0)>
+	LF            = <US-ASCII LF,  linefeed (10)>
+	SP            = <US-ASCII SP,  horizontal-tab (9)>
+
+
+Smart Service git-upload-pack
+------------------------------
+This service reads from the remote repository.
+
+Clients MUST first perform ref discovery with
+'$GIT_URL/info/refs?service=git-upload-pack'.
+
+	C: POST $GIT_URL/git-upload-pack HTTP/1.0
+	C: Content-Type: application/x-git-upload-pack-request
+	C:
+	C: ....want 0a53e9ddeaddad63ad106860237bbf53411d11a7
+	C: ....have 441b40d833fdfa93eb2908e52742248faf0ee993
+	C: 0000
+
+	S: 200 OK
+	S: Content-Type: application/x-git-upload-pack-result
+	S: Cache-Control: no-cache
+	S:
+	S: ....ACK %s, continue
+	S: ....NAK
+
+Clients MUST NOT reuse or revalidate a cached reponse.
+Servers MUST include sufficient Cache-Control headers
+to prevent caching of the response.
+
+Servers SHOULD support all capabilities defined here.
+
+Clients MUST send at least one 'want' command in the request body.
+Clients MUST NOT reference an id in a 'want' command which did not
+appear in the response obtained through ref discovery.
+
+	compute_request   = want_list
+	                    have_list
+	                    request_end
+	request_end       = "0000" | "done"
+
+	want_list         = PKT-LINE(want NUL cap_list LF)
+	                    *(want_pkt)
+	want_pkt          = PKT-LINE(want LF)
+	want              = "want" SP id
+	cap_list          = *(SP capability) SP
+
+	have_list         = *PKT-LINE("have" SP id LF)
+
+	command           = create | delete | update
+	create            = 40*"0" SP new_id SP name
+	delete            = old_id SP 40*"0" SP name
+	update            = old_id SP new_id SP name
+
+TODO: Document this further.
+TODO: Don't use uppercase for variable names below.
+
+Capability include-tag
+~~~~~~~~~~~~~~~~~~~~~~
+
+When packing an object that an annotated tag points at, include the
+tag object too.  Clients can request this if they want to fetch
+tags, but don't know which tags they will need until after they
+receive the branch data.  By enabling include-tag an entire call
+to upload-pack can be avoided.
+
+Capability thin-pack
+~~~~~~~~~~~~~~~~~~~~
+
+When packing a deltified object the base is not included if the base
+is reachable from an object listed in the COMMON set by the client.
+This reduces the bandwidth required to transfer, but it does slightly
+increase processing time for the client to save the pack to disk.
+
+The Negotiation Algorithm
+~~~~~~~~~~~~~~~~~~~~~~~~~
+The computation to select the minimal pack proceeds as follows
+(c = client, s = server):
+
+ init step:
+ (c) Use ref discovery to obtain the advertised refs.
+ (c) Place any object seen into set ADVERTISED.
+
+ (c) Build an empty set, COMMON, to hold the objects that are later
+     determined to be on both ends.
+ (c) Build a set, WANT, of the objects from ADVERTISED the client
+     wants to fetch, based on what it saw during ref discovery.
+
+ (c) Start a queue, C_PENDING, ordered by commit time (popping newest
+     first).  Add all client refs.  When a commit is popped from
+     the queue its parents should be automatically inserted back.
+     Commits MUST only enter the queue once.
+
+ one compute step:
+ (c) Send one $GIT_URL/git-upload-pack request:
+
+	C: 0032want <WANT #1>...............................
+	C: 0032want <WANT #2>...............................
+	....
+	C: 0032have <COMMON #1>.............................
+	C: 0032have <COMMON #2>.............................
+	....
+	C: 0032have <HAVE #1>...............................
+	C: 0032have <HAVE #2>...............................
+	....
+	C: 0000
+
+     The stream is organized into "commands", with each command
+     appearing by itself in a pkt-line.  Within a command line
+     the text leading up to the first space is the command name,
+     and the remainder of the line to the first LF is the value.
+     Command lines are terminated with an LF as the last byte of
+     the pkt-line value.
+
+     Commands MUST appear in the following order, if they appear
+     at all in the request stream:
+
+       * want
+       * have
+
+     The stream is terminated by a pkt-line flush ("0000").
+
+     A single "want" or "have" command MUST have one hex formatted
+     SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
+     multiple commands.
+
+     The HAVE list is created by popping the first 32 commits
+     from C_PENDING.  Less can be supplied if C_PENDING empties.
+
+     If the client has sent 256 HAVE commits and has not yet
+     received one of those back from S_COMMON, or the client has
+     emptied C_PENDING it should include a "done" command to let
+     the server know it won't proceed:
+
+	C: 0009done
+
+  (s) Parse the git-upload-pack request:
+
+      Verify all objects in WANT are directly reachable from refs.
+
+	  The server MAY walk backwards through history or through
+      the reflog to permit slightly stale requests.
+
+      If no WANT objects are received, send an error:
+
+TODO: Define error if no want lines are requested.
+
+      If any WANT object is not reachable, send an error:
+
+TODO: Define error if an invalid want is requested.
+
+     Create an empty list, S_COMMON.
+
+     If 'have' was sent:
+
+     Loop through the objects in the order supplied by the client.
+     For each object, if the server has the object reachable from
+     a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
+     do not add any ancestors, even if they also appear in HAVE.
+
+  (s) Send the git-upload-pack response:
+
+     If the server has found a closed set of objects to pack or the
+     request ends with "done", it replies with the pack.
+
+TODO: Document the pack based response
+	S: PACK...
+
+     The returned stream is the side-band-64k protocol supported
+     by the git-upload-pack service, and the pack is embedded into
+     stream 1.  Progress messages from the server side may appear
+     in stream 2.
+
+     Here a "closed set of objects" is defined to have at least
+     one path from every WANT to at least one COMMON object.
+
+     If the server needs more information, it replies with a
+     status continue response:
+
+TODO: Document the non-pack response
+
+  (c) Parse the upload-pack response:
+
+TODO: Document parsing response
+
+      Do another compute step.
+
+
+Smart Service git-receive-pack
+------------------------------
+This service modifies the remote repository.
+
+Clients MUST first perform ref discovery with
+'$GIT_URL/info/refs?service=git-receive-pack'.
+
+	C: POST $GIT_URL/git-receive-pack HTTP/1.0
+	C: Content-Type: application/x-git-receive-pack-request
+	C:
+	C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 refs/heads/maint\0 report-status
+	C: 0000
+	C: PACK....
+
+	S: 200 OK
+	S: Content-Type: application/x-git-receive-pack-result
+	S: Cache-Control: no-cache
+	S:
+	S: ....
+
+Clients MUST NOT reuse or revalidate a cached reponse.
+Servers MUST include sufficient Cache-Control headers
+to prevent caching of the response.
+
+Servers SHOULD support all capabilities defined here.
+
+Clients MUST send at least one command in the request body.
+Within the command portion of the request body clients SHOULD send
+the id obtained through ref discovery as old_id.
+
+	update_request    = command_list
+	                    "PACK" <binary data>
+
+	command_list      = PKT-LINE(command NUL cap_list LF)
+	                    *(command_pkt)
+	command_pkt       = PKT-LINE(command LF)
+	cap_list          = *(SP capability) SP
+
+	command           = create | delete | update
+	create            = 40*"0" SP new_id SP name
+	delete            = old_id SP 40*"0" SP name
+	update            = old_id SP new_id SP name
+
+TODO: Document this further.
+
+
+References
+----------
+
+link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
+link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
+
-- 
1.6.5.rc3.193.gdf7a
