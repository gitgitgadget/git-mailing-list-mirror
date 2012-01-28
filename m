From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Sat, 28 Jan 2012 15:53:28 +0100
Message-ID: <201201281553.29387.jnareb@gmail.com>
References: <20120126144517.GA4229@server.brlink.eu> <m31uqkepx6.fsf@localhost.localdomain> <20120127235330.GA2718@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCF7-0000o9-De
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab2A1OxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 09:53:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53933 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2A1OxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 09:53:01 -0500
Received: by eaal13 with SMTP id l13so570640eaa.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=D6xrZM4OKneki+G7K3ZxwDsHoljuBrJCLJl3ZXnlryQ=;
        b=jkCfSRYjy3n8zAiGqTjIO62davFn33kuBg/2I+EDFdbjFeA3bIXeZXJDgA7WppGYCN
         VPBHNPeQmsgE3WAdSSx8JwmnZ0+db4BXeXhcjCVoNbbQoFG215dx2s9rmw1yFR0c+uxx
         zfYDovcnbJ7ES0otijufr20scz7lQK8Pc/17w=
Received: by 10.213.112.204 with SMTP id x12mr1810764ebp.43.1327762379461;
        Sat, 28 Jan 2012 06:52:59 -0800 (PST)
Received: from [192.168.1.13] (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id y54sm44569766eef.8.2012.01.28.06.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 06:52:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120127235330.GA2718@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189255>

On Sat, 28 Jan 2012, Bernhard R. Link wrote:
> * Jakub Narebski <jnareb@gmail.com> [120127 23:33]:

> > > This commit changes the project listings (project_list, project_index
> > > and opml) to limit the output to only projects in a subdirectory if the
> > > new optional parameter ?pf=directory name is used.
> >
> > Could you explain why you want this feature, and why for example
> > project search just does not cut it?
> 
> The project list takes often a very long time and searching in that list
> takes the same time (and would also show projects not starting with the
> text).

There are at least two ways to speed up getting projects list page.


First is to limit number of projects shown, like e.g. http://repo.or.cz
which shows only search form and tag cloud, but no projects, or at least
paginate (divide into pages of e.g. 100 projects) list of projects.

I have some patches improving projects list and searching projects, 
including slight speedup to search result generation and project list
pagination in my StGit stack.  I'll clean them up and (re)send them to
git mailing list for discussion.


Second solution would be to finally add caching support to gitweb,
either on the level of caching git command output like Lea Wiemann
work from GSoC2008, or caching intermediate Perl data structures
used by gitweb like in old patches by Petr 'Pasky' Baudis (though only
for projects list page), or caching of final HTML output like in
http://git.kernel.org fork of gitweb.

There is some work in progress that I have in gitweb/cache branch and
in gitweb/cache-kernel* branches in my repository (either on
http://github.com/jnareb/git or http://repo.or.cz/w/git/jnareb-git.git).

The problem with cleaning it up to the form suitable for inclusion is
that it is quite a bit of code, and it very much requires splitting gitweb.
Splitting gitweb in turn requires reworking of current hacky "longjump"
based (non-local goto) error handling into exception based error handling.
That in turn would be best handled using non-core CPAN modules, namely
Try::Tiny and HTTP::Exception or at least Exception::Class.  For that
we need I think a way of bundling requirements with gitweb in inc/ 
a la Module::Install.

Ehhh...

> I'd for example like to be able to place a link to all projects shown
> at http://anonscm.debian.org/gitweb/ which are below mirrorer/ and get
> a not having to wait for description information being extracted for all
> the other projects.

I would prefer instead of introducing yet another arbitrary parameter
extend project searching, so that you can specify that you want to
search project names only (IIRC I have a patch for that, or beginnings
of one, in my StGit stack), and use prefix search by the way of regexp
search.

So

  pf=mirrorer/

would be

  s=^mirrorer/;sr=1;st=project_name
 
> > > It uses the infrastructure already there for 'forks' (which also filters
> > > projects but needs a project called like the filter directory to work).
> > 
> > It is not entirely clear for me that what you mean here is (I think)
> > that using
> > 
> >   git_get_projects_list($project_filter);
> > 
> > just works thanks to forks filtering infrastructure.
> 
> Yes, it uses the optional git_get_projects_list argument which is
> currently only used by action=forks.

This needs to be stated more clearly in the commit message.
 
> > > This feature is disabled if strict_export is used and there is no
> > > projects_list to avoid showing more than intended.
> > > Without strict_export enabled this change should not show any projects
> > > one could not get details from anyway. So if the validate_pathname
> > > checks are not sufficient this would at most make it easier to get a
> > > list of viewable content.
> > 
> > I don't quite understand this reasoning.  Why project filtering is
> > disabled with strict_export?  It should just filter, regardless if
> > project are from scanning $project_filter subdirectory, or filtering
> > out project names from $projects_list file that do not begin with
> > $project_filter prefix.
> 
> strict_export is a security switch to make sure that no unintended
> information is exported. Without a project_list all that strict_export
> ensures is that there is no way to escape the project_root by giving
> some path to a project outside that is not catched by the simple check
> against /./ and /../. As the new code would allow a way around this
> check, I think the sane thing is to simply disable this new feature in
> case of this paranoid check being activated. (And reporting an error
> message if it is used).

Hmmm... I think this new feature can be made compatible with strict export...
if it is not replaced by search extension, as I have proposed above.

> > > ---
> > > As most parameters are not documented in documentation/gitweb.txt,
> > > I did not add documentation for this one either.
> >
> > On the other hand IIRC getting list of projects is quite well
> > documented in gitweb manpage (or at least it should be).
> 
> In Documentation/gitweb.txt there is only a list of possible actions, but no
> documentation of any of the other arguments. (none of the order argument
> to project_list nor anything else). If actions like blob_plain do list
> essential arguments like f= then giving this option special rooms does
> not seem to fit very well with the rest.

I was thinking about "Controlling access to git repositories" section in
Documentation/gitweb.txt, but after closer examination I think it wouldn't
fit there.

> >  
> > [...]
> > > @@ -3962,6 +3973,13 @@ sub git_footer_html {
> > >  			              -class => $feed_class}, $format)."\n";
> > >  		}
> > >  
> > > +	} elsif (defined $project_filter) {
> > > +		print $cgi->a({-href => href(project=>undef, action=>"opml",
> > > +		                             project_filter => $project_filter),
> > > +		              -class => $feed_class}, "OPML") . " ";
> > > +		print $cgi->a({-href => href(project=>undef, action=>"project_index",
> > > +		                             project_filter => $project_filter),
> > > +		              -class => $feed_class}, "TXT") . "\n";
> > >  	} else {
> > >  		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> > >  		              -class => $feed_class}, "OPML") . " ";
> > 
> > I wonder if perhaps a better solution wouldn't be to use -replay=>1 in
> > generating projects list in other formats (OPML and TXT).
> 
> Wouldn't that also replay options like "order"?

Right.  My mistake.


Anyway

+		print $cgi->a({-href => href(project=>undef, action=>"opml",
+		                             project_filter => $project_filter),
+		              -class => $feed_class}, "OPML") . " ";
+		print $cgi->a({-href => href(project=>undef, action=>"project_index",
+		                             project_filter => $project_filter),
+		              -class => $feed_class}, "TXT") . "\n";

would do the right thing because of the way href() works when passed
key-value pair with undefined key.

In other words there is no need for conditional; just add 

   project_filter => $project_filter

and href() would do the right thing.
-- 
Jakub Narebski
Poland
