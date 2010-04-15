From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: add maildomain_sanitize()
Date: Thu, 15 Apr 2010 05:47:45 -0700 (PDT)
Message-ID: <m38w8og9w4.fsf@localhost.localdomain>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
	<1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
	<7v1vep427o.fsf@alter.siamese.dyndns.org>
	<87ljcrwxni.fsf_-_@jondo.cante.net>
	<87bpdnwpoh.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:47:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2OU6-00083u-MD
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0DOMru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:47:50 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:35026 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0DOMrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:47:48 -0400
Received: by bwz25 with SMTP id 25so1532335bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yqTF+7ZokBF8d5eBGhD5Z0fCB1a3j7NjgBuGq/xPviI=;
        b=jed1tmK5KvmVzd/wGxtyZXFB1UYl3iIFzYdAKgqktY7sZ37EfECfn8doBHAWOAQRyO
         W4P+ywBPuLuDvlTlMETkO9S5YgZY8FBg9TMezMDUARjyY6gnkmo+PkUtYXDaBvLuOCrL
         9qYq2x/NGWv7CRV1L0x4s2dqFm+NoJgdTYPoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Am+HEzq42HI9lwKC+hvB7fB0mz4RC7UudNiUtQSGdljI7pQah1/W9Wzara7zSm4dp9
         6pv836c+o9EsoaW7P3Lxo1LRqYMx5UEqcX0nQUClZkp+VU4FiGYaj2hqea+CNgXVmatg
         SyRkHf+qZin6q7zg+FhpUM8+UsMmsyi8mJ0NY=
Received: by 10.102.246.2 with SMTP id t2mr56040muh.103.1271335666657;
        Thu, 15 Apr 2010 05:47:46 -0700 (PDT)
Received: from localhost.localdomain (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id g1sm7820357muf.0.2010.04.15.05.47.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 05:47:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3FClu4L027068;
	Thu, 15 Apr 2010 14:48:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3FCldjS027064;
	Thu, 15 Apr 2010 14:47:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87bpdnwpoh.fsf_-_@jondo.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144978>

Jari Aalto <jari.aalto@cante.net> writes:

> Move duplicate maildomain checks to a single subroutine.
> Require that a FQDN contains at least one period.
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---

Good idea.

[...]
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ce569a9..0e8f18c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -863,14 +863,28 @@ sub sanitize_address
>  # This maildomain*() code is based on ideas in Perl library Test::Reporter
>  # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
>  
> +sub maildomain_sanitize
> +{
> +	local $_ = shift;
> +
> +	#  On Mac, the the domain name is not necessarily in FQDN format
> +	#  Require a period in the string
> +
> +	if ( $^O eq 'darwin'  and  /\.local$/ ) {
> +		# Nope, pass this one.
> +	}
> +	elsif ( /\./ ) {
> +		$_;
> +	}
> +}

Style:

  +sub maildomain_sanitize {
  +	local $domain = shift;
  +
  +	#  On Mac, the the domain name is not necessarily in FQDN format
  +	#  Require a period in the string
  +
  +	if ($^O eq 'darwin'  &&  $domain =~ /\.local$/) {
  +		# Nope, pass this one.
  +	} elsif ($domain =~ /\./) {
  +		return $domain;
  +	}
  +}

(probably fixed in new version of this series).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
