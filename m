From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] archive: support filtering paths with glob
Date: Mon, 22 Sep 2014 12:15:27 -0700
Message-ID: <xmqq4mvzlb5c.fsf@gitster.dls.corp.google.com>
References: <1433062.XhRCATRB3s@al>
	<1411271706-1151-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peter@lekensteyn.nl
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 21:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW95H-0006Ds-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 21:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbaIVTPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2014 15:15:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61788 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaIVTPe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2014 15:15:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8852C3C3D7;
	Mon, 22 Sep 2014 15:15:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xLRKw/ksHKwn
	/pGFGJ6BUkg46Hk=; b=w78jStyEtHdYrhCgVR0c1Zfg4rpMLUmVC3wEXCPDw1NA
	5wU17iaKQ/NjgGRBpraRvhHQHxY0tIFqCI2ThEEFJN2mzWJs1k0W3gi7GVZv+tgN
	grU44db2a8gNotrwmxVvnFWHFWJgT+KVNxMuHJ4GwCbokz5g4KeiADcXQSNBR0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JCKlTJ
	Z02iVVTsvTqsh36pNvPpERD4MfBhutQ41AxA9nRZc8AocqOYIdenJmKrC2k8wrX4
	mLsCCx5DuyC4bZ2/VIFI1LqjKhIMTBPEfpeyd3mKmMxnu+LYw5lL6a0oFwuJdTz/
	0zs+wkbjMpU6J8p768zq4J+v/SFNnlolYBUV8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 687353C3D6;
	Mon, 22 Sep 2014 15:15:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D56B23C3D3;
	Mon, 22 Sep 2014 15:15:30 -0400 (EDT)
In-Reply-To: <1411271706-1151-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 21
 Sep 2014 10:55:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1E9108E-428C-11E4-BD21-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257377>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void queue_directory(const unsigned char *sha1,
> +		const char *base, int baselen, const char *filename,
> +		unsigned mode, int stage, struct archiver_context *c)
> +{
> +	struct directory *d;
> +	d =3D xmallocz(sizeof(*d) + baselen + 1 + strlen(filename));
> +	d->up	   =3D c->bottom;
> +	d->baselen =3D baselen;
> +	d->mode	   =3D mode;
> +	d->stage   =3D stage;
> +	c->bottom  =3D d;
> +	d->len =3D sprintf(d->path, "%.*s%s/", baselen, base, filename);
> +	hashcpy(d->sha1, sha1);
> +}
> +
> +static int write_directory(struct archiver_context *c)
> +{
> +	struct directory *d =3D c->bottom;
> +	int ret;
> +
> +	if (!d)
> +		return 0;
> +	c->bottom =3D d->up;
> +	d->path[d->len - 1] =3D '\0'; /* no trailing slash */
> +	ret =3D
> +		write_directory(c) ||

By recursing into itself using c->bottom set to one level higher, we
first flush all the leading directories.

> +		write_archive_entry(d->sha1, d->path, d->baselen,
> +				    d->path + d->baselen, d->mode,
> +				    d->stage, c) !=3D READ_TREE_RECURSIVE;

And after the entries for the leading directories, we write an entry
for this directory.

Which makes sense; presumably the caller will then write an entry
that hangs this directory after calling this.

When we have a/b/c and a/d/e to be written, the first round would
write a/ and then a/b/ with the above, and presumably elsewhere
somebody will write a/b/c; next time around we do need to write a/d/
but we wouldn't want to write a/ itself.  How is this code
preventing the recursion going all the way up every time to avoid
repeating a/?

Puzzled...

> +	free(d);
> +	return ret ? -1 : 0;
> +}
> +
> +static int queue_or_write_archive_entry(const unsigned char *sha1,
> +		const char *base, int baselen, const char *filename,
> +		unsigned mode, int stage, void *context)
> +{
> +	struct archiver_context *c =3D context;
> +
> +	while (c->bottom &&
> +	       !(baselen >=3D c->bottom->len &&
> +		 !strncmp(base, c->bottom->path, c->bottom->len))) {

Is this comparison, which does not see if the substring matches from
the beginning but without making sure that the tail of the shorter
substring coincides with the directory boundary in the longer
string, correctly done?  Or does it consider abcd/ef is inside abc/?

Ah, we should be OK as I think <base, baselen> is passed with a
trailing slash appended in read_tree_1() when it recurses, so this
comparison is correct.
