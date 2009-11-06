From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep
 for fixed-strings
Date: Fri, 6 Nov 2009 05:13:17 -0500
Message-ID: <20091106101316.GA22549@coredump.intra.peff.net>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091106084855.GA20964@coredump.intra.peff.net>
 <7vbpjg0y8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Collins <bricollins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 11:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Lpb-0007fg-2V
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 11:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZKFKNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 05:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZKFKNT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 05:13:19 -0500
Received: from peff.net ([208.65.91.99]:56853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbZKFKNT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 05:13:19 -0500
Received: (qmail 6193 invoked by uid 107); 6 Nov 2009 10:17:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Nov 2009 05:17:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Nov 2009 05:13:17 -0500
Content-Disposition: inline
In-Reply-To: <7vbpjg0y8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132296>

On Fri, Nov 06, 2009 at 02:00:11AM -0800, Junio C Hamano wrote:

> > I don't see a reason not to allow this combination if our grep
> > implementation supports it. My only reservation would be that we
> > sometimes call out to an external grep, and non-GNU grep might barf on
> > this. But I think that is OK, as the user should get a sane error from
> > the external grep.
> 
> I think that is OK but not for the reason you stated.  The user should
> never get such an error message.
> 
> The reason why I think this is OK is because the builder can choose to use
> NO_EXTERNAL_GREP if the external grep does not allow this combination.

Yes, I think that would be a sane thing to do (and I suspect anyone
using non-GNU grep is probably already doing it). But what I meant more
was that the _transition_ should be fine. If we start shipping with this
patch but people haven't updated their build configuration, it is not
going to break horribly; it should just produce an error, which is what
it is doing now.

>     # Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
>     # your external grep (e.g., if your system lacks grep, if its grep
>     # does not support necessary features, or spawning external process is
>     # slower than built-in grep git has).  To be usable, your grep must
>     # support -C<n> (show n lines of context), -e <pattern> (primarily
>     # used to quote a pattern that begins with a dash), and use of -F and
>     # -i at the same time.  Otherwise define this.
> 
> But I didn't try hard to find out what _else_ we are depending on.

It is not really _us_ depending on it. It is "things the user wants to
do that _we_ support, but that their grep might not." So I don't think
there is much point in enumerating features. If their system grep
doesn't handle options that they want to use, then it won't work for
them. If they don't use them, then they will be fine.

Though "-e" might be the exception, as I think we might use it
unconditionally. But something like "-F -i" really depends on whether
the user wants to use it.

So I am fine with the text above, but I wouldn't worry too hard about
trying to come up with an exhaustive feature list.

-Peff
