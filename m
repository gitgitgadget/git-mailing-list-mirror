From: Jeff King <peff@peff.net>
Subject: Re: git add --patch bug with split+edit?
Date: Fri, 16 Jan 2009 21:33:46 -0500
Message-ID: <20090117023346.GA15817@coredump.intra.peff.net>
References: <833afihfvc.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jan 17 03:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO120-0002ct-5J
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 03:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938184AbZAQCdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761509AbZAQCdu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:33:50 -0500
Received: from peff.net ([208.65.91.99]:35942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938012AbZAQCdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:33:49 -0500
Received: (qmail 23650 invoked by uid 107); 17 Jan 2009 02:33:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 16 Jan 2009 21:33:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2009 21:33:46 -0500
Content-Disposition: inline
In-Reply-To: <833afihfvc.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106009>

On Sat, Jan 17, 2009 at 03:37:43AM +0200, Hannu Koivisto wrote:

> echo "sur\nbaz\nbaz\njee\njee" > baz
> git add --patch
> 
> Now say 's RET y RET e RET' and remove the second "+jee" line using
> your editor.  The output for me looks like this:
> [...]
> error: patch failed: baz:1
> error: baz: patch does not apply
> Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]?

Actually, you do not even need to change the patch at all for this to
fail. The hunk that you edit looks like this:

@@ -1,2 +2,4 @@
 baz
 baz
+jee
+jee

which doesn't make sense. I think the hunk header should actually be:

  @@ -1,2 +1,4 @@

But I don't think that is the problem, since git-apply should be
recounting the hunk information (and in a simple test, it doesn't fix
it).

Hm. OK, I see. The "does this diff apply" check feeds _both_ parts of
the split patch to git-apply. But of course the second part will never
correctly apply, because its context overlaps with the first part, but
doesn't take it into account.

Doing the check with _just_ the edited patch would work. But that
doesn't take into account that your edited patch will potentially fail
to apply in the long run, depending on whether or not you accept the
other half of the split patch. And we can't know that yet, because the
user may not have told us (they could have skipped the first half, and
then come back to it later after the edit step).

So in general, I think splitting and editing the same hunk is inherently
dangerous and is going to lead to these sorts of problems. And because
editing provides a superset of the functionality, I think you should
just edit and either allow the first part of the hunk to be applied or
not depending on your preference.

But maybe there is some better way of resolving the conflict. I don't
see one, but I'm tired and didn't think too hard on it. :)

-Peff
