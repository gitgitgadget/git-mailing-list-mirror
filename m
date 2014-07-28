From: Jeff King <peff@peff.net>
Subject: struct hashmap_entry packing
Date: Mon, 28 Jul 2014 13:17:44 -0400
Message-ID: <20140728171743.GA1927@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 19:17:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBoYe-0006fs-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 19:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbaG1RRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 13:17:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41827 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750949AbaG1RRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 13:17:49 -0400
Received: (qmail 20167 invoked by uid 102); 28 Jul 2014 17:17:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 12:17:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 13:17:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254327>

Hi Karsten,

The hashmap_entry documentation claims:

  `struct hashmap_entry`::

	An opaque structure representing an entry in the hash table,
	which must be used as first member of user data structures.
	Ideally it should be followed by an int-sized member to prevent
	unused memory on 64-bit systems due to alignment.

I'm not sure if the statement about alignment is true. If I have a
struct like:

    struct magic {
	    struct hashmap_entry map;
	    int x;
    };

the statement above implies that I should be able to fit this into only
16 bytes on an LP64 system. But I can't convince gcc to do it. And I
think that makes sense, if you consider code like:

   memset(&magic.map, 0, sizeof(struct hashmap_entry));

The sizeof() has to be the same regardless of whether the hashmap_entry
is standalone or in another struct, and therefore must be padded up to
16 bytes. If we stored "x" in that padding in the combined struct, it
would be overwritten by our memset.

Am I missing anything? If this is the case, we should probably drop that
bit from the documentation. It's possible that we could get around it by
embedding the hashmap_entry elements directly into the parent struct,
but we would be counting on a reader dereferencing it as a hashmap_entry
seeing the members at the exact same offset. I'd imagine that's one of
those things that holds most of the time, but is violating the standard.
It's probably not worth it to save a few bytes.

-Peff
