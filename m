From: Jeff King <peff@peff.net>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Sun, 19 Oct 2008 09:00:50 -0400
Message-ID: <20081019130050.GA1822@coredump.intra.peff.net>
References: <1224095087.5366.19.camel@localhost> <20081016191751.GB14707@coredump.intra.peff.net> <1224187863.2796.15.camel@localhost> <20081016203916.GB9487@coredump.intra.peff.net> <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 07:20:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrXvB-0003Cm-V7
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 15:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYJSNAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYJSNAy
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 09:00:54 -0400
Received: from peff.net ([208.65.91.99]:3789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbYJSNAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 09:00:53 -0400
Received: (qmail 7438 invoked by uid 111); 19 Oct 2008 13:00:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 09:00:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 09:00:50 -0400
Content-Disposition: inline
In-Reply-To: <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98613>

On Fri, Oct 17, 2008 at 04:08:42PM -0700, Junio C Hamano wrote:

> I do not think that is a correct approach.
> 
> The offending callchain is:
> 
>   update_ref(..., "HEAD", REF_NODEREF, ...);
>   -> lock_any_ref_for_update("HEAD", ..., REF_NODEREF);
>    -> lock_ref_sha1_basic("HEAD", ..., REF_NODEREF, ...);
>       . calls resolve_ref() to read HEAD to arrive at
>         refs/heads/master
>       . however, it notices REF_NODEREF and adjusts the ref to be updated
>         back to "HEAD";
>     -> hold_lock_file_for_update(..., "HEAD", 1);
>      -> lock_file(..., "HEAD");
>         . resolves symlink "HEAD" to "refs/heads/master", and
>           locks it!  This creates "refs/heads/master.lock", that is
>           then renamed to "refs/heads/master" when unlocked.
> 
> In other words, the breakage is in lock_file() and not in resolve_ref().
> The latter gives the same output to the caller whether the HEAD is
> symbolic link or textual symref -- at least it should.

To be fair, my patch fixed the problem in lock_ref_sha1_basic, not
resolve_ref. It merely asked resolve_ref to annotate the resolution to
show whether a symlink was found, since it already had that information.

But if I am reading your patch right, you are actually enabling detached
HEAD in this instance, which is much better. Unfortunately, I had quite
a few conflicts in applying your patches on top of master (with or
without the patch from "checkout --track -b broken"), and when I thought
I had fixed up the result, the test actually still failed.

So I will take your word that it actually works, and that I screwed up
resolving the conflicts.

-Peff

PS If you are rebasing or resolving anyway, as I suspect you will have
to, there is a typo in the test: s/detch/detach/
