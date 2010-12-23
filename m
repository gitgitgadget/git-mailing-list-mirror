From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v7 2/9] gitweb: use eval + die for error (exception)
 handling
Date: Wed, 22 Dec 2010 20:08:01 -0600
Message-ID: <20101223020801.GB14585@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235525.7998.99816.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 03:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVabH-0008Uk-U8
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 03:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0LWCIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 21:08:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51046 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab0LWCII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 21:08:08 -0500
Received: by ywl5 with SMTP id 5so2452437ywl.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 18:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Og6HWmnu12Prt7mkEQniUB+4swqif4XMrUv2E9Xbqbw=;
        b=KfVJt4Am4E8nRD56gGCR9s3cWfdIhKpix9aYcXH2hKVrDK4xCRUuC+rhqItAjJmuCg
         zJKiFFiAOE/HPV0ZvSAg1+dK7NpJ7eG9mdJt7ZX4yDPehhcXnKtC+sDbaAu13A9tglOs
         nsM9l17UuVtFfW/bgfZka9iRwwY72jssqbvQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vamDsg/L1JaXebIuBd4aG6jsj9FgwtkrbCnvJ0FKPCm1NzMyf3kLxkvluRYKWlxdyY
         WX9x7rqf7ZzDZnZYOVoEjA+syLIpJJ7uietDvCEB4LN6Mi9xfQiUzk3R7zBzMWBiraco
         ++Ciy037DL4gP/HcllFBHTkY5wKeeMQS520hg=
Received: by 10.101.166.33 with SMTP id t33mr4530733ano.83.1293070088104;
        Wed, 22 Dec 2010 18:08:08 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id b27sm11832373ana.8.2010.12.22.18.08.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 18:08:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101222235525.7998.99816.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164117>

Jakub Narebski wrote:

> Gitweb assumes here that exceptions thrown by Perl would be simple
> strings; die_error() throws hash reference (if not for minimal
> extrenal dependencies, it would be probable object of Class::Exception
> or Throwable class thrown).

Hmm, why not throw an object of new type Gitweb::Exception?

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1045,21 +1045,6 @@ sub configure_gitweb_features {
>  	}
>  }
>  
> -# custom error handler: 'die <message>' is Internal Server Error
> -sub handle_errors_html {
> -	my $msg = shift; # it is already HTML escaped
> -
> -	# to avoid infinite loop where error occurs in die_error,
> -	# change handler to default handler, disabling handle_errors_html
> -	set_message("Error occured when inside die_error:\n$msg");
> -
> -	# you cannot jump out of die_error when called as error handler;
> -	# the subroutine set via CGI::Carp::set_message is called _after_
> -	# HTTP headers are already written, so it cannot write them itself
> -	die_error(undef, undef, $msg, -error_handler => 1, -no_http_header => 1);
> -}
> -set_message(\&handle_errors_html);
> -

Hoorah!

>  # dispatch
>  sub dispatch {
>  	if (!defined $action) {
> @@ -1167,7 +1152,11 @@ sub run {
>  		$pre_dispatch_hook->()
>  			if $pre_dispatch_hook;
>  
> -		run_request();
> +		eval { run_request() };
> +		if (defined $@ && !ref($@)) {
> +			# some Perl error, but not one thrown by die_error
> +			die_error(undef, undef, $@, -error_handler => 1);
> +		}

The !ref($@) seems overzealous, which is why I am wondering if it
would be possible to use bless() for a finer-grained check.

>  
>  	DONE_REQUEST:
>  		$post_dispatch_hook->()
> @@ -3768,7 +3757,8 @@ EOF
>  	print "</div>\n";
>  
>  	git_footer_html();
> -	goto DONE_REQUEST
> +
> +	die {'status' => $status, 'error' => $error}
>  		unless ($opts{'-error_handler'});

Is the DONE_REQUEST label still needed?

Thanks, I am happy to see the semantics becoming less thorny.
Jonathan
