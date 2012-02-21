From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tag: refuse tag messages that contain NULs
Date: Tue, 21 Feb 2012 12:47:06 -0800
Message-ID: <7vpqd7gbhx.fsf@alter.siamese.dyndns.org>
References: <7v39a6pkmb.fsf@alter.siamese.dyndns.org>
 <1329741483-22567-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzwcG-0005zL-MA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab2BUUrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 15:47:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753Ab2BUUrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 15:47:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BEBB62A5;
	Tue, 21 Feb 2012 15:47:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ohvaa011hb1E
	74koZcmTfS2TNmM=; b=u1lak4pUz0NXVYbVdvA8qs0nZXTwBIphAQMK9ez2EaB5
	kVFzI0AxhMrDbGVG7WBK0kLOI2uNHcKHCk77B3oUg4hSGNdQhjnXuZQLSdHn0lLF
	Skol3jFSZ1ut91RRh2b/wkP41T5xJSzTLY781+8f3gt3WuaW4LUNkmMX/uZiaaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ByBZ8H
	NqgNgeLaXYazxN8cvHo0W3gFvLCkY451fhNCD87PFc4aI9ShK9wBHyKnaPVZIxsz
	K3VUdPqG4cH5OOIHQDpL5roJW1GIAX++0zaisJTnM3dgyB37a8mDvkof2X7+gkuG
	Snaba9eCgMXn2N8DMe5WgnjA8kFlQFyYKOW5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83C8062A4;
	Tue, 21 Feb 2012 15:47:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD76C62A2; Tue, 21 Feb 2012
 15:47:07 -0500 (EST)
In-Reply-To: <1329741483-22567-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 20 Feb
 2012 19:38:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3839973A-5CCD-11E1-9D17-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191182>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  It's not about after those. It's about right before write_sha1_file(=
).
>  I wanted to catch all NULs no matter how they come. But yes the chec=
k
>  should happen early to avoid wasting user's time (e.g. doing signing=
)

No, it is not about that.  It is about checking _the input_.  If we had
bugs in do_sign() that adds what we do not want, that is not a user's
fault and "a NUL byte in tag message not allowed" is an inappropriate
thing to give to the user.

And giving "We screwed up and added NUL that you cannot work around to
remove, sorry, you hit a bug." is not very useful.

>  So how about this?
> ...
> diff --git a/sha1_file.c b/sha1_file.c
> index 88f2151..2fc8623 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2519,6 +2519,12 @@ int write_sha1_file(const void *buf, unsigned =
long len, const char *type, unsign
>  	char hdr[32];
>  	int hdrlen;
> =20
> +	/* GIT_HASH_NUL is for the test suite to hash abitrary content */
> +	if (!getenv("GIT_HASH_NUL") &&
> +	    (!strcmp(type, commit_type) || !strcmp(type, tag_type)) &&
> +	    memchr(buf, '\0', len))
> +		return error("BUG: %s message contains NUL.", type);
> +

This is yucky.  Is this really worth it?

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index e93ac73..8cb13e5 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1269,4 +1269,8 @@ test_expect_success 'mixing incompatibles modes=
 and options is forbidden' '
>  	test_must_fail git tag -v -s
>  '
> =20
> +test_expect_success 'tag content contains NUL' '
> +	test_must_fail git tag -F "$TEST_DIRECTORY"/t3900/UTF-16.txt utf16
> +'
> +

This is caught without the change to write_sha1_file(), isn't it?  If s=
o,
I would say we should drop that GIT_HASH_NUL hunk.
