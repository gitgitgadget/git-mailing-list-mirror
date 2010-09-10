From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Optimize paging when sorted by path
Date: Fri, 10 Sep 2010 12:24:15 -0700 (PDT)
Message-ID: <m3vd6dl7wq.fsf@localhost.localdomain>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
	<1284135442-10971-2-git-send-email-lkundrak@v3.sk>
	<1284135442-10971-3-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Cx-0007Ht-Mx
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab0IJTYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 15:24:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57404 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0IJTYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:24:17 -0400
Received: by eyb6 with SMTP id 6so1985600eyb.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mDIQW++TxssRxkEuA4SJgdp2EbD6poE69YWmdNjIwwA=;
        b=MRahYSuOxrmkJHccdL8mNit1lnkKLtcf8inUq9vMhq+CvorS3UGUcCnjvqvwfFp/Tz
         HYid3vMiCXtCaLPStdmqXagZEr2aEnirMciWwxhQtHOBFQluNZrTCUbVFs8WzJ1AtKIQ
         SybvVdMV6cywHcLfyfgUEMxYOaUsdT9mZDPJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fOV5pKGwB+TMh9UaIOoBizJ0GZZAOItZM1tdK1WUbId5dEG6nPdWjHnv1QlSO1xqez
         ryXPZL2huVucyaRX0sa/qN6oGbJTiXQRv147V3UC8ys1bAHJ38BLgKvAzmV4unKlO6qU
         oOQZFWYQX2qZrknNg+F5R/2IC1l1y5aSJlh+s=
Received: by 10.213.102.8 with SMTP id e8mr27046ebo.49.1284146656286;
        Fri, 10 Sep 2010 12:24:16 -0700 (PDT)
Received: from localhost.localdomain (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id v59sm4389630eeh.10.2010.09.10.12.24.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:24:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8AJNn2B020966;
	Fri, 10 Sep 2010 21:23:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8AJNYXU020962;
	Fri, 10 Sep 2010 21:23:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1284135442-10971-3-git-send-email-lkundrak@v3.sk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155957>

Lubomir Rintel <lkundrak@v3.sk> writes:

> There's no need to get authors, description and last modification time
> of a project that's not being shown on a current page. We can only tell
> that in advance if the list is sorted by pathname.

More advanced version of this trick can be found in

  [RFC/PATCH] gitweb: Paginate project list
  http://thread.gmane.org/gmane.comp.version-control.git/80896/focus=81613

from 2008-05-10.  Perhaps it would be a good idea to merge these two
patches?

> ---
>  gitweb/gitweb.perl |   47 ++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8dc7f29..a2e9a95 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4608,12 +4608,30 @@ sub format_sort_th {
>  	return $sort_th;
>  }
>  
> +sub git_try_to_order {
> +	my ($projects, $order) = @_;
> +
> +	my %order_info = (
> +		project => { key => 'path', type => 'str' },
> +		descr => { key => 'descr_long', type => 'str' },
> +		owner => { key => 'owner', type => 'str' },
> +		age => { key => 'age', type => 'num' }
> +	);
> +	my $oi = $order_info{$order};
> +	return undef unless exists $projects->[0]->{$oi->{'key'}};

Nitpick: there is no need to use '->' between [0] and {$oi->{'key'}}.
BTW is this sanity check necessary?

> +	if ($oi->{'type'} eq 'str') {
> +		@$projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projects;
> +	} else {
> +		@$projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projects;
> +	}
> +	return 1;
> +}

Note that separating this part of code into subroutine is a good idea
anyway, even if the final patch would look different.

> +
>  sub git_project_list_body {
>  	# actually uses global variable $project
>  	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
>  
>  	my $check_forks = gitweb_check_feature('forks');
> -	my @projects = fill_project_list_info($projlist, $check_forks);
>  
>  	$order ||= $default_projects_order;
>  	$page ||= 0;
> @@ -4622,26 +4640,29 @@ sub git_project_list_body {
>  		$to = $from + $projects_per_page - 1 unless defined $to;
>  	}
>  	$from = 0 unless defined $from;
> -	$to = $#projects if (!defined $to || $#projects < $to);
> +	$to = $#$projlist if (!defined $to || $#$projlist < $to);
>  
>  	my $prev_link = $cgi->a({-href => href(-replay=>1, page=>$page-1),
>  		 -accesskey => "p", -title => "Alt-p"}, "prev") if ($page > 0);
>  	my $next_link = $cgi->a({-href => href(-replay=>1, page=>$page+1),
>  		 -accesskey => "n", -title => "Alt-n"}, "next") if ($#$projlist > $to);
>  
> -	my %order_info = (
> -		project => { key => 'path', type => 'str' },
> -		descr => { key => 'descr_long', type => 'str' },
> -		owner => { key => 'owner', type => 'str' },
> -		age => { key => 'age', type => 'num' }
> -	);
> -	my $oi = $order_info{$order};
> -	if ($oi->{'type'} eq 'str') {
> -		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
> -	} else {
> -		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
> +	# If we're paginating and can order the list now (by pathname), we
> +	# don't need to do an unnecessary and expensive query of the details
> +	# of the projects we're not going to display. Attempt the sort and
> +	# remove the other projects from the list if the sort is successful.
> +	# Can't be used with ctags, since it needs a complete project list.
> +	my $ordered = git_try_to_order($projlist, $order)
> +		unless gitweb_check_feature('ctags');
> +	if ($ordered) {
> +		@$projlist = @$projlist[$from..$to];
> +		$to -= $from;
> +		$from = 0;
>  	}
>  
> +	my @projects = fill_project_list_info($projlist, $check_forks);
> +	git_try_to_order(\@projects, $order) unless $ordered;
> +
>  	my $show_ctags = gitweb_check_feature('ctags');
>  	if ($show_ctags) {
>  		my %ctags;
> -- 
> 1.7.2.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
