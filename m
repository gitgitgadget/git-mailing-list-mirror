From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:10:11 -0500
Message-ID: <20160220081010.GA16722@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112324.GF9319@sigill.intra.peff.net>
 <CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:10:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX2cP-0005N7-7V
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949917AbcBTIKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:10:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:45964 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1949419AbcBTIKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:10:14 -0500
Received: (qmail 9915 invoked by uid 102); 20 Feb 2016 08:10:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:10:14 -0500
Received: (qmail 4067 invoked by uid 107); 20 Feb 2016 08:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:10:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Feb 2016 03:10:11 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286767>

On Sat, Feb 20, 2016 at 03:07:00AM -0500, Eric Sunshine wrote:

> > diff --git a/line-log.c b/line-log.c
> > @@ -746,23 +747,16 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
> >         if (!rev->diffopt.detect_rename) {
> > -               int i, count = 0;
> > -               struct line_log_data *r = range;
> > -               const char **paths;
> > -               while (r) {
> > -                       count++;
> > -                       r = r->next;
> > -               }
> > -               paths = xmalloc((count+1)*sizeof(char *));
> > -               r = range;
> > -               for (i = 0; i < count; i++) {
> > -                       paths[i] = xstrdup(r->path);
> > -                       r = r->next;
> > -               }
> > -               paths[count] = NULL;
> > +               struct line_log_data *r;
> > +               struct argv_array paths = ARGV_ARRAY_INIT;
> > +
> > +               for (r = range; r; r = r->next)
> > +                       argv_array_push(&paths, r->path);
> >                 parse_pathspec(&rev->diffopt.pathspec, 0,
> > -                              PATHSPEC_PREFER_FULL, "", paths);
> > -               free(paths);
> > +                              PATHSPEC_PREFER_FULL, "", paths.argv);
> > +               /* argv strings are now owned by pathspec */
> > +               paths.argc = 0;
> > +               argv_array_clear(&paths);
> 
> This overly intimate knowledge of the internal implementation of
> argv_array_clear() is rather ugly.

Yep, I agree. Suggestions?

We can just leak the array of "char *". This function is called only
once per program invocation, and that's unlikely to change.

I guess we can make an argv_array_detach_strings() function. Or maybe
even just argv_array_detach() would be less gross, and then this
function could manually free the array but not the strings themselves.

-Peff
