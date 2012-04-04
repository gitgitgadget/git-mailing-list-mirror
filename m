From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last
 change
Date: Wed, 4 Apr 2012 08:39:39 +0200
Message-ID: <20120404063939.GA17024@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <201204040112.02269.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFJst-00008f-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 08:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2DDGjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 02:39:53 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:33200 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab2DDGjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 02:39:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 1A8305F0047;
	Wed,  4 Apr 2012 08:40:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DKpio7kn-5eX; Wed,  4 Apr 2012 08:40:27 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 43F245F0049;
	Wed,  4 Apr 2012 08:40:26 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 8BB494669F; Wed,  4 Apr 2012 08:39:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204040112.02269.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194681>

On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
> On Tue, 3 Apr 2012, Kacper Kornet wrote:
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> > index 7aba497..bfeef21 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -403,6 +403,9 @@ $default_projects_order::
> >  	i.e. path to repository relative to `$projectroot`), "descr"
> >  	(project description), "owner", and "age" (by date of most current
> >  	commit).
> > +
> > +$no_list_age::
> > +	Omit column with date of the most curren commit

> s/curren/current/

> Thanks for adding documentation, though I would prefer if you expanded
> this description (for example including the information that it touches
> projects list page).

What about:

$no_list_age::
	Whether to show the column with date of the most current commit on the
	projects list page. It can save a bit of I/O.

> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index a8b5fad..f42468c 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -133,6 +133,9 @@ our $default_projects_order = "project";
> >  # (only effective if this variable evaluates to true)
> >  our $export_ok = "++GITWEB_EXPORT_OK++";

> > +# don't generate age column
> > +our $no_list_age = 0;

> "age" column where?

> Hmmm... can't we come with a better name than $no_list_age?

Any of $no_age_column, $omit_age_column, $no_last_commit would be better?


> > @@ -5495,7 +5500,8 @@ sub git_project_list_body {
> >  	                                 'tagfilter'  => $tagfilter)
> >  		if ($tagfilter || $search_regexp);
> >  	# fill the rest
> > -	@projects = fill_project_list_info(\@projects);
> > +	my @all_fields = $no_list_age ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
> > +	@projects = fill_project_list_info(\@projects, @all_fields);

> That looks quite strange on first glance.  I know that empty list means
> filling all fields, but the casual reader migh wonder about this
> conditional expression.

> Perhaps it would be better to write it this way:

>   -	@projects = fill_project_list_info(\@projects);
>   +	my @fields = qw(descr descr_long owner ctags category);
>   +	push @fields, 'age' unless ($no_list_age);
>   +	@projects = fill_project_list_info(\@projects, @fields);

> or something like that.

> Well, at least until we come up with a better way to specify "all fields
> except those specified".

Yes, that's better. Especially that I would like also to introduce
option to prevent printing repository owner everywhere.

-- 
  Kacper Kornet
