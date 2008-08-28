From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-aware HTTP transport
Date: Wed, 27 Aug 2008 21:42:27 -0700
Message-ID: <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
 <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
 <20080828035018.GA10010@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 06:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYZMC-00055i-PT
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 06:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYH1Emg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 00:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbYH1Emg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 00:42:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbYH1Emf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 00:42:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 949DF6A65D;
	Thu, 28 Aug 2008 00:42:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA7456A65B; Thu, 28 Aug 2008 00:42:29 -0400 (EDT)
In-Reply-To: <20080828035018.GA10010@spearce.org> (Shawn O. Pearce's message
 of "Wed, 27 Aug 2008 20:50:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB8675C0-74BB-11DD-90D5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94036>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> HTTP Redirects
> --------------
>
> If a POST request results in an HTTP 302 or 303 redirect response
> clients should retry the request by updating the URL and POSTing
> the same request to the new location.  Subsequent requests should
> still be sent to the original URL.

At the first reading I was confused because this seemed to contradict with
the server pinning that is done by the payload level redirect.

> Service upload-pack
> -------------------
>
> Prepares an estimated minimal pack to transfer new objects to the
> client.
>
> URL: $url/backend.git-http/upload-pack
> Content-Type: application/x-git; service=upload-pack
>
> The computation to select the minimal pack proceeds as follows
> (c = client, s = server):
>
>  init step:
>  (c) Use show-ref to obtain the advertised refs.
>  (c) Place any object seen in show-ref into set ADVERTISED.
>
>  (c) Build a set, WANT, of the objects from ADVERTISED the client
>      wants to fetch, based on what it saw from show-ref.
>
>  (c) Start a queue, C_PENDING, ordered by commit time (popping newest
>      first).  Add all client refs.  When a commit is popped from the
>      queue its parents should be automatically inserted back.  Commits
>      should only enter the queue once.
>
>  one compute step:
>  (c) Send an upload-pack request:
>
> 	C: 0011capabilities
> 	C: 0024thin-pack include-tag ofs-delta
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
>      name of the section ("capabilities", "want", "have", "common").
>      The second pkt-line has the binary SHA-1 ids which compose that
>      section.

It appears that you really meant "Binary", as opposed to "Hexadecimal"
that show-ref example illustrate, judging from the later 3,276 number.
I'd prefer hexadecimal here.

As a protocol specification, you'd eventually need to describe the
pkt-line format, namely, (1) four hexadecimal digits that represents the
length of the line (including that four bytes), followed by that many
number of bytes as the line's payload, or (2) "0000" which is "flush".
Also typically the text based line payload is LF terminated (hence the
four-hexdigit length counts the terminating LF).  Also "capabilities" need
to be defined.

>   (s) Parse the upload-pack request:
>
>       Verify all objects in WANT are reachable from refs.  As
>       this may require walking backwards through history to
>       the very beginning on invalid requests the server may
>       use a reasonable limit of commits (e.g. 1000) walked
>       beyond any ref tip before giving up.

I suspect moving as much work to the client side by erroring out and
having the client restart from show-ref might be a better tradeoff (also
this has been advertised as a security feature on the native protocol
side).

>       If any WANT object is not reachable, send an error:
>
> 	S: 001estatus error invalid want
>
>      Create an empty list, S_COMMON.
>
>      If 'common' was sent:
>
>      Load all objects into S_COMMON.

Security?  Error out if some of them do not exist on the server end, at
least.

>   (s) Send the upload-pack response:
>
>      If the server has found a closed set of objects to pack, it
>      replies with the pack and the enabled capabilities.  The set
>      of enabled capabilities is limited to the intersection of
>      what the client requested and what the server supports.

Define "closed set".

>      The stream formatting rules are the same as the request.
>
>      The section "common" details the contents of S_COMMON,
>      that is all objects from HAVE that the server also has.

An object in HAVE that exists on the server end can be a descendant of
many other HAVEs. Answering with that youngest one alone is enough,
without the other HAVEs the server end also has as its ancestors, as they
are redundant information.

>   (c) Parse the upload-pack response:
>
>       If the status pkt-line is "status pack:"
>
>       Process the pack stream and update the local refs.
>
>       If the status pkt-line is "status continue":
>
>       Reset COMMON to the items in S_COMMON.  The new S_COMMON
>       should be a superset of the existing COMMON set.

Is there a way to detect bad clients that does not obey this rule without
server side states?
