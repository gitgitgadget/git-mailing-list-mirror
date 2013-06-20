From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] log: --author-date-order
Date: Thu, 20 Jun 2013 16:16:50 -0400
Message-ID: <20130620201650.GB31364@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-5-git-send-email-gitster@pobox.com>
 <20130610055014.GF3621@sigill.intra.peff.net>
 <7vobbel8ib.fsf@alter.siamese.dyndns.org>
 <20130610184918.GC2084@sigill.intra.peff.net>
 <7v61x8tw0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplHu-0000yU-H0
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118Ab3FTUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:16:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:59522 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161052Ab3FTUQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:16:53 -0400
Received: (qmail 6609 invoked by uid 102); 20 Jun 2013 20:17:53 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 15:17:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 16:16:50 -0400
Content-Disposition: inline
In-Reply-To: <7v61x8tw0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228530>

On Thu, Jun 20, 2013 at 12:36:21PM -0700, Junio C Hamano wrote:

> > I like the latter option. It takes a non-trivial amount of time to load
> > the commits from disk, and now we are potentially doing it 2 or 3 times
> > for a run (once to parse, once to get the author info for topo-sort, and
> > possibly later to show it if --pretty is given; though I did not check
> > and maybe we turn off save_commit_buffer with --pretty). It would be
> > nice to have an extended parse_object that handled that. I'm not sure of
> > the interface. Maybe variadic with pairs of type/slab, like:
> >
> >   parse_commit_extended(commit,
> >                         PARSE_COMMIT_AUTHORDATE, &authordate_slab,
> >                         PARSE_COMMIT_DONE);
> >
> > ?
> 
> What I had in mind actually was a custom slab tailored for each
> caller that is an array of struct.  If the caller is interested in
> authordate and authorname, instead of populating two separate
> authordate_slab and authorname_slab, the caller declares a
> 
> 	struct {
>         	unsigned long date;
>                 char name[FLEX_ARRAY];
> 	} author_info;
> 
> prepares author_info_slab, and use your commit_parser API to fill
> them.

Yes, I think it is nicer to stay in one slab if you have multiple
values, but it means more custom code for the caller. If the
commit_parser API is nice, it should not be that much code, though.

It does make it harder to support arbitrary combinations directly in
parse_commit. If a caller wants to also parse_commit and use the same
buffer to pick out its custom information, I think we'd need to do one
of:

  1. Give parse_commit a callback, so that the callback can pick out the
     data it wants while parse_commit has the commit buffer in memory.
     E.g.:

       void grab_author_info(const char *buf, unsigned long len, void *data)
       {
              struct author_info *ai = data;
              /* fill fields from buffer */
       }

       ...
       parse_commit_extra(commit, grab_author_info,
                          slab_at(&author_slab, commit));

  2. Teach parse_commit to operate not only on a raw commit object, but
     also on the commit_parser API. Like:

       struct commit_parser parser = {0};

       /* actually open the object and start our incremental parser */
       init_commit_parser(&parser, commit);

       /* fill in parents, date, etc, as parse_commit does now */
       parse_commit_from_parser(commit, &parser);

       /* fill in whatever extra data we are interested in */
       *slab_at(&slab, commit) = get_author_date(&parser);

       /* done, drop the buffer */
       close_commit_parser(&parser);

The latter would need to handle transferring ownership of the buffer to
"struct commit" from "struct commit_parser" when save_commit_buffer is
turned off.

I think we're a bit high-level now to be making such decisions, though,
as we do not even have such a commit_parser API.

-Peff
