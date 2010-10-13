From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/15] daemon: use run-command api for async serving
Date: Wed, 13 Oct 2010 15:47:21 -0700
Message-ID: <7vpqvdhfra.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6A6p-0004Qp-9C
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab0JMWrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:47:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0JMWrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:47:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5808DE185;
	Wed, 13 Oct 2010 18:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QfrVZcwD3gg99oz82NkUJMmG6Rg=; b=qcvjku
	OqK0qxwYOYneLljlCS6O3A9RsnIPCsYimx02WDMVupcteJqgKxyH4e+e3r41z/qm
	ydHOkdIytkyjmdp1ayFDu/HE2rfgdXUbMps3J3hLEmcfaKyR5riFjOME8ykQoWo7
	G30pLR7H2qWnFfh9hx8nwWi4Eaeo7v+bkjjGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmxRq81027/DRZ/KJ5T6n8pU+LnVafya
	+UN8NCY+sRXNhFG0L6F30vCPovoP7BNSf1RHRU0yaWq5FjH+/1QLDEtWBp9SGfnY
	8yne/owvhkbBP+4S/YO8s7ZiHCzU7HfEQx3GZQu0sZAjHZsjBSIG9DeW64ljZpnN
	mTPRiTYfEZ8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B48ADE180;
	Wed, 13 Oct 2010 18:47:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DF44DE17F; Wed, 13 Oct
 2010 18:47:23 -0400 (EDT)
In-Reply-To: <1286833829-5116-9-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon\, 11 Oct 2010 23\:50\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC50C214-D71B-11DF-887B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158998>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> @@ -1017,7 +1005,12 @@ int main(int argc, char **argv)
>  				continue;
>  			}
>  		}
> +		if (!strcmp(arg, "--serve")) {
> +			serve_mode = 1;
> +			continue;
> +		}
>  		if (!strcmp(arg, "--inetd")) {
> +			serve_mode = 1;
>  			inetd_mode = 1;
>  			log_syslog = 1;
>  			continue;
> @@ -1161,12 +1154,12 @@ int main(int argc, char **argv)
>  		die("base-path '%s' does not exist or is not a directory",
>  		    base_path);
>  
> -	if (inetd_mode) {
> +	if (serve_mode) {
>  		struct sockaddr_storage ss;
>  		struct sockaddr *peer = (struct sockaddr *)&ss;
>  		socklen_t slen = sizeof(ss);
>  
> -		if (!freopen("/dev/null", "w", stderr))
> +		if (inetd_mode && !freopen("/dev/null", "w", stderr))
>  			die_errno("failed to redirect stderr to /dev/null");

This is not particularly a good style.  Please make it more clear that we
freopen in inetd mode by writing it like this:

	if (inetd_mode) {
        	if (!freopen(...))
                	die_errno(...)
	}
