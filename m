From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] out-of-bounds access from corrupted .idx files
Date: Thu, 25 Feb 2016 09:20:05 -0500
Message-ID: <20160225142004.GA17678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacek Wielemborek <d33tah@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 15:20:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwm6-00020R-Au
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 15:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760705AbcBYOUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 09:20:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:49120 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760639AbcBYOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 09:20:08 -0500
Received: (qmail 6510 invoked by uid 102); 25 Feb 2016 14:20:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:20:07 -0500
Received: (qmail 21355 invoked by uid 107); 25 Feb 2016 14:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:20:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 09:20:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287390>

This series teaches Git to detect a few problems with corrupted .idx
files, and adds tests for some more cases.  There's conceptually some
overlap with t5300, but I don't think it was covering any of these cases
explicitly.

There are two real bugs that could cause segfaults or bus errors via
bogus reads (but never writes). On top of that, these are all problems
in .idx files, which are usually generated locally. So I don't think
there's anything particularly security interesting here. You'd need a
situation where you convince somebody to read your .idx files (so maybe
a multi-user server), and then I don't see how you'd turn it into remote
code execution.

I think with these patches, fuzzing .idx files should never result in
any memory problems (though of course git will die()).  Famous last
words, of course. I stopped short of poking at other file formats, which
might have similar issues. Obvious candidates are .bitmap files, and the
on-disk $GIT_DIR/index.

  [1/3]: t5313: test bounds-checks of corrupted/malicious pack/idx files
  [2/3]: nth_packed_object_offset: bounds-check extended offset
  [3/3]: use_pack: handle signed off_t overflow

-Peff
