From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Mon, 2 Feb 2009 07:41:40 -0500
Message-ID: <20090202124139.GA8325@sigio.peff.net>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu> <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de> <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu> <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de> <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoffrey Thomas <geofft@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 13:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTy8c-0000Zd-EL
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 13:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbZBBMl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 07:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZBBMl3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 07:41:29 -0500
Received: from peff.net ([208.65.91.99]:42316 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781AbZBBMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 07:41:28 -0500
Received: (qmail 8336 invoked by uid 1000); 2 Feb 2009 12:41:40 -0000
Content-Disposition: inline
In-Reply-To: <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108079>

On Sun, Feb 01, 2009 at 10:48:51PM -0800, Junio C Hamano wrote:

> > I do not know what encoding the author is at that point, but if you cannot 
> > be sure that it is UTF-8, using utf8_strwidth() is just as wrong as the 
> > current code, IMHO.
> 
> That is true, but then we are not losing anything.
> 
> This codepath is not about the payload (the contents of the files) but the
> author name part of the commit log message, and UTF-8 would probably be
> the only sensible encoding to standardize on.
> 
> If your project uses UTF-8 for everybody, great, we will align them better
> than we did before.  If not, sorry, you will get a different misaligned
> names.
> 
> That assumes utf8_width() does not barf when fed an invalid byte sequence,
> but I did not think it is that fragile (I didn't actually audit the
> codepath, though).

We should be able to know the encoding (we call reencode_commit_message,
but we don't bother to save the result). It should be trivial to do:

int strwidth(const char *s, const char *encoding)
{
  if (!strcmp(encoding, "utf-8"))
    return utf8_strwidth(s);
  /* ideally, else if (some_other_encoding_family) */
  else
    return strlen(s);
}

Then utf-8 is fixed, and other encodings keep identical behavior (and
don't even waste cycles on utf-8 decoding). And it should be obvious to
anyone who wants to add a width detector for their pet encoding where it
should go.

-Peff
