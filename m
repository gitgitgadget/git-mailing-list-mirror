From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 06:24:29 -0500
Message-ID: <20131122112429.GA16172@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
 <20131122095801.GB12042@sigill.intra.peff.net>
 <CAP8UFD1fMTrJGo9Z4+jdWqc-=UmPG1jQjwTij4962WDoh_a1DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 12:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjoqt-0007eF-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 12:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab3KVLYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 06:24:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:43722 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751956Ab3KVLYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 06:24:33 -0500
Received: (qmail 12092 invoked by uid 102); 22 Nov 2013 11:24:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 05:24:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 06:24:29 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD1fMTrJGo9Z4+jdWqc-=UmPG1jQjwTij4962WDoh_a1DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238179>

On Fri, Nov 22, 2013 at 12:04:01PM +0100, Christian Couder wrote:

> In "sha1_file.c", there is:
> 
> void *read_sha1_file_extended(const unsigned char *sha1,
>                               enum object_type *type,
>                               unsigned long *size,
>                               unsigned flag)
> {
>         void *data;
>         char *path;
>         const struct packed_git *p;
>         const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
>                 ? lookup_replace_object(sha1) : sha1;
> 
>         errno = 0;
>         data = read_object(repl, type, size);
> ...
> 
> And in cache.h, there is:
> 
> #define READ_SHA1_FILE_REPLACE 1
> static inline void *read_sha1_file(const unsigned char *sha1, enum
> object_type *type, unsigned long *size)
> {
>         return read_sha1_file_extended(sha1, type, size,
> READ_SHA1_FILE_REPLACE);
> }
> 
> So the READ_SHA1_FILE_REPLACE is a way to disable replacement at compile time.

Is it? I did not have the impression anyone would ever redefine
READ_SHA1_FILE_REPLACE at compile time, but that it was a flag that
individual callsites would pass to read_sha1_file_extended to tell them
whether they were interested in replacements. And the obvious reasons to
not be are:

  1. You are doing some operation which needs real objects, like fsck or
     generating a packfile.

  2. You have already resolved any replacements, and want to make sure
     you are getting the same object used elsewhere (e.g., because you
     already printed its size :) ).

The only site which calls read_sha1_file_extended directly and does not
pass the REPLACE flag is in streaming.c. And that looks to be a case of
(2), since we resolve the replacement at the start in open_istream().

I am kind of surprised we do not need to do so for (1) in places like
pack-objects.c. Most of that code does not use read_sha1_file,
preferring instead to find the individual pack entries (for reuse). But
there are some calls to read_sha1_file, and I wonder if there is a bug
lurking there.

-Peff
