From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] use new Git::config_path() for aliasesfile
Date: Sat, 1 Oct 2011 00:00:11 +0200
Message-ID: <201110010000.13328.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <1317379945-9355-3-git-send-email-cowose@gmail.com> <7vsjndoldq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9l87-00072d-NU
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab1I3WAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:00:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39422 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab1I3WAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:00:21 -0400
Received: by eya28 with SMTP id 28so1433407eya.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cSYHD4CegwaI3XHHAFUjgfwVn+nFXSRQ7pGBMGt7dl0=;
        b=jtVlha7F8Xt4dP7UG9VexEGqjYffauudDxH1BZR6ZdNxEgY0hWmIupJ3V2qjVuK1KE
         X1gWnuuv0Av59FYpnYhbYK7bPvx5hRJH+yCpJsSg7CkTkM4HoIG/7vS/YBCYOAFWaxHO
         9jbYIjL37SccP50KSSbb5Wa3bh/1gUojzToaM=
Received: by 10.223.23.10 with SMTP id p10mr8148939fab.112.1317420019780;
        Fri, 30 Sep 2011 15:00:19 -0700 (PDT)
Received: from [192.168.1.13] (abwd251.neoplus.adsl.tpnet.pl. [83.8.227.251])
        by mx.google.com with ESMTPS id h16sm8499398fab.19.2011.09.30.15.00.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 15:00:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjndoldq.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182513>

On Fri, 30 Sep 2011, Junio C Hamano wrote:

> I think the addition of "config --path" support is a good idea, but the
> resulting code suffers from too many cut&paste cruft across the config*
> family of methods.
> 
> How about doing a bit of refactoring, perhaps something like this, on top
> as a separate patch?

This is a good idea, in my opinion.
 
> I tried to be careful to still forcing the "one value only" for config_bool
> and config_int, but extra sets of eyeballs would be needed.

We do have tests for that, have we?
 
[...]
> +Common subroutine to implement bulk of what the config* family of methods
> +do. This wraps command('config') so it is not so fast.

BTW. I wonder if it wouldn't be a good idea to restart work on Git::Config
with lazy/eager loading of the whole config, like git_get_project_config()
and git_parse_project_config() subroutines from gitweb do it - running 
"git config -z -l".  Though then --int/--bool/--path conversion would have
to be implemented in Perl...
  
>  =cut
>  
> -sub config {
> -	my ($self, $var) = _maybe_self(@_);
> -
> +sub _config_common {
> +	my ($self, $var, $opts) = _maybe_self(@_);
> +	
>  	try {
> -		my @cmd = ('config');
> +		my @cmd = ('config', $opts->{'kind'} ? @{$opts->{'kind'}} : ());

How it is supposed to work?

First, you probably want to check for "exists $opts->{'kind'}", or even
"defined $opts->{'kind'}".

Second, "@{$opts->{'kind'}}" assumes that $opts->{'kind'} is an array
reference (something we didn't check)... and it isn't.


BTW. why do you use hashref?  Do you plan for the future to pass more
options that 'kind'?

>  		unshift @cmd, $self if $self;
>  		if (wantarray) {
>  			return command(@cmd, '--get-all', $var);
> @@ -594,6 +590,21 @@ sub config {
>  			throw $E;
>  		}
>  	};
> +
> +}
> +
> +=item config ( VARIABLE )
> +
> +Retrieve the configuration C<VARIABLE> in the same manner as C<config>
> +does. In scalar context requires the variable to be set only one time
> +(exception is thrown otherwise), in array context returns allows the
> +variable to be set multiple times and returns all the values.
> +
> +=cut
> +
> +sub config {
> +	my ($self, $var) = _maybe_self(@_);
> +	return _config_common($self, $var, +{});

No need to pass an empty hash.  Perl has a feature called autovivification:
when an undefined variable is dereferenced, it gets silently upgraded to
an array or hash reference (depending of the type of the dereferencing).

It is un-Perlish to do so.

>  sub config_bool {
>  	my ($self, $var) = _maybe_self(@_);
[...]
> +	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
> +	return (defined $val && $val eq 'true');
>  }
[...]

>  sub config_path {
>  	my ($self, $var) = _maybe_self(@_);
[...]
> +	return _config_common($self, $var, +{'kind' => '--path'});
>  }

Why the difference between {'kind' => '--bool'} and +{'kind' => '--path'}?

> -This currently wraps command('config') so it is not so fast.
> -

Shouldn't this be mentioned somewhat, even indirectly?

-- 
Jakub Narebski
Poland
