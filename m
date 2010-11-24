From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: selectable configurations that change with
 each request
Date: Wed, 24 Nov 2010 09:57:50 -0800
Message-ID: <7vhbf6txi9.fsf@alter.siamese.dyndns.org>
References: <20101111213456.21127.36449.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Julio Lajara <julio.lajara@alum.rpi.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 18:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLJbf-0002d1-Mw
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 18:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab0KXR6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 12:58:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab0KXR6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 12:58:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78B7A350B;
	Wed, 24 Nov 2010 12:58:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uIAf5geSZkR+mbKjrxsdIZOw9EQ=; b=P3ylKr
	Ls5xBdUbBVbAIj3dHi/JQV9pye417ri8ffHiLwzr1jsj+hZkKbOWR4xjXXTAFZxS
	JpogsO4EDlAYGDLZ34yPSTzcXYtlly/ZdnaRt2JEMA2RydW3LSRmh90L6h/u0IhE
	PcQNWgtdsVOtdw7laURTY27nsbRI8rrHKQiyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0bRBrdUhjx1Lmuc33U/81G/uOF6dnn4
	j84FHjmICBCkYHa/6LbEcMr7Bhr/mRNgAfjmZIVlPArC8VtkFDLTgdNCO+MKY/WO
	IjdAC5SfdTcYjlHRQkOvw4bNmmmfdYgYpvp/Vei2eqWZgreV5uWYWgN4xPPq1wEO
	tbqHOKhImRM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37F90350A;
	Wed, 24 Nov 2010 12:58:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ACECC3509; Wed, 24 Nov 2010
 12:58:06 -0500 (EST)
In-Reply-To: <20101111213456.21127.36449.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Thu\, 11 Nov 2010 22\:36\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6751CE5A-F7F4-11DF-B4C6-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162072>

Jakub Narebski <jnareb@gmail.com> writes:

> The default value for $per_request_config is 1 (true), which means that
> old configuration that require to change per session (like gitolite's)
> will keep working.
>
> Because there is a call to evaluate_gitweb_config() in the run() subroutine
> (the call in run_config() is not invoked at first request to avoid double
> running it), therefore evaluate_git_version() could be moved back there, and
> is now evaluated only once.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I like the "we can keep the old behaviour by default, but you can go
fancier if you wanted to" attitude of this patch.

I however am not sure if this particular implementation is regression
free.  People who wanted the per-request configuration used to be able to
access what evaluate_uri() did while running evaluate_gitweb_config(),
which in turn means that their custom configuration could take things like
my-url and path-info into account, but now for the first invocation they
cannot.  It probably is just the matter of moving some code around from
their old custom gitweb-config to a per_request_config sub they need to
write and point $per_request_config variable at, but that makes "setting 1
will keep the old behaviour" a false promise, no?

> @@ -1068,12 +1076,18 @@ sub reset_timer {
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
> +	if ($per_request_config) {
> +		if (ref($per_request_config) eq 'CODE') {
> +			$per_request_config->();
> +		} elsif (!$first_request) {
> +			evaluate_gitweb_config();
> +		}
> +	}
>  	check_loadavg();
>  
>  	# $projectroot and $projects_list might be set in gitweb config file
> @@ -1126,6 +1140,10 @@ sub evaluate_argv {
>  
>  sub run {
>  	evaluate_argv();
> +	evaluate_gitweb_config();
> +	evaluate_git_version();
> +
> +	$first_request = 1;
>  
>  	$pre_listen_hook->()
>  		if $pre_listen_hook;
> @@ -1139,6 +1157,7 @@ sub run {
>  
>  		$post_dispatch_hook->()
>  			if $post_dispatch_hook;
> +		$first_request = 0;
>  
>  		last REQUEST if ($is_last_request->());
>  	}
