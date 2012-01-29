From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 1/2] gitweb: add project_filter to limit project list to a subdirectory
Date: Mon, 30 Jan 2012 00:06:29 +0100
Message-ID: <201201300006.30287.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120129160615.GA13937@server.brlink.eu> <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Bernhard R. Link" <brl+git@mail.brlink.eu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 00:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrdow-0003pL-J8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab2A2XF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:05:58 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55219 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab2A2XF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:05:57 -0500
Received: by eaal13 with SMTP id l13so926431eaa.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=F7RJDuwKpPlikZkJwjnnuHvNMCz+SRfx+Iyax+7nKgk=;
        b=s58JmMm5ihkGqjYDr07WtQzH3gsd9JN/4yR6mb72A6MKXfnaPYLTE7vF5JNKqkhsiN
         z39ZJIt8XBrs+1ryL0SKJG1AwqPiqNNB+vC9u7TqXtyfr1fWv+0yHYBCsEllGpEL1s8m
         PfD94MMsxxA8lYluLvNB+7UO3rEpmKz7RSd/I=
Received: by 10.213.113.144 with SMTP id a16mr2467576ebq.94.1327878356115;
        Sun, 29 Jan 2012 15:05:56 -0800 (PST)
Received: from [192.168.1.13] (abwg78.neoplus.adsl.tpnet.pl. [83.8.230.78])
        by mx.google.com with ESMTPS id n17sm64724178eei.3.2012.01.29.15.05.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 15:05:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189301>

On Sun, 29 Jan 2012, Junio C Hamano wrote:
> "Bernhard R. Link" <brl+git@mail.brlink.eu> writes:
> 
> > This commit changes the project listing views (project_list,
> > project_index and opml) to limit the output to only projects in a
> > subdirectory if the new optional parameter ?pf=directory name is used.
> >
> > The change is quite minimal as git_get_projects_list already can limit
> > itself to a subdirectory (though that was previously only used for
> > 'forks').
> >
> > If there is a GITWEB_LIST file, the contents are just filtered like
> > with the forks action.
> 
> Meaning, a directory is shown if it is listed on GITWEB_LIST and is a
> subdirectory of the directory specified with project_filter?  If so,
> spelling it out instead of saying "just filtered like with the forks
> action" may be clearer without making the description excessively longer.

This means the following:

  If $projects_list point to file with a list of projects, gitweb will
  show only those project on the list which name matches $project_filter
  prefix.

> > Without a GITWEB_LIST file only the given subdirectory is searched
> > for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
> > In the later case GITWEB_PROJECTROOT is traversed normally (unlike
> > with forks) and projects not in the directory ignored.
> 
> It is unclear to me what "In the later case" refers to, even assuming that
> it is a typo of "the latter case".
> 
> Do you mean "When there is no GITWEB_LIST but GITWEB_STRICT_EXPORT is set,
> project_filter that specifies anything outside GITWEB_PROJECTROOT is
> ignored"?

  If $projects_list points to a directory, but $strict_export is true, then
  $project_list is scanned recursively for git repositories, as without
  this feature, but only those projects that begin with $project_filter
  are shown.

  Otherwise ($projects_list points to directory and $strict_export not true)
  then $project_filter subdirectory of $projects_list is scanned recursively
  for git repositories (i.e. starting from "projects_list/$project_filter").
 
I am not sure if this paranoia mode is really needed for $strict_export,
though.

> A more fundamental issue I have with this patch is how an end user starts
> using this. Once project_filter is set, the breadcrumbs would let the user
> click and navigate around, but in my superficial glance at the patch it is
> not apparent how the initial setting of project_filter can happen without
> the user manually adding pf= to the URL, which is a less than ideal end
> user experience.

The second patch in series adds breadcrumbs allowing to filter projects
in any per-project view.

This feature was originally intended for giving handcrafter URL with
'pf=....' to people...

> > @@ -2839,7 +2848,7 @@ sub git_get_projects_list {
> >  		my $pfxlen = length("$dir");
> >  		my $pfxdepth = ($dir =~ tr!/!!);
> >  		# when filtering, search only given subdirectory
> > -		if ($filter) {
> > +		if ($filter and not $paranoid) {
> >  			$dir .= "/$filter";
> >  			$dir =~ s!/+$!!;
> >  		}
> > @@ -2864,6 +2873,10 @@ sub git_get_projects_list {
> >  				}
> >  
> >  				my $path = substr($File::Find::name, $pfxlen + 1);
> > +				# paranoidly only filter here
> > +				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
> > +					next;
> > +				}
> 
> When you find "foo" directory and a project_filter tells you to match
> "foo", because $path does not match "^foo/", it will not match (even
> though its subdirectory "foo/bar" would)?

Strictly speaking the match is on dirname of a project path; the basename
of a project does not matter.  It is intended, but perhaps should be made
more clear in the commit message.
 
> > +sub print_nav_breadcrumbs_path {
> > +	my $dirprefix = undef;
> > +	while (my $part = shift) {
> > +		$dirprefix .= "/" if defined $dirprefix;
> > +		$dirprefix .= $part;
> > +		print $cgi->a({-href => href(project => undef,
> > +		                             project_filter => $dirprefix,
> > +					     action=>"project_list")},
> > +			      esc_html($part)) . " / ";
> > +	}
> > +}
> > +
> >  sub print_nav_breadcrumbs {
> >  	my %opts = @_;
> >  
> > @@ -3841,6 +3866,8 @@ sub print_nav_breadcrumbs {
> >  			print " / $opts{-action_extra}";
> >  		}
> >  		print "\n";
> > +	} elsif (defined $project_filter) {
> > +		print_nav_breadcrumbs_path(split '/', $project_filter);
> >  	}
> >  }
> 
> Hmm.
> 
> While this may not be wrong, I wonder if this is limiting a useful feature
> too narrowly. When I visit "/pub/scm /linux/kernel/git/torvals/linux.git"
> at git.kernel.org, for example, there currently are two links, "/pub/scm"
> to the toplevel and "/linux/kernel/git/torvals/linux.git" to itself. I
> often wish to see uplinks to intermediate levels like "/linux/kernel/git"
> and "/linux/kernel/git/torvalds".
> 
> Perhaps that is the topic of your second patch. I dunno.

Yes, it is.

-- 
Jakub Narebski
Poland
