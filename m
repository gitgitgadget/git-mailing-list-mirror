From: Jeff King <peff@peff.net>
Subject: Re: Adding git hooks
Date: Sat, 26 Apr 2014 13:50:02 -0400
Message-ID: <20140426175002.GC21493@sigill.intra.peff.net>
References: <1398504843.79785833@f133.i.mail.ru>
 <7vy4yshul9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Suvorov Ivan <sv_91@inbox.ru>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:50:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6ju-0003gu-8w
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaDZRuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:50:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:39160 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751682AbaDZRuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:50:05 -0400
Received: (qmail 26569 invoked by uid 102); 26 Apr 2014 17:50:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Apr 2014 12:50:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 13:50:02 -0400
Content-Disposition: inline
In-Reply-To: <7vy4yshul9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247171>

On Sat, Apr 26, 2014 at 10:24:50AM -0700, Junio C Hamano wrote:

> Suvorov Ivan <sv_91@inbox.ru> writes:
> 
> > I want to extend the functionality of git due to the possibility of
> > separation of the user repository into 2 parts - one part will be
> > stored as usual, under version control git, and the second part will
> > be stored in another location such as an FTP-server.
> 
> Sounds like you are looking for git-annex, perhaps?

I agree that is the right approach, but git-annex and git-media work
_above_ the object layer, and taint the history by storing symlinks in
git instead of the real sha1s. I'd love to see a solution that does the
same thing, but lives at the pack/loose object layer. Basically:

  1. Teach sha1-file.c to look for missing objects by hitting an
     external script, like:

        git config odb.command "curl https://example.com/%s"

     and place them in an alternates-like separate object database.

  2. Teach the git protocol a new extension to say "don't bother sending
     blobs over size X". You'd have to coordinate that X with the source
     from your odb.command.

You'd probably want to wrap up the odb.command in a more fancy helper.
For example, for performance, we'd probably want to be able to query it
for "which objects do you have", as well as "fetch this object". And it
would be nice if it could auto-query the "X" for step 2, and manage
pruning local objects (e.g., when they become deep in history).

We'd probably also want to teach a few places in git to treat external
objects specially. For example, they should probably be auto-treated as
binary, so that a "log -p" does not try to fetch all of them. And
likewise, things like "log -S" should probably ignore them by default.

I have a messy sketch of step 1 that I did quite a while ago, but
haven't proceeded further on it.

-Peff
