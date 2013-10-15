From: Jeff King <peff@peff.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Mon, 14 Oct 2013 20:19:26 -0400
Message-ID: <20131015001926.GC10415@sigill.intra.peff.net>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 02:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVsMJ-0003Tk-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab3JOATa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 20:19:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:49419 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757951Ab3JOAT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:19:28 -0400
Received: (qmail 26558 invoked by uid 102); 15 Oct 2013 00:19:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 19:19:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 20:19:26 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236157>

On Sat, Oct 12, 2013 at 10:42:17AM +0700, Nguyen Thai Ngoc Duy wrote:

> Just wondering if this has been considered and dropped before.
> Currently we use try_delta() for every object including trees. But
> trees are special. All tree entries must be unique and sorted. That
> helps simplify diff algorithm, as demonstrated by diff_tree() and
> pv4_encode_tree(). A quick and dirty test with test-delta shows that
> tree_diff only needs half the time of diff_delta(). As trees account
> for like half the objects in a repo, speeding up delta search might
> help performance, I think.

No, as far as I know, it is a novel idea. When we were discussing commit
caching a while back, Shawn suggested slicing trees on boundaries and
store delta instructions that were pure "change this entry", "add this
entry", and "delete this entry" chunks. The deltas might end up a little
bigger, but if the reader knew the writer had sliced in this way, it
could get a packv4-style cheap tree-diff, while remaining backwards
compatible with implementations that just blindly reassemble the buffer
from delta instructions.

I didn't get far enough to try it, but doing what you propose would be
the first step. Now that packv4 is more of a reality, it may not be
worth pursuing, though.

-Peff
