From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH]: Allow misc https cert for git-svnimport
Date: Tue, 2 May 2006 14:44:55 -0700
Message-ID: <20060502214455.GA4591@hand.yhbt.net>
References: <200604281801.07155.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue May 02 23:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2fz-0006UN-Hj
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWEBVo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWEBVo4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:44:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51112 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964994AbWEBVoz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 17:44:55 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 81B692DC01A; Tue,  2 May 2006 14:44:55 -0700 (PDT)
To: "P. Christeas" <p_christ@hol.gr>
Content-Disposition: inline
In-Reply-To: <200604281801.07155.p_christ@hol.gr>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19430>

"P. Christeas" <p_christ@hol.gr> wrote:
> Just had to access a server with a broken certificate (self signed), so I 
> added that patch to git-svnimport.

Matthias should know more about git-svnimport than I do :)

I'm not fully up-to-date on how the SVN:: modules work for this, nor do
I know off the top of my head an ssl svn server with a self-signed cert
to test with.  I just copied the ssl stuff off svn-mirror a while ago :)

> --- /usr/bin/git-svnimport	2006-04-13 09:39:39.000000000 +0300
> +++ /home/panos/bin/git-svnimport	2006-04-28 17:55:45.000000000 +0300
> @@ -96,9 +96,14 @@
>  sub conn {
>  	my $self = shift;
>  	my $repo = $self->{'fullrep'};
> -	my $auth = SVN::Core::auth_open ([SVN::Client::get_simple_provider,
> +# 	my $auth = SVN::Core::auth_open ([SVN::Client::get_simple_provider,
> +# 			  SVN::Client::get_ssl_server_trust_file_provider,
> +# 			  SVN::Client::get_ssl_server_trust_prompt_provider(\&_trust_callback),
> +# 			  SVN::Client::get_username_provider]);
> +	my $auth = [SVN::Client::get_simple_provider,
>  			  SVN::Client::get_ssl_server_trust_file_provider,
> -			  SVN::Client::get_username_provider]);
> +			  SVN::Client::get_ssl_server_trust_prompt_provider(\&_trust_callback),
> +			  SVN::Client::get_username_provider];
>  	my $s = SVN::Ra->new(url => $repo, auth => $auth);
>  	die "SVN connection to $repo: $!\n" unless defined $s;
>  	$self->{'svn'} = $s;
> @@ -125,6 +130,45 @@
>  	return $name;
>  }
>  
> +sub _trust_callback {
> +	my ($cred,$realm,$ifailed,$server_cert_info,$may_save) = @_;
> +	#$cred->accepted_failures($SVN::Auth::SSL::UNKNOWNCA);
> +	print "SSL certificate is not trusted: $ifailed \n";
> +	print "Fingerprint: " . $server_cert_info->fingerprint . "\n";
> +	print "Hostname:    ". $server_cert_info->hostname ;
> +	print " (MISMATCH)" if ( $ifailed & $SVN::Auth::SSL::CNMISMATCH);
> +	print "\n";
> +	
> +	print "Valid from:  ". $server_cert_info->valid_from;
> +	print " (NOT YET)" if ( $ifailed & $SVN::Auth::SSL::NOTYETVALID);
> +	print "\n";
> +	
> +	print "Valid until: ". $server_cert_info->valid_until;
> +	print " (EXPIRED)" if ( $ifailed & $SVN::Auth::SSL::EXPIRED);
> +	print "\n";
> +	
> +	print "Issuer:      ". $server_cert_info->issuer_dname;
> +	print " (UNKNOWN)" if ( $ifailed & $SVN::Auth::SSL::UNKNOWNCA);
> +	print "\n\n";
> +	
> +	print "Do you still want to accept that certificate? [y/N] ";
> +	my $accept = <STDIN>;
> +	chomp($accept);
> +	print "\n";
> +	if (($accept eq "y") or ($accept eq "Y" )) {
> +		$cred->accepted_failures($ifailed);
> +	# 	print "Save cert, so that it is accepted in future calls? [y/N] ";
> +	# 	my $mmsave = <STDIN>;
> +	# 	chomp($mmsave);
> +	# 	if (($mmsave eq "y") or ($mmsave eq "Y" )) {
> +	# 		$may_save = 1;
> +	# 	}
> +		print "\n";
> +	}
> +
> +}
> +
> +
>  package main;
>  use URI;
>  


-- 
Eric Wong
