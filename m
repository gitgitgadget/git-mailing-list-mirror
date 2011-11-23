From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix https interactive authentication problem
Date: Wed, 23 Nov 2011 17:51:21 -0500
Message-ID: <20111123225121.GA23357@sigill.intra.peff.net>
References: <F6A589D6B10801478E0DE246A9EF187C1BD5E8@MBX12.d.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Steinmann Ruedi <ruediste@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 23 23:51:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTLf7-00027R-C0
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 23:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab1KWWvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 17:51:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49479
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab1KWWvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 17:51:24 -0500
Received: (qmail 7186 invoked by uid 107); 23 Nov 2011 22:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 17:51:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 17:51:21 -0500
Content-Disposition: inline
In-Reply-To: <F6A589D6B10801478E0DE246A9EF187C1BD5E8@MBX12.d.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185883>

On Wed, Nov 23, 2011 at 07:58:02AM +0000, Steinmann  Ruedi wrote:

> Cloning a repository over https works fine when the username/password is
> given in the URL. But if it is queried interactively, an error occurs(see below).
> I found that the username/password is not set when a connection is reused.
> 
> With this patch, the username/password is set whenever a connection is reused.
> 
> Sample output showing the error:
> 
> git clone https://n.ethz.ch/student/...
> Cloning into ...
> Username:
> Password:
> error: Unable to get pack file https://n.ethz.ch/student/.../objects/pack/pack-1ced2ebff0c9fc1f07e0c7cc9dd3fc75f6ac6962.pack
> The requested URL returned error: 401
> ...
> error: Fetch failed.

Hmm. What version of git are you using?

We used to always set up the auth information in get_curl_handle, so all
handles had any auth information that we already got. But we removed
that recently in 986bbc0 (http: don't always prompt for password,
2011-11-04), which is in v1.7.8-rc1 and later.

I'm wondering if this was an unintended side effect of that patch.

Usually git will notice the 401 and retry with credentials (requesting
them from the user if necessary). That used to not work for all requests
but I fixed that in 8d677ed (http: retry authentication failures for all
http requests, 2011-07-18), which is also in v1.7.8-rc*.

However, it looks like the packfile-fetching code for dumb http does not
actually go through the usual http_request method, and does not
recognize the 401.

So if you are using v1.7.8-rc*, then I think that is the issue. And your
patch is just undoing what 8d677ed did. But the right fix is to refactor
the packfile-fetching function on top of the other http-fetching code,
so it can get the benefit of that logic.

If you are using an older version of git (pre-8d677ed), then one guess
about what is happening is a race condition with setting up multiple
curl handles:

  1. we get curl handle 1 from get_curl_handle, calling
     init_curl_http_auth. But we have no username in the url, so we
     assume no credentials are needed.

  2. we get curl handle 2 from get_curl_handle, as above.

  3. we make a request on handle one, get a 401, and ask for
     credentials.

  4. we make a request for a packfile on handle 2, but we never copied
     the auth from step (3) into the curl handle from step (2), and it
     fails.

(I haven't looked closely at our usage of curl_multi_*, so I am not 100%
sure that this can even happen. So consider it just a theory).

If this is the case, your fix works because it calls init_curl_http_auth
more often (i.e., before making any request, not just when we create the
handle). But that means it is also undoing what 8d677ed did; we will ask
the user for credentials before actually seeing a 401.

We could still fix this by teaching the packfile-fetching code to
respect 401s. However, it does incur an unnecessary round-trip (we
already know from the other request that credentials are required, but
we don't bother to use them).

So I think the logic you want instead is "if we already have
credentials, use them with this curl slot, but otherwise don't bother
the user". Which would mean splitting the prompting bit out of
init_curl_http_auth.

-Peff
