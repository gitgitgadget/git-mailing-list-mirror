From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 12/18] gitweb: Change file handles (in caching) to lexical variables as opposed to globs
Date: Thu, 09 Dec 2010 16:16:20 -0800 (PST)
Message-ID: <m3d3pa1o0j.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-13-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqf1-0005AY-K8
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab0LJAQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:16:27 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:36818 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0LJAQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:16:26 -0500
Received: by bwz16 with SMTP id 16so3384562bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wOalmOpQEaQE9wmEIK8P2efuH5OhwKWxJ+7ZYP41QIs=;
        b=w43yrhJm0DmPEaoB1T1SaUKsPGS/68HEz2TFcN1U38Byd4/cXXKqsrj7VcSGkQ2LB1
         /VRqCdlyE2fPF4mZn4hnxarDpOngFpNYeplRmq/L8QBUodboIrYQPlUlaxicPlui36K/
         ujP8jPbN2I99kLSg9e40eoWHOyqrJGEZhh8CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cnxs4KKoluP6c6nuFOECmOkQZspR4DAyUR5daEdAcmjXvUZ9qioRq3TirhKqRg+0yQ
         n70nRJDYgKvt61q8Wgh9ayvpDFZN6j7EV1Jf8zpGlQgJx8M0iZV9X46cKgcO3/Oh29Sb
         DVxMyOG+DU1XLaSk5QcIctDJKLRIX3Yj6a2sc=
Received: by 10.204.101.83 with SMTP id b19mr57541bko.199.1291940181806;
        Thu, 09 Dec 2010 16:16:21 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id d11sm1249822bkd.22.2010.12.09.16.16.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:16:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA0Fplb020298;
	Fri, 10 Dec 2010 01:16:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA0Feus020295;
	Fri, 10 Dec 2010 01:15:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-13-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163365>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This isn't a huge change, it just adds global variables for the file handles,
> an additional cleanup to localize the variable a bit more which should alleviate
> the issues that Jakub had with my original approach.
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/lib/cache.pl |  114 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 71 insertions(+), 43 deletions(-)
> 
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index 5182a94..fafc028 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -14,6 +14,12 @@ use Digest::MD5 qw(md5 md5_hex md5_base64);
>  use Fcntl ':flock';
>  use File::Copy;
>  
> +# Global declarations
> +our $cacheFile;
> +our $cacheFileBG;
> +our $cacheFileBinWT;
> +our $cacheFileBin;

You are trading globs for global (well, package) variables.  They are
not lexical filehandles... though I'm not sure if it would be possible
without restructuring code; note that if variable holding filehandle
falls out of scope, then file would be automatically closed.

BTW. Do you really need all those types/variables?

> +
>  sub cache_fetch {
>  	my ($action) = @_;
>  	my $cacheTime = 0;
> @@ -49,9 +55,9 @@ sub cache_fetch {
>  	}else{
>  		#if cache is out dated, update
>  		#else displayCache();
> -		open(cacheFile, '<', "$fullhashpath");
> -		stat(cacheFile);
> -		close(cacheFile);
> +		open($cacheFile, '<', "$fullhashpath");
> +		stat($cacheFile);
> +		close($cacheFile);
[...]

-- 
Jakub Narebski
Poland
ShadeHawk on #git
