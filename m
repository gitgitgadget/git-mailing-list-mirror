From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] decorate: allow storing values instead of pointers
Date: Mon, 11 Jul 2011 17:20:32 -0400
Message-ID: <20110711212032.GB30155@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161649.GA10418@sigill.intra.peff.net>
 <7vr55wd1hw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:20:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNuC-0003pV-I8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab1GKVUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:20:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41626
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab1GKVUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:20:34 -0400
Received: (qmail 5372 invoked by uid 107); 11 Jul 2011 21:20:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 17:20:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 17:20:32 -0400
Content-Disposition: inline
In-Reply-To: <7vr55wd1hw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176897>

On Mon, Jul 11, 2011 at 12:06:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  static void grow_decoration(struct decoration *n)
> >  {
> > -	int i;
> > -	int old_size = n->size;
> > -	struct object_decoration *old_hash = n->hash;
> > +	unsigned char *old_hash = n->hash;
> > +	unsigned char *old_end = n->end;
> > +	unsigned char *p;
> >  
> > -	n->size = (old_size + 1000) * 3 / 2;
> > -	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
> > +	n->stride = sizeof(struct object_decoration) + WIDTH(n);
> 
> This value should not change once it is initialized, or all h*ll breaks
> loose while accessing the old-hash, right?  Just wondering if it makes the
> intention clearer if the function had something like this in it:
> 
> 	if (!old_size) {
> 		/* initial */
>                 n->stride = ...
> 	} else {
> 		/* rehash to grow */
> 	}

Yes, things will break horribly if you ever change the width. I wonder
if we can get some language support with:

  struct decoration {
     ...
     const int width;
     ...
  };

which would require that calling code set the width during
initialization. Doing anything else is more or less insane, although it
does make trouble for the object-cache code, which uses a run-time
function to initialize itself.  But as it's somewhat tightly coupled
with decorations and knows what it's doing, I would not be opposed to
casting away the constness in that one spot with a comment as a
workaround.

> I am mostly worried about both width and stride being assignable
> fields. An alternative may be to expose
> 
> 	int decoration_stride(struct decoration *n)
>         {
>         	return sizeof(struct object_decoration) + WIDTH(n);
> 	}
> 
> to the outside callers and drop "stride" field.

Yeah, I considered that (the "end" field is calculable, too). I just
didn't want the overhead of:

  for (p = d->hash; p < decoration_end(d); p += decoration_stride(d))
     ...

But I suppose we can inline both of those and let the optimizer deal
with hoisting the actual calculations them out of the loop. Or maybe I'm
just being stupid and optimizing too early. Speed is definitely one of
my criteria for this series, though.

-Peff
