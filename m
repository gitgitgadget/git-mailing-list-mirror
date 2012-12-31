From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Mon, 31 Dec 2012 10:31:43 -0800
Message-ID: <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9gory?= Pakosz <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 19:32:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpk9e-00076g-R0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab2LaSbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 13:31:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab2LaSbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Dec 2012 13:31:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9B36B82F;
	Mon, 31 Dec 2012 13:31:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cJ62zsZo4byt
	WWF0lUBJyrHA8js=; b=Eiq+b9Isf8FU4zsXI6C/dB4cFvA6cyqltCgzBLKWyP0z
	PBq9/J7/1pazY+lnnsE5UExibEcCYPyS8/CCGVMPwU8wZq4Z0ews6MjLQ/geIYye
	IDyrgbzO1g2HDy+zNy//HMuDl4AwjqnQdvTeBJzJgMfQKDYdDejnhabF6sO2z/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yfTo9E
	uPBMsJ5zV64zeO7IMAu7S5vGn4pBno7pihLTUOb/6eDDwIeI9ygxOpK7hkTeaMRF
	zS45Yp/Y2O6EDSfpt8rHddjAF/mbZ7jaAIiK5J0nbAeCce3Wrvq1EiR1p/4g6LFX
	RPD55GAd/4Q9oVfnzdptDlL3AZAONsZZ9dRfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C934B82E;
	Mon, 31 Dec 2012 13:31:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19B25B82D; Mon, 31 Dec 2012
 13:31:45 -0500 (EST)
In-Reply-To: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 (=?utf-8?Q?=22Gr=C3=A9gory?= Pakosz"'s message of "Mon, 31 Dec 2012 17:24:11
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 545D74AC-5378-11E2-95A6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212357>

Gr=C3=A9gory Pakosz <gpakosz@visionobjects.com> writes:

>   1) either make git-filter-branch dereference annotated tags and do
> the verification itself then use the two arguments version of git
> update-ref
>   2) in the case of an annotated tag, pass another <old value> to git=
 update-ref
>
> Please find below a patch that implements solution 1).
> ...
>  		echo "Ref '$ref' was deleted"
> -		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
> +		test $(git rev-parse --verify "$ref^{commit}") =3D $sha1 && git
> update-ref -m "filter-branch: delete" -d "$ref" ||

Thanks.  A few comments.

At the design level.  Where does this $sha1 come from in the first
place?  If a ref that named the annotated tag was deleted, shouldn't
we arrange things so this part of the code receives the $sha1 of the
tag that corresponds to the $ref so that "update-ref -d" can check
that nobody tampered with the repository while the script was
working?

At the implementation level.  When the ref being deleted pointed at
a tree or a blob, the original would have correctly removed it, but
will the updated one?
