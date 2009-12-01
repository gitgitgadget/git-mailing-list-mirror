From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH 0/2] http: allow multi-pass authentication
Date: Tue, 1 Dec 2009 12:28:26 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>, <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>, <1254510286-23155-1-git-send-email-nmiell@gmail.com>, <25718488.post@talk.nabble.com>
 <20091127234110.7b7e9993.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>,
	gsky51@gmail.com, Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 11:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPyz-0007Qn-QL
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 11:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZLAK3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 05:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbZLAK3F
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 05:29:05 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:51731 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbZLAK3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 05:29:01 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B03EE3D008CAA68; Tue, 1 Dec 2009 12:29:02 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20091127234110.7b7e9993.rctay89@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134194>

On Fri, 27 Nov 2009, Tay Ray Chuan wrote:

> This patch series applies on top of master. It enables fetching and
> pushing over http with the most suitable authentication scheme chosen
> by curl when the http.authAny or GIT_HTTP_AUTH_ANY is set.

I also tested this, and things generally seem to work fine.

Thanks to the "maintain curl sessions" patch, only the first request needs 
to be redone after getting the 401 error containing the authentication 
challenge, the later ones work fine on the first try. However, 
theoretically, I guess we can't be certain that the curl session really is 
initialized for the later requests (we could be given a new fresh curl 
session for some reason), or the first request could perhaps be a large, 
(currently) non-rewindable POST.


Avoiding redoing large POST requests is generally accomplished by adding a 
Expect: 100-continue header, and then waiting for a reply (either 100 
continue or 401 unauthorized) to that header before actually sending the 
POST body data. If the server doesn't support the Expect header (e.g. 
Lighttpd doesn't support it), the client starts sending the POST body 
after a timeout (1 second in libcurl).

(As a side note, chunked POST requests without a content-length header 
isn't supported by lighttpd at all at the moment, neither in the stable 
1.4 version nor in the new upcoming 1.5 branch.)


Normally, libcurl should add the Expect: 100-continue header 
automatically, but for some reason 
(http://article.gmane.org/gmane.comp.web.curl.library/25992) it doesn't, 
so that's probably why we're manually adding that header in 
remote-curl.c:371 at the moment. libcurl doesn't detect this at the moment 
(http://article.gmane.org/gmane.comp.web.curl.library/25991) so it won't 
wait for the 100 continue response before starting to send the body data. 

So, with a server supporting Expect, the 401 error response may come after 
sending a few KB of POST data (corresponding to the roundtrip delay for 
the server to respond to the header) - if the server doesn't support 
Expect at all, the whole request will be sent and may need to be rewound.

To clarify - this only happens if the curl authentication isn't 
initialized yet, for the first request of every curl session. The 
"maintain curl sessions" patch makes sure this isn't needed in the normal 
case.

I've experimented with two solutions to this, which add partial and full 
rewind solutions to the chunked POST requests - I'll send them as 
follow-ups to this mail.

// Martin
