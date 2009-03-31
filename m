From: Jeff King <peff@peff.net>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 12:08:42 -0400
Message-ID: <20090331160842.GA9019@coredump.intra.peff.net>
References: <20090331112637.GA1910@coredump.intra.peff.net> <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LogXt-0002AM-1n
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760934AbZCaQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760739AbZCaQI4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:08:56 -0400
Received: from peff.net ([208.65.91.99]:39383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759775AbZCaQI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:08:56 -0400
Received: (qmail 11171 invoked by uid 107); 31 Mar 2009 16:09:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 12:09:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 12:08:42 -0400
Content-Disposition: inline
In-Reply-To: <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115274>

On Tue, Mar 31, 2009 at 08:55:00AM -0700, Junio C Hamano wrote:

> IIRC, DIR_HAS_BSD_GROUP_SEMANTICS means you do not have to ask explicitly
> with g+s to the filesystem to use the "subdirectory is owned by the same
> group as its parent" semantics.  On SysV you have to ask; on BSD you do
> not have to (and do not need FORCE_DIR_SET_GID).

OK, I see. Thanks for the explanation. So the test is wrong, since it
explicitly checks for g+s, and we only need it sometimes.

> That one was not about "you do not have to ask", but "you are not allowed
> to ask because the request will fail".  Perhaps between FBSD4 and FBSD6
> things changed, and you can now make g+s request (which I presume is still
> a no-op other than setting the bit on)?

Yes, you can ask just fine now:

  $ uname -sr
  FreeBSD 6.1-RELEASE-p17-jc1
  $ mkdir foo
  $ ls -ld foo
  drwxr-xr-x  2 peff  peff  512 Mar 31 09:04 foo/
  $ chmod g+s foo
  $ ls -ld foo
  drwxr-sr-x  2 peff  peff  512 Mar 31 09:04 foo/

But it isn't necessary.

> Ideally the test should be checking if the subdirectory is owned by the
> same group as the toplevel, but that is rather hard to correctly arrange,
> as it depends on the set of groups the user who runs the test belongs to,
> how the git work tree is set up (if it is owned by his primary group or a
> secondary), etc.

Shouldn't that just be:

  perl -e 'sub group { return (stat(shift))[5] }' \
       -e 'exit group($ARGV[0]) == group($ARGV[1]) ? 0 : 1' \
       a b

?

-Peff
