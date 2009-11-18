From: Jeff King <peff@peff.net>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 10:51:54 -0500
Message-ID: <20091118155154.GA15184@coredump.intra.peff.net>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Philip Hofstetter <phofstetter@sensational.ch>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAmpd-0004Fy-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbZKRPvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbZKRPvu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:51:50 -0500
Received: from peff.net ([208.65.91.99]:51243 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810AbZKRPvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 10:51:50 -0500
Received: (qmail 30701 invoked by uid 107); 18 Nov 2009 15:55:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 10:55:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 10:51:54 -0500
Content-Disposition: inline
In-Reply-To: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133187>

On Wed, Nov 18, 2009 at 03:20:48PM +0100, Philip Hofstetter wrote:

> Some investigating revealed an interesting quirk in git-mailinfo which
> seems to be a bit too eager to extract author information: Instead of
> just looking at the From:-Line in a mails header (git-rebase seems to
> use git-am which in turn uses git-mailinfo), it searches for "from:"
> *anywhere* in the mail and uses the last found information as the
> source for the author information.

It is not quite "anywhere"; extra headers are respected at the very top
of the message body. This is intentional, to allow one to indicate that
a patch you are sending was authored by somebody else.

So the problem is slightly less severe; the body of your commit message
has to _start_ with "From:". Still, it is awfully ugly to hit a parsing
ambiguity like this when you are trying to do something as simple as
rebase.

Some solutions I can think of are:

  1. Improve the header-finding heuristic to actually look for something
     more sane, like "From:.*<.*@.*>" (I don't recall off the top of my
     head which other headers we handle in this position. Probably
     Date, too).

  2. Give mailinfo a "--strict" mode to indicate that it is directly
     parsing the output of format-patch, and not some random email. Use
     --strict when invoking "git am" via "git rebase".

> While I know it's rude to have a line beginning with "from:" (and it's
> even ruder to have a line beginning with "from "), IMHO the header
> ends at the first blank line and I see no reason to extract author
> information past the header.

As I explained above, there is a reason, but I don't think it's rude to
have either of those lines. You were, after all, writing a commit
message, not an email (and even if you were, it is a failure of the
storage format if it can't represent your data correctly). So I think
git is to blame here.

-Peff
