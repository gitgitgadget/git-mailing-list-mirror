From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Wed, 4 Apr 2012 18:22:08 +0200
Message-ID: <20120404162208.GN10461@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204040112.02269.jnareb@gmail.com>
 <20120404063939.GA17024@camk.edu.pl>
 <201204041631.42905.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFSyq-0003eU-3D
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 18:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab2DDQWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 12:22:24 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:59841 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932305Ab2DDQWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 12:22:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 157F55F0049;
	Wed,  4 Apr 2012 18:23:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CdyqytRCQ9tj; Wed,  4 Apr 2012 18:22:55 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id A45DA5F0048;
	Wed,  4 Apr 2012 18:22:55 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id E886F4669F; Wed,  4 Apr 2012 18:22:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204041631.42905.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194705>

On Wed, Apr 04, 2012 at 04:31:42PM +0200, Jakub Narebski wrote:
> On Wed, 4 April 2012, Kacper Kornet wrote:
> > On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
> >> On Tue, 3 Apr 2012, Kacper Kornet wrote:
> > What about:

> > $no_list_age::
> > 	Whether to show the column with date of the most current commit on the
> > 	projects list page. It can save a bit of I/O.

> Perhaps it would be better to say it like this:

>   $no_list_age::
>   	If true, omit the column with date of the most current commit on the
>   	projects list page. [...]

> It is true that it can save a bit of I/O: the git_get_last_activity()
> examines all branches (some of which are usually loose), and must hit
> the object database, unpacking/getting commit objects to get at commit
> date.

> But the fact that it also saves a fork (a git command call) per repository
> reminds me of something which I missed in first round of review, namely
> that generating 'age' and 'age_string' fields serve also as a check if
> repository really exist.

> So either we document this fact, or use some other way to verify that
> git repository is valid.

I think that git_project_list_body always works with the list returned
by git_get_projects_list. And git_get_projects_list validates if the
path is a git repository. So it should not be a problem. Please correct
me, if I am wrong.



> >>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >>> index a8b5fad..f42468c 100755
> >>> --- a/gitweb/gitweb.perl
> >>> +++ b/gitweb/gitweb.perl
> >>> @@ -133,6 +133,9 @@ our $default_projects_order = "project";
> >>>  # (only effective if this variable evaluates to true)
> >>>  our $export_ok = "++GITWEB_EXPORT_OK++";

> >>> +# don't generate age column
> >>> +our $no_list_age = 0;

> >> "age" column where?

> >> Hmmm... can't we come with a better name than $no_list_age?

> > Any of $no_age_column, $omit_age_column, $no_last_commit would be better?

> $no_age_column seems better than $no_list_age... but see below. 

> >>> @@ -5495,7 +5500,8 @@ sub git_project_list_body {
> >>>  	                                 'tagfilter'  => $tagfilter)
> >>>  		if ($tagfilter || $search_regexp);
> >>>  	# fill the rest
> >>> -	@projects = fill_project_list_info(\@projects);
> >>> +	my @all_fields = $no_list_age ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
> >>> +	@projects = fill_project_list_info(\@projects, @all_fields);

> >> That looks quite strange on first glance.  I know that empty list means
> >> filling all fields, but the casual reader migh wonder about this
> >> conditional expression.

> >> Perhaps it would be better to write it this way:

> >>   -	@projects = fill_project_list_info(\@projects);
> >>   +	my @fields = qw(descr descr_long owner ctags category);
> >>   +	push @fields, 'age' unless ($no_list_age);
> >>   +	@projects = fill_project_list_info(\@projects, @fields);

> >> or something like that.

> >> Well, at least until we come up with a better way to specify "all fields
> >> except those specified".

> > Yes, that's better. Especially that I would like also to introduce
> > option to prevent printing repository owner everywhere.

> Well, because this patch affects gitweb configuration, and because we
> need to preserve (as far as possible) the backward compatibility with
> existing gitweb configuration files we need to be careful with changes.

> Perhaps instead of $no_age_column that can be single configuration
> variable like @excluded_project_list_fields instead of one variable
> per column.  Somebody might want to omit project description as well
> (though then project search must be limited to project names only).
> Though this approach will have problem that some of columns simply
> have to be present... maybe one variable per column (perhaps hidden
> in a hash) is a better solution.

I thought about two different variables as that would have a slightly
different functionality. While I want to get rid off Last Change from
the projects list page, I still want to get this information on pages of
single repositories. On the other hand I don't want repository owner to
be shown anywhere.

-- 
  Kacper Kornet
