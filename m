From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] attr: allow pattern escape using backslash
Date: Sat, 06 Oct 2012 00:54:30 -0700
Message-ID: <7vzk40qbm1.fsf@alter.siamese.dyndns.org>
References: <1349508125-24775-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 09:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKPDm-00053f-07
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 09:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab2JFHye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 03:54:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2JFHyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 03:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E716868;
	Sat,  6 Oct 2012 03:54:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hq62b5Rw8jRH
	HXT5g8eW28nQZEY=; b=AkWCYYAfs8WAMINSZOfVJV2n5RgrmMjt1BJ9H3xUNih7
	LWrF/15xXuhQ59xFbU8j7OCO3ASG5Rj/EZhUKCxDJH47h+MN6Wog67YpFPnIZsNx
	+YiQUly/rk5urYCv+vl1rwBe3Irez6pZeQeJzSYOsfbupiYKJkUdQiPY635uq0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=er9zGE
	jhGxtvv0n2SdEE+g7DyvNe49cYlQsga+0D8ISYtJlcDosA4FCnfMjvNESlNJnLu4
	OZwF2z2O+YwcLjlBJFNOelZckqQans6s0MTi0SkAMiiH7jiyFMF4VEG7pRyDgj3F
	lA1qZmCjvedrDH5DwX6E45vphjCf3YylEEScU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB2D96867;
	Sat,  6 Oct 2012 03:54:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C0BC6866; Sat,  6 Oct 2012
 03:54:32 -0400 (EDT)
In-Reply-To: <1349508125-24775-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 6 Oct
 2012 14:22:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1051997C-0F8B-11E2-84EE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207136>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> .gitattributes pattern syntax is supposed to be the same as .gitignor=
e
> (except a few things that do not make sense in attr context, but
> that's a different issue). .gitignore uses fnmatch() as the matching
> machinery and "\" is accepted as an escape code. In theory the patter=
n
> 'foo\ bar' should match path 'foo bar' in .gitignore. Granted, no one
> would write 'foo\ bar' in .gitignore when 'foo bar' should
> suffice.
>
> Regardless, 'foo\ bar attr' does not (but should) attach "attr" to
> path "foo bar" because pattern/attr parse code does not understand
> backslash escape. It parses the line as path 'foo\' and attributes
> 'bar' and 'attr'. This patch teaches attr code to recognize the
> backslash in patterns (not macro names) and pass 'foo\ bar' down to
> fnmatch().
>
> This changes the attr behavior. "foo\ attr", if exists in the field,
> would match nothing because path "foo\" is invalid in UNIX and is a
> directory in Windows, which we do not accept attaching attributes
> to. With this patch, that line becomes invalid and is rejected. So
> it's not really bad (i.e. no silent changes in behavior).
>
> Other subtle behavioral changes may happen. Still, I think we should
> do this as it seems like a correct thing to do.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  We discussed the "spaces in path names in attr" before and I remembe=
r
>  using quotes or double quotes, even substituting spaces with
>  dots, were raised. I don't remember if backslashes were mentioned.

My knee-jerk reaction, without thinking things through, is that this
makes sense and doing the same for .gitignore would, too (even
though the one-item-per-line nature of .gitignore makes "\ " and " "
practically equivalent).

Shouldn't we do the same for quoting fnmatch(3) metacharacters?  To
match a path component 'a' followed by an asterisk followed by 'b',
you could then write 'a\*b'.  Same for quoting the backslash itself.
