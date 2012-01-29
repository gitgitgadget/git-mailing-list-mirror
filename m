From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: add project_filter to limit project list to a subdirectory
Date: Sun, 29 Jan 2012 13:54:49 +0100
Message-ID: <201201291354.50241.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <m3wr8bcuon.fsf@localhost.localdomain> <20120129012234.GD16079@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sun Jan 29 13:54:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrUHT-0004AS-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 13:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab2A2MyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 07:54:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57482 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2A2MyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 07:54:21 -0500
Received: by eaal13 with SMTP id l13so795159eaa.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ejWcBu1LIkUytqD2E1D+ZEX1g51v9ZX1AyBDVwnhbOQ=;
        b=sF4lpwwFdazupyelMdgXdrdlhTO03FMxWYgNMNRV1QrRfvdflT9I1eelHNHAGN45mB
         pB/WrA3v0W9bAsW1eV4/QWYcdlvaub8fg7xuFmaV1lWpbcoIrRqv4FnJ5Ivk30xVkYuS
         ie0JU8rsT/YJHQITfpNSAstIVclHrSHNHRRvw=
Received: by 10.213.25.146 with SMTP id z18mr2274469ebb.65.1327841659384;
        Sun, 29 Jan 2012 04:54:19 -0800 (PST)
Received: from [192.168.1.13] (abwg78.neoplus.adsl.tpnet.pl. [83.8.230.78])
        by mx.google.com with ESMTPS id t11sm31078800eea.10.2012.01.29.04.54.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 04:54:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120129012234.GD16079@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189286>

On Sun, 29 Jan 2012, Bernhard R. Link wrote:

> This commit changes the project listing views (project_list,
> project_index and opml) to limit the output to only projects in a
> subdirectory if the new optional parameter ?pf=directory name is used.
> 
> The change is quite minimal as git_get_projects_list already can limit
> itself to a subdirectory (though that was previously only used for
> 'forks').
>
Nice and succinct.
 
> If there is a GITWEB_LIST file, the contents are just filtered like
> with the forks action.
> 
O.K.

> Without a GITWEB_LIST file only the given subdirectory is searched
> for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
> In the later case GITWEB_PROJECTROOT is traversed normally (unlike
> with forks) and projects not in the directory ignored.
> (As there is no check if the filter_path would have been found in
> the usual search as the project path is checked with forks).
> 
Now I understand how project_filter interacts with strict_export.

Though I am not sure if this "paranoid mode" is really necessary.  I don't
see how you could get in situation where scanning from $project_list and
filtering with $project_filter prefix, and scanning from 
$project_list/$project_filter would give different results.

I think you are overly paranoid here, but perhaps it is better to be
overly strict, and then relax it if it turns out to be not necessary.

> Reusing $project instead of adding a new parameter would have been
> nicer from a UI point-of-view (including PATH_INFO support) but
> would complicate the $project validating code that is currently being
> used to ensure nothing is exported that should not be viewable.
> 
Sidenote: support for actionless PATH_INFO URLs would make it even more
complicated...

> Additionally change html page headers to not only link the project
> root and the currently selected project but also the directories in
> between using project_filter.
> 
Excuse me changing my mind, but I think that as far as this patch series
is applied as whole, it would be better for maintability to keep those
two patches split; though put the above as a [part of] commit message
in 2/2 patch.

> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> ---
> 
> changes since v2:
>         improve description
>         remove || 0 for boolean argument
>         merge with patch using this feature
>         use user-visible configuration names instead of internal ones
> 
> * Jakub Narebski <jnareb@gmail.com> [120128 23:45]:
> > "Bernhard R. Link" <brl+git@mail.brlink.eu> writes:
> > > If strict_export is enabled and there is no projects_list, it still
> > > traverses the full tree and only filters afterwards to avoid anything
> > > getting visible by this. Otherwise only the subtree needs to be
> > > traversed, significantly reducing load times.
> > >
> > I still don't understand interaction between project_filter ('pf'),
> > $strict_export and $projects_list being either directory or a file
> > with a list of projects.
> > 
> > Does it mean, that when $projects_list is a file with a list of projects,
> > and we use project_filter, then:
> > 
> > * if $strict_export is false, then $project_list is ignored, and the
> >   filtered list of projects is created by scanning
> >   "$projectroot/$project_filter"
> 
> No. If project_list is set, i.e. a file, then this is always used.
> If it is a directory (because it is not set thus set to projectroot),
> then with forks it still traverses that directory (as that was checked
> before to be a reachable project with a previous call to
> git_get_projects_list). In the case of project_filter only the directory
> is traversed without strict_export and the whole projectroot is
> traversed with strict_export.
> 
O.K., now I understand it.

> Is the new description better.
> 
Yes it is.

> > A few nitpicks with respect to patch itself.
> > 
> > >  -2827,6 +2835,7 @@ sub git_get_project_url_list {
> > >  
> > >  sub git_get_projects_list {
> > >  	my $filter = shift || '';
> > > +	my $paranoid = shift || 0;
> > >  	my @list;
> > >  
> > 
> > First, undefined value is false in Perl, so there is no need for
> > " || 0" in setting $paranoid variable.
> 
> I thought it make it clearer that the argument might not be set and
> what the default is. But that is personal taste.

First, optional parameter defaults to false in the 'my $foo = shift;'
or equivalent form is (I think) idiomatic Perl.  Second, this way of
writing it is used through gitweb code (CodingGuidelines: imitate existing
coding practices). 
 
> > Second, why not use global variable $strict_export instead of adding
> > another parameter to git_get_projects_list()?
> 
> That would change the action=forks behaviour to traverse the whole
> projectroot two times. This way paranoia is only activated if
> strict_mode is set _and_ the argument was not yet checked to be
> reachable.

Thanks for explanation.
 
>  gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 44 insertions(+), 8 deletions(-)

Not that large for a new feature...

-- 
Jakub Narebski
Poland
