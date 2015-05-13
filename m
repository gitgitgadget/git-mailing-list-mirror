From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] asciidoc fixups
Date: Wed, 13 May 2015 00:56:51 -0400
Message-ID: <20150513045650.GA6070@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:57:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOjA-00072D-PT
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbEME4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:56:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:57589 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750958AbbEME4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:56:53 -0400
Received: (qmail 1715 invoked by uid 102); 13 May 2015 04:56:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:56:53 -0500
Received: (qmail 6859 invoked by uid 107); 13 May 2015 04:56:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:56:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:56:51 -0400
Content-Disposition: inline
In-Reply-To: <20150513021556.GA4160@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268926>

On Tue, May 12, 2015 at 10:15:56PM -0400, Jeff King wrote:

> You can build with asciidoctor on the command-line. I don't know if it
> would be feasible to diff the asciidoc and asciidoctor output to look
> for gratuitous differences (or if the output is so different due to
> trivial stuff that the diff is unreadable).

So...it kind of works. I had to do unspeakable things with sed, and even
then ended up with an 18,000-line "--color-words" diff.

Below are some fixes. The early ones are actual bugs in our sources. The
latter ones are changes we could do to make asciidoctor happier. Each
patch is independent, so we can take or leave whatever we want.

After this series, the remaining problems are:

  - asciidoctor does not render {litdd}, which is our invention; locally
    this may be because I did not have the right incantation, but it is
    also broken on git-scm.com. I think the right fix is to define that
    attribute for the site renderer (so not a bug in our sources, and
    not an asciidoctor bug)

  - in the '[verse]' section of the SYNOPSIS of each man page, AsciiDoc
    renders 'git add' in the usual way (with emphasis). Whereas
    AsciiDoctor renders it normally, with the literal quotes included.

    In the same [verse] section, AsciiDoctor does not convert literal
    "..." into a fancy ellipsis. So perhaps it treats [verse] as a
    section in which markup is not expanded? This may be related to the
    [verseblock] stuff we have in our config file.

  - We use "{attr? foo}" to display "foo" only when "attr" is set.
    AsciiDoctor does not seem to understand this and renders the whole
    string.

  - Lots of places where we backslash-escape some syntax for AsciiDoc
    ends up rendered by AsciiDoctor with the backslashes included. In
    some cases the quoting is unnecessary and we can drop it (see
    patches 6 and 7 below). But in others it really is necessary, and
    AsciiDoc generates bad output without the backslashes. The major
    ones are "--" surrounded by spaces (which becomes an emdash), and
    things like @\{HEAD}, which needs quoted to tell AsciiDoc that HEAD
    isn't an attribute.

    I'm not sure of the solution (is AsciiDoctor just broken, or
    is there some other syntax we could use that would work in both
    places, or what?).

Here are the patches. They do not include the code-fence fixes from
Jean-Noel and myself that were already posted, but could easily go on
top.

  [1/8]: doc: fix misrendering due to `single quote'
  [2/8]: doc: fix unquoted use of "{type}"
  [3/8]: doc: fix hanging "+"-continuation
  [4/8]: doc: fix length of underlined section-title
  [5/8]: doc/add: reformat `--edit` option
  [6/8]: doc: convert \--option to --option
  [7/8]: doc: drop backslash quoting of some curly braces
  [8/8]: doc: put example URLs inside literal backticks

-Peff
