From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 6 Feb 2012 03:34:07 -0500
Message-ID: <20120206083407.GA9287@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuK1f-0008T7-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab2BFIeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:34:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58693
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab2BFIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:34:09 -0500
Received: (qmail 25338 invoked by uid 107); 6 Feb 2012 08:41:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:41:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:34:07 -0500
Content-Disposition: inline
In-Reply-To: <7vk4408ir6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190046>

On Mon, Feb 06, 2012 at 12:32:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The first case is an indication of a broken or corrupt repo,
> > and we should notify the user of the error.
> >
> > The second case is OK to silently ignore; however, the
> > existing code leaked the buffer returned by read_sha1_file.
> > ...  
> >  	buf = read_sha1_file(sha1, &type, &size);
> > -	if (!buf || !size)
> > +	if (!buf)
> > +		die_errno("unable to read object %s", sha1_to_hex(sha1));
> > +	if (!size) {
> > +		free(buf);
> >  		return;
> > +	}
> >  
> >  	/* skip header */
> >  	sp = strstr(buf, "\n\n");
> 
> Hmm, a pedant in me says a tag object cannot have zero length, so the
> second case is also an indication of a corrupt repository, unless the tag
> happens to be a lightweight one that refers directly to a blob object that
> is empty.

Yes. Or alternatively, it should just be caught in the strstr() case
below (which would silently ignore it).

> For that matter, shouldn't we make sure that the type is OBJ_TAG? It might
> make sense to allow OBJ_COMMIT (i.e. lightweight tag to a commit) as well,
> because the definition of "first N lines" is compatible between tag and
> commit for the purpose of the -n option.

Yup. See patch 3. :)

-Peff
