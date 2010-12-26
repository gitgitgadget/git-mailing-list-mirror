From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v7 1/9] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error
Date: Sun, 26 Dec 2010 23:25:50 +0100
Message-ID: <201012262325.51585.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <201012252314.22541.jnareb@gmail.com> <20101226095054.GB21588@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 23:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWz2g-0005Ce-NX
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 23:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0LZW0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 17:26:06 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58786 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab0LZW0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 17:26:04 -0500
Received: by fxm20 with SMTP id 20so8806572fxm.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=owAC/vjQAYpbkgiaRQD/B7bOgdehpw5qFYfaVGM6t3c=;
        b=Tedk93ndL8z+pau14fPPUm/gOvhZxXTsBdD5vBUKVUPbDz04ga0RZbWBCpbP2DL2HC
         65ImIxN61Zsjd2reeg5fyvnrDMMf7u7XvAx9HjPI4VsiP0Tg/7liZWo2xJAdVSf1IPE4
         0O8y4rAqlSmZi1zMiXFMIJUKd0Lvr+AUP/ueU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nXz9HtwtgVOSxrSbQZmK2SfCEvMyxZ5gecnSGFIJZOfQYwBJUN7W23p4bpr84J7/5Z
         dLki/zs2yqUYXJH2KIVpMa8yrwwlORBUJiGnA6yvz0lofCd5PvhYmpstCqrbPKVe81nM
         G63KzVD8KAVOhSNeuv4SW5V/N4FN5TlDJuY0Q=
Received: by 10.223.79.68 with SMTP id o4mr1253236fak.0.1293402362896;
        Sun, 26 Dec 2010 14:26:02 -0800 (PST)
Received: from [192.168.1.13] (abwr69.neoplus.adsl.tpnet.pl [83.8.241.69])
        by mx.google.com with ESMTPS id e6sm2843143fav.32.2010.12.26.14.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 14:26:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101226095054.GB21588@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164201>

On Sun, 26 Dec 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
>> On Thu, 23 Dec 2010, Jonathan Nieder wrote:
 
>>> die_error gets called when server load is too high; I wonder whether
>>> it is right to go back for another request in that case.
>>
>> If client (web browser) are requesting connection, we have to tell it
>> something anyway.
> 
> Right, I should have thought a few seconds more.  Respawning
> gitweb.perl would generate _more_ load[1].

> [1] I can imagine scenarios in which exiting gitweb would help
> alleviate the load, involving:
> 
>  - large memory footprint for each gitweb process forcing the system
>    into swapping (e.g., from a memory leak), or
>  - FastCGI-like server noticing the load and choosing to decrease the
>    number of gitweb instances.
> 
> In the usual case, presumably gitweb memory footprint is small and
> FastCGI-like servers limit the number of gitweb instances to a modest
> fixed number.

I assume that CGI / FastCGI / mod_perl (+ ModPerl::Registry) web server
would know how to regulate number of workers according to the server
load.
 
>>> A broken per-request (or other) configuration could potentially leave
>>> a gitweb process in a broken state,
> [...]
>> 'die $@ if $@' would call CORE::die, which means it would end gitweb
>> process.
> 
> This is referring to a later patch?

I'm sorry I haven't made myself clear.

What I meant here is that gitweb includes the following code

	if (-e $GITWEB_CONFIG) {
		do $GITWEB_CONFIG;
		die $@ if $@;
	}

which means that CGI::Carp::die is called, which might call 
handle_errors_html, and which ends in CORE::die, which ends gitweb
process.  So if there is no way for broken configuration to leave
gitweb in a rboken state _at this point in series_.

Thank you for thinking about this, because it could cause problems
(could because I have not checked if it does or if it doesn't) in the
following patch, when gitweb uses eval / die for error handling.
Then it might happen when $per_request_config is false or CODE that
instead of trying to reread broken config on subsequent requests, we
will run with broken config.  It depends if "die"-ing in 
evaluate_gitweb_config would prevent setting $first_request to false.
I'd have to check that.

>> For CGI server it doesn't matter anyway, as for each request the process
>> is respawned anyway (together with respawning Perl interpreter), and I
>> think that ModPerl::Registry and FastCGI servers monitor process that it
>> is to serve requests, and respawn it if/when it dies.
> 
> Sorry, that was unclear of me.  I meant that buggy configuration could
> leave a gitweb process in buggy but alive state and frequent failing
> requests might be a way to notice that.  Contrived example (just to
> illustrate what I mean):
> 
> 	our $version .= ".custom";
> 	if (length $version>= 1000) {	# untested, buggy code goes here.
> 		@diff_opts = ("--nonsense");
> 	}
> 
> I think I was not right to worry about this, either.  It is better to
> make such unusual and buggy configurations as noticeable as possible
> so they can be fixed.

See above.

> [...]
>> But actually handle_errors_html gets called only from fatalsToBrowser,
>> which in turn gets called from CGI::Carp::die... which ends calling
>> CODE::die (aka realdie), which ends CGI process anyway.
>>
>> That is why die_error ends with
>> 
>>	goto DONE_GITWEB
>>		unless ($opts{'-error_handler'});
>> 
>> i.e. it doesn't goto DONE_GITWEB nor DONE_REQUEST if called from
>> handle_errors_html anyway.
> [...]
>> Thanks a lot for your comments.

Which should make it in either commit message, or comments, I guess.
 
> Thanks for a thorough explanation.  For what it's worth, with or
> without removal of the DONE_GITWEB: label,
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-- 
Jakub Narebski
Poland
