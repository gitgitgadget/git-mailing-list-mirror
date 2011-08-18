From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] log: decorate "replaced" on to replaced commits
Date: Thu, 18 Aug 2011 11:16:55 -0700
Message-ID: <7vippua433.fsf@alter.siamese.dyndns.org>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fF-00025K-EW
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab1HRTx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 15:53:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1HRTxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 15:53:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F062B4B64;
	Thu, 18 Aug 2011 15:53:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=w5sxDIuF5Za6khuFIK8h0+n21
	kM=; b=rccAtlI3LG/PqW3CYyXoD3hu9LUTsEWrViQ3aWWDRz9/EHC9X4oBex0ON
	LNQw5tqdfq62+r3M8KvsXWRYJFcd2jJmIwlP0szibG5jEQ4ccOZdsqj/cxoMRkWX
	R740pWWbHtzAMW0umzQfSMZzNxaaR5Oet0YhOwyseNAAYA/PzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=j69N7Z7sRTBtHfMYUOl
	fhoomOZiKAaYxuDytQVjjoWNY5ehzvaoJB0gqv7m1KD/mH5a2ec8QV67mB+hK5LJ
	62V9uGgJDN5/82yp0R5lzxddrHUl2EzNXO5wgf8hORF/ogcvikYKxcB70ktm1ZZH
	Fr33Vmhq5+NUQ09nVCNfhKa0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F964B62;
	Thu, 18 Aug 2011 15:53:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AF524B61; Thu, 18 Aug 2011
 15:53:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCF6E5E0-C9D3-11E0-BF47-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179617>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Old code also decorates "new" commits with "refs/replace/SHA1". This
> is now gone, but I guess no one will miss it.

Makes sense but...

> +	if (!prefixcmp(refname, "refs/replace/")) {
> +		unsigned char original_sha1[20];
> +		if (get_sha1_hex(refname + 13, original_sha1)) {
> +			warning("invalid replace ref %s", refname);
> +			return 0;
> +		}
> +		obj =3D parse_object(original_sha1);
> +		if (obj && (obj->type =3D=3D OBJ_COMMIT || obj->type =3D=3D OBJ_TA=
G))

=2E.. is it necessary to check and limit the types like this here?

If the argument is "we know only commits and tags are listed and blobs =
and
trees are not shown with --decorate option" and "excluding the decorati=
on
that we know will never be used will avoid bloating the decorate hashta=
ble
with unused cruft", then add_name_decoration() should be doing the chec=
k
for all of its callers, not just this one, no?

> +			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
> +		return 0;
> +	}
> +
> +	obj =3D parse_object(sha1);
>  	if (!obj)
>  		return 0;
