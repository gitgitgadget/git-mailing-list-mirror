From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] connect: make parse_connect_url() return separated host and port
Date: Mon, 16 May 2016 15:39:08 -0700
Message-ID: <xmqqr3d1zkz7.fsf@gitster.mtv.corp.google.com>
References: <20160516000740.19042-1-mh@glandium.org>
	<20160516000740.19042-5-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:39:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2RAS-0006jb-48
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcEPWjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:39:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbcEPWjL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:39:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B42E31C4AF;
	Mon, 16 May 2016 18:39:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kegfcSGyP/hFVHeOqFQpNXdzXbU=; b=FWClcT
	T2/Fa2oGAw2x4RtPUPB+IaPrctvrAeJMNOd+fqjWIcy6eLOiKNUJV4R0dQ/YqJj3
	L9V2qkSpIbgcb5gCDHZdSg75qT56P1KO0lJSACf5IrlUQuFoNm+v0aYbiiKmoF2Q
	Uu+iiVt+w/X12iZlhvdH0wu8v6FAtyNU7gXxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2GaCSq1gQNz6b+O6ieWNvLDVjMXVF6o
	5JVceD/4DScgsVgT9WgSJAQ3RBAn/RhGS5umyLPj/ejtMdi3vY6okh6DtnwynfMU
	ZaDqPMaSpQdqujNBZr1JuJceYYUlrdbR6DplTYt9CsqtyaBXW5aU9Q2zE/Lcu5Xd
	OPIqKGq9RrI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABDC51C4AE;
	Mon, 16 May 2016 18:39:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 351E91C4AD;
	Mon, 16 May 2016 18:39:10 -0400 (EDT)
In-Reply-To: <20160516000740.19042-5-mh@glandium.org> (Mike Hommey's message
	of "Mon, 16 May 2016 09:07:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01AA5134-1BB7-11E6-9283-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294810>

Mike Hommey <mh@glandium.org> writes:

> +	get_host_and_port(&host, &port);
> +
> +	if (*host && !port) {
> +		/* The host might contain a user:password string, ignore it
> +		 * when searching for the port again */
> +		char *end_user = strrchr(host, '@');
> +		port = get_port(end_user ? end_user : host);

Scanning from the right because host part would never have '@', but
there could be an invalid URL with an unquoted '@' in userinfo part?
Then this makes sense.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 91a69fc..9acba2b 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -553,7 +553,7 @@ check_prot_path () {
>  	Diag: protocol=$2
>  	Diag: path=$3
>  	EOF
> -	git fetch-pack --diag-url "$1" | grep -v hostandport= >actual &&
> +	git fetch-pack --diag-url "$1" | grep -v host= | grep -v port= >actual &&

A single process:

	... | grep -v -e '^host=' -e '^port='

perhaps?

> @@ -562,22 +562,17 @@ check_prot_host_port_path () {
>  	case "$2" in
>  		*ssh*)
>  		pp=ssh
> -		uah=userandhost
> -		ehost=$(echo $3 | tr -d "[]")
> -		diagport="Diag: port=$4"
>  		;;
>  		*)
> -		pp=$p
> -		uah=hostandport
> -		ehost=$(echo $3$4 | sed -e "s/22$/:22/" -e "s/NONE//")
> -		diagport=""
> +		pp=$2
>  		;;
>  	esac
> +	ehost=$(echo $3 | tr -d "[]")
>  	cat >exp <<-EOF &&
>  	Diag: url=$1
>  	Diag: protocol=$pp
> -	Diag: $uah=$ehost
> -	$diagport
> +	Diag: userandhost=$ehost
> +	Diag: port=$4
>  	Diag: path=$5
>  	EOF

This makes the diag output simpler and allows the caller to expect
the same set of variables, which is good.
