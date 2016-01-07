From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Thu, 7 Jan 2016 07:46:08 -0500
Message-ID: <20160107124608.GB14421@sigill.intra.peff.net>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <cover.1452085713.git.johannes.schindelin@gmx.de>
 <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 13:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH9xI-0001M0-02
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 13:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcAGMqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 07:46:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:49874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752331AbcAGMqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 07:46:11 -0500
Received: (qmail 3417 invoked by uid 102); 7 Jan 2016 12:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 07:46:10 -0500
Received: (qmail 3745 invoked by uid 107); 7 Jan 2016 12:46:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 07:46:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jan 2016 07:46:08 -0500
Content-Disposition: inline
In-Reply-To: <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283479>

On Wed, Jan 06, 2016 at 02:09:49PM +0100, Johannes Schindelin wrote:

> In shared repositories, we have to be careful when writing files whose
> permissions do not allow users other than the owner to write them.
> 
> In particular, we force the marks file of fast-export and the FETCH_HEAD
> when fetching to be rewritten from scratch.
> 
> This commit does not touch the following users of fopen() that want to
> write files:

The patch looks good, and thanks for cataloguing the other cases.

> - git am, when splitting mails (git-am correctly cleans up its directory
>   after finishing, so there is no need to share those files between users)
> 
> - git apply, when writing rejected hunks
> 
> - git fsck, when writing lost&found blobs

For these latter two, I had to ask myself "why not?". You gave such nice
reasons for the other items in the list, I wondered what your reasoning
was here. In the second case, for example, I think it would prevent a
second shared user from running `git fsck --lost-found`, because we are
likely to find the same "old" dangling objects and fail to write them.

I also wondered why we do not do the usual write-to-temp and rename in
some of these cases, but that is not really relevant to your patch.

-Peff
