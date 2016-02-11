From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] drop "struct name_path" and path_name()
Date: Thu, 11 Feb 2016 17:23:15 -0500
Message-ID: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:23:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzdy-0003TL-5r
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbcBKWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:23:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:40749 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbcBKWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:23:17 -0500
Received: (qmail 24403 invoked by uid 102); 11 Feb 2016 22:23:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:23:17 -0500
Received: (qmail 11689 invoked by uid 107); 11 Feb 2016 22:23:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:23:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:23:15 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286008>

The graph traversal code in list-objects.c uses "struct name_path" to
build a linked list of path components, which it then feeds to the
callbacks. This is meant to be efficient, because we keep pointers into
the actual tree data for each name. However, there are two things that
work against this:

  1. In some cases, we keep in parallel a strbuf with the running
     pathname, so that we can feed it to tree_entry_interesting().

  2. The ultimate fate of this linked list is often to get concatenated
     into a single buffer anyway, via path_name().

So it's really not buying us much efficiency over just using
strbuf_addstr() and strbuf_setlen() in the first place. And it's extra
code that is slightly tricky to get right, especially with respect to
size_t and integer overflow (compare path_name() and
show_object_with_path() before and after).

This series drops the whole thing in favor of using a strbuf. Because I
wanted to make sure we weren't regressing performance, I measured two
cases before and after (and of course verified that they produce
identical output):

  1. "git rev-list --objects --all", which prints the name of each tree
     and blob we find directly from the linked list (without ever
     constructing the whole string), and does not use
     tree_entry_interesting (and so does not otherwise need to keep the
     running strbuf). So we'd see any negative effects of the strategy
     here.

  2. "git prune --dry-run", which walks the complete graph but does
     not do anything useful with the pathnames. So it would not
     otherwise need to assemble or look at the path components at all.

Both of them showed no measurable difference in their best-of-five times
when run on git.git. I didn't measure peak memory usage. For the reasons
explained in patch 3, it will actually be slightly _better_ for a normal
repo like git.git. But you could construct a pathological case where it
is worse (e.g., if you had a tree with a 500MB path-name, the old code
would need 500MB to run rev-list, and the new code will need 2*500MB
during the callback). I think the cleanup is worth it.

  [1/5]: http-push: stop using name_path
  [2/5]: show_object_with_name: simplify by using path_name()
  [3/5]: list-objects: convert name_path to a strbuf
  [4/5]: list-objects: drop name_path entirely
  [5/5]: list-objects: pass full pathname to callbacks

-Peff
