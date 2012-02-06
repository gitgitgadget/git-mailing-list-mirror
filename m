From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Mon, 6 Feb 2012 02:04:24 -0500
Message-ID: <20120206070424.GC9931@sigill.intra.peff.net>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <20120206000420.GC28735@sigill.intra.peff.net>
 <20120206063213.GC10489@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 08:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuIco-0004cZ-UR
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab2BFHE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 02:04:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58614
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2BFHE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 02:04:26 -0500
Received: (qmail 24377 invoked by uid 107); 6 Feb 2012 07:11:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 02:11:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 02:04:24 -0500
Content-Disposition: inline
In-Reply-To: <20120206063213.GC10489@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190033>

On Sun, Feb 05, 2012 at 10:32:13PM -0800, Tom Grennan wrote:

> >> +--points-at <object>::
> >> +	Only list annotated or signed tags of the given object.
> >> +
> >
> >It is unclear to me from this documentation if we will only peel a
> >single level, or if we will peel indefinitely. E.g., what will this
> >show:
> >
> >  $ git tag one v1.0
> >  $ git tag two one
> >  $ git tag --points-at=v1.0
> >
> >It will clearly show "one", but will it also show "two" (from reading
> >the code, I think the answer is "no")? If not, should it?
> 
> Actually, neither one nor two would be listed as these are lightweight
> tags.  In the modified example,
> 
>   $ git tag -a -m One one v1.0
>   $ git tag -a -m Two two one
>   $ git tag --points-at v1.0
>   one
>   $ git tag --points-at one
>   two

Hmm. Yeah, I see that now. And re-reading your description, I see that
it is explicit only to read from tag objects. Somehow the name
"points-at" seems a bit misleading to me, then, as it implies being more
inclusive of all pointing, including lightweight tags.

I know that has nothing to do with your use-case though; I just wonder
if there could be a better name. I can't think of one, though, and I'm
not sure we will ever want a more inclusive --points-at, so maybe it is
not worth caring about.

> >Before your patch, a tag whose sha1 could not be read would get its name
> >printed, and then we would later return without printing anything more.
> >Now it won't get even the first bit printed.
> >
> >However, I'm not sure the old behavior wasn't buggy; it would print part
> >of the line, but never actually print the newline.
> 
> If you prefer, I can restore the old behavior just moving the
> condition/return back below the refname print; then add "buf" qualifier
> to the following fragment and at each intermediate free.

Thinking on it more, your behavior is at least as good as the old. And
it only comes up in a broken repo, anyway, so trying to come up with
some kind of useful outcome is pointless.

> >> +		if (filter->points_at) {
> >> +			unsigned char tagged_sha1[20];
> >> +			if (memcmp("object ", buf, 7) \
> >> +			    || buf[47] != '\n' \
> >> +			    || get_sha1_hex(buf + 7, tagged_sha1) \
> >> +			    || memcmp(filter->points_at, tagged_sha1, 20)) {
> >> +				free(buf);
> >> +				return 0;
> >> +			}
> >> +		}
> >
> >Hmm, I would have expected to use parse_tag_buffer instead of doing it
> >by hand. This is probably a tiny bit more efficient, but I wonder if the
> >code complexity is worth it.
> 
> I didn't see how to get the object sha out of parse_tag_buffer() to
> compare with "point_at". The inline conditions seem simple enough.

I think it would be:

  struct tag *t = lookup_tag(sha1);
  if (parse_tag_buffer(t, buf, size) < 0)
          return 0; /* error, possibly should die() */
  if (!hashcmp(filter->points_at, t->tagged.sha1))
          /* matches */

That might bear a little bit of explanation. Git keeps a struct in
memory for each object, each of which contains a "struct object" at the
beginning. By calling lookup_tag, we either find an existing reference
to the tag with this sha1, or create a new "struct tag". And then we
parse it using the data we've read, storing it in the "struct tag" (for
our use, or for later use). The "tagged" member points to the tagged
object. Which again is a struct object; it may or may not have been
read and parsed, but we definitely know its sha1.

If this seems a little cumbersome, it is because the usual usage is more
like:

  struct object *obj = parse_object(sha1);
  if (!obj)
          die("unable to read %s", sha1_to_hex(sha1));
  if (obj->type == OBJ_TAG) {
          struct tag *t = (struct tag *)obj;
          if (!hashcmp(filter->points_at, t->tagged.sha1))
                  /* matched */

And then you don't have to bother with calling read_sha1_file at all.

BTW, writing that helped me notice two bugs in your patch:

  1. You read up to 47 bytes into the buffer without ever checking
     whether size >= 47.

  2. You never check whether the object you read from read_sha1_file is
     actually a tag.

So your patch would read random heap memory on something like:

  blob=`echo foo | git hash-object --stdin -w`
  git tag foo $blob

-Peff
