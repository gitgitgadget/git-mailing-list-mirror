From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 09/10] connect.c: Refactor url parsing
Date: Thu, 21 Nov 2013 15:38:07 -0800
Message-ID: <xmqq7gc12un4.fsf@gitster.dls.corp.google.com>
References: <201311212141.57411.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjdpF-0003MQ-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab3KUXiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 18:38:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099Ab3KUXiL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 18:38:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8099154843;
	Thu, 21 Nov 2013 18:38:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8B35CwCkAK4z
	J45yluTUAhm6NNE=; b=PmFxF6LV7k/VNVJbNBZo83QehJ7SBECCpz0ICMBFC60e
	1uv/pHsNtZqXyQNvPFzyR6JP7vEw/2+IB2YWeQa2wwq8zhLqmMHIxrtT5eJmnZvb
	r6Yxz34V/XnlW0A+jtFOiTeXGrh2SbTDXVnjTeYdw1fGhzzOEtxix+e2ZxB73TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JBS0EA
	BfoADWWqc465d+wWG6EYsAH1TixNBe+aaERTS8h0K3JxGqys/TSnDjrDEmIpmL/K
	jDXRK8BemCW2IDobcTvU4KThrG6q9EAgquXGuv6bLQVICX3vIgxhZaEwxReVNkWL
	VbHfqawhqSMsP58IlwjRHqtlhH0PyT0kkgn4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ECFE54842;
	Thu, 21 Nov 2013 18:38:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A08E254841;
	Thu, 21 Nov 2013 18:38:09 -0500 (EST)
In-Reply-To: <201311212141.57411.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:41:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FAAA79B2-5305-11E3-B64E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238165>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Make the function is_local() from tramsport.c public and use it

s/ams/ans/, perhaps?

> in both transport.c and connect.c
> Use a protocol "local" for URLs for the local file system.
> ---
>  connect.c        | 58 ++++++++++++++++++++++++++++++----------------=
----------
>  connect.h        |  1 +
>  t/t5601-clone.sh | 10 +---------
>  transport.c      |  8 --------
>  4 files changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 3d174c8..95568ac 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -232,13 +232,23 @@ int server_supports(const char *feature)
> =20
>  enum protocol {
>  	PROTO_LOCAL =3D 1,
> +	PROTO_FILE,
>  	PROTO_SSH,
>  	PROTO_GIT
>  };
> =20
> +int is_local(const char *url)
> +{
> +	const char *colon =3D strchr(url, ':');
> +	const char *slash =3D strchr(url, '/');
> +	return !colon || (slash && slash < colon) ||
> +		has_dos_drive_prefix(url);
> +}
> +
>  static const char *prot_name(enum protocol protocol) {
>  	switch (protocol) {
>  		case PROTO_LOCAL:
> +		case PROTO_FILE:
>  			return "file";
>  		case PROTO_SSH:
>  			return "ssh";
> @@ -260,7 +270,7 @@ static enum protocol get_protocol(const char *nam=
e)
>  	if (!strcmp(name, "ssh+git"))
>  		return PROTO_SSH;
>  	if (!strcmp(name, "file"))
> -		return PROTO_LOCAL;
> +		return PROTO_FILE;
>  	die("I don't handle protocol '%s'", name);
>  }
> =20
> @@ -563,9 +573,8 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	char *url;
>  	char *host, *path;
>  	char *end;
> -	int separator;
> +	int separator =3D '/';

Hmph.  Doesn't this belong to the earlier patch that did s/c/separator/=
?

>  	enum protocol protocol =3D PROTO_LOCAL;
> -	int free_path =3D 0;
> =20
>  	if (is_url(url_orig))
>  		url =3D url_decode(url_orig);
> @@ -577,10 +586,12 @@ static enum protocol parse_connect_url(const ch=
ar *url_orig, char **ret_host,
>  		*host =3D '\0';
>  		protocol =3D get_protocol(url);
>  		host +=3D 3;
> -		separator =3D '/';
>  	} else {
>  		host =3D url;
> -		separator =3D ':';
> +		if (!is_local(url)) {
> +			protocol =3D PROTO_SSH;
> +			separator =3D ':';
> +		}
>  	}
> =20
>  	/*
> @@ -596,17 +607,12 @@ static enum protocol parse_connect_url(const ch=
ar *url_orig, char **ret_host,
>  	} else
>  		end =3D host;
> =20
> -	path =3D strchr(end, separator);
> -	if (path && !has_dos_drive_prefix(end)) {
> -		if (separator =3D=3D ':') {
> -			if (host !=3D url || path < strchrnul(host, '/')) {
> -				protocol =3D PROTO_SSH;
> -				*path++ =3D '\0';
> -			} else /* '/' in the host part, assume local path */
> -				path =3D end;
> -		}
> -	} else
> +	if (protocol =3D=3D PROTO_LOCAL)
> +		path =3D end;
> +	else if (protocol =3D=3D PROTO_FILE && has_dos_drive_prefix(end))

Hmm, this is for things like...  "file:///Z:/Documents/repo.git"???

> diff --git a/connect.h b/connect.h
> index 527d58a..ce657b3 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -9,5 +9,6 @@ extern int git_connection_is_socket(struct child_proc=
ess *conn);
>  extern int server_supports(const char *feature);
>  extern int parse_feature_request(const char *features, const char *f=
eature);
>  extern const char *server_feature_value(const char *feature, int *le=
n_ret);
> +int is_local(const char *url);

In .h files, we very strongly prefer "extern" in front.

I also have to wonder if "is_local()" too generic a name for a
global API function.  It was a perfectly fine name for a static
function within the context of transport.c, though.

>  #endif
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 57234c0..bd1bfd3 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -364,15 +364,7 @@ do
>  done
> =20
>  # Corner cases
> -# failing
> -for url in [foo]bar/baz:qux [foo/bar]:baz
> -do
> -	test_expect_failure "clone $url is not ssh" '
> -		test_clone_url $url none
> -	'
> -done
> -
> -for url in foo/bar:baz
> +for url in foo/bar:baz [foo]bar/baz:qux [foo/bar]:baz
>  do
>  	test_expect_success "clone $url is not ssh" '
>  		test_clone_url $url none
> diff --git a/transport.c b/transport.c
> index 7202b77..a09ba95 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -885,14 +885,6 @@ void transport_take_over(struct transport *trans=
port,
>  	transport->cannot_reuse =3D 1;
>  }
> =20
> -static int is_local(const char *url)
> -{
> -	const char *colon =3D strchr(url, ':');
> -	const char *slash =3D strchr(url, '/');
> -	return !colon || (slash && slash < colon) ||
> -		has_dos_drive_prefix(url);
> -}
> -
>  static int is_file(const char *url)
>  {
>  	struct stat buf;
