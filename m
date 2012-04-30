From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] archive-tar: turn write_tar_entry into blob-writing
 only
Date: Mon, 30 Apr 2012 11:15:13 -0700
Message-ID: <7vr4v5f5n2.fsf@alter.siamese.dyndns.org>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
 <1335761837-12482-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 20:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOv87-0007pD-TA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab2D3SPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 14:15:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab2D3SPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 14:15:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DA8663E;
	Mon, 30 Apr 2012 14:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5UJJCKgI0HYE
	y7nDFdNc93w6LNE=; b=ioSrFDhm4cNVRSpHEnLYTeEtOWEKsyLV0VkTxrA3Guww
	rVJFcrbZyhOA6NODpBFB73lm+IPoYaaMqkiGmM4NClLIcUsW8hEPos2A/qbbyjp1
	FX/HTNE2GRZTNs1ozFBLWAskyUTG6RdbshV9xbBemDbzd3M2vnEd/TlKtCwCX9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ke3Ggp
	ozJFik1OsHQkX0aRkMPJ6hKnmh3gbtIRaIkyAqbcti8xczh+l2vxmzsGAK8UpFJY
	CUep7pO3yFpNCmZ6QutX6Aup02mOBB6JZ8HHdYENXBqcMl9ZKXwCaIVCAn3B9s7/
	xoajKE1LmaboELafqiO6Aw8p1bNO19HVDfHBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0935F663D;
	Mon, 30 Apr 2012 14:15:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7204A6637; Mon, 30 Apr 2012
 14:15:15 -0400 (EDT)
In-Reply-To: <1335761837-12482-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 30 Apr
 2012 11:57:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F4A78E4-92F0-11E1-BD3C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196587>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Before this patch write_tar_entry() can:
>
>  - write global header
>    by write_global_extended_header() calling write_tar_entry with
>    with both sha1 and path =3D=3D NULL
>
>  - write extended header for symlinks, by write_tar_entry() calling
>    itself with sha1 !=3D NULL and path =3D=3D NULL
>
>  - write a normal blob. In this case both sha1 and path are valid.
>
> After this patch, the first two call sites are modified to write the
> header without calling write_tar_entry(). The function is now for
> writing blobs only.

Nice.

I am kind of surprised how hacky the original code that switched on !sh=
a1
and !path was, especially given that it came from Ren=C3=A9 at ae64bbc
(tar-tree: Introduce write_entry(), 2006-03-25) --- it even claims that
these are "reasonable" magic values ;-).
