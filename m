From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: prefer git_get_project_owner() over get_file_owner()
Date: Sat, 7 Jul 2007 12:05:18 -0700 (PDT)
Message-ID: <260120.95921.qm@web31806.mail.mud.yahoo.com>
References: <7vzm2ckb3h.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 07 21:12:06 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7FhN-0005LQ-QN
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbXGGTMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbXGGTMA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 15:12:00 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:35939 "HELO
	web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752547AbXGGTL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2007 15:11:59 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2007 15:11:59 EDT
Received: (qmail 96978 invoked by uid 60001); 7 Jul 2007 19:05:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Lv/YEYiL/dnmvGWM+Kd6LUK875PWoJASanyZZhXsE3WJ/Zvflsv2IQycl7LtZBR+qCmOX5xkz1YeYjBBPtRa7YurfIOaGoDY/RVsdjWKF6CWdyWc43bJCrd3UOCX0pZ+SpQVkaWSBk4oAZcv8lckAF/+ugsfzpiRLXK3TVmDdnQ=;
X-YMail-OSG: UGuWLOMVM1mqlB5jn_y506JC6D26ZHNdUN.jvHSGANzg84J0yCQ6tD9lcrWsj0KCJOoYOQ--
Received: from [71.80.231.250] by web31806.mail.mud.yahoo.com via HTTP; Sat, 07 Jul 2007 12:05:18 PDT
In-Reply-To: <7vzm2ckb3h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51835>

--- Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > This way if $projects_list exists, it'll be used, otherwise get_file_owner()
> > will be used as before.
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> 
> The patch looks good to me.
> 
> HOWEVER.
> 
> It strikes me that repeated call to git_get_project_owner()
> would be way too inefficient.  Not caller's fault.
> 
> How about doing something like this on top of your patch?

Yes, this sounds sensible. ACK.

    Luben


> 
>  gitweb/gitweb.perl |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index dbfb044..f114585 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1465,12 +1465,12 @@ sub git_get_projects_list {
>  	return @list;
>  }
>  
> -sub git_get_project_owner {
> -	my $project = shift;
> -	my $owner;
> +our $gitweb_project_owner = undef;
> +sub git_get_project_list_from_file {
>  
> -	return undef unless $project;
> +	return if (defined $gitweb_project_owner);
>  
> +	$gitweb_project_owner = {};
>  	# read from file (url-encoded):
>  	# 'git%2Fgit.git Linus+Torvalds'
>  	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
> @@ -1482,13 +1482,25 @@ sub git_get_project_owner {
>  			my ($pr, $ow) = split ' ', $line;
>  			$pr = unescape($pr);
>  			$ow = unescape($ow);
> -			if ($pr eq $project) {
> -				$owner = to_utf8($ow);
> -				last;
> -			}
> +			$gitweb_project_owner->{$project} = to_utf8($ow);
>  		}
>  		close $fd;
>  	}
> +}
> +
> +sub git_get_project_owner {
> +	my $project = shift;
> +	my $owner;
> +
> +	return undef unless $project;
> +
> +	if (!defined $gitweb_project_owner) {
> +		git_get_project_list_from_file();
> +	}
> +
> +	if (exists $gitweb_project_owner->{$project}) {
> +		$owner = $gitweb_project_owner->{$project};
> +	}
>  	if (!defined $owner) {
>  		$owner = get_file_owner("$projectroot/$project");
>  	}
> 
> 
