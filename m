From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 07/10] connect.c: Corner case for IPv6
Date: Thu, 21 Nov 2013 15:31:01 -0800
Message-ID: <xmqqbo1d2uyy.fsf@gitster.dls.corp.google.com>
References: <201311212141.10690.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjdiI-0008Dw-N3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab3KUXbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 18:31:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab3KUXbF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 18:31:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B616354600;
	Thu, 21 Nov 2013 18:31:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fM9qb6t4E8+y
	9PXZIZeLZHCgWXA=; b=IavIDV7Yww0LuBaKm15KjXWwEvLJ4unswtn+IM9xn3a+
	Jx2Yh1xF8sxUDSgxzOcQfAYUlb3EExmgEzXXde2aYdg3OAyKz0BmP292/lWV6qgC
	Ormzb+ZfvylFfIGEUesRy0NEzlGLnDq1DuL6oivUBtJ4WudfjqjIojL7r8eQpu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xzyGUt
	v1IcM3pTvWGiwWPjk720bKeM1T99JlrkWZhG0Hzr6wxF4Fe9DRNULjYd2cPpecIf
	y30mMTLiI2Umq8Nafd9zOlki4AC+drl3uorCRxgM+zpasXu0ZCwtmD4xy+JPhEN3
	Smym5drPijiyNxHugMqgKR4kc8lCFUMOa1FTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A968C545FF;
	Thu, 21 Nov 2013 18:31:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC9BF545FD;
	Thu, 21 Nov 2013 18:31:03 -0500 (EST)
In-Reply-To: <201311212141.10690.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:41:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FCE5721E-5304-11E3-8516-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238164>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Commit faea9ccbadf75128 introduced "user-relative paths":
> "ssh://host.xz/~junio/repo" is the same as "host.xz:~junio/repo".
>
> Commit 356bece0a27258181 "Support [address] in URLs" introduced a reg=
ression:
> When an URL like "[::1]:/~repo" is used, the replacement of "/~"
> with "~" was enabled for IPv6 host names, and "[::1]:/~repo" is
> converted into "[::1]:~repo".
>
> Solution:
> Don't use "if (url !=3D hostname)", but look at the separator instead=
=2E
> Rename the variable "c" into separator.
> ---

Sign-off?

The above explanation sounds sensible.

Thanks.

>  connect.c             | 14 +++++++-------
>  t/t5500-fetch-pack.sh | 16 ++++------------
>  t/t5601-clone.sh      | 12 ++----------
>  3 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 1b93b4d..0cb88b8 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -566,7 +566,7 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	char *url;
>  	char *host, *path;
>  	char *end;
> -	int c;
> +	int separator;
>  	enum protocol protocol =3D PROTO_LOCAL;
>  	int free_path =3D 0;
>  	char *port =3D NULL;
> @@ -581,10 +581,10 @@ static enum protocol parse_connect_url(const ch=
ar *url_orig, char **ret_host,
>  		*host =3D '\0';
>  		protocol =3D get_protocol(url);
>  		host +=3D 3;
> -		c =3D '/';
> +		separator =3D '/';
>  	} else {
>  		host =3D url;
> -		c =3D ':';
> +		separator =3D ':';
>  	}
> =20
>  	/*
> @@ -604,9 +604,9 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	} else
>  		end =3D host;
> =20
> -	path =3D strchr(end, c);
> +	path =3D strchr(end, separator);
>  	if (path && !has_dos_drive_prefix(end)) {
> -		if (c =3D=3D ':') {
> +		if (separator =3D=3D ':') {
>  			if (host !=3D url || path < strchrnul(host, '/')) {
>  				protocol =3D PROTO_SSH;
>  				*path++ =3D '\0';
> @@ -623,7 +623,7 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	 * null-terminate hostname and point path to ~ for URL's like this:
>  	 *    ssh://host.xz/~user/repo
>  	 */
> -	if (protocol !=3D PROTO_LOCAL && host !=3D url) {
> +	if (protocol !=3D PROTO_LOCAL && separator =3D=3D '/') {
>  		char *ptr =3D path;
>  		if (path[1] =3D=3D '~')
>  			path++;
> @@ -638,7 +638,7 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	/*
>  	 * Add support for ssh port: ssh://host.xy:<port>/...
>  	 */
> -	if (protocol =3D=3D PROTO_SSH && host !=3D url)
> +	if (protocol =3D=3D PROTO_SSH && separator =3D=3D '/')
>  		port =3D get_port(end);
> =20
>  	*ret_host =3D xstrdup(host);
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 7f55b95..ac5b08b 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -604,19 +604,11 @@ do
>  		test_expect_success "fetch-pack --diag-url $h:$r" '
>  			check_prot_path $h:$r $p "$r"
>  		'
> +		# No "/~" -> "~" conversion
> +		test_expect_success "fetch-pack --diag-url $h:/~$r" '
> +			check_prot_host_path $h:/~$r $p "$hh" "/~$r"
> +		'
>  	done
> -	h=3Dhost
> -	hh=3Dhost
> -	# "/~" -> "~" conversion
> -	test_expect_failure "fetch-pack --diag-url $h:/~$r" '
> -		check_prot_host_path $h:/~$r $p "$hh" "~$r"
> -	'
> -	h=3D[::1]
> -	hh=3D$(echo $h | tr -d "[]")
> -	# "/~" -> "~" conversion
> -	test_expect_success "fetch-pack --diag-url $h:/~$r" '
> -		check_prot_host_path $h:/~$r $p "$hh" "~$r"
> -	'
>  done
> =20
>  test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index ba99972..57234c0 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -356,15 +356,7 @@ do
>  done
> =20
>  #ipv6
> -# failing
> -for repo in /~proj
> -do
> -	test_expect_failure "clone [::1]:$repo" '
> -		test_clone_url [::1]:$repo ::1 $repo
> -	'
> -done
> -
> -for repo in rep rep/home/project 123
> +for repo in rep rep/home/project 123 /~proj
>  do
>  	test_expect_success "clone [::1]:$repo" '
>  		test_clone_url [::1]:$repo ::1 $repo
> @@ -373,7 +365,7 @@ done
> =20
>  # Corner cases
>  # failing
> -for repo in [foo]bar/baz:qux [foo/bar]:baz
> +for url in [foo]bar/baz:qux [foo/bar]:baz
>  do
>  	test_expect_failure "clone $url is not ssh" '
>  		test_clone_url $url none
