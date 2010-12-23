From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v7 1/9] gitweb: Go to DONE_REQUEST rather than
 DONE_GITWEB in die_error
Date: Wed, 22 Dec 2010 19:55:40 -0600
Message-ID: <20101223015540.GA14585@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235459.7998.43333.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 02:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVaPO-0003ZO-3j
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 02:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab0LWBzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 20:55:52 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37643 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab0LWBzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 20:55:51 -0500
Received: by gwj20 with SMTP id 20so3362816gwj.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WdicaNnBghmOjjXqPGA8BBPt7PqMG3yd+91UhUM32CA=;
        b=Ep0YiMcy4B7IByTzm0LxS3Q7Kj6525BV+a+MeqmCLcPS00efLJssXwcJsExn7QuxNJ
         wfMSqq6YMpfwhVKWjX6UBr0M5tx8hABcYTbsF63drwbFgG6ytlfmTAv3cS6LpQIuxo9E
         lKk3M6reoyqDMg81jEgX+tUqySRqMnhsl0uPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KrQfCnHAXf/pchfXXdD1OKpPrnBxB8g9vKF7cFzFna5ny8s+e8Vz18TmOkMtLUheN1
         yUHs/9wOFd9uXMAio6QxRINSxu2dT6ukEvS/j5lA0zBkKoFdH1XQ/mfnGwbAvFObdgjN
         mg+ORHJz3N2c67to/ph+t/DCCovslD8CogITs=
Received: by 10.150.57.4 with SMTP id f4mr12033736yba.285.1293069350630;
        Wed, 22 Dec 2010 17:55:50 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id i22sm4012984yhd.42.2010.12.22.17.55.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 17:55:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101222235459.7998.43333.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164116>

Jakub Narebski wrote:

> End the request after die_error finishes, rather than exiting gitweb
> instance
[...]
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1169,6 +1169,7 @@ sub run {
>  
>  		run_request();
>  
> +	DONE_REQUEST:
>  		$post_dispatch_hook->()
>  			if $post_dispatch_hook;
>  		$first_request = 0;
> @@ -3767,7 +3768,7 @@ EOF

[side note: the "@@ EOF" line above would say "@@ sub die_error {" if
userdiff.c had perl support and gitattributes used it.]

>  	print "</div>\n";
>  
>  	git_footer_html();
> -	goto DONE_GITWEB
> +	goto DONE_REQUEST
>  		unless ($opts{'-error_handler'});

This seems to remove the last user of the DONE_GITWEB label.  Why not
delete the label, too?

When die_error is called by CGI::Carp (via handle_errors_html), it
does not rearm the error handler afaict.  Previously that did not
matter because die_error kills gitweb; now should it be set up
again?

die_error gets called when server load is too high; I wonder whether
it is right to go back for another request in that case.

A broken per-request (or other) configuration could potentially leave
a gitweb process in a broken state, and until now the state would be
reset on the first error.  I wonder if escape valve would be needed
--- e.g., does the CGI harness take care of starting a new gitweb
process after every couple hundred requests or so?

Aside from those (minor) worries, this patch seems like a good idea.
