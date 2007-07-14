From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] --decorate now decorates ancestors, too
Date: Sat, 14 Jul 2007 01:23:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707140123141.14781@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
 <Pine.LNX.4.64.0707110229320.4047@racer.site> <20070711022714.GI27033@thunk.org>
 <7vmyy1tq96.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 02:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9VQX-0000mG-Gh
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbXGNAXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 20:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755313AbXGNAXv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:23:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:36591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753516AbXGNAXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 20:23:50 -0400
Received: (qmail invoked by alias); 14 Jul 2007 00:23:48 -0000
Received: from R180a.r.pppool.de (EHLO noname) [89.54.24.10]
  by mail.gmx.net (mp032) with SMTP; 14 Jul 2007 02:23:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hUZhmg4MhxT4pReh1GWpjoPMLF2wbaKYvbcBLEO
	vnNkfXfS8f+iRf
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyy1tq96.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52426>

Hi,

On Thu, 12 Jul 2007, Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > On Wed, Jul 11, 2007 at 02:29:49AM +0100, Johannes Schindelin wrote:
> >> 
> >> The option --decorate changed default behavior: Earlier, it decorated
> >> commits pointed to by any ref.  The new behavior is this: decorate the
> >> with the given refs and its ancestors, i.e.
> >> 
> >> 	git log --decorate next master
> >> 
> >> will show "next", "next^", "next~2", ..., "master", "master^", ...
> >> in parenthesis after the commit name.
> >
> > I'm wondering how useful the default is.  The arguments get used for
> > two things; both for git-log to decide what revisions to display, and
> > which refs to decorate, right?  I'm not sure that overloading is such
> > a great idea.
> >
> > Also, I note that "git log --decorate" does nothing at all.  Maybe it
> > would be better to keep the default to be "any-ref" instead of "given"?
> 
> I think defaulting to "given" is a regression.  It could be
> argued that "tag-ref" or "tag" might be a better default
> (judging from my experience with "name-rev"), but keeping
> "any-ref" would probably be the safest.

Okay, fair enough.  I kind of expected people to disagree as of the 
default mode.  My preference would have been "tag", since I need that 
quite often, but I am willing to put my wishes aside there.

Probably I should follow up with a replacement patch, and a config 
variable "commit.decorateMode" patch, leaving the default at "any-ref"?

> But in general I do not see ("I haven't realized" might turn out to be a 
> better expression) much value in this series yet except for the initial 
> clean-up patches, while I think this option would be quite expensive in 
> terms of memory footprints on projects with nontrivial size of history.  
> I dunno.

There are a few points I want to make to convince you:

- I need this quite often to see which version introduced a certain 
  feature.  This is most visible on IRC, where people ask "how can I do X, 
  I have version Y", and me responding "There is a feature P, but 
  unfortunately, it is only available from revision Q~N" where Q > Y.

  I really want other people to do this easily, without having to know how 
  name-rev (which has a dash in its name, and thus is kind of 
  plumbing-ish) works.


- It is _not_ expensive.  It only ever allocates something in the case of 
  merges (at least that's how I designed it), and should free the used 
  memory when the commit name is not used at all (but maybe I forgot that 
  part...).  So you will have at most one allocation of a few bytes per 
  merge, and I really do not see how this could break down for 
  pathological, but real-world, cases.

- 40-character commit names seem to be really hard on people.

To drive the 3rd point home: I often see people confused as to what those 
long commit names are.  They do not even realise that they are _object_ 
names, actually, not only applicable to commit objects.

IMHO a great way to teach users that commit names are equivalent to 
shortcuts like "v1.5.0-rc1~20" would be to even enable decoration by tags 
by default.

Ciao,
Dscho
