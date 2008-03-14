From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 01:22:05 +0100
Message-ID: <20080314002205.GL10335@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxpr-0001wX-9C
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbYCNAbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbYCNAbI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:31:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46076 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbYCNAbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:31:07 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 20:31:07 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id 44F61393BA0E; Fri, 14 Mar 2008 01:22:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77159>

On Thu, Mar 13, 2008 at 08:07:09PM -0400, Jay Soffian wrote:
> On Thu, Mar 13, 2008 at 7:14 PM, Petr Baudis <pasky@suse.cz> wrote:
> >  diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> >  index 8e2bf3d..673077a 100644
> >  --- a/gitweb/gitweb.css
> >  +++ b/gitweb/gitweb.css
> >  @@ -85,6 +85,12 @@ div.title, a.title {
> >         color: #000000;
> >   }
> >
> >  +div.stale_info {
> >  +       display: block;
> >  +       text-align: right;
> >  +       font-style: italic;
> >  +}
> >  +
> >   div.readme {
> >         padding: 8px;
> >   }
> 
> What does this have to do with it?

The box shows that cached information is being shown.

> >  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >  index bcb6193..0eee195 100755
> >  --- a/gitweb/gitweb.perl
> >  +++ b/gitweb/gitweb.perl
> >  @@ -122,6 +122,15 @@ our $fallback_encoding = 'latin1';
> 
> ...
> 
> >  +               if ($cache_lifetime and -f $cache_file) {
> >  +                       # Postpone timeout by two minutes so that we get
> >  +                       # enough time to do our job.
> >  +                       my $time = time() - $cache_lifetime + 120;
> >  +                       utime $time, $time, $cache_file;
> >  +               }
> 
> Race condition. I don't see any locking. Nothing keeps multiple instances from
> regenerating the cache concurrently...
> 
> >  +               @projects = git_get_projects_details($projlist, $check_forks);
> >  +               if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {
> 
> ...and then clobbering each other here. You have two choices:
> 
> 1) Use a lock file for the critical section.
> 
> 2) Assume the race condition is rare enough, but you still need to account for
> it. In that case, you want to write to a temporary file and then rename to the
> cache file name. The rename is atomic, so though N instances of gitweb may
> regenerate the cache (at some CPU/IO overhead), at least the cache file won't
> get corrupted.

You are of course right - I wanted to do the rename, but forgot to write
it in the actual code. :-)

There is a more conceptual problem though - in case of such big sites,
it really makes more sense to explicitly regenerate the cache
periodically instead of making random clients to have to wait it out.
We could add a 'force_update' parameter to accept from localhost only
that will always regenerate the cache, but that feels rather kludgy -
can anyone think of a more elegant solution? (I don't think taking the
@projects generating code out of gitweb and then having to worry during
gitweb upgrades is any better.)

> Out of curiosity, repo.or.cz isn't running this as a CGI is it? If so, wouldn't
> running it as a FastCGI or modperl be a vast improvement?

Unlikely. Currently the machine is mostly IO-bound and only small
portion of CPU usage comes from gitweb itself.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
