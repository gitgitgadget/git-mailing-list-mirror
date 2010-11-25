From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] gitweb: selectable configurations that change with
 each request
Date: Thu, 25 Nov 2010 12:23:14 -0600
Message-ID: <20101125182314.GA17261@burratino>
References: <20101111213456.21127.36449.stgit@localhost.localdomain>
 <7vhbf6txi9.fsf@alter.siamese.dyndns.org>
 <201011242243.20545.jnareb@gmail.com>
 <201011251318.31235.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Julio Lajara <julio.lajara@alum.rpi.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 19:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLgTn-0005DL-7z
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 19:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab0KYSXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 13:23:30 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41050 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0KYSX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 13:23:29 -0500
Received: by qwb7 with SMTP id 7so1233597qwb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b/Sk1HU8DpautXXjC1MP4DJA5YozfJnYhD2pGTXc4ck=;
        b=cM56FgDSW8ebwZDwhQNY6fX39Knn6XP6Nx6z3Q5lMnydTI58my+rCJFNzz3pw1t0Qk
         Vzg1nboXAQYgC3GCKlVL45h8M4PGVI4K3HrS45L1bNNtnYWqPJXpCy4/G1vo5QxcmU7V
         PCUFymVcthGTslidmh/AZMX4qyhwaKaeUO1Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JWzoiMxwRI0Z2Cllkf4EOLx1F/ATOyXcBEVIKMOr+UGkkRBehGCc/HVPuaO7uOAd1v
         hBniWekzHDP3FyygfBlriHQNpTcA38DvPp78Zgh/9QpuGJQ01rsw73BaEFTMAhwVya7S
         CdxlwjkUyLcJ80zz7S4bQC8rb7vElo7hNO7y8=
Received: by 10.229.236.203 with SMTP id kl11mr930459qcb.204.1290709408807;
        Thu, 25 Nov 2010 10:23:28 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm621332qcb.15.2010.11.25.10.23.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 10:23:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011251318.31235.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162150>

Jakub Narebski wrote:

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
[...]
> @@ -1068,12 +1076,21 @@ sub reset_timer {
>  	our $number_of_git_cmds = 0;
>  }
>  
> +our $first_request = 1;
>  sub run_request {
>  	reset_timer();
>  
>  	evaluate_uri();
> -	evaluate_gitweb_config();
> -	evaluate_git_version();
> +	if ($first_request) {
> +		evaluate_gitweb_config();
> +		evaluate_git_version();
> +	} elsif ($per_request_config) {
> +		if (ref($per_request_config) eq 'CODE') {
> +			$per_request_config->();
> +		} else {
> +			evaluate_gitweb_config();
> +		}
> +	}

Should per_request_config() be run for the first request, too?  Maybe:

	if ($first_request) {
		evaluate_gitweb_config();
		evaluate_git_version();
	}
	if ($per_request_config) {
		if (ref($per_request_config) eq 'CODE') {
			$per_request_config->();
		} elsif (!$first_request) {
			evaluate_gitweb_config();
		}
	}
