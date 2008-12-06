From: Jeff King <peff@peff.net>
Subject: Re: why not preserve file permissions?
Date: Fri, 5 Dec 2008 20:29:14 -0500
Message-ID: <20081206012913.GA2910@coredump.intra.peff.net>
References: <87tz9igzbr.fsf@jidanni.org> <7vljuuxn66.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 02:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8m09-00008T-2h
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYLFB3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYLFB3Q
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:29:16 -0500
Received: from peff.net ([208.65.91.99]:2646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbYLFB3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:29:16 -0500
Received: (qmail 2816 invoked by uid 111); 6 Dec 2008 01:29:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 05 Dec 2008 20:29:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2008 20:29:14 -0500
Content-Disposition: inline
In-Reply-To: <7vljuuxn66.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102430>

On Fri, Dec 05, 2008 at 02:38:41PM -0800, Junio C Hamano wrote:

> Actually in a very early days, git used to record the full (mode & 0777)
> for blobs.
> 
> Once people started using git, everybody realized that it had a very
> unpleasant side effect that the resulting tree depended on user's umasks,

Note, of course that "everybody" in your sentence is "everybody who was
using git as a source control mechanism." I think as git has grown,
people have wanted to use it to version other things, such as dot files
in their home directory or the contents of /etc, two situations where
file metadata might be of as much interest as the file content.

And I don't see a real problem in a config switch or two to handle a
vastly different workflow like that, if it can be done with minimal
intrusion. For example, now we throw away most of the mode bits; it
would probably only be a few lines of code difference to keep those mode
bits, people who turned on that config option would presumably know what
they are doing, and performance for the usual workflow would be
unaffected.

_But_ I think people who ask for just permission bits aren't really
thinking things through. Those bits are only one part of the metadata.
There's file owner and group. There are timestamps. There are
non-regular files with their own associated metadata (like major/minor
device numbers). There are extended attributes, which covers things like
ACLs (and I don't even know if there's a standard representation that
can cover the ACLs for all platforms we support).

And those things _aren't_ as easy as flipping a config switch. They mean
changes to the fundamental data structures of git, and all of the pain
that entails: a lot of code, interoperability annoyances, and probably
performance impacts for unrelated workflows.

So I am sympathetic to somebody who, after thinking it through, has a
use case that just requires tracking permissions bits and wants a config
option for git to do that. But the commonly given examples seem much
better served by a _full_ metadata solution that lives on top of git,
like metastore. I haven't seen a compelling argument for just handling
permission bits.

-Peff
