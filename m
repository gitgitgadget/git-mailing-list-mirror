From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2 (take 2)] gitweb: Make git_get_refs_list do work of git_get_references
Date: Sun, 17 Sep 2006 12:00:41 +0200
Message-ID: <200609171158.48358.jnareb@gmail.com>
References: <200609170226.39330.jnareb@gmail.com> <200609171057.56467.jnareb@gmail.com> <7vfyeq6dn3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 12:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtRh-0000zq-MO
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 12:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWIQKAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 06:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIQKAH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 06:00:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57752 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964823AbWIQKAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 06:00:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so280063ugd
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 03:00:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:resent-from:resent-to:resent-date:resent-message-id:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=hSkfCOn3JOfddQZyBrDwZrYlSzyLhJ24byftXb8rH8GmKEqcb3T652xAdVgTV5RQ7S1La7oMPaba3MFy0PUt6PxE0f6NmKFD5uBZQ5KbhZlrtWlkU6syNb48gb8qjgSKf1GDdnwTL2/hpwHDRMiBrn+aFnXBcZ0r45qjJ7XHtv0=
Received: by 10.66.221.6 with SMTP id t6mr6509354ugg;
        Sun, 17 Sep 2006 03:00:01 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id z40sm1778594ugc.2006.09.17.03.00.00;
        Sun, 17 Sep 2006 03:00:01 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vfyeq6dn3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27178>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This was supposed to make gitweb performance better, by 
> > (in the case of git_summary) replacing three calls to git-peek-remote
> > (or one reading info/refs and two calls to git-peek-remote) by only 
> > one such a call. ApacheBench shows that after changes summary and tags 
> > views are slower, while heads remains the same or even faster (?).
> 
> That does not give us much confidence in the patch, does it?  If
> it results in cleaner code that is fine, though.

This was because the additional test you proposed for "it is tag if
it is followed by deref" was implemented incorrectly. Corrected in "take 3"
of this patch.

> > @@ -1107,8 +1115,8 @@ sub git_get_refs_list {
> >  		push @reflist, \%ref_item;
> >  	}
> >  	# sort refs by age
> > -	@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
> > -	return \@reflist;
> > +	#@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
> > +	return (\@reflist, \%refs);
> >  }
> 
> I've already said I do not like commented out lines that do not
> say why they are commented out, but I sense something more
> serious here.  Doesn't this removal of sorting affect the
> callers?

Corrected in "take 3" of this patch.

> > @@ -2072,14 +2080,14 @@ sub git_tags_body {
> >  
> >  sub git_heads_body {
> >  	# uses global variable $project
> > -	my ($taglist, $head, $from, $to, $extra) = @_;
> > +	my ($headlist, $head, $from, $to, $extra) = @_;
> >  	$from = 0 unless defined $from;
> > -	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
> > +	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
> >  
> >  	print "<table class=\"heads\" cellspacing=\"0\">\n";
> >  	my $alternate = 0;
> >  	for (my $i = $from; $i <= $to; $i++) {
> > -		my $entry = $taglist->[$i];
> > +		my $entry = $headlist->[$i];
> >  		my %tag = %$entry;
> >  		my $curr = $tag{'id'} eq $head;
> >  		if ($alternate) {
> 
> Unrelated but indeed is a good clean-up.  It was quite confusing
> before (I think this was a result of cut and paste reuse).

And I see that this cleanup is incomplete (%tag = %$entry). Gaah.
Should I split cleanup patch?


> > @@ -2500,7 +2518,7 @@ sub git_tags {
> >  	git_print_page_nav('','', $head,undef,$head);
> >  	git_print_header_div('summary', $project);
> >  
> > -	my $taglist = git_get_refs_list("refs/tags");
> > +	my ($taglist) = git_get_refs_list("tags");
> >  	if (defined @$taglist) {
> >  		git_tags_body($taglist);
> >  	}
> > @@ -2513,9 +2531,9 @@ sub git_heads {
> >  	git_print_page_nav('','', $head,undef,$head);
> >  	git_print_header_div('summary', $project);
> >  
> > -	my $taglist = git_get_refs_list("refs/heads");
> > -	if (defined @$taglist) {
> > -		git_heads_body($taglist, $head);
> > +	my ($headlist) = git_get_refs_list("heads");
> > +	if (defined @$headlist) {
> > +		git_heads_body($headlist, $head);
> >  	}
> >  	git_footer_html();
> >  }
> 
> It always confuses me when people say:
> 
> 	if (defined @$arrayref)

Gaah. It should be either 
	if (defined $arrayref)
or
	if (@$arrayref)
or (if one is truly paranoid) ;-)
	if (defined $arrayref && ref($arrayref) eq "ARRAY" && @$arrayref)

[...]
> You probably would want to grep for 'defined @' and fix them all
> at once.

Will do. Unless someone will do this first.

-- 
Jakub Narebski
Poland
