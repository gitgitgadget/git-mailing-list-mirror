From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Tue, 31 Dec 2013 08:22:39 +0900
Message-ID: <20131230232239.GA5688@glandium.org>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
 <20131229222433.GA31355@glandium.org>
 <CALWbr2wYqxdMhaWfXQCOk3J_Mxy6=NcScyg9-__j8PPdhY7reA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 00:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxmAe-0005aS-OM
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 00:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386Ab3L3XWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 18:22:48 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43779 "EHLO
	jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932343Ab3L3XWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 18:22:48 -0500
Received: from mh by jigen.glandium.org with local (Exim 4.82)
	(envelope-from <mh@glandium.org>)
	id 1VxmAR-0001pN-Gm; Tue, 31 Dec 2013 08:22:39 +0900
Content-Disposition: inline
In-Reply-To: <CALWbr2wYqxdMhaWfXQCOk3J_Mxy6=NcScyg9-__j8PPdhY7reA@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239830>

On Mon, Dec 30, 2013 at 08:41:13AM +0100, Antoine Pelisse wrote:
> On Sun, Dec 29, 2013 at 11:24 PM, Mike Hommey <mh@glandium.org> wrote:
> > On Sun, Dec 29, 2013 at 12:30:02PM +0100, Antoine Pelisse wrote:
> >> Mercurial can have bookmarks pointing to "nullid" (the empty root
> >> revision), while Git can not have references to it.
> >> When cloning or fetching from a Mercurial repository that has such a
> >> bookmark, the import will fail because git-remote-hg will not be able to
> >> create the corresponding reference.
> >>
> >> Warn the user about the invalid reference, and continue the import,
> >> instead of stopping right away.
> >
> > It's not invalid, it's used to indicate deleted bookmarks. (Tags have
> > the same property)
> 
> Hey Mike,
> Indeed, I don't know how I ended-up with such a bookmark, but it
> prevented me from git-cloning the repository (and the backtrace was
> not very helpful at first).
> But I'm still not sure what you mean by "deleted bookmarks" ?
> I guess it's not "hg bookmark --delete", as it would not be listed at
> all. Is it "hg strip some_changeset" that end-up deleting the
> bookmarked changeset ? I think I've tested this use-case and it moved
> the bookmark to a parent changeset.

Mmmm after looking at the mercurial code, it looks like i was wrong and
bookmarks are not handled like tags. You can actually create such a
bookmark on purpose with:

$ hg bookmark -r null foo

Then, if you do, say:

$ hg up -r foo
$ echo a > a
$ hg add a
$ hg commit -m a

Then you end up with a completely new head with no ancestors in common
with the others.

In git terms,

$ hg bookmark -r null foo
$ hg up -r foo

is equivalent to

$ git checkout --orphan foo

But git never creates an actual ref in that case.

Mike
