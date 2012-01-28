From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/2] gitweb: add project_filter to limit project list to a subdirectory
Date: Sat, 28 Jan 2012 14:45:28 -0800 (PST)
Message-ID: <m3wr8bcuon.fsf@localhost.localdomain>
References: <20120128165606.GA6770@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Jan 28 23:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrH1v-00006O-FC
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 23:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab2A1Wpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 17:45:31 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40618 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2A1Wpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 17:45:30 -0500
Received: by eaal13 with SMTP id l13so666514eaa.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gpg3OJ95TJm6dVkT6qgCE3n81Y2mqwsKKQ4NOCkWtAQ=;
        b=QFvA8IW+nKjE/GzbkjLeKWPl2lqjZfHsaVUq1tchDRNL0VQq1MBYO1j4Tg8Mn82p3M
         h0nKEkN+zci1WjDk9JXF+B2NpEjTOy2sF6SKpFZPTBpR6LXuE6Bddb/vyicZ8QMTmH1r
         RZ7Z/EOusLsYXtBwjPzi3mBMzD0LLDQ6TunC0=
Received: by 10.213.29.2 with SMTP id o2mr1903492ebc.54.1327790729029;
        Sat, 28 Jan 2012 14:45:29 -0800 (PST)
Received: from localhost.localdomain (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id x4sm49855306eeb.4.2012.01.28.14.45.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 14:45:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0SMk1mM012945;
	Sat, 28 Jan 2012 23:46:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0SMk03v012942;
	Sat, 28 Jan 2012 23:46:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120128165606.GA6770@server.brlink.eu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189267>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> This commit changes the project listings (project_list, project_index
> and opml) to limit the output to only projects in a subdirectory if the
> new optional parameter ?pf=directory name is used.
> 
"project listings" to "projects listing views", isn't it?

> The change is quite minimal as git_get_projects_list already can limit
> itself to a subdirectory (though that was previously only used for
> 'forks').
>
Nice description, and more clear than before.
 
> If strict_export is enabled and there is no projects_list, it still
> traverses the full tree and only filters afterwards to avoid anything
> getting visible by this. Otherwise only the subtree needs to be
> traversed, significantly reducing load times.
>
I still don't understand interaction between project_filter ('pf'),
$strict_export and $projects_list being either directory or a file
with a list of projects.

Does it mean, that when $projects_list is a file with a list of projects,
and we use project_filter, then:

* if $strict_export is false, then $project_list is ignored, and the
  filtered list of projects is created by scanning
  "$projectroot/$project_filter"

* if $strict_export is true, then $project_list file is read in full,
  and then filtered to project with $project_filter as prefix
 
Is it correct?  Is it sane, stated this way?

> Reusing $project instead of adding a new parameter would have been
> nicer from a UI point-of-view (including PATH_INFO support) but
> would complicate the $project validating code that is currently being
> used to ensure nothing is exported that should not be viewable.
> 
O.K.

Anyway PATH_INFO support can be added in the future, by special casing
situation where project list action is stated using PATH_INFO... I think.


A few nitpicks with respect to patch itself.

> @@ -2827,6 +2835,7 @@ sub git_get_project_url_list {
>  
>  sub git_get_projects_list {
>  	my $filter = shift || '';
> +	my $paranoid = shift || 0;
>  	my @list;
>  

First, undefined value is false in Perl, so there is no need for
" || 0" in setting $paranoid variable.

Second, why not use global variable $strict_export instead of adding
another parameter to git_get_projects_list()?

> @@ -5979,7 +5994,7 @@ sub git_project_list {
>  		die_error(400, "Unknown order parameter");
>  	}
>  
> -	my @list = git_get_projects_list();
> +	my @list = git_get_projects_list($project_filter, $strict_export);
>  	if (!@list) {
>  		die_error(404, "No projects found");
>  	}

[...]

> @@ -3963,9 +3976,11 @@ sub git_footer_html {
>  		}
>  
>  	} else {
> -		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> +		print $cgi->a({-href => href(project=>undef, action=>"opml",
> +		                             project_filter => $project_filter),
>  		              -class => $feed_class}, "OPML") . " ";
> -		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
> +		print $cgi->a({-href => href(project=>undef, action=>"project_index",
> +		                             project_filter => $project_filter),
>  		              -class => $feed_class}, "TXT") . "\n";
>  	}

O.K.

-- 
Jakub Narebski
