From: Jeff King <peff@peff.net>
Subject: Re: Index Fileformat: stat(2) info necessary? What for?
Date: Mon, 26 Aug 2013 18:17:18 -0400
Message-ID: <20130826221718.GA12384@sigill.intra.peff.net>
References: <CAB46HOmMtgD+CtWUS3CQhr+ux1a3JP=hF2Cerd2nmDWzX5pxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Bernoth <erik.bernoth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 00:17:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE56E-00070u-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 00:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3HZWRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 18:17:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:40501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3HZWRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 18:17:22 -0400
Received: (qmail 3007 invoked by uid 102); 26 Aug 2013 22:17:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 17:17:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 18:17:18 -0400
Content-Disposition: inline
In-Reply-To: <CAB46HOmMtgD+CtWUS3CQhr+ux1a3JP=hF2Cerd2nmDWzX5pxcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233037>

On Mon, Aug 26, 2013 at 02:34:18PM +0200, Erik Bernoth wrote:

> Now there's a lot of information (all the stat(2) stuff) that gets
> stored about the staged files, which I never needed for file-IO in
> Python or Java. In my eyes if a person would be cloning my git
> repository he wouldn't need it as well, because the new inode on his
> system will probably be different from mine and applying the access
> rights onto the cloning user id and group id would also make sense,
> because that user introduced that file to that system.

Git does not look at the index at all when cloning; only the actual
objects. So that stat information is not copied (the information in the
clone's index comes from the checkout procedure on the receiving side).

> Thus I am now missing concrete experience in when this stat(2)
> information comes in handy or if it would be completely okay in a
> python-git implementation to just store the info shown with `git
> ls-files -s` to a file, maybe zlib.compressed like a git object. Of
> course I would then lose the compatibility with git repositories,
> which is a shame even if it would make sense. What is your opinion?

The stat information is there for performance. Think about how you would
implement "git diff" between the working tree and the index (or a tree).

Naively, you would have to open each file and either compare it byte for
byte to what is committed, or hash it and compare the hash to what is
committed. We have to open the files anyway to show a real patch, of
course, but most files haven't been modified, and we would like to avoid
opening them at all.

By keeping the stat information, we can check that the version in the
index is at some sha1 X, and then check that the stat information
matches what is on the disk, and know that what is on disk also has sha1
X. That makes comparing to the index or a tree very cheap; we only call
lstat() once per file, rather than opening and hashing all of the bytes.

-Peff
