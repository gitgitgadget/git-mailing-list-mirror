From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 8 Jun 2014 07:23:33 -0400
Message-ID: <20140608112333.GA9691@sigill.intra.peff.net>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
 <20140604194353.23903.89933.chriscool@tuxfamily.org>
 <xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
 <CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
 <CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 13:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtbCe-0006oo-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 13:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaFHLXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 07:23:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:39698 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753481AbaFHLXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 07:23:35 -0400
Received: (qmail 24410 invoked by uid 102); 8 Jun 2014 11:23:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Jun 2014 06:23:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2014 07:23:33 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251054>

On Sun, Jun 08, 2014 at 08:49:45AM +0200, Christian Couder wrote:

> On Fri, Jun 6, 2014 at 5:44 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> >         /* find existing parents */
> >         strbuf_addstr(&buf, commit->buffer);
> 
> Unfortunately, it looks like the above will not work if the commit->buffer
> contains an embedded NUL. I wonder if it is a real problem or not.

I ran into a similar problem recently[1] and have been pondering
solutions to know the size of commit->buffer. What I've been come up
with is:

  1. Look up the object size via sha1_object_info. Besides being
     inefficient (which probably does not matter for you here, but might
     for using commit->buffer in a traversal), it strikes me as
     inelegant; is it possible for commit->buffer to ever disagree in
     size with the results of sha1_object_info, and if so, what happens?

  2. Add an extra member "len" to "struct commit". This is simple, but
     bloats "struct commit", which may have a performance impact for
     things like rev-list, where the field will be unused.

  3. Store the length of objects as a size_t, exactly sizeof(size_t)
     bytes before the object buffer. Provide a macro:

       #define OBJECT_SIZE(buf) (((size_t *)(buf))[-1])

     to access it. Most callers can just use the buffer as-is, but
     anybody who calls free() would need to be adjusted to use a special
     "object_free".

  4. Keep a static commit_slab that points to the length for each parsed
     commit. We pay the same memory cost as (2), but as it's not part of
     the struct, the cache effects are minimized.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/250480
