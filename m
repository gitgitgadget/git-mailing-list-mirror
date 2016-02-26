From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: use argv_array for pack_objects
Date: Fri, 26 Feb 2016 05:59:26 -0500
Message-ID: <20160226105926.GB12472@sigill.intra.peff.net>
References: <1456402406-13617-1-git-send-email-michael@procter.org.uk>
 <CAPig+cRSKFsO+ygnQGxj+HjO+9Y_7YdubvqscNH7X1A6gM8OtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Procter <michael@procter.org.uk>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 11:59:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZG7a-0006fq-9j
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 11:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbcBZK7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 05:59:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:49979 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752005AbcBZK73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 05:59:29 -0500
Received: (qmail 4351 invoked by uid 102); 26 Feb 2016 10:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:59:29 -0500
Received: (qmail 2885 invoked by uid 107); 26 Feb 2016 10:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:59:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 05:59:26 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRSKFsO+ygnQGxj+HjO+9Y_7YdubvqscNH7X1A6gM8OtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287567>

On Thu, Feb 25, 2016 at 09:14:01PM -0500, Eric Sunshine wrote:

> On Thu, Feb 25, 2016 at 7:13 AM, Michael Procter <michael@procter.org.uk> wrote:
> > Use the argv_array in the child_process structure, to avoid having to
> > manually maintain an array size.
> >
> > Signed-off-by: Michael Procter <michael@procter.org.uk>
> > ---
> > diff --git a/upload-pack.c b/upload-pack.c
> > @@ -90,35 +90,32 @@ static void create_pack_file(void)
> >                 "corruption on the remote side.";
> >         int buffered = -1;
> >         ssize_t sz;
> > -       const char *argv[13];
> > -       int i, arg = 0;
> > +       int i;
> >         FILE *pipe_fd;
> >
> >         if (shallow_nr) {
> > -               argv[arg++] = "--shallow-file";
> > -               argv[arg++] = "";
> > +               argv_array_push(&pack_objects.args, "--shallow-file");
> > +               argv_array_push(&pack_objects.args, "");
> >         }
> 
> Not worth a re-roll, but:
> 
>     if (shallow_nr)
>         argv_array_pushv(..., "--shallow-file", "", NULL);
> 
> would have made it clearer that the two arguments are related (and
> allowed you to drop the braces).

This same pattern repeats in a few places, and I always want to say:

  argv_array_pushf(..., "--shallow-file=%s", file);

but the parsing side is lazy. It wouldn't be too hard to fix (and would
make the option nicer for users, too!), but perhaps it would be better
still to convert git.c to use the standard parse-options.

That is more work, though. Maybe it would be good for the
low-hanging-fruit list.

Other than that, Michael's patch looks fine to me (unsurprising, since I
already saw it off-list and offered my commentary :) ). I agree it's not
worth a re-roll for just this point.

-Peff
