From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project search
Date: Mon, 5 Mar 2012 10:03:10 +0100
Message-ID: <201203051003.10605.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <201203031156.00948.jnareb@gmail.com> <7vaa3w55i3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 10:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4TpB-0005AK-8o
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 10:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab2CEJDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 04:03:16 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40953 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2CEJDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 04:03:14 -0500
Received: by eekc41 with SMTP id c41so1355435eek.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 01:03:13 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.101.134 as permitted sender) client-ip=10.14.101.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.101.134 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.101.134])
        by 10.14.101.134 with SMTP id b6mr10859143eeg.81.1330938193613 (num_hops = 1);
        Mon, 05 Mar 2012 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=fHjM1UGtBn/2MmCpiS238i5HDFFzhJ4ROdsoqsLTVQQ=;
        b=SbwGkcXbx2PnneNGISny9HSnAT0YKdcXawOQT9l2JOuOKDpoYR8VjWsB6o7aE5iPBS
         N9jbzDkGvp+GRIkqjEAjN4XajR6vBRlxCcDf+VqpM642J3YCZgRm7Ek6TGsGr0ficzH9
         fh/jr/GQbNPu1zkgKYoZMi6SGzhfB6AxD/5zkHBwCblZEnLOKV63SDbhs0feB8T0lPOL
         /0qRCUXuB4ylQSEZ4O2tb/edMjBovgBFOqpKpvHnWbJGKTzG3sqZ0TR8Lc+pNoPZqsiW
         /eATWQkBOyKcoionXvwh9QzDKBp+aCz0bzt13CU1rEHjeGxqRspxra87MrodJyuUh1Qg
         R4kg==
Received: by 10.14.101.134 with SMTP id b6mr8253805eeg.81.1330938193524;
        Mon, 05 Mar 2012 01:03:13 -0800 (PST)
Received: from [192.168.1.13] (abwg221.neoplus.adsl.tpnet.pl. [83.8.230.221])
        by mx.google.com with ESMTPS id z47sm33522319een.5.2012.03.05.01.03.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 01:03:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vaa3w55i3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192216>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > ....  The fix is about adding new code and should
> > apply cleanly to 'maint' and even to older versions; the only trouble
> > with older version might be whitespace issue related to refactoring
> > code into subroutines.
> 
> OK, so the global $searchtext is what came from form submit from the end
> user, while the global $search_regexp is what the code should be using
> for matching throughout the program, prepared by eval-and-validate-params.
> 
> Here is a hand-ported version of your patch that should apply to 1.7.6.6;
> does it look sane?
> 
>  gitweb/gitweb.perl |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 50a835a..d1698b7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2905,10 +2905,10 @@ sub filter_forks_from_projects_list {
>  sub search_projects_list {
>  	my ($projlist, %opts) = @_;
>  	my $tagfilter  = $opts{'tagfilter'};
> -	my $searchtext = $opts{'searchtext'};
> +	my $search_re = $opts{'search_regexp'};
>  
>  	return @$projlist
> -		unless ($tagfilter || $searchtext);
> +		unless ($tagfilter || $search_re);
>  
>  	my @projects;
>   PROJECT:
> @@ -2920,10 +2920,10 @@ sub search_projects_list {
>  				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
>  		}
>  
> -		if ($searchtext) {
> +		if ($search_re) {
>  			next unless
> -				$pr->{'path'} =~ /$searchtext/ ||
> -				$pr->{'descr_long'} =~ /$searchtext/;
> +				$pr->{'path'} =~ /$search_re/ ||
> +				$pr->{'descr_long'} =~ /$search_re/;
>  		}
>  
>  		push @projects, $pr;
> @@ -5097,7 +5097,7 @@ sub git_project_list_body {
>  	@projects = fill_project_list_info(\@projects);
>  	# searching projects require filling to be run before it
>  	@projects = search_projects_list(\@projects,
> -	                                 'searchtext' => $searchtext,
> +	                                 'search_regexp' => $search_regexp,
>  	                                 'tagfilter'  => $tagfilter)
>  		if ($tagfilter || $searchtext);
>  

It looks sane, though 

  	@projects = search_projects_list(\@projects,
 -	                                 'searchtext' => $searchtext,
 +	                                 'search_regexp' => $search_regexp,
  	                                 'tagfilter'  => $tagfilter)
  		if ($tagfilter || $searchtext);

should be better written as

  	@projects = search_projects_list(\@projects,
 -	                                 'searchtext' => $searchtext,
 +	                                 'search_regexp' => $search_regexp,
  	                                 'tagfilter'  => $tagfilter)
 - 		if ($tagfilter || $searchtext);
 + 		if ($tagfilter || $search_regexp);

It is functionally the same, because $search_regexp is derived from
$searchtext, but IMHO it is more clear.

-- 
Jakub Narebski
Poland
