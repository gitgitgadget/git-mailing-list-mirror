From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: selectable configurations that change with each request
Date: Wed, 24 Nov 2010 22:43:20 +0100
Message-ID: <201011242243.20545.jnareb@gmail.com>
References: <20101111213456.21127.36449.stgit@localhost.localdomain> <7vhbf6txi9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Julio Lajara <julio.lajara@alum.rpi.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 22:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLN7l-00077C-5J
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab0KXVn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 16:43:27 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51563 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0KXVn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 16:43:26 -0500
Received: by bwz15 with SMTP id 15so246374bwz.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=N73trSUGOOPUdcpNLb2JMpIEu0FzQotaKr/NDtYfQL0=;
        b=r2fSdOzju1P4Ue3iopUVgxf8fQlfJ/kbTeU9xSx/ZRLAPVZ0A9BSioP37YDw2876OL
         6H5eoLx7+L6e04HerOWnfEjFmcLnsm2ugONrBq54YfGeVC4DiXuFVPJZQPwtSKTs/UFR
         oM8rroNncWbi27s32HwNnEsBdnU6ZMix9mXds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dAyzbe+JEgI5KQZF7kx6bMVFtJar+2IQYZINcH6OgpLUP5aCNOwTFZb4zUkjrxH084
         9QE/R2BDXyuaWzKU1os6RV8+tjLG2Gb1S0G6hxP5bm+TtpalV3HhUiR/qLKMQ2VvCU/+
         0rO8SlPeIb89668gQhRnz7q23MXwTReoKWG+M=
Received: by 10.204.79.144 with SMTP id p16mr2982918bkk.161.1290635005330;
        Wed, 24 Nov 2010 13:43:25 -0800 (PST)
Received: from [192.168.1.13] (abwq109.neoplus.adsl.tpnet.pl [83.8.240.109])
        by mx.google.com with ESMTPS id d27sm3981887bkw.14.2010.11.24.13.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 13:43:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhbf6txi9.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162089>

On Wed, 24 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > The default value for $per_request_config is 1 (true), which means that
> > old configuration that require to change per session (like gitolite's)
> > will keep working.
> >
> > Because there is a call to evaluate_gitweb_config() in the run() subroutine
> > (the call in run_config() is not invoked at first request to avoid double
> > running it), therefore evaluate_git_version() could be moved back there, and
> > is now evaluated only once.
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> I like the "we can keep the old behaviour by default, but you can go
> fancier if you wanted to" attitude of this patch.

Thanks.

> I however am not sure if this particular implementation is regression
> free.  People who wanted the per-request configuration used to be able to
> access what evaluate_uri() did while running evaluate_gitweb_config(),
> which in turn means that their custom configuration could take things like
> my-url and path-info into account, but now for the first invocation they
> cannot.  It probably is just the matter of moving some code around from
> their old custom gitweb-config to a per_request_config sub they need to
> write and point $per_request_config variable at, but that makes "setting 1
> will keep the old behaviour" a false promise, no?

Thanks for catching this; I forgot to take into account the fact that
gitweb config changing with request would need request-related variables.

So instead of code flow looking like this

  evaluate_gitweb_config();
  $first_request = 1;

  while (...) {

  	if ($per_request_config) {
		if (ref($per_request_config) eq 'CODE') {
			$per_request_config->();
		} elsif (!$first_request) {
			evaluate_gitweb_config();
		}
	}

	$first_request = 0;

  }


we would move to

  $first_request = 1;
  while (...) {

  	if ($first_request) {
		evaluate_gitweb_config();
	} elsif ($per_request_config) {
		if (ref($per_request_config) eq 'CODE') {
			$per_request_config->();
		} else {
  			evaluate_gitweb_config();
  		}
	}
	$first_request = 0;

  }


I'll send new version soon.


P.S. if we could assume that nobody ever edits gitweb.cgi directly
to set $per_request_config to non-default value, we could probably
get rid of $first_request variable...
 
> > @@ -1068,12 +1076,18 @@ sub reset_timer {
> >  	our $number_of_git_cmds = 0;
> >  }
> >  
> > +our $first_request = 1;
> >  sub run_request {
> >  	reset_timer();
> >  
> >  	evaluate_uri();
> > -	evaluate_gitweb_config();
> > -	evaluate_git_version();
> > +	if ($per_request_config) {
> > +		if (ref($per_request_config) eq 'CODE') {
> > +			$per_request_config->();
> > +		} elsif (!$first_request) {
> > +			evaluate_gitweb_config();
> > +		}
> > +	}
> >  	check_loadavg();
> >  
> >  	# $projectroot and $projects_list might be set in gitweb config file
> > @@ -1126,6 +1140,10 @@ sub evaluate_argv {
> >  
> >  sub run {
> >  	evaluate_argv();
> > +	evaluate_gitweb_config();
> > +	evaluate_git_version();
> > +
> > +	$first_request = 1;
> >  
> >  	$pre_listen_hook->()
> >  		if $pre_listen_hook;
> > @@ -1139,6 +1157,7 @@ sub run {
> >  
> >  		$post_dispatch_hook->()
> >  			if $post_dispatch_hook;
> > +		$first_request = 0;
> >  
> >  		last REQUEST if ($is_last_request->());
> >  	}
> 

-- 
Jakub Narebski
Poland
