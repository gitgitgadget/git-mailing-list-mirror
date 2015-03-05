From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive-zip: add --text parameter
Date: Wed, 04 Mar 2015 18:16:27 -0800
Message-ID: <xmqq7fuw5guc.fsf@gitster.dls.corp.google.com>
References: <12g5ss8uqwflv.dlg@nililand.de> <54F77573.80109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luatex@nililand.de, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 03:16:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTLL0-00068e-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 03:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbbCECQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 21:16:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754114AbbCECQa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 21:16:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20C893DA6D;
	Wed,  4 Mar 2015 21:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G+lf9NIQLdWn
	1fn8FR1ixHPj6CE=; b=asAMeLrLR5pw2+rnnx+x45VINA8yFLb+U7QvnsG2qCXK
	pLcS0YbH0EQDG7kHnHyqbbDzXhfcoQD5wD/GZDSeV3t6VJzHOsvj6Pz8q/CPbKSN
	4a+HhLB6lJA4jGSUgBGlu80wI/a3Pwgzz1R6uz7NEKRLgBpMF0n5XmPA4p3z+YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rl5hWr
	CUC064P6RGDN/ZedzaTwfleCYljx0JlCwpJ470BMB+baMzwQO2ktnT9mTuL2O7K/
	99TNvW64pgGU3Kwld/r+idVCIbdh6QPdCdJ3WBOLT9zXtNZ0Na6ZVluzG0oQ1Y1p
	BPH7w6BN5QEZnThgDcK7AG4Ahyd7mPxk7R+Ew=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 189CA3DA68;
	Wed,  4 Mar 2015 21:16:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7487D3DA65;
	Wed,  4 Mar 2015 21:16:28 -0500 (EST)
In-Reply-To: <54F77573.80109@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 04 Mar
	2015 22:13:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1BB0EAE-C2DD-11E4-8790-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264811>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> No sign-off, yet, because I'm not sure we really need another option.
> E.g. --text=3Dall doesn't seem to be actually useful, but it was easy=
 to
> implement.  Info-ZIP's zip always creates archives like --text=3Dauto
> does, so perhaps we should make that our default behavior as well?

My knee-jerk reaction is "yeah, why not? what are the downsides,
other than the result will not be bit-for-bit identical to the
output from older Git".  I am sure I am missing something as I do
not regularly use this format.

> @@ -256,6 +264,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>  				return error("cannot read %s",
>  					     sha1_to_hex(sha1));
>  			crc =3D crc32(crc, buffer, size);
> +			if (is_binary < 0)
> +				is_binary =3D buffer_is_binary(buffer, size);

In this codepath, do you have the path of the thing the buffer
contents came from?  I am wondering if consulting the attributes
system is a better idea. Anything that is explicitly marked as
"binary" or "-diff" is definitely binary, and anything that is not
marked as "binary" is text to us for all practical purposes, no?
