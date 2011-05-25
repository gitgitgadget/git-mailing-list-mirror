From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2 (version B)] gitweb: Use /etc/gitweb.conf even if
 gitweb_conf.perl exist
Date: Wed, 25 May 2011 11:54:13 -0700
Message-ID: <7v8vtu4nmy.fsf@alter.siamese.dyndns.org>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
 <1306341328-11108-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJE1-0002U4-Ms
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1EYSy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:54:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab1EYSy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:54:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 99B2054B5;
	Wed, 25 May 2011 14:56:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ivObdmhMh0AJWoziat3AZFH1h7s=; b=WPAePh
	vB3SzrH5S+ylWvlcAow+Rr00C8b5We6m37FZzQw7q529k9+FYs3SVifU/jW00kGw
	sy0Ag5dmjMRkGFdxKGB/7PWU/lNJ4Xc3ts3BeAYgXHzVhizcJPV636eWtkK0vtRt
	n7LEoMUR7h+RTq/j1Em2PKWXvLcTod2RLRrTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckES5Fh17kSA7eH4YXWRR7pu1tiBzhkF
	TK1280xlDj0qRwdewUiatcFJfW5/NtPLRaJTXzBd8D42fOTU0QdWC0Z97nU82Ah9
	/4qHkcG7rnsOW2Oh86t6Kn67DSP2xJJnlJJdAwglS/5bpUGaWSsrkJcD3M1QCyLT
	IREcbVXNffA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 478CB54AC;
	Wed, 25 May 2011 14:56:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DF59549F; Wed, 25 May 2011
 14:56:22 -0400 (EDT)
In-Reply-To: <1306341328-11108-4-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 25 May 2011 18:35:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2E3733C-8700-11E0-BDE9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174447>

Jakub Narebski <jnareb@gmail.com> writes:

> This commit should be thought as exclusive to
>
>   [PATCH 2/2 (version A)] gitweb: Mention read_config_file in gitweb/README
>
> We have to choose one or the other.

Who says?  We do not have to.  Why not do this instead?

	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} ||
		"/etc/gitweb-common.conf";

	# common system-wide settings for convenience
        read_config_file($GITWEB_COMMON);

        # as always, use the per-instance GITWEB_CONFIG if exists,
        # otherwise use GITWEB_SYSTEM_CONFIG
        read_config_file($GITWEB_CONFIG) ||
        	read_config_file($GITWEB_CONFIG_SYSTEM);

There is no risk of hurting any existing installations, and people who do
have things that needs to be shared do not have to go around and update
all the per-instance configuration files.

 diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ce92d67..e4b0932 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -656,9 +656,10 @@ sub evaluate_gitweb_config {
>  	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
>  	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  
> -	# use first config file that exists
> -	read_config_file($GITWEB_CONFIG) or
> +	# let settings in second override ones in first
>  	read_config_file($GITWEB_CONFIG_SYSTEM);
> +	read_config_file($GITWEB_CONFIG)
> +		if ($GITWEB_CONFIG ne $GITWEB_CONFIG_SYSTEM);
>  }
>  
>  # Get loadavg of system, to compare against $maxload.
