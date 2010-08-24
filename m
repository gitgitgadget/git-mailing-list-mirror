From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/32] move do_compress() from pack-objects.c to
 pack-write.c
Date: Tue, 24 Aug 2010 18:25:54 -0500
Message-ID: <20100824232554.GF2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <1282688422-7738-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 01:28:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2uU-0004jH-FV
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 01:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404Ab0HXX1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 19:27:52 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39891 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab0HXX1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 19:27:37 -0400
Received: by qwh6 with SMTP id 6so6632626qwh.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wDic0IDLmVOjSQ+1BBCbghBZoSoSVuio3zwMJZ+hQDA=;
        b=MFf/Z8azBqDbCTrHvZgOny1/6YjKG+WwJUo4As6T5gg5umtMv6CmtAIq4619Ncm6pA
         hOFlAz1ErsqVrPA8DweCjkRmLhdP0HVAaBNpXuX5itwVZ22R2a+TGEWi0q+aXQNpV6B2
         4xkKay2UdGYfWwdioSNAgzEmBVDG6bU8WjvhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sXDxUKG+R/UEE4CdlEXAioL3++sHEvyC2t5fjbul/J9u6O1zC7Q6jZmH2ZxNPyPqu3
         8BXIAeQrBTzwCBMIQBOISZBQ7u259z7mhk6v21hW5Ekg9hfz4vhnva4zP5E1EMee2jyp
         6NnM2X2E939hLA8sbd6S8iTvbl8sEAuxbyc5Q=
Received: by 10.229.211.21 with SMTP id gm21mr3307202qcb.135.1282692456912;
        Tue, 24 Aug 2010 16:27:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e6sm749484qcr.5.2010.08.24.16.27.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 16:27:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282688422-7738-5-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154382>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Subject: [PATCH 04/32] move do_compress() from pack-objects.c to pack=
-write.c

exposing it as internal API.  Makes sense.

> +unsigned long compress_object(void **pptr, unsigned long size)
> +{
> +	z_stream stream;
> +	void *in, *out;
> +	unsigned long maxsize;
> +
> +	memset(&stream, 0, sizeof(stream));
> +	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
> +	maxsize =3D deflateBound(&stream, size);
> +
> +	in =3D *pptr;
> +	out =3D xmalloc(maxsize);
> +	*pptr =3D out;
> +
> +	stream.next_in =3D in;
> +	stream.avail_in =3D size;
> +	stream.next_out =3D out;
> +	stream.avail_out =3D maxsize;
> +	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
> +		; /* nothing */
> +	deflateEnd(&stream);
> +
> +	return stream.total_out;
> +}

However, there is nothing particularly specialized to git objects
about this.  e.g. deflate_it() from diff.c could use this.
