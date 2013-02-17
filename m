From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sun, 17 Feb 2013 15:18:33 -0800
Message-ID: <7vvc9qedh2.fsf@alter.siamese.dyndns.org>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <1360999078-27196-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 00:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7DVj-0004ki-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 00:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3BQXSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2013 18:18:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab3BQXSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2013 18:18:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0E1BD93;
	Sun, 17 Feb 2013 18:18:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=he7JIlsNavyA
	G4l7a7/qxlA/9nc=; b=ikCRylI1u42jhmQyeDgzZC9htw9FraHCo4ScCs7IL08T
	VInr/cDSUqH1eL1F+WvKwumqfpbLgG6+HWhVhxyAi5c0zi5UJLH1KIRhhnisKe+J
	v9XRBj4D+fdjN0tImpY2o+/bFREcGxg1dofdLEM1aviTrILbn7PniSgHbdqnfEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=waNRWV
	r3eJCJSjNiG39INdcnXZ3P83wflhmvqynCkMW+kcI9jB2GNxltBJIA1ab/mV+Uv/
	GN9rAa0QJL8wZMWbiZRDDX31y4sCHqEroWJT0lGwpRkPYIBQDjyuKkNL4mwom7Zf
	sMdqPZNvTvy3yAlwxg38pkQZe0HMqV+zKpve4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23810BD91;
	Sun, 17 Feb 2013 18:18:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A87B3BD90; Sun, 17 Feb 2013
 18:18:34 -0500 (EST)
In-Reply-To: <1360999078-27196-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 16 Feb
 2013 14:17:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59E82984-7958-11E2-AEA0-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216411>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If path_handled is returned, contents goes up. And if check_only is
> true, the loop could be broken early. These will not happen when
> treat_one_path (and its wrapper treat_path) returns
> path_ignored. dir_add_name internally does a cache_name_exists() chec=
k
> so it makes no difference.
>
> To avoid this behavior change, treat_one_path is instructed to skip
> the optimization when check_only or contents is used.

OK, that makes more understandable why this is safe.

> @@ -1242,9 +1246,23 @@ enum path_treatment {
>  static enum path_treatment treat_one_path(struct dir_struct *dir,
>  					  struct strbuf *path,
>  					  const struct path_simplify *simplify,
> -					  int dtype, struct dirent *de)
> +					  int dtype, struct dirent *de,
> +					  int exclude_shortcut_ok)
>  {
> ...=20
> @@ -1331,18 +1347,29 @@ static int read_directory_recursive(struct di=
r_struct *dir,
>  		goto out;
> =20
>  	while ((de =3D readdir(fdir)) !=3D NULL) {
> -		switch (treat_path(dir, de, &path, baselen, simplify)) {
> +		switch (treat_path(dir, de, &path, baselen,
> +				   simplify,
> +				   !check_only && !contents)) {
> ...

Between these two places we may want to say what kind of short-cut
we are talking about, but there only is one kind of short-cut at
this moment, so let's leave that to other people who want to further
optimize things in this codepath by adding other short-cuts.

Thanks; will queue.
