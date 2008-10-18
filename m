From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 2/5] gitweb: generate project/action/hash URLs
Date: Sun, 19 Oct 2008 01:14:25 +0200
Message-ID: <200810190114.26280.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:27:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrLCr-00075Z-RG
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 01:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYJRX02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYJRX01
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 19:26:27 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:6810 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYJRX0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 19:26:24 -0400
Received: by ey-out-2122.google.com with SMTP id 6so397901eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p9fPk2e2GjVR5o4y3DWNJU4FcNz0vOXirXQ807MrB2I=;
        b=MY24/3hOy++U53CgRZRjXwejo1FjN9skFNVOXOFv9Uz2jbWrtAybLnZE04Saq0HhW2
         3enewJBkRnh73mVxNVi6d9vX3UjTGHDdy5Nikg3mZW8SaQWTg+JS16aN7VZH9LZZnX+Y
         LegVbbgUSBXSXGrpHJTS/nE8f5PM7X0uFK4Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IApszvy59jydlYOTASWGxIafCwqwzsngajCOxm9yil2QvFYwLG0up3xhomvBSFheW8
         1jzdLfUVCFtqvxK4KctHTlhXsb68y/5xB1oy9zCZ6XVSGclwTbFjkQ567rCg8+rmbDku
         IIUtnlUtvdrrk5QTLTknmy9Eoko6HRu2cC1TQ=
Received: by 10.210.49.19 with SMTP id w19mr6560241ebw.149.1224372383589;
        Sat, 18 Oct 2008 16:26:23 -0700 (PDT)
Received: from ?192.168.1.11? (abwr242.neoplus.adsl.tpnet.pl [83.8.241.242])
        by mx.google.com with ESMTPS id 7sm7149891eyb.1.2008.10.18.16.26.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 16:26:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98581>

On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:

> When generating path info URLs, reduce the number of CGI parameters by
> embedding action and hash_parent:filename or hash in the path.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Nice, well commented, and clean.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++---
>  1 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6d0dc26..5337d40 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -724,14 +724,41 @@ sub href (%) {
>  
>  	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
>  	if ($use_pathinfo) {
> -		# use PATH_INFO for project name
> +		# try to put as many parameters as possible in PATH_INFO:
> +		#   - project name
> +		#   - action
> +		#   - hash or hash_base:filename
> +
> +		# When the script is the root DirectoryIndex for the domain,
> +		# $href here would be something like http://gitweb.example.com/
> +		# Thus, we strip any trailing / from $href, to spare us double
> +		# slashes in the final URL
> +		$href =~ s,/$,,;

I like having this comment here.

> +
> +		# Then add the project name, if present
>  		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>  		delete $params{'project'};
>  
> -		# Summary just uses the project path URL
> -		if (defined $params{'action'} && $params{'action'} eq 'summary') {
> +		# Summary just uses the project path URL, any other action is
> +		# added to the URL

Which meant that we prefer http://base_url/project over http://base_url/project/summary

> +		if (defined $params{'action'}) {
> +			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
>  			delete $params{'action'};
>  		}
> +
> +		# Finally, we put either hash_base:file_name or hash
> +		if (defined $params{'hash_base'}) {
> +			$href .= "/".esc_url($params{'hash_base'});
> +			if (defined $params{'file_name'}) {
> +				$href .= ":".esc_url($params{'file_name'});
> +				delete $params{'file_name'};
> +			}
> +			delete $params{'hash'};
> +			delete $params{'hash_base'};
> +		} elsif (defined $params{'hash'}) {
> +			$href .= "/".esc_url($params{'hash'});
> +			delete $params{'hash'};
> +		}
>  	}
>  
>  	# now encode the parameters explicitly
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
