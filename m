From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP/RFC PATCH 1/2] Introduce GIT_INDEX_PREFIX
Date: Thu, 5 Jun 2008 05:35:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050532240.21190@racer>
References: <20080604162825.GB23975@laptop>  <7vabi1xepi.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0806042015w72295f07k25ad709f5d976b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K47FG-0002eA-N2
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYFEEhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYFEEhR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:37:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751241AbYFEEhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:37:16 -0400
Received: (qmail invoked by alias); 05 Jun 2008 04:37:14 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp001) with SMTP; 05 Jun 2008 06:37:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1983gACISd8qh6yC9TusPHH1jOT1OojSoekOIxuoP
	94XzITZD5NbzpY
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0806042015w72295f07k25ad709f5d976b20@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83856>

Hi,

On Thu, 5 Jun 2008, Nguyen Thai Ngoc Duy wrote:

> On Thu, Jun 5, 2008 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> >
> >> GIT_INDEX_PREFIX is used to limit write access to a specific directory.
> >> Only "important" information is protected by index prefix (those will
> >> be used to create tree objects)
> >>
> >> When GIT_INDEX_PREFIX is set, any attempt to modify the index (refresh
> >> it is okay though) will bail out. read-tree and merge, however, can
> >> write to full index. For merge, no conflict is allowed outside index
> >> prefix.
> >
> > This is kind of hard to judge as part of "narrow checkout" series, 
> > because it is not clear how this will actually _help_ narrow checkout.
> 
> When you do narrow checkout. You only have a subdirectory, so you would 
> not want some commands to accidentally change things outside that 
> subdirectory in index.

When they operate purely on the index?  Why not?

I guess that Junio's point was that the semantics are not at all clear.

> > In other words, as a standalone "protect parts outside a single 
> > subdirectory" it can be reviewed and judged, but it is unclear how it 
> > would help narrow checkout if you excempted only a _single_ 
> > subdirectory. E.g. you might want to limit yourself to arch/x86 _and_ 
> > include/asm-x86.
> 
> Well it could be extended to support multiple path separated by colon
> later if someone needs it :)

The thing is: if the concept is sound, chances are that it is _easy_ to 
support that, should someone need it.

> >> @@ -71,6 +73,9 @@ static void setup_git_env(void)
> >>       git_graft_file = getenv(GRAFT_ENVIRONMENT);
> >>       if (!git_graft_file)
> >>               git_graft_file = xstrdup(git_path("info/grafts"));
> >> +     index_prefix = getenv(INDEX_PREFIX_ENVIRONMENT);
> >> +     if (index_prefix && (!*index_prefix || index_prefix[strlen(index_prefix)-1] != '/'))
> >> +             die("GIT_INDEX_PREFIX must end with a slash");
> >
> > Not nice (aka "why 'must'?").
> 
> Simpler handling. Maybe it should append slash by itself if missing.

Not maybe.  Definitely.  That was what the comment was about.

> >> diff --git a/read-cache.c b/read-cache.c
> >> index ac9a8e7..4f8d44b 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -23,6 +23,11 @@
> >>
> >>  struct index_state the_index;
> >>
> >> +static int outside_index_prefix(const struct index_state *istate, const char *ce_name)
> >> +{
> >> +     return istate == &the_index && get_index_prefix() && prefixcmp(ce_name, get_index_prefix());
> >> +}
> >
> > The first check above needs to be justified.
> >
> > If you say "outside of this path are off-limits", why do you allow a
> > temporary index that is used during a partial commit and other
> > index_states excempt from that rule?
> 
> Because unpack_trees writes new index from scratch so it will always 
> violate that. That check is IMO enough for simple index manipulation 
> like add/remove an entry. For unpack_trees, I have check_index_prefix() 
> to match a temporary index with current index before it gets written to 
> disk.

unpack_trees() is what drives merges.  Does that mean that the only 
opportunity to end up with conflicts is _not_ prevented?

Ciao,
Dscho
