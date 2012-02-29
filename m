From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] pickaxe: allow -i to search in patch
 case-insensitively
Date: Wed, 29 Feb 2012 04:18:55 -0500
Message-ID: <20120229091855.GE14181@sigill.intra.peff.net>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-3-git-send-email-gitster@pobox.com>
 <20120229083534.GC14181@sigill.intra.peff.net>
 <7vy5rmt3w8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:19:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fgi-0007XY-F4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411Ab2B2JTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:19:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32860
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391Ab2B2JS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 04:18:58 -0500
Received: (qmail 20793 invoked by uid 107); 29 Feb 2012 09:19:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 04:19:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 04:18:55 -0500
Content-Disposition: inline
In-Reply-To: <7vy5rmt3w8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191825>

On Wed, Feb 29, 2012 at 12:55:35AM -0800, Junio C Hamano wrote:

> > I can't imagine anybody would want to have different case-sensitivity
> > options for grepping the commit message versus pickaxe. But even if they
> > do, and we later add options to control them individually, we would
> > still want the short-and-sweet "-i" to cover the common case of setting
> > both. So I think the approach is good.
> 
> What you didn't read in the above is that the devilq around "-i" is not in
> the case insensitivity switch between log-part grep (--grep/--author) and
> patch part grep (-S/-G), but how it interacts with generating the patch
> part case insensitively (i.e. "log -p --ignore-case", which is also "-i").

Hmm. So there are actually three potential options to flip. However, I
think the reasoning above is still sound. We could later split
--regexp-ignore-case into two sub-options if we wanted (but like I said,
I doubt anybody will want that; I was more concerned with making sure
that if somebody _does_ want it, we have not painted ourselves into a
corner).

> You can see what I decided to do in an evil merge in 'pu'.
> 
> In short,
> 
>   * The short-and-sweet "-i" means both --regexp-ignore-case (grep) and
>     --ignore-case (diff); and
> 
>   * The long-hand can be used to ask for case
>     insensitive grep but case sensitive patch, or vice versa.

Yes, the evil merge looks sane, assuming both topics implement the
desired behavior.

I am a little dubious of the decision in jc/diff-ignore-case to have
"-i" imply "--ignore-case". For "git diff", it makes perfect sense. But
for "git log", it feels wrong. Ignoring case for the regexps is very
common, and ignoring case for the diffs is uncommon (it is, after all, a
feature we have gone many years without, and I don't remember anyone
bringing it up until recently).

As a user, I would be surprised that something common like "git log
--author=junio -i -p" would change diff generation between versions of
git.  It's probably not a huge regression, as patches which actually
look different with --ignore-case are relatively rare, so you are
unlikely to see any difference if you trigger it accidentally. But that
just argues to me that it is a feature that one would want to turn on
explicitly, anyway.

-Peff
