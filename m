From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] ensure index is set for all OBJ_COMMIT objects variable
Date: Fri, 11 Jul 2014 04:41:41 -0400
Message-ID: <20140711084141.GA5521@sigill.intra.peff.net>
References: <53BF28F4.8050704@ramsay1.demon.co.uk>
 <20140711003053.GB11360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WOt-00065v-FN
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaGKIlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:41:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59945 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752223AbaGKIln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:41:43 -0400
Received: (qmail 18110 invoked by uid 102); 11 Jul 2014 08:41:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 03:41:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 04:41:41 -0400
Content-Disposition: inline
In-Reply-To: <20140711003053.GB11360@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253255>

Here's a series to address the bug I mentioned earlier by catching the
conversion of OBJ_NONE to OBJ_COMMIT in a central location and setting
the index there.

I've included your patch 1/2 unchanged in the beginning, as I build on
top of it (and your patch 2/2 is no longer applicable).  The rest is
refactoring leading up to patch 6 to fix the bug. Patch 7 is a bonus
cleanup.

I'd hoped to cap off the series by converting the "type" field of
"struct commit" to a "const unsigned type : 3", which would avoid any
new callers being added that would touch it without going through the
proper procedure.  However, it's a bitfield, which makes it hard to cast
the constness away in the actual setter function. My best attempt was to
use a union with matching const and non-const members, but that would
mean changing all of the sites which read the field (and there are many)
to use "object->type.read".

There may be a clever solution hiding in a dark corner of C, but I
suspect we are entering a realm of portability problems with older
compilers (I even saw one compiler's documentation claim that "const"
was forbidden on bitfields, even though C99 has an example which does
it).

  [1/7]: alloc.c: remove the alloc_raw_commit_node() function
  [2/7]: move setting of object->type to alloc_* functions
  [3/7]: parse_object_buffer: do not set object type
  [4/7]: add object_as_type helper for casting objects
  [5/7]: alloc: factor out commit index
  [6/7]: object_as_type: set commit index
  [7/7]: diff-tree: avoid lookup_unknown_object

-Peff
