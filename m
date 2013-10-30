From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4] remote-curl: fix large pushes with GSSAPI
Date: Wed, 30 Oct 2013 22:40:30 +0000
Message-ID: <20131030224030.GC12595@vauxhall.crustytoothpaste.net>
References: <1383014197-11607-1-git-send-email-sandals@crustytoothpaste.net>
 <20131030084510.GO11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 23:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbeRO-00089I-3C
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 23:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3J3Wkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 18:40:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33418 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754753Ab3J3Wkg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 18:40:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:21a5:310a:1a75:4292])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 318D360001;
	Wed, 30 Oct 2013 22:40:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131030084510.GO11317@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237075>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 04:45:10AM -0400, Jeff King wrote:
> However, we do reuse the curl handles. And in the case of rpc case, we
> are only doing one request at a time, so the handle you get is
> guaranteed to be the last one used.  So it works in practice, but it
> would break if the curl handle code breaks any of these assumptions.
>=20
> I think the clean way to do it would be to teach the slot code to pull
> out the available auth methods, and pass them up through the call chain.
> Like this on top of your patch:
>=20
> diff --git a/http.c b/http.c
> index 0ddb164..32fa998 100644
> --- a/http.c
> +++ b/http.c
> @@ -761,6 +761,12 @@ void finish_active_slot(struct active_request_slot *=
slot)
>  	if (slot->results !=3D NULL) {
>  		slot->results->curl_result =3D slot->curl_result;
>  		slot->results->http_code =3D slot->http_code;
> +#if LIBCURL_VERSION_NUM >=3D 0x070a08
> +		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
> +				  &slot->results->authtype);
> +#else
> +		slot->results->authtype =3D 0;
> +#endif
>  	}
> =20
>  	/* Run callback if appropriate */
> diff --git a/http.h b/http.h
> index d77c1b5..4b32b9b 100644
> --- a/http.h
> +++ b/http.h
> @@ -54,6 +54,7 @@
>  struct slot_results {
>  	CURLcode curl_result;
>  	long http_code;
> +	long authtype;
>  };
> =20
>  struct active_request_slot {
> diff --git a/remote-curl.c b/remote-curl.c
> index eaa286c..d026f05 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -383,25 +383,29 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  	return size;
>  }
> =20
> -static int run_slot(struct active_request_slot *slot)
> +static int run_slot(struct active_request_slot *slot,
> +		    struct slot_results *results)
>  {
>  	int err;
> -	struct slot_results results;
> +	struct slot_results results_buf;
> =20
> -	slot->results =3D &results;
> +	if (!results)
> +		results =3D &results_buf;
> +
> +	slot->results =3D results;
>  	slot->curl_result =3D curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);
> =20
> -	err =3D handle_curl_result(&results);
> +	err =3D handle_curl_result(results);
>  	if (err !=3D HTTP_OK && err !=3D HTTP_REAUTH) {
>  		error("RPC failed; result=3D%d, HTTP code =3D %ld",
> -		      results.curl_result, results.http_code);
> +		      results->curl_result, results->http_code);
>  	}
> =20
>  	return err;
>  }
> =20
> -static int probe_rpc(struct rpc_state *rpc)
> +static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  {
>  	struct active_request_slot *slot;
>  	struct curl_slist *headers =3D NULL;
> @@ -423,7 +427,7 @@ static int probe_rpc(struct rpc_state *rpc)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
> =20
> -	err =3D run_slot(slot);
> +	err =3D run_slot(slot, results);
> =20
>  	curl_slist_free_all(headers);
>  	strbuf_release(&buf);
> @@ -462,20 +466,16 @@ static int post_rpc(struct rpc_state *rpc)
>  	}
> =20
>  	if (large_request) {
> -		long authtype =3D 0;
> +		struct slot_results results;
> =20
>  		do {
> -			err =3D probe_rpc(rpc);
> +			err =3D probe_rpc(rpc, &results);
>  		} while (err =3D=3D HTTP_REAUTH);
>  		if (err !=3D HTTP_OK)
>  			return -1;
> =20
> -#if LIBCURL_VERSION_NUM >=3D 0x070a08
> -		slot =3D get_active_slot();
> -		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL, &authtype);
> -		if (authtype & CURLAUTH_GSSNEGOTIATE)
> +		if (results.authtype & CURLAUTH_GSSNEGOTIATE)
>  			needs_100_continue =3D 1;
> -#endif
>  	}
> =20
>  	headers =3D curl_slist_append(headers, rpc->hdr_content_type);
> @@ -572,7 +572,7 @@ retry:
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
> =20
> -	err =3D run_slot(slot);
> +	err =3D run_slot(slot, NULL);
>  	if (err =3D=3D HTTP_REAUTH && !large_request)
>  		goto retry;
>  	if (err !=3D HTTP_OK)
>=20
> That's note tested beyond compiling, but I think it should work. Feel
> free to squash it into your patch, or if you'd like, I can split out the
> refactoring steps with a commit message for you.

If you would split it out, that would be great.  Then I'll simply rebase
my patch on top of yours and go from there.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJScYreAAoJEL9TXYEfUvaLnrEP/AvIuNLlhej0Rrc2OInOH7nq
ieVV1YYBxfv+BZwRbSbtmVeQC1ECYbqrHG3YlCFG8gkjAeUH19KPg9o+RtIr0ne1
NIrqi2p5cQQnS0GDomynHjz2vZgu5HAukdn1orfNlkEH5eeGG6ZD4FbXimNa/Txz
v+UrZTa/o9K3bGxOcZQpHVJOyMkPGK1ITdCq/zna31wMNTBS+ZG7Dezso5722+GQ
2BYrbPTnyvG6lk2p/Q8y3f8PcEYzmqOnercO+Jmsq3ZCQNs4KfAxR8MPssO4unYB
FoNNr6a3Ppn7I+qacWo1TOui+KewdzESavLYfPq/7mMRVH1FnAxXSQcjG55ZuMWx
mKOloB7brbS7l5OKkuQy0oAOb1x/FJa9v2pxT7x3j6+DBb9z0sZOYSJGD94vO6hA
Fe/VQy1y2gT8MUSNGdcpOzqNvUtdHSb+3OJUtdXbpm3yfvCV8/ImJlJrWAat0Ewt
KsLY4X+o9hnLHqk5hzzSzIR3AjgkAMlOBVLDG6RhVUN6itMEmgIoJIeyABkD35W0
1ZYPfTiwRwcShSYumhZVX9134J200vhuOn4GmcLwdzFcoaOIoE1KKdvOi5n+/fun
4uxUsD1RZiBVbocitEx+J4u+wG4VsQ88ZED65ogs3r61n39y52wgqSauvvVa97ZR
najcYujKwKkWII9MCQUv
=ACWv
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
