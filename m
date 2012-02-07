From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 14:12:02 -0500
Message-ID: <20120207191202.GA496@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuqSZ-0000Ht-CG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab2BGTMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:12:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59367
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756413Ab2BGTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:12:05 -0500
Received: (qmail 10456 invoked by uid 107); 7 Feb 2012 19:19:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 14:19:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 14:12:02 -0500
Content-Disposition: inline
In-Reply-To: <20120207190228.GB6264@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190200>

On Tue, Feb 07, 2012 at 11:02:28AM -0800, Tom Grennan wrote:

> >Would using sha1_array save us from having to create our own data
> >structure? As a bonus, it can do O(lg n) lookups, though I seriously
> >doubt anyone will provide a large number of "--points-at".
> 
> Thanks, but I now realize that I also need to save the pointed at
> refname to detect lightweight tags that have matching sha's but
> different names.

I'm not sure I understand. Wouldn't you match lightweight tags by the
sha1 they point at? Something like:

  static int tag_points_at(struct sha1_array *sa,
                           const unsigned char *sha1)
  {
          struct object *obj;

          /* Lightweight tag of an interesting sha1? */
          if (sha1_array_lookup(sa, sha1) >= 0)
                  return 1;

          /* Otherwise, maybe a tag object pointing to an interesting sha1 */
          obj = parse_object(sha1);
          if (!obj)
                 return 0; /* or probably we should even just die() */
          if (obj->type != OBJ_TAG)
                 return 0;
          if (sha1_array_lookup(sa, ((struct tag *)obj)->tagged->sha1) < 0)
                 return 0;
          return 1;
 }

> >Also, should you check "unset"? When we have options that build a list,
> >usually doing "--no-foo" will clear the list. E.g., this:
> >
> >  git tag --points-at=foo --points-at=bar --no-points-at --points-at=baz
> >
> >should look only for "baz".
> 
> Ahh, so I just need to:
> 	if (unset) {
> 		if (*opt_value)
> 			free_points_at(*opt_value);
> 		*opt_value = NULL;
> 		return 0;
> 	}

Yes, exactly.

> >> +		{
> >> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
> >> +			"print only annotated|signed tags of the object",
> >> +			PARSE_OPT_LASTARG_DEFAULT,
> >> +			parse_opt_points_at, (intptr_t)NULL,
> >> +		},
> >
> >I think you can drop the LASTARG_DEFAULT here, as it is no longer
> >optional, no?
> 
> You mean flags = 0 instead of PARSE_OPT_LASTARG_DEFAULT, right?

Right. Though without flags, you can probably just use the OPT_CALLBACK
wrapper, like:

  OPT_CALLBACK(0, "points-at", &points_at, "object",
               "print only annotated|signed tags of the object",
               parse_opt_points_at)

Note that if you are going to handle lightweight tags, that description
should probably be updated.

-Peff
