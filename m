From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] log: --author-date-order
Date: Mon, 10 Jun 2013 14:49:18 -0400
Message-ID: <20130610184918.GC2084@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-5-git-send-email-gitster@pobox.com>
 <20130610055014.GF3621@sigill.intra.peff.net>
 <7vobbel8ib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um79j-0005wU-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab3FJStX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:49:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:47267 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab3FJStW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:49:22 -0400
Received: (qmail 25361 invoked by uid 102); 10 Jun 2013 18:50:13 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 13:50:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 14:49:18 -0400
Content-Disposition: inline
In-Reply-To: <7vobbel8ib.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227356>

On Mon, Jun 10, 2013 at 12:39:24AM -0700, Junio C Hamano wrote:

> > I'm not excited about introducing yet another place that parses commit
> > objects (mostly not for correctness, but because we have had
> > inconsistency in how malformed objects are treated). It is at least
> > using split_ident_line which covers the hard bits. I wonder how much
> > slower it would be to simply call format_commit_message to do the
> > parsing.
> 
> The thought certainly crossed my mind, not exactly in that form but
> more about splitting the machinery used in pretty.c into a more
> reusable form.
> 
> The result of my attempt however did not become all that reusable
> (admittedly I didn't spend too much brain cycles on it), so I punted
> ;-).

Yes, I feel like it has been tried before. The problem is that a clean
interface would let you get individual pieces of information with a
single call. But an efficient interface will utilize the same parsing
pass to get multiple items out, and stop parsing when we have gotten all
required items (but leave the parser in a consistent state so that we
can pick it up later).

The format_commit_one parser does that, but the "format_commit_context"
it holds is a bit bulky. I think it might be possible to pull out the
parsing bits into a separate struct, and you could call it something
like:

  struct commit_parser parser;
  unsigned long authordate;
  const char *authorname;
  int authorlen;

  commit_parser_init(&parser, commit);
  authordate = commit_parse_authordate(&parser);
  authorname = commit_parse_authorname(&parser, &authorlen);

where the second parse call is basically "free", because we've already
done (and cached) the hard work in the first call.

So they might look like:

  static void parse_author_ident(struct commit_parser *parser)
  {
          if (!parser->author.name_begin) {
                  if (!parser->authorline.start)
                          parse_commit_header(parser);
                  split_ident_line(&parser->author,
                                   parser->authorline.start,
                                   parser->authorline.len);
          }
  }

  unsigned long commit_parse_authordate(struct commit_parser *parser)
  {
          parse_author_ident(parser);
          /* XXX should check for malformedness here */
          return strtoul(ident.date_begin, NULL, 10);
  }

  const char *commit_parse_authorname(struct commit_parser *parser,
                                      unsigned long *len)
  {
          parse_author_ident(parser);
          *len = parser.author.name_end - parser.author.name_begin;
          return parser.author.name_begin;
  }

and so forth. It would be easy (and have the same efficiency) for
format_commit_message to build on that, and it calling it from regular
code is not too bad.

> But you are right.  The commit->buffer may no longer be there, and
> the --author-date-order option needs to read the object again
> in this codepath.  That would be in line with what --pretty/format
> would do, I guess.
> 
> Or we could extend parse_commit() API to take an optional commit
> info slab to store not just author date but other non-essential
> stuff like people's names, and we arrange that extended API to be
> triggered when we know --author-date-order is in effect?

I like the latter option. It takes a non-trivial amount of time to load
the commits from disk, and now we are potentially doing it 2 or 3 times
for a run (once to parse, once to get the author info for topo-sort, and
possibly later to show it if --pretty is given; though I did not check
and maybe we turn off save_commit_buffer with --pretty). It would be
nice to have an extended parse_object that handled that. I'm not sure of
the interface. Maybe variadic with pairs of type/slab, like:

  parse_commit_extended(commit,
                        PARSE_COMMIT_AUTHORDATE, &authordate_slab,
                        PARSE_COMMIT_DONE);

?

-Peff
