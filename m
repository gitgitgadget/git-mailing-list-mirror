From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Tue, 25 Mar 2014 13:49:28 -0700
Message-ID: <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com>
References: <5331B6F6.60501@web.de> <5331B717.5010600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSYHy-0004na-4C
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 21:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbaCYUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 16:49:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbaCYUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 16:49:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF2B3763AD;
	Tue, 25 Mar 2014 16:49:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KL/Ay0ttlzydprsjRXEn3aSbQk=; b=OLZst9
	dPBgK3ZYhr6z9qaY/bwTdDVgdbw1GbnX9FQiaurPpMnGEFRY5mb+w/krtEnAyrHD
	kwq+mw+pDeTqv8aBD9IyQIlLfAwqqpfL3X7ECOi4A+VgWRIOKYVVxslMxvSdc5nq
	oeJZiIL7OjU9dgw41K6w91uhiZPIOm6y78pY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ges5sKm8MWQixJE73GiwzafxCFqVZph1
	+DXF1TgbItJPXzLvre1WwhrzLLvC1YwGtruVYoZdd9SU5O2+jnit/hA5lID/hA8E
	IzI/Kri3aZklM6bjKkW1kTtfnG80tfSIn4/hQPfN3db//Z78MsUjPpn1Fz6BJJ9w
	ZZrgbUbrfGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC7B763AC;
	Tue, 25 Mar 2014 16:49:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BA4A763AB;
	Tue, 25 Mar 2014 16:49:29 -0400 (EDT)
In-Reply-To: <5331B717.5010600@web.de> (Jens Lehmann's message of "Tue, 25 Mar
	2014 18:04:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F621FE5A-B45E-11E3-9E18-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245153>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> For the upcoming submodule test framework we often need to assert that an
> empty directory exists in the work tree. Add the test_dir_is_empty()
> function which asserts that the given argument is an empty directory.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> I believe this one is pretty straightforward (unless I missed that this
> functionality already exists someplace I forgot to look ;-).

I am not very thrilled to see that it depends on "." and ".." to
always exist, which may be true for all POSIX filesystems, but
still...

Do expected callsites of this helper care if "$1" is a symbolic link
that points at an empty directory?

What do expected callsites really want to ensure?  In other words,
why do they care if the directory is empty?  Is it to make sure,
after some operation, they can "rmdir" the directory?

>  t/test-lib-functions.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 158e10a..93d10cd 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -489,6 +489,17 @@ test_path_is_dir () {
>  	fi
>  }
>
> +# Check if the directory exists and is empty as expected, barf otherwise.
> +test_dir_is_empty () {
> +	test_path_is_dir "$1" &&
> +	if test $(ls -a1 "$1" | wc -l) != 2
> +	then
> +		echo "Directory '$1' is not empty, it contains:"
> +		ls -la "$1"
> +		return 1
> +	fi
> +}
> +
>  test_path_is_missing () {
>  	if [ -e "$1" ]
>  	then
