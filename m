From: Jeff King <peff@peff.net>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 08:41:25 -0400
Message-ID: <20070624124125.GA18803@coredump.intra.peff.net>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com> <20070624065008.GA6979@efreet.light.src> <200706241314.46238.robin.rosenberg.lists@dewire.com> <7vzm2ptw04.fsf@assigned-by-dhcp.cox.net> <85myypef7p.fsf@lola.goethe.zz> <7vsl8htuin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 14:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2RPF-0005yA-SZ
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 14:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbXFXMl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754479AbXFXMl2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 08:41:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3801 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbXFXMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 08:41:28 -0400
Received: (qmail 6806 invoked from network); 24 Jun 2007 12:41:45 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 24 Jun 2007 12:41:45 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jun 2007 08:41:25 -0400
Content-Disposition: inline
In-Reply-To: <7vsl8htuin.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50797>

On Sun, Jun 24, 2007 at 05:19:12AM -0700, Junio C Hamano wrote:

> > ASCII-armoring of what amounts to binary files is the task of the mail
> > software.  Also working with encodings.  Escaping characters in the
> > diff headers but not in the file contents is not going to achieve
> > anything useful, anyway.
> 
> You misunderstood me.  The issue is not about transmitting
> without corruption.  Armoring would make it impossible to
> COMMENTING on the patch INLINE.
> 
> And that is where the pathname quoting git diff does originally
> comes from.

Then how about quoted-printable?

The point is that you're _already_ screwed by the fact that there can be
up to three different encodings in a patch (commit message, pathnames,
and file contents) but we only know one of them (the commit message).
With the other two, trying to convert encodings is pointless, since we
don't know the starting point. So we can either output them as-is as
binary, or use some sort of quoting mechanism.

The quoting that happens now is:
  - sometimes unnecessary, and hurts people who are _not_ sending the
    diff through the mail
  - not recognized by any widely-used un-quoter. I can't comment on your
    diff very well if it changes the file "\a/f\303\263\303\266", and
    there's no viewer that will let me read that in a sane way.
    I think David's point is that by doing the quoting at the MIME
    level (using 8bit, or 7bit with QP), the recipient's MUA can at
    least show the binary characters.  Sure, that will totally break if
    you are using a bad mismatch of encodings, but there's nothing we
    can do to fix that, not knowing what the encodings are. At least it
    _will_ work in the case that your encodings are the same.

The only argument I see _for_ the current quoting is for parsing by
non-mail programs (like patch or git-apply); in that case, it would seem
only necessary only to quote tab, newline, backslash, and double quote.
But at least those retain their human-readability.

-Peff
