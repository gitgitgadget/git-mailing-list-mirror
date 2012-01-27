From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Fri, 27 Jan 2012 14:33:10 -0800 (PST)
Message-ID: <m31uqkepx6.fsf@localhost.localdomain>
References: <20120126144517.GA4229@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Fri Jan 27 23:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RquMB-0002aY-8z
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 23:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab2A0WdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 17:33:14 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57068 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2A0WdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 17:33:12 -0500
Received: by eekc14 with SMTP id c14so720557eek.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 14:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Hkj7QQfSUrgxMc/RYYyOmDSvky9lW9CrR9nrPu3tv6U=;
        b=iUEUppeld4QnWT6WD6EYf5Y572Efhpd9UpibLuM7k0yl1pn2qLluQQndiZQulkq16v
         7WLzrwB2wEqbp1ZfkRuLvx5fLGBWKofwcpctiUcDjBAcvpQaXlByg61afaj7pgPAn7o7
         P2YD+54UCP9rtj6W3ouvareBHHMxrluTKOzSU=
Received: by 10.14.8.210 with SMTP id 58mr1033538eer.94.1327703591454;
        Fri, 27 Jan 2012 14:33:11 -0800 (PST)
Received: from localhost.localdomain (abvs200.neoplus.adsl.tpnet.pl. [83.8.216.200])
        by mx.google.com with ESMTPS id n17sm35120850eei.3.2012.01.27.14.33.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 14:33:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0RMXgFc030197;
	Fri, 27 Jan 2012 23:33:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0RMXfuZ030194;
	Fri, 27 Jan 2012 23:33:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120126144517.GA4229@server.brlink.eu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189240>

"Bernhard R. Link" <brl+list+git@mail.brlink.eu> writes:

> This commit changes the project listings (project_list, project_index
> and opml) to limit the output to only projects in a subdirectory if the
> new optional parameter ?pf=directory name is used.

Could you explain why you want this feature, and why for example
project search just does not cut it?
 
> It uses the infrastructure already there for 'forks' (which also filters
> projects but needs a project called like the filter directory to work).

It is not entirely clear for me that what you mean here is (I think)
that using

  git_get_projects_list($project_filter);

just works thanks to forks filtering infrastructure.

> This feature is disabled if strict_export is used and there is no
> projects_list to avoid showing more than intended.
> Without strict_export enabled this change should not show any projects
> one could not get details from anyway. So if the validate_pathname
> checks are not sufficient this would at most make it easier to get a
> list of viewable content.

I don't wuite understand this reasoning.  Why project filtering is
disabled with strict_export?  It should just filter, regardless if
project are from scanning $project_filter subdirectory, or filtering
out project names from $projects_list file that do not begin with
$project_filter prefix.
 
> Reusing $project instead of adding a new parameter would have been
> nicer from a UI point-of-view (including PATH_INFO support) but
> complicate the $project validating code that is currently being
> used to ensure nothing is exported that should not be viewable.

That is I think quite reasonable.
 
> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> 
> ---
> As most parameters are not documented in documentation/gitweb.txt,
> I did not add documentation for this one either.

On the other hand IIRC getting list of projects is quite well
documented in gitweb manpage (or at least it should be).
 
[...]
> @@ -3962,6 +3973,13 @@ sub git_footer_html {
>  			              -class => $feed_class}, $format)."\n";
>  		}
>  
> +	} elsif (defined $project_filter) {
> +		print $cgi->a({-href => href(project=>undef, action=>"opml",
> +		                             project_filter => $project_filter),
> +		              -class => $feed_class}, "OPML") . " ";
> +		print $cgi->a({-href => href(project=>undef, action=>"project_index",
> +		                             project_filter => $project_filter),
> +		              -class => $feed_class}, "TXT") . "\n";
>  	} else {
>  		print $cgi->a({-href => href(project=>undef, action=>"opml"),
>  		              -class => $feed_class}, "OPML") . " ";

I wonder if perhaps a better solution wouldn't be to use -replay=>1 in
generating projects list in other formats (OPML and TXT).

> @@ -5979,7 +5997,7 @@ sub git_project_list {
>  		die_error(400, "Unknown order parameter");
>  	}
>  
> -	my @list = git_get_projects_list();
> +	my @list = git_get_projects_list($project_filter);
>  	if (!@list) {
>  		die_error(404, "No projects found");
>  	}
> @@ -6018,7 +6036,7 @@ sub git_forks {
>  }
>  
>  sub git_project_index {
> -	my @projects = git_get_projects_list();
> +	my @projects = git_get_projects_list($project_filter);
>  	if (!@projects) {
>  		die_error(404, "No projects found");
>  	}
> @@ -7855,7 +7873,7 @@ sub git_atom {
>  }
>  
>  sub git_opml {
> -	my @list = git_get_projects_list();
> +	my @list = git_get_projects_list($project_filter);
>  	if (!@list) {
>  		die_error(404, "No projects found");
>  	}

Nice!

-- 
Jakub Narebski
