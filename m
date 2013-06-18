From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple
 times
Date: Tue, 18 Jun 2013 18:13:28 -0400
Message-ID: <20130618221327.GA14234@sigill.intra.peff.net>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
 <20130618051902.GA5916@sigill.intra.peff.net>
 <CA+sFfMdEvwzmnEBeO+_pwdmN3m5rkJvUCVFFJU8mtmyN+WxH6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, daniel@haxx.se
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 00:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up49h-00027t-K7
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 00:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785Ab3FRWNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 18:13:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:40986 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932479Ab3FRWNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 18:13:32 -0400
Received: (qmail 4435 invoked by uid 102); 18 Jun 2013 22:14:30 -0000
Received: from mobile-032-132-054-112.mycingular.net (HELO sigill.intra.peff.net) (32.132.54.112)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 17:14:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 18:13:28 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMdEvwzmnEBeO+_pwdmN3m5rkJvUCVFFJU8mtmyN+WxH6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228319>

On Tue, Jun 18, 2013 at 12:29:03PM -0700, Brandon Casey wrote:

> >   1. Older versions of curl (and I do not recall which version off-hand,
> >      but it is not important) stored just the pointer. Calling code was
> >      required to manage the string lifetime itself.
> 
> Daniel mentions that the change happened in libcurl 7.17.  RHEL 4.X
> (yes, ancient, dead, I realize) provides 7.12 and RHEL 5.X (yes,
> ancient, but still widely in use) provides 7.15.  Just pointing it
> out.

Yeah, I didn't mean to imply "we don't care about these versions", only
that our analysis is different between the two sets. We have #ifdefs for
curl going back to 7.7.4. That's probably excessive, but AFAIK, we would
still work with such old versions.

> > It could be a problem when we have multiple handles in play
> > simultaneously (we invalidate the pointer that another simultaneous
> > handle is using, but do not immediately reset its pointer).
> 
> Don't we have multiple handles in play at the same time?  What's going
> on in get_active_slot() when USE_CURL_MULTI is defined?  It appears to
> be maintaining a list of "slot" 's, each with its own curl handle
> initialized either by curl_easy_duphandle() or get_curl_handle().

Yes, we do; the dumb http walker will pipeline loose pack and object
requests (which makes a big difference when fetching small files). The
smart http code may use the curl-multi interface under the hood, but it
should only have a single handle, and the use of the multi interface is
just for sharing code with the dumb fetch.

> So, yeah, this is what I was referring to when I mentioned
> "potentially dangerous".  Since the current code does not change the
> size of the string, the pointer will never change, so we won't ever
> invalidate a pointer that another handle is using.

Agreed. I did not so much mean to dispute your "potentially dangerous"
claim as clarify exactly what the potential is. :)

> The other thing I thought was potentially dangerous, was just
> truncating the string.  Again, if there are multiple curl handles in
> use (which I thought was a possibility), then merely truncating the
> string that contains the username/password could potentially cause a
> problem for another handle that could be in the middle of
> authenticating using the string.  But, I don't know if there is any
> multi-processing happening within the curl library.

I don't think curl does any threading; when we are not inside
curl_*_perform, there is no curl code running at all (Daniel can correct
me if I'm wrong on that).

So I think from curl's perspective a truncation and exact rewrite is
atomic, and it sees only the final content.  I don't know what would
happen if you truncated and put in _different_ contents. For example, if
curl would have written out half of the username/password, blocked and
returned from curl_multi_perform, then you update the buffer, then it
resumes writing.

IOW, I believe the current code is safe (though in a very subtle way),
but if you were to allow password update, I'm not sure if it would be or
not (and if not, you would need a per-handle buffer to make it safe).

I'm fine with making the safety less subtle (e.g., your patch, with a
comment added).

> If we _don't_ ever use multiple curl handles, and/or if there is no
> threading going on in the background within libcurl, then I don't
> think there is really any danger in what the current code does.  It
> would just be an issue of needlessly rewriting the same string over
> and over again, which is probably not a big deal depending on how
> often that happens.

It should be once per http request. But copying a dozen bytes is
probably nothing compared to the actual request.
