From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Refactor git_header_html
Date: Wed, 22 Jun 2011 08:44:34 +0200
Message-ID: <201106220844.35431.jnareb@gmail.com>
References: <20110621183550.9315.21922.stgit@localhost.localdomain> <7v4o3i7nkt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 08:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZHBF-0000al-8T
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 08:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab1FVGos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 02:44:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59933 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab1FVGor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 02:44:47 -0400
Received: by fxm17 with SMTP id 17so421991fxm.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=zDAjMqB5mWirSqe/3IAJ60p66lWq9syf0ZPUsDAzo1Y=;
        b=FsleMdiPX5BMrElEEZerGdNZk11HzFbYzK4ufd5xz4AVvDIqJ9e5GvyGokd+qc3Fu4
         f0VsbLMMp45aTmmcwl0gaaQ2k7qdJLCDojP9Z3fsKzR8eUrvHWe6/8I4SoPoLX4/SHSR
         HqwrWVj/LQyhtrg5zML8vt+9ijVDNlq7N6I3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HlLD0ai5AZi985DGQI2neDgR8rayzLN9eU4GgeYpGLU88VGG8RG113P7ODBXv0FsrV
         RrId8isJpftPQ7E6geEJiINiwepZJ8xcI/TSNegPyylA82Q3hmoxDCJh0FkOcqueU9SF
         y7TC1KwpwbX9apr50QEfZmNEeum0hun91FuK8=
Received: by 10.223.56.24 with SMTP id w24mr355518fag.131.1308725086154;
        Tue, 21 Jun 2011 23:44:46 -0700 (PDT)
Received: from [192.168.1.15] (abvd183.neoplus.adsl.tpnet.pl [83.8.201.183])
        by mx.google.com with ESMTPS id h1sm116417fag.35.2011.06.21.23.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 23:44:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4o3i7nkt.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176222>

On Wed, 22 Jun 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > P.S. I wonder if print_search_form() should also get passed %opts as
> > one of its parameters...
> 
> I do not particularly care for this:
> 
> 	sub foo {
>         	my %opts = @_;
> 
> 		if ($opts{-option} eq 'bar') {
>                 	... do this ...
> 
> style, which lets a caller pass any random typo to the callee, like so:
> 
> 	foo(-optoin => 'value');
> 
> But maybe it is just me.

Well, originally this style was used mainly to pass some extra rarely
set boolean flags; isn't

        foo($bar, "baz", -quux => 1, -corge => 1);

better than

        foo($bar, "baz", 1, 0, 1);

when it is ordinarily (most times) called as

        foo($bar, "baz");


When writing in C, one would probably use #defines for this:

        foo(bar, "baz", FOO_QUUX | FOO_CORGE);

but it is not very Perl-ish, I would think.

> > +sub print_header_links {
> > +	my %opts = @_;
> > +
> > +	# print out each stylesheet that exist, providing backwards capability
> > +	# for those people who defined $stylesheet in a config file
> > +	if (defined $stylesheet) {
> > +		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
> > +	} else {
> > +		foreach my $stylesheet (@stylesheets) {
> > +			next unless $stylesheet;
> > +			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
> > +		}
> > +	}
> > +	if ($opts{'-feed'}) {
> > +		print_feed_meta();
> > +	}
> 
> Here, we refrain from showing the <link> elements that are related to the
> RSS/Atom feeds (if we know what $project we are talking about), or <link>
> elements that are related to the project list (html top page and opml) if
> we are not showing a normal return, as $opts{'-feed'} is true only when we
> are returning '200 OK'.
> 
> The original implementation, even though it used statement modifiers after
> this print_feed_meta(), was much easier to follow, at least for me. The
> association between "feed-meta" and "200 OK" was close together and more
> direct.

Hmmm... perhaps then I should have gone with my first thought, namely
passing $status to print_header_links().  

Will resend.


Note that in case of print_nav_breadcrumbs() the code used %opts
originally, so it is only passed from git_header_html...

> > ...
> > -		}
> > -	}
> > -	print_feed_meta()
> > -		if ($status eq '200 OK');
> 
> Other than that, this looks a correct no-op patch that makes the resulting
> smaller functions easier to grok.

Thanks. 

-- 
Jakub Narebski
Poland
