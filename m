From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: add output buffering and associated functions
Date: Thu, 28 Oct 2010 02:56:35 -0700 (PDT)
Message-ID: <m3bp6eiqu5.fsf@localhost.localdomain>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
	<1288226574-19068-3-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 11:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBPDw-00040R-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 11:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0J1J4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 05:56:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39111 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0J1J4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 05:56:39 -0400
Received: by fxm16 with SMTP id 16so1728133fxm.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ABBsiQC94LD/xCxswoDsV4fCEH2pVN+secvo/SPuhmw=;
        b=jx0poVGPkQIvY6pYpUpYnNEXnKRsPvh2UA0HXhCZZOSb21Z44hHIEHOd10pF6xolM4
         4tyw8Gshu00PMnUgJPWATc/y4u+gimkEQ3fKPOUa5VOClYKbzgqsH/EIdtn/21xRW54v
         ffQWiQSMiDFHHawz9e+PRtBtVEvl0B/54tV48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Ng+WKfoKGkXDulpH3nbQpr+8KZWlDb1nHbSgdA1LLpOjy+UPZhzCu0CzWMZ4KwiCrG
         ZvhEFcdgUqY7qcqPfcjcGVewgJwAAac8Mx7JH9WgH5YstXWpAs4nrMwccfYoFuKqn7/2
         6Fg63CHRezp9dNL5vo6Gnmam5RU/1JCXpKsM4=
Received: by 10.223.70.133 with SMTP id d5mr3125600faj.64.1288259796619;
        Thu, 28 Oct 2010 02:56:36 -0700 (PDT)
Received: from localhost.localdomain (abvj108.neoplus.adsl.tpnet.pl [83.8.207.108])
        by mx.google.com with ESMTPS id m8sm382529faj.35.2010.10.28.02.56.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 02:56:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9S9u2IP006671;
	Thu, 28 Oct 2010 11:56:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9S9tlU1006667;
	Thu, 28 Oct 2010 11:55:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1288226574-19068-3-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160166>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This adds output buffering for gitweb, mainly in preparation for
> caching support.  This is a dramatic change to how caching was being
> done, mainly in passing around the variable manually and such.
> 
> This centrally flips the entire STDOUT to a variable, which after the
> completion of the run, flips it back and does a print on the resulting
> data.
> 
> This should save on the previous 10K line patch (or so) that adds more
> explicit output passing.

Signoff?

> ---
>  gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 215a4e9..757ef46 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -30,6 +30,9 @@ BEGIN {
>  
>  our $version = "++GIT_VERSION++";
>  
> +# Output buffer variable
> +$output = "";
> +
>  our ($my_url, $my_uri, $base_url, $path_info, $home_link);
>  sub evaluate_uri {
>  	our $cgi;
> @@ -1151,6 +1154,25 @@ sub evaluate_argv {
>  	);
>  }
>  
> +sub change_output {
> +	our $output;
> +
> +	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
> +	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
> +
> +	# Close STDOUT, so that it isn't being used anymore.
> +	close STDOUT;
> +
> +	# Trap STDOUT to the $output variable, which is what I was using in the original
> +	# patch anyway.
> +	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $var
> +}
> +
> +sub reset_output {
> +	# This basically takes STDOUT_REAL and puts it back as STDOUTl
> +	open(STDOUT,">&STDOUT_REAL");
> +}

Nice solution.  I'll steal it for GitwebCache::Capture::Redirect (or
something like that, instead of relying on a bit cryptic select($fh)).

> @@ -1163,7 +1185,10 @@ sub run {
>  		$pre_dispatch_hook->()
>  			if $pre_dispatch_hook;
>  
> +		change_output();
>  		run_request();
> +		reset_output();
> +		print $output;

Doesn't this enable capture unconditionally?  

Wouldn't that screw-up the blame_data part of blame_interactive Ajax-y
view?  Wouldn't that decrease perceived responsiveness of gitweb?

>  
>  		$post_dispatch_hook->()
>  			if $post_dispatch_hook;
> @@ -3673,6 +3698,10 @@ sub die_error {
>  		500 => '500 Internal Server Error',
>  		503 => '503 Service Unavailable',
>  	);
> +	# Reset the output so that we are actually going to STDOUT as opposed
> +	# to buffering the output.
> +	reset_output();
> +

Good.

>  	git_header_html($http_responses{$status}, undef, %opts);
>  	print <<EOF;
>  <div class="page_body">

-- 
Jakub Narebski
Poland
ShadeHawk on #git
