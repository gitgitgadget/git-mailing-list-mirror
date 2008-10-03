From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: generate project/action/hash URLs
Date: Fri, 3 Oct 2008 03:48:13 +0200
Message-ID: <200810030348.13575.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlZo0-0005EL-VQ
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 03:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYJCBsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 21:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYJCBsx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 21:48:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6368 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYJCBsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 21:48:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so551338nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=amwPinPPFpwGZoRCO+boX+UrzyFv3w5vSSeHcP66F84=;
        b=isvHq2/HsxGJQel40Dzo23SpFirIP2h9WZ0NSP44MmZlP5ZcqBIdUZYPP5u9nuurTL
         3dM/+Lwes+/5y76mlE3nNwoSDMq5iqQTWAFgp+8YXEzqJ3zlUidFtYjDCcuPUtT1UDhM
         2B2mwDnxUNztsj4M9iE9StD+lZc/QS4/0kguk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mfvZJF5zU3LL31lMab+gdzQCDRPuyCcWOIDxB2cdjqltyMcJoyi838+FUciXIuSqMa
         dGNvgKPiPVtf4yvYzAmNPF2Gxzi8i9wJRsM1+yYB/COLB8gV/maVtKqw+6DLp8RV24h6
         YyXNpQVbRcTY60PBbQ6yjMlVITcP01IobMPAE=
Received: by 10.210.49.19 with SMTP id w19mr466793ebw.99.1222998529033;
        Thu, 02 Oct 2008 18:48:49 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm3442182eyf.8.2008.10.02.18.48.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 18:48:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97389>

On Tue, 2 Oct 2008, Giuseppe Bilotta wrote:

> When generating path info URLs, reduce the number of CGI parameters by
> embedding action and hash_parent:filename or hash in the path.

_Perhaps_ it should be noted that even though gitweb accepted
'project/hash' and 'project/hash_base:file_name' path_info URLs, it
generated links with only 'project/' in path_info.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   32 +++++++++++++++++++++++++++++---
>  1 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ec4326f..2c380ac 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -687,14 +687,40 @@ sub href (%) {
>  
>  	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
>  	if ($use_pathinfo) {
> -		# use PATH_INFO for project name
> +		# try to put as many parameters as possible in PATH_INFO:
> +		#   - project name
> +		#   - action
> +		#   - hash or hash_base:filename
> +
> +		# Strip any trailing / from $href, or we might get double
> +		# slashes when the script is the DirectoryIndex

Perhaps example, like $href='gitweb.example.com/', could be put here.

> +		#

I think that we can lose this empty line comment here.

> +		$href =~ s,/$,,;
> +
> +		# Then add the project name, if present
>  		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>  		delete $params{'project'};
>  
> -		# Summary just uses the project path URL
> -		if (defined $params{'action'} && $params{'action'} eq 'summary') {
> +		# Summary just uses the project path URL, any other action is
> +		# added to the URL
> +		if (defined $params{'action'}) {
> +			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
>  			delete $params{'action'};
>  		}

Good.

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

Hmmmm...

Shouldn't the code first check for $file_name, then add either 
"$hash_base:$file_name" (url-escaped), or "$hash" (not "$hash_base")?

>  	}
>  
>  	# now encode the parameters explicitly

Thank you very much for work on improving gitweb.

-- 
Jakub Narebski
Poland
