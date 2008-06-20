From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] graph.c: make many functions static
Date: Fri, 20 Jun 2008 10:19:11 -0700
Message-ID: <20080620171910.GA31552@adamsimpkins.net>
References: <20080619082110.6117@nanako3.lavabit.com> <7vhcbptev8.fsf@gitster.siamese.dyndns.org> <20080620060035.GA22345@adamsimpkins.net> <7vmylgo8v7.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 19:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9kHX-0005HS-Cu
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 19:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYFTRTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2008 13:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYFTRTO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 13:19:14 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:46252 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYFTRTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 13:19:14 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 3E4BD77722D;
	Fri, 20 Jun 2008 13:19:13 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id F0105777221;
	Fri, 20 Jun 2008 13:19:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 6886B14100D0; Fri, 20 Jun 2008 10:19:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmylgo8v7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85667>

On Fri, Jun 20, 2008 at 12:37:00AM -0700, Junio C Hamano wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
>=20
> > On Thu, Jun 19, 2008 at 12:16:11PM -0700, Junio C Hamano wrote:
> >> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <=
nanako3@lavabit.com> writes:
> > ...
> >> > +/* Internal API */
> >> > + ...
> >> > +static int graph_next_line(struct git_graph *graph, struct strb=
uf *sb);
> >> > +static void graph_padding_line(struct git_graph *graph, struct =
strbuf *sb);
> >> > +static void graph_show_strbuf(struct git_graph *graph, struct s=
trbuf const *sb);
> >>=20
> >> I think these are probably fine, not in the sense that nobody call=
s these
> >> functions _right now_ but in the sense that I do not foresee a cal=
ling
> >> sequence outside the graph.c internal that needs to call these dir=
ectly,
> >> instead of calling graph_show_*() functions that use these.
> >
> > Documentation/technical/api-history-graph.txt should also be update=
d
> > to remove the discussion of these functions if they are no longer
> > publicly exposed.
>=20
> Actually, I was expecting (not necessarily _hoping_) you to defend th=
ese
> public API by providing examples that illustrates when calling these =
from
> outside graph API implementation could be useful.

Ah.  I see :-)

I do think that graph_next_line() and graph_padding_line() are
potentially useful as public APIs, since they are more generic than
the other API functions that wrap them.  These functions both output
to a strbuf.  graph_show_oneline() and graph_show_padding() are simple
wrappers around these functions that print the resulting strbuf to
stdout.  graph_next_line() and graph_padding_line() will be needed by
anyone who wants to write the graph output somewhere other than
stdout.  They could also be useful if someone wants to further
manipulate the output before printing it.

graph_show_strbuf() is a somewhat similar situation.
graph_show_commit_msg() is a wrapper around graph_show_strbuf()--it
calls graph_show_strbuf() and then also prints the remainder of the
graph.  A caller would need to use graph_show_strbuf() directly if
they have multiple strbufs that need to be displayed alongside the
graph.  In this case, they'll want to call graph_show_strbuf()
multiple times before printing the remainder of the graph.  (The
caller could also work around this by concatenating the strbufs first,
then passing the entire thing to graph_show_commit_msg().  However,
the downside of this approach is that it requires copying the
strbufs.)

I didn't defend these earlier since I wasn't sure if it was simply
git's style to make functions static until there is a proven need for
them to be public.  At the moment, the existing log-tree.c code is
only using the wrappers around these functions.  I don't really see an
immediate need for the core git code to use any of these functions
directly, but they might of interest to people working on libifying
git.

--=20
Adam Simpkins
adam@adamsimpkins.net
