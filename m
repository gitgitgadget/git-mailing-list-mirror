From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over
 strbuf_split
Date: Wed, 17 Feb 2016 17:14:30 -0500
Message-ID: <20160217221430.GA24899@sigill.intra.peff.net>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
 <1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:14:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWAMn-0008CZ-NB
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965703AbcBQWOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:14:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:44441 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965535AbcBQWOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:14:33 -0500
Received: (qmail 13273 invoked by uid 102); 17 Feb 2016 22:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 17:14:32 -0500
Received: (qmail 12948 invoked by uid 107); 17 Feb 2016 22:14:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 17:14:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2016 17:14:30 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286559>

On Wed, Feb 17, 2016 at 05:11:50PM -0500, Eric Sunshine wrote:

> On Wed, Feb 17, 2016 at 1:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > From: Jeff King <peff@peff.net>
> >
> > We don't do any post-processing on the resulting strbufs, so it is
> > simpler to just use string_list_split, which takes care of removing
> > the delimiter for us.
> >
> > Written-by: Jeff King <peff@peff.net>
> 
> Perhaps Peff can give his sign-off...

Ah, right. I usually sign-off when sending to the list, so the version
he pulled from GitHub didn't have it.

Definitely:

  Signed-off-by: Jeff King <peff@peff.net>

And I don't think "Written-by" was doing much here, anyway; I am already
the author by the From header at the top. :)

-Peff

> 
> > Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> > ---
> >  ref-filter.c | 29 +++++++++++------------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index f097176..19367ce 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -886,41 +886,34 @@ static void populate_value(struct ref_array_item *ref)
> >                         continue;
> >                 } else if (match_atom_name(name, "align", &valp)) {
> >                         struct align *align = &v->u.align;
> > -                       struct strbuf **s, **to_free;
> > +                       struct string_list params = STRING_LIST_INIT_DUP;
> > +                       int i;
> >                         int width = -1;
> >
> >                         if (!valp)
> >                                 die(_("expected format: %%(align:<width>,<position>)"));
> >
> > -                       /*
> > -                        * TODO: Implement a function similar to strbuf_split_str()
> > -                        * which would omit the separator from the end of each value.
> > -                        */
> > -                       s = to_free = strbuf_split_str(valp, ',', 0);
> > -
> >                         align->position = ALIGN_LEFT;
> >
> > -                       while (*s) {
> > -                               /*  Strip trailing comma */
> > -                               if (s[1])
> > -                                       strbuf_setlen(s[0], s[0]->len - 1);
> > -                               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
> > +                       string_list_split(&params, valp, ',', -1);
> > +                       for (i = 0; i < params.nr; i++) {
> > +                               const char *s = params.items[i].string;
> > +                               if (!strtoul_ui(s, 10, (unsigned int *)&width))
> >                                         ;
> > -                               else if (!strcmp(s[0]->buf, "left"))
> > +                               else if (!strcmp(s, "left"))
> >                                         align->position = ALIGN_LEFT;
> > -                               else if (!strcmp(s[0]->buf, "right"))
> > +                               else if (!strcmp(s, "right"))
> >                                         align->position = ALIGN_RIGHT;
> > -                               else if (!strcmp(s[0]->buf, "middle"))
> > +                               else if (!strcmp(s, "middle"))
> >                                         align->position = ALIGN_MIDDLE;
> >                                 else
> > -                                       die(_("improper format entered align:%s"), s[0]->buf);
> > -                               s++;
> > +                                       die(_("improper format entered align:%s"), s);
> >                         }
> >
> >                         if (width < 0)
> >                                 die(_("positive width expected with the %%(align) atom"));
> >                         align->width = width;
> > -                       strbuf_list_free(to_free);
> > +                       string_list_clear(&params, 0);
> >                         v->handler = align_atom_handler;
> >                         continue;
> >                 } else if (!strcmp(name, "end")) {
> > --
> > 2.7.1
