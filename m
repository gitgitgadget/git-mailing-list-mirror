From: Jeff King <peff@peff.net>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and
 --relative[=<path>] option
Date: Thu, 8 Jul 2010 10:23:41 -0400
Message-ID: <20100708142341.GA9991@coredump.intra.peff.net>
References: <201007051015.26995.jnareb@gmail.com>
 <201007081300.18712.jnareb@gmail.com>
 <20100708114125.GA2427@sigill.intra.peff.net>
 <201007081419.42702.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWs11-0007cc-6A
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab0GHOXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 10:23:45 -0400
Received: from peff.net ([208.65.91.99]:34600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385Ab0GHOXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:23:44 -0400
Received: (qmail 4721 invoked by uid 107); 8 Jul 2010 14:24:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Jul 2010 10:24:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jul 2010 10:23:41 -0400
Content-Disposition: inline
In-Reply-To: <201007081419.42702.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150577>

On Thu, Jul 08, 2010 at 02:19:42PM +0200, Jakub Narebski wrote:

> Nevertheless for the patch output format both "git diff --relative=sub"
> and "git diff --relative=sub/" give the same output, without 'b//quux'.
> The same IMHO should be done for raw output format, so we don't have
> '/quux' but 'quux'.

Hmm. That is because the diff output properly eliminates the double "/".
But AFAICT, all of the following do what I would expect:

  git diff --relative=sub
  git diff --relative=sub/ ;# same as above
  git diff --relative=foo- ;# yields "a/10" for file "foo-10"

Doing

  git diff --relative=sub --stat

shows the same issue as your --raw version, as does --name-only. I think
the right solution is to clean up a leading "/" for those cases. That
leaves the possibility for non-directory prefixes, but should do what
the user wants in the directory case (since a leading "/" is
nonsensical).

Or was that what you had in mind the whole time? My impression was that
you wanted --relative=foo to always be equivalent to --relative=foo/.
The subtle difference is that I want the "/" removed only if it is the
next character (or another way of thinking about it is to append "/" to
the prefix only if it is an actual directory).

-Peff
