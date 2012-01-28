From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/2] gitweb: place links to parent directories in page header
Date: Sat, 28 Jan 2012 14:54:55 -0800 (PST)
Message-ID: <m3sjizcu8x.fsf@localhost.localdomain>
References: <20120128165606.GA6770@server.brlink.eu>
	<20120128165753.GA6795@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Jan 28 23:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrHB8-0002xa-8X
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 23:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2A1Wy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 17:54:57 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46278 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2A1Wy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 17:54:57 -0500
Received: by eekc14 with SMTP id c14so986601eek.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0m6YOEjCqDN7Gcaxh4QHrPhtWfeVT4vjyKZi4IGT5/o=;
        b=T9obXOs3YMw3IvXpZALffTvJHBafAs0Qj7xGkzaWs7JCExSdqJ9Y6tk/DjjV3DcFEY
         rPVzuyrnPYZq82jT8nlu3RLDzVQO9nMN89UUAz7K6mZ/pDSEtF2MNCYkAzaWNEIh+VB7
         kZS0tMqF24V7QChJLl15T7Pmr2FsYV0FY10hg=
Received: by 10.14.13.129 with SMTP id b1mr857019eeb.41.1327791295830;
        Sat, 28 Jan 2012 14:54:55 -0800 (PST)
Received: from localhost.localdomain (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id o49sm1328474eeb.7.2012.01.28.14.54.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 14:54:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0SMtR1c013059;
	Sat, 28 Jan 2012 23:55:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0SMtQOY013056;
	Sat, 28 Jan 2012 23:55:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120128165753.GA6795@server.brlink.eu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189268>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

Description?

> Signed-off-by: Bernhard R. Link <brlink@debian.org>
> 
> ---
> This patch was not yet part of v1.
> 
> I'm not sure this if having this as seperate patch or merged into 1/2
> makes more sense.

While adding links that lead to gitweb URLs with project_filter
parameter set, i.e. linking new feature in, could be postponed to a
later commit, I think some way of notifying client that project list
is filtered would be better to have in 1/2.
 
>  gitweb/gitweb.perl |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a114bd4..ddce27d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3841,7 +3841,18 @@ sub print_nav_breadcrumbs {
>  
>  	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
>  	if (defined $project) {
> -		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
> +		my @dirname = split '/', $project;
> +		my $projectbasename = pop @dirname;
> +		my $dirprefix = undef;
> +		while (my $part = shift @dirname) {
> +			$dirprefix .= "/" if defined $dirprefix;
> +			$dirprefix .= $part;
> +			print $cgi->a({-href => href(project => undef,
> +			                             project_filter => $dirprefix,
> +			                             action=>"project_list")},
> +			              esc_html($part)) . " / ";
> +		}
> +		print $cgi->a({-href => href(action=>"summary")}, esc_html($projectbasename));
>  		if (defined $action) {
>  			my $action_print = $action ;
>  			if (defined $opts{-action_extra}) {

Nice solution.

> @@ -3854,6 +3865,16 @@ sub print_nav_breadcrumbs {
>  			print " / $opts{-action_extra}";
>  		}
>  		print "\n";
> +	} elsif (defined $project_filter) {
> +		my @dirname = split '/', $project_filter;
> +		my $dirprefix = undef;
> +		while (my $part = shift @dirname) {
> +			$dirprefix .= "/" if defined $dirprefix;
> +			$dirprefix .= $part;
> +			print $cgi->a({-href => href(project_filter => $dirprefix,
> +			                             action=>"project_list")},
> +			              esc_html($part)) . " / ";
> +		}
>  	}
>  }

Hmmm... I'd have to check how it looks like, but seems like a good
idea... even if there is a little bit of code duplication.

-- 
Jakub Narebski
