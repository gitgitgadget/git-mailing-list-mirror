From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Sun, 24 Nov 2013 03:44:44 -0500
Message-ID: <20131124084444.GA23238@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <20131122020911.GA12042@sigill.intra.peff.net>
 <20131122172859.GA703@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 09:44:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkVJC-0000Vk-Ul
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 09:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab3KXIor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 03:44:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:44694 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756090Ab3KXIoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 03:44:46 -0500
Received: (qmail 24049 invoked by uid 102); 24 Nov 2013 08:44:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 02:44:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 03:44:44 -0500
Content-Disposition: inline
In-Reply-To: <20131122172859.GA703@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238252>

On Fri, Nov 22, 2013 at 01:28:59PM -0400, Joey Hess wrote:

> > Hrm. For --batch, I'd think we would open the whole object and notice
> > the corruption, even with the current code. But for --batch-check, we
> > use sha1_object_info, and for an "experimental" object, we do not need
> > to de-zlib the object at all.  So we end up reporting whatever crap we
> > decipher from the garbage bytes.  My patch would fix that, as we would
> > not incorrectly guess an object is experimental anymore.
> > 
> > If you have specific cases that trigger even after my patch, I'd be
> > interested to see them.
> 
> I was seeing it with --batch, not --batch-check. Probably only with the
> old experimental loose object format. In one case, --batch reported a
> size of 20k, and only output 1k of data. With the object file I sent
> earlier, --batch reports a huge size, and fails trying to allocate the
> memory for it before it can output anything.

Ah, yeah, that makes sense. We report the size via sha1_object_info,
whether we are going to output the object itself or not. So we might
report the bogus size, not noticing the corruption, and then hit an
error and bail when sending the object itself.

My patch makes that better in some cases, because we'll notice more
corruption when looking at the header of the object for
sha1_object_info. But fundamentally, we may still hit an error while
outputting the bytes. Reading the cat-file code, it looks like we should
always die if we hit an error, so at least a reader will get premature
EOF (and not the beginning of another object).

I can believe there is some specific corruption that yields a valid zlib
stream that is a different size than the object advertises. Since
v1.8.4, we double-check that the size we advertised matches what we are
about to write. But the streaming-blob code path does not include that
check, so it might still be affected. It would be pretty easy and cheap
to detect that case.

In any code path where we call parse_object, we double-check that the
result matches the sha1 we asked for. But low-level commands like
cat-file just call read_sha1_file directly, and do not have such a
check. We could add it, but I suspect the processing cost would be
noticeable.

> I also have seen at least once a corrupt pack file that caused git to try
> and allocate a absurd quantity of memory.

I'm not surprised by that. The packfiles contain size information
outside of the checksummed zlib data, and we pre-allocate the buffer
before reading the zlib data. We could try to detect it, but then we are
hard-coding the definition of "absurd". The current definition is "we
asked the OS for memory, and it did not give it to us". :)

-Peff
