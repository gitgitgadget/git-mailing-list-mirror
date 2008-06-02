From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
	git_get_head_hash
Date: Mon, 2 Jun 2008 11:29:26 +0200
Message-ID: <20080602092926.GJ18781@machine.or.cz>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com> <m3lk1q24nb.fsf@localhost.localdomain> <4841471E.2070302@gmail.com> <200806020019.23858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 11:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K36N1-0000Dk-35
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 11:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbYFBJ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 05:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbYFBJ3e
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 05:29:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56458 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbYFBJ3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 05:29:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1CD4A1E4C03F; Mon,  2 Jun 2008 11:29:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806020019.23858.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83504>

On Mon, Jun 02, 2008 at 12:19:23AM +0200, Jakub Narebski wrote:
> On Sat, 31 May 2008, Lea Wiemann wrote:
> > Layer 2 is application-independent as well, so it can become an extra 
> > class in Git.pm or a separate module.  (It should stay independent of 
> > layers 3 and 4).
> 
> I think it would be better as separate module.  Would it be Git::Cache
> (or Git::Caching), Gitweb::Cache, or part of gitweb, that would have
> to be decided.  Besides, I'm not sure if it is really application-
> -independent as you say: I think we would get better result if we
> collate data first, which is application dependent.  Also I think
> there is no sense to cache everything: what to cache is again
> application dependent.

I'm not very comfortable with putting caching directly to Git either.

Even if you _would_ decide that you want to add caching directly to Git
interface, it would be better to use extra module Git::Cached and
auto-wrap all Git functions through AUTOLOAD. But that still has the
problems Jakub desrcibed.

> > We may need to have an explicitly implemented layer 0 (front-end 
> > caching) in Gitweb for at least a subset of pages (like project pages), 
> > but we'll see if that's necessary.
> 
> I think that front-end caching (HTML/RSS/Atom output caching) has sense
> for large web pages (large size and large number of items), such as
> projects list page if it is unpaginated (and perhaps even if it is
> divided into pages, although I'm sure not for project search page),
> commonly requested snapshots (if they are enabled), large trees like
> SPECS directory with all the package *.spec files for distribution
> repository, perhaps summary/feed for most popular projects. If (when)
> syntax highlighting would got implemented, probably also caching
> blob view (as CPU can become issue).
> 
> Front-end (HTML output) caching has the advantages of easy to calculate
> strong ETag, and web server support for If-Match: and If-None-Match:
> HTTP/1.1 headers.  You can easy support Range: request, needed for
> resuming download (e.g. for downloading snapshots, if this feature is
> enabled in gitweb).

Caching snapshots would definitely make sense, sure.

> You can even compress the output, and serve it to clients which
> support proper transparent compression (Content-Encoding).

What does this have to do with caching?

> And of course it has the advantage of actually been written and tested
> in work, in the case of kernel.org gitweb.  Although caching parsed
> data was implemented in repo.or.cz gitweb, it was done only for
> projects list view, and it is quite new and not so thoroughly tested
>   http://article.gmane.org/gmane.comp.version-control.git/77469

This argument does have some value, but I don't think it matters too
much, since as far as I understood, it is going to get largely
reimplemented anyway.

> It would be nice for front-end caching to have an option to use absolute
> time for all time/dates, and to (optionally) not use adaptive
> Content-Type...

I'd hate to have to do unnecessary compromises in order to get sensible
caching.

Even in your excellent series on Gitweb caching series, I didn't spot
any arguments that would put frontend caching in front of the
intermediate data caching option; yes, it is the simplest solution
implementation-wise, but also the least flexible one. My gut feeling is
still to go with data caching instead of HTML caching.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
