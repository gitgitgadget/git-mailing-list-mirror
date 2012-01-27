From: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
Subject: Re: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Sat, 28 Jan 2012 00:53:32 +0100
Message-ID: <20120127235330.GA2718@server.brlink.eu>
References: <20120126144517.GA4229@server.brlink.eu>
 <m31uqkepx6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 00:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqvbl-0005lR-UI
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 00:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab2A0XxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 18:53:24 -0500
Received: from server.brlink.eu ([78.46.187.186]:54044 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab2A0XxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 18:53:23 -0500
Received: from p5483e00c.dip.t-dialin.net ([84.131.224.12] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rqvbe-0002eH-6Y; Sat, 28 Jan 2012 00:53:22 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rqvbo-0000l1-Ma; Sat, 28 Jan 2012 00:53:33 +0100
Content-Disposition: inline
In-Reply-To: <m31uqkepx6.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189245>

* Jakub Narebski <jnareb@gmail.com> [120127 23:33]:
> > This commit changes the project listings (project_list, project_index
> > and opml) to limit the output to only projects in a subdirectory if the
> > new optional parameter ?pf=directory name is used.
>
> Could you explain why you want this feature, and why for example
> project search just does not cut it?

The project list takes often a very long time and searching in that list
takes the same time (and would also show projects not starting with the
text).

I'd for example like to be able to place a link to all projects shown
at http://anonscm.debian.org/gitweb/ which are below mirrorer/ and get
a not having to wait for description information being extracted for all
the other projects.

> > It uses the infrastructure already there for 'forks' (which also filters
> > projects but needs a project called like the filter directory to work).
> 
> It is not entirely clear for me that what you mean here is (I think)
> that using
> 
>   git_get_projects_list($project_filter);
> 
> just works thanks to forks filtering infrastructure.

Yes, it uses the optional git_get_projects_list argument which is
currently only used by action=forks.

> > This feature is disabled if strict_export is used and there is no
> > projects_list to avoid showing more than intended.
> > Without strict_export enabled this change should not show any projects
> > one could not get details from anyway. So if the validate_pathname
> > checks are not sufficient this would at most make it easier to get a
> > list of viewable content.
> 
> I don't wuite understand this reasoning.  Why project filtering is
> disabled with strict_export?  It should just filter, regardless if
> project are from scanning $project_filter subdirectory, or filtering
> out project names from $projects_list file that do not begin with
> $project_filter prefix.

strict_export is a security switch to make sure that no unintended
information is exported. Without a project_list all that strict_export
ensures is that there is no way to escape the project_root by giving
some path to a project outside that is not catched by the simple check
against /./ and /../. As the new code would allow a way around this
check, I think the sane thing is to simply disable this new feature in
case of this paranoid check being activated. (And reporting an error
message if it is used).

> > ---
> > As most parameters are not documented in documentation/gitweb.txt,
> > I did not add documentation for this one either.
>
> On the other hand IIRC getting list of projects is quite well
> documented in gitweb manpage (or at least it should be).

In Documentation/gitweb.txt there is only a list of possible actions, but no
documentation of any of the other arguments. (none of the order argument
to project_list nor anything else). If actions like blob_plain do list
essential arguments like f= then giving this option special rooms does
not seem to fit very well with the rest.

>  
> [...]
> > @@ -3962,6 +3973,13 @@ sub git_footer_html {
> >  			              -class => $feed_class}, $format)."\n";
> >  		}
> >  
> > +	} elsif (defined $project_filter) {
> > +		print $cgi->a({-href => href(project=>undef, action=>"opml",
> > +		                             project_filter => $project_filter),
> > +		              -class => $feed_class}, "OPML") . " ";
> > +		print $cgi->a({-href => href(project=>undef, action=>"project_index",
> > +		                             project_filter => $project_filter),
> > +		              -class => $feed_class}, "TXT") . "\n";
> >  	} else {
> >  		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> >  		              -class => $feed_class}, "OPML") . " ";
> 
> I wonder if perhaps a better solution wouldn't be to use -replay=>1 in
> generating projects list in other formats (OPML and TXT).

Wouldn't that also replay options like "order"?

        Bernhard R. Link
