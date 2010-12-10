From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 17/18] gitweb: Prepare for cached error pages & better error page handling
Date: Thu, 09 Dec 2010 17:49:28 -0800 (PST)
Message-ID: <m3r5dqz9c5.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-18-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:49:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQs78-00080K-5Z
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743Ab0LJBtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:49:33 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:54943 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778Ab0LJBtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:49:32 -0500
Received: by bwz16 with SMTP id 16so3456468bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tILeG9Y+L0hJhfCR3X756BLvI1sozueSZngGQ1mqLM4=;
        b=aay1I3kLDiphES2leFyJuABAPXT12rbm9Vcz2dvOWzA+JQwCCmsQcbLusE8EECven2
         yKgFFZpQ1EMX6h4jMZImBF67G3f6tAWkTQp3T+6npw+a+zdoXbRYztnXbz8OYqkeQZZI
         ybMwHlqwYUqgU4JgBBy5KkHfvAUhF0xdDXwgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HRZNMaPncJgpjJ+oFTqL/zMXeajxbjQac7kDBdABLGTKYb8Vt5tCSd3hffLrnARHrY
         Hi7kf+cnISxID+oA8umPLme4KeTf+FmKlPcKAGvTkE/tRYZCTSz0P9BbGX7yWIPxfjpK
         fZnX1aAna+HgFnXjbUCSxNktXw95NMg0aw//w=
Received: by 10.204.121.136 with SMTP id h8mr188561bkr.8.1291945768981;
        Thu, 09 Dec 2010 17:49:28 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id d27sm1274820bkw.14.2010.12.09.17.49.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 17:49:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA1mw8d021538;
	Fri, 10 Dec 2010 02:49:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA1mhmw021533;
	Fri, 10 Dec 2010 02:48:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-18-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163379>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> To quote myself from an e-mail of mine:
> 
> 	I've got a hammer, it clearly solves all problems!
> 
> This is the prepatory work to set up a mechanism inside the
> caching engine to cache the error pages instead of throwing
> them straight out to the client.

There is no problem with capturing output of die_error, nor there is a
problem with caching error pages (perhaps transiently in memory).

The problem is that subroutines calling die_error assum that it would
exit ending subroutine that is responsible for generating current
action; see "goto DONE_GITWEB" which should be "goto DONE_REQUEST",
and which was "exit 0" some time ago at the end of die_error().

With caching error pages you want die_error to exit $actions{$action}->(),
but not exit cache_fetch().  How do you intend to do it?

> 
> This adds two functions:
> 
> die_error_cache() - this gets back called from die_error() so
> that the error message generated can be cached.

*How* die_error_cache() gets called back from die_error()?  I don't
see any changes to die_error(), or actually any calling sites for
die_error_cache() in the patch below.
 
> cacheDisplayErr() - this is a simplified version of cacheDisplay()
> that does an initial check, if the error page exists - display it
> and exit.  If not, return.

Errr... isn't it removed in _preceding_ patch?  WTF???

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index a8c902d..6cb82c8 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -302,6 +302,36 @@ sub cacheUpdate {
>  	}
>  }
>  
> +sub die_error_cache {
> +	my ($output) = @_;
> +
> +	open(my $cacheFileErr, '>:utf8', "$fullhashpath.err");
> +	my $lockStatus = flock($cacheFileErr,LOCK_EX|LOCK_NB);

Why do you need to lock here?  A comment would be nice.

> +
> +	if (! $lockStatus ){
> +		if ( $areForked ){

Grrrr...

But if it is here to stay, a comment if you please.

> +			exit(0);
> +		}else{
> +			return;
> +		}
> +	}
> +
> +	# Actually dump the output to the proper file handler
> +	local $/ = undef;
> +	$|++;

Why not

  +	local $| = 1;


> +	print $cacheFileErr "$output";
> +	$|--;
> +
> +	flock($cacheFileErr,LOCK_UN);
> +	close($cacheFileErr);

Closing file will unlock it.

> +
> +	if ( $areForked ){
> +		exit(0);
> +	}else{
> +		return;

So die_error_cache would not actually work like "die" here and like
die_error(), isn't it?

> +	}
> +}
> +
>  
>  sub cacheWaitForUpdate {
>  	my ($action) = @_;
> @@ -380,6 +410,28 @@ EOF
>  	return;
>  }
>  
> +sub cacheDisplayErr {
> +
> +	return if ( ! -e "$fullhashpath.err" );
> +
> +	open($cacheFileErr, '<:utf8', "$fullhashpath.err");
> +	$lockStatus = flock($cacheFileErr,LOCK_SH|LOCK_NB);
> +
> +	if (! $lockStatus ){
> +		show_warning(
> +				"<p>".
> +				"<strong>*** Warning ***:</strong> Locking error when trying to lock error cache page, file $fullhashpath.err<br/>/\n".

esc_path

> +				"This is about as screwed up as it gets folks - see your systems administrator for more help with this.".
> +				"<p>"
> +				);
> +	}
> +
> +	while( <$cacheFileErr> ){
> +		print $_;
> +	}

Why not 'print <$cacheFileErr>' (list context), like in insert_file()
subroutine?

> +	exit(0);
> +}

Callsites?

Note: I have't read next commit yet.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
