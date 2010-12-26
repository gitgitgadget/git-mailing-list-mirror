From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v7 1/9] gitweb: Go to DONE_REQUEST rather than
 DONE_GITWEB in die_error
Date: Sun, 26 Dec 2010 03:50:54 -0600
Message-ID: <20101226095054.GB21588@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235459.7998.43333.stgit@localhost.localdomain>
 <20101223015540.GA14585@burratino>
 <201012252314.22541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 10:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWnOK-0000lc-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 10:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab0LZJvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 04:51:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55866 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab0LZJvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 04:51:10 -0500
Received: by iyi12 with SMTP id 12so6740956iyi.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 01:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cYMu+aKC+oPnUDBOG1ox/bn/5T83S4rQYaBPiarYXwY=;
        b=NVKIl6rp/ldDeac+J/RWJjxSUeqfPZQLUqA7MrFRYeObkZBUVaGIsecmKUn5Y40pjr
         /4DyJ7MmBDAv9+7C45I+SSZfaMhmLkkltObdxmL3VE6UOLcpi9o5d0iETB9eaDPSrl7o
         uX703+0fp7ludPqQ+5fK+d6txiWkNeY1oxwfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YfEv5zGBbA8Twigp7kSiZUAO3TWtmmvZZvGY9u3Xva1edc5/lEdsOQxrMktdXu2l0J
         co9VMu/8pIVEk+Yk8LDASo9rSrPXCmh5MOz5VE2cwRSHStY2HTdocQkrRD09BSZF+f7+
         /zjEpdDMvkxhh9bnSIcKyUUK+NXLcYpEtDB8A=
Received: by 10.42.171.70 with SMTP id i6mr11145865icz.319.1293357069686;
        Sun, 26 Dec 2010 01:51:09 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 8sm9831500iba.4.2010.12.26.01.51.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 01:51:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012252314.22541.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164185>

Jakub Narebski wrote:
> On Thu, 23 Dec 2010, Jonathan Nieder wrote:

>> This seems to remove the last user of the DONE_GITWEB label.  Why not
>> delete the label, too?
>
> Well, actually this patch is in this series only for the label ;-)
>
> Anyway, I can simply drop this patch, and have next one in series
> (adding exception-based error handling, making die_error work like
> 'die') delete DONE_GITWEB label...

I like the current order (first the brief patch to change the
semantics, then the more ambitious change to an eval {} based error
handling implementation), but it doesn't matter so much.

>> die_error gets called when server load is too high; I wonder whether
>> it is right to go back for another request in that case.
>
> If client (web browser) are requesting connection, we have to tell it
> something anyway.

Right, I should have thought a few seconds more.  Respawning
gitweb.perl would generate _more_ load[1].

>> A broken per-request (or other) configuration could potentially leave
>> a gitweb process in a broken state,
[...]
> 'die $@ if $@' would call CORE::die, which means it would end gitweb
> process.

This is referring to a later patch?

> For CGI server it doesn't matter anyway, as for each request the process
> is respawned anyway (together with respawning Perl interpreter), and I
> think that ModPerl::Registry and FastCGI servers monitor process that it
> is to serve requests, and respawn it if/when it dies.

Sorry, that was unclear of me.  I meant that buggy configuration could
leave a gitweb process in buggy but alive state and frequent failing
requests might be a way to notice that.  Contrived example (just to
illustrate what I mean):

	our $version .= ".custom";
	if (length $version >= 1000) {	# untested, buggy code goes here.
		@diff_opts = ("--nonsense");
	}

I think I was not right to worry about this, either.  It is better to
make such unusual and buggy configurations as noticeable as possible
so they can be fixed.

[...]
> But actually handle_errors_html gets called only from fatalsToBrowser,
> which in turn gets called from CGI::Carp::die... which ends calling
> CODE::die (aka realdie), which ends CGI process anyway.
>
> That is why die_error ends with
> 
>	goto DONE_GITWEB
>		unless ($opts{'-error_handler'});
> 
> i.e. it doesn't goto DONE_GITWEB nor DONE_REQUEST if called from
> handle_errors_html anyway.
[...]
> Thanks a lot for your comments.

Thanks for a thorough explanation.  For what it's worth, with or
without removal of the DONE_GITWEB: label,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[1] I can imagine scenarios in which exiting gitweb would help
alleviate the load, involving:

 - large memory footprint for each gitweb process forcing the system
   into swapping (e.g., from a memory leak), or
 - FastCGI-like server noticing the load and choosing to decrease the
   number of gitweb instances.

In the usual case, presumably gitweb memory footprint is small and
FastCGI-like servers limit the number of gitweb instances to a modest
fixed number.
