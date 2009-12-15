From: Jeff King <peff@peff.net>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 12:03:21 -0500
Message-ID: <20091215170321.GB21322@coredump.intra.peff.net>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 18:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKaoA-00085k-D2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 18:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760632AbZLORD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 12:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760619AbZLORD2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 12:03:28 -0500
Received: from peff.net ([208.65.91.99]:35508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760617AbZLORD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 12:03:27 -0500
Received: (qmail 25983 invoked by uid 107); 15 Dec 2009 17:08:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 15 Dec 2009 12:08:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2009 12:03:21 -0500
Content-Disposition: inline
In-Reply-To: <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135290>

On Mon, Dec 14, 2009 at 03:31:38PM -0800, Junio C Hamano wrote:

> The change to do so looks like this; it has a few side effects:
> 
>  - If somebody else were relying on the fact that 'nkf -w' names the
>    entire command, it now will run 'nkf' command with '-w' as an argument,
>    and it will break such a set-up.  IOW, command that has an IFS white
>    space in its path will now need to be quoted from the shell.
> 
>    You can see the fallout from this in the damage made to t/ hierarchy in
>    the attached patch.
> 
>  - You can now use $HOME and other environment variables your shell
>    expands when defining your textconv command.
> 
> Overall I think it is a good direction to go, but we need to be careful
> about how we transition the existing repositories that use the old
> semantics.

I agree that this is a good change. My only reservation would be that
spawning a shell would be slightly slower (think "git log -p"). However:

  1. textconv is dog-slow already, as it has to dump each blob to a
     tempfile[1].

  2. There is an obvious optimization, which is that you can skip the
     shell if there are no metacharacters (in fact, we seem to be doing
     that already in launch_editor).

> We might need to introduce diff.*.xtextconv or something.

I am torn on this. I don't like introducing behavior changes that might
hurt people (and really, I think we are just talking about people with
textconv pointing to a program by its full path that has a space in it).
But I also hate carrying around baggage crap like xtextconv forever. It
makes git harder to explain why there are two variables that do almost
the same thing, and the one they want to use is probably the one with
the crappier, unlikely-to-be-guessed name.

So I am somewhat inclined to call it a bug fix, but I don't feel very
strongly.

-Peff

[1] The current textconv interface is really nice for things like just
using "antiword" out of the box. But I wrote a new interface which can
be much faster: it calls the textconv filter with the blob name, and
then the filter is responsible for using cat-file to get at the blob.
This means the filter can look at only part of a blob (e.g., if we are
interested in the metadata tags at the beginning of a large media file),
and it can cache answers as it sees fit, avoiding access to the blob
entirely.

I need to polish the code a bit and submit it. Obviously this is not
meant to replace the existing textconv, but rather to supplement it, for
when "fast and inconvenient" is better than "slow and simple". What is
the best way to configure this? I can imagine "diff.*.textconvType =
fast", or also "diff.*.fastTextconv".

-Peff
