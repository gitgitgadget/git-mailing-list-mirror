From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on
 pathinfo-style project URLs
Date: Sat, 13 Dec 2008 20:43:50 -0500
Message-ID: <1229219030.3360.44.camel@mattlaptop2.local>
References: <1229195421.3943.8.camel@mattlaptop2.local>
	 <1229202689.31181.1.camel@mattlaptop2.local>
	 <m3tz97g329.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 02:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBg2h-0006XV-4z
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 02:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYLNBnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 20:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYLNBnx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 20:43:53 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:41432 "EHLO
	jankymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751087AbYLNBnx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 20:43:53 -0500
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a2.g.dreamhost.com (Postfix) with ESMTP id CC272B6A40;
	Sat, 13 Dec 2008 17:43:51 -0800 (PST)
In-Reply-To: <m3tz97g329.fsf@localhost.localdomain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103038>

On Sat, 2008-12-13 at 13:47 -0800, Jakub Narebski wrote:
> Errr... I see that it adds trailing slash only for project-only
> path_info links, but the commit message was not entirely clear for me.

I will clarify the message.

> BTW. encoding data in position in array feels a bit hacky to me, but
> I guess that is the limitation of current %feature design, with
> 'default' having to be array (reference).
> 
> >  	# Note that you will need to change the default location of CSS,
> >  	# favicon, logo and possibly other files to an absolute URL. Also,
> >  	# if gitweb.cgi serves as your indexfile, you will need to force
> > @@ -829,8 +834,8 @@ sub href (%) {
> >  		}
> >  	}
> >  
> > -	my $use_pathinfo = gitweb_check_feature('pathinfo');
> > -	if ($use_pathinfo) {
> > +	my @use_pathinfo = gitweb_get_feature('pathinfo');
> 
> Why not name those variables for better readability?
> 
> +       my ($use_pathinfo, $trailing_slash) = gitweb_get_feature('pathinfo');

I'll do that.

> > +	if ($use_pathinfo[0]) {
> >  		# try to put as many parameters as possible in PATH_INFO:
> >  		#   - project name
> >  		#   - action
> > @@ -845,7 +850,12 @@ sub href (%) {
> >  		$href =~ s,/$,,;
> >  
> >  		# Then add the project name, if present
> > -		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
> > +		my $proj_href = undef;
> > +		if (defined $params{'project'}) {
> > +			$href .= "/".esc_url($params{'project'});
> > +			# Save for trailing-slash check below.
> > +			$proj_href = $href;
> > +		}
> >  		delete $params{'project'};
> >  
> >  		# since we destructively absorb parameters, we keep this
> > @@ -903,6 +913,10 @@ sub href (%) {
> >  			$href .= $known_snapshot_formats{$fmt}{'suffix'};
> >  			delete $params{'snapshot_format'};
> >  		}
> > +
> > +		# If requested in the configuration, add a trailing slash to a URL that
> > +		# has nothing appended after the project path.
> > +		$href .= '/' if ($use_pathinfo[1] && defined $proj_href && $href eq $proj_href);
> >  	}
> 
> The check _feels_ inefficient.  I think (but feel free to disagree) that
> it would be better to use something like $project_pathinfo, set it
> when adding project as pathinfo, and unset if we add anything else as
> pathinfo.

I considered doing that, but I decided that not having to litter the
preceding code with manipulation of $project_pathinfo outweighed
whatever negligible performance difference there might be.

> > +		if ($use_pathinfo[0]) {
> >  			$action .= "/".esc_url($project);
> > +			# Add a trailing slash if requested in the configuration.
> > +			$action .= '/' if ($use_pathinfo[1]);
> 
> Hmmm... let me check something... you rely on the fact that $project
> doesn't end with slash, while I think (but please check it) that it
> can end with slash if it is provided by CGI query.

You are right; in fact, this is already a problem for the strict_export
check.  Gitweb should probably strip trailing slashes when it reads the
"p" parameter.  I will submit a separate patch for that.

-- 
Matt
