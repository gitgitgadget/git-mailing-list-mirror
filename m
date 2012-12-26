From: Jeff King <peff@peff.net>
Subject: Re: generating format-patch options from an e-mail
Date: Wed, 26 Dec 2012 16:57:12 -0500
Message-ID: <20121226215712.GA11491@sigill.intra.peff.net>
References: <20121226200623.GA29446@simaj.xs4all.nl>
 <7vbodgo8kv.fsf@alter.siamese.dyndns.org>
 <20121226210737.GB20704@xs4all.nl>
 <871B6C10EBEFE342A772D1159D1320853A00DD2E@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Wed Dec 26 22:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnyyk-0008BE-MI
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 22:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab2LZV5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 16:57:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36682 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab2LZV5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 16:57:15 -0500
Received: (qmail 6126 invoked by uid 107); 26 Dec 2012 21:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Dec 2012 16:58:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Dec 2012 16:57:12 -0500
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853A00DD2E@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212159>

On Wed, Dec 26, 2012 at 09:31:46PM +0000, Pyeron, Jason J CTR (US) wrote:

> > That would work for the message-ID, but not for the various To: and Cc:
> > addresses.
> > 
> > The hacky script that I sent afterwards produces a string with the
> 
> Nit, it does not make use of the reply-to header if present.

I do something very similar to Simon, except that rather than generating
a reply with my script, I generate the cover letter in my MUA, and then
use that response as a template. So the MUA does the heavy lifting,
understanding reply-to, culling my own address from cc, etc. The
format-patch replies then have the exact same to/cc headers as the
template, and use the template's message-id as the in-reply-to (for
proper threading).

My perl looks like this (feed the template via stdin):

  perl -ne '
    if (defined $opt && /^\s+(.*)/) {
      $val .= " $1";
      next;
    }
    if (defined $opt) {
      print "--$opt=", quotemeta($val), " ";
      $opt = $val = undef;
    }
    if (/^(cc|to):\s*(.*)/i) {
      $opt = lc($1);
      $val = $2;
    }
    elsif (/^message-id:\s*(.*)/i) {
      $opt = "in-reply-to";
      $val = $1;
    }
  '

That, of course, presupposes a cover letter. If I am sending a single
patch, then I just do "format-patch --stdout" right into my MUA's
editor), and let it handle the headers.

-Peff
