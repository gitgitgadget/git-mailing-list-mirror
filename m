From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: hash non-delta objects while reading from stream
Date: Fri, 18 May 2012 15:15:27 -0700
Message-ID: <xmqq4nrd2l1c.fsf@junio.mtv.corp.google.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:15:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVVSf-0005WF-Mj
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 00:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab2ERWPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 18:15:31 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:50717 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2ERWPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 18:15:30 -0400
Received: by lbbgp10 with SMTP id gp10so197082lbb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 15:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=X4SRckDZFtvVkZ57LtfXLMbRAwJiOvwaXUCU8Zu7tfw=;
        b=MJOAfqHlCvaOHW48QdSVUdu8Wzq5O/NyAtUWtDnL5ClVMxo8tcrTGuFQfk/DrOX8k1
         17EuTzYVDNL9Qpn0vu6lUOLNkm7GiX9Ct8i/nABbhZ9XSWz8VLVMRgyCK5qJhRWERk5V
         TFu1TGXYtenVQHcShAjCF5rSkJXw1k2noHH/5xn1DAh9KnVBxN3kcuSCiaIy25OYacQp
         3H/WovLaRqAuSAWJytcYy6v0PPI7vx+75tOUlNsuHGy8Ocm79R404s4s546TkOnp3Pu2
         NVHxq8KZkz+s9gbTqS8ezKpkgsQRTYMW0kL9Oeg8Clg6Zs3Wo1qeXiNfF+jM60HwAhj1
         nvYQ==
Received: by 10.213.10.203 with SMTP id q11mr2416212ebq.4.1337379329044;
        Fri, 18 May 2012 15:15:29 -0700 (PDT)
Received: by 10.213.10.203 with SMTP id q11mr2416207ebq.4.1337379328955;
        Fri, 18 May 2012 15:15:28 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si9916841eeg.3.2012.05.18.15.15.28
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 15:15:28 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id BF28C5C0050;
	Fri, 18 May 2012 15:15:28 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 1DE64E1772; Fri, 18 May 2012 15:15:28 -0700 (PDT)
In-Reply-To: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:50:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkBmTDfLaV62OAcSLg7T/1ZWrNmDWjcFit6r1ArSvY+T9h0aWVc50otb6WkvsFwD1gekklXWmUFcf17Bc3ts6Wbie4UQnpYBm54108ZJWZc5C5feVKVOoqzZpBJmS85ZkrQHdkbSlmPMKOC/nAlA4bZiRRUkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197977>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void *unpack_entry_data(unsigned long offset, unsigned long s=
ize,
> +			       enum object_type type, unsigned char *sha1)
>  {
>  	int status;
>  	git_zstream stream;
>  	void *buf =3D xmalloc(size);
> +	git_SHA_CTX c;
> +	char hdr[32];
> +	int hdrlen;
> +	unsigned char *last_out;
> +
> +	if (!is_delta_type(type)) {
> +		hdrlen =3D sprintf(hdr, "%s %lu", typename(type), size)+1;

s/+/ & /;

> +		git_SHA1_Init(&c);
> +		git_SHA1_Update(&c, hdr, hdrlen);
> +	} else
> +		sha1 =3D NULL;
> ...
>  	memset(&stream, 0, sizeof(stream));
>  	git_inflate_init(&stream);
>  	stream.next_out =3D buf;
>  	stream.avail_out =3D size;
> +	last_out =3D buf;
> =20
>  	do {
>  		stream.next_in =3D fill(1);
>  		stream.avail_in =3D input_len;
>  		status =3D git_inflate(&stream, 0);
>  		use(input_len - stream.avail_in);
> +		if (sha1)
> +			git_SHA1_Update(&c, last_out, stream.next_out - last_out);
> +		last_out =3D stream.next_out;
>  	} while (status =3D=3D Z_OK);

Shouldn't "last_out" be scoped inside the loop, perhaps like this,

	do {
		unsigned char *boo =3D stream.next_out;
		stream.next_in =3D fill(1);
		stream.avail_in =3D input_len;
		status =3D git_inflate(&stream, 0);
		use(input_len - stream.avail_in);
		if (sha1)
			git_SHA1_Update(&c, boo, stream.next_out - boo);
	} while (status =3D=3D Z_OK);

instead of leaking it to the whole function?

> @@ -711,6 +730,8 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
>  	free(delta_data);
>  	if (!result->data)
>  		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
> +	hash_sha1_file(result->data, result->size,
> +		       typename(delta_obj->real_type), delta_obj->idx.sha1);
>  	sha1_object(result->data, result->size, delta_obj->real_type,
>  		    delta_obj->idx.sha1);
>  	counter_lock();

The call-chain after your patch looks like this:

    parse_pack_objects()
    . for each incoming object=20
      -> unpack_raw_entry()
	 . check type
         -> unpack_entry_data()
            . check type
            . unpack to obtain the data while hashing
	      if the type can be hashed.
      . check type
      . if the data is complete, let sha1_object() check it

The updated sha1_object() no longer hashes but the caller is responsibl=
e
for giving a correct hash value for the data, so you added a call to
hash_sha1_file() to the other caller (i.e resolve_delta()) of the
function.

The flow of the resulting code feels somewhat iffy that two functions
that are very far apart in the callchain have to coordinate among
themselves to ensure that the object data is always hashed once: plain
ones in unpack_entry_data() and deltified ones in resolve_delta().  It
smells like inviting future bugs when we introduce new in-pack types
that are neither delta or plain.

Overall it looks correct.  Thanks.
