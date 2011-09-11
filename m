From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 13:43:12 -0700
Message-ID: <7vty8iolnj.fsf@alter.siamese.dyndns.org>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 22:43:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2qs9-0005fh-A0
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab1IKUnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 16:43:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab1IKUnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 16:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2C85A15;
	Sun, 11 Sep 2011 16:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4VmfLaOtEK5YhzJWRssCKryAsk=; b=WhYUuh
	Aly3XDomok+hbxIpU03bvNGbA5QC2B1zDhJp+iT4zJ1VMOsAPTWdQzOMyIkSR8R1
	vM/gaX9lfeaUGl4ogURP/wL7nRH9zi2RcnyaW0m0Bewr0WQa/iIo/HMYTW49ji+9
	7cr5G7q1UtBpgzhhCZugCXYNJ5g0C6CshWRQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sj9SbS5CIcA90dKi7MAWe/FubFILWmCC
	BYVwHbxYrlkBLBvqqkAFCl7fwOl9y6cA6wjGj5eg3K1iaFunoU8JBhqulfpR0jRy
	f3e/JVOOwyxIUO3UzGUM68nWBMovFYZ3PVSejJSP8A/SlbBXjfjJfw4WXvgQZTiM
	2ywe9ZRQ95U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3A615A14;
	Sun, 11 Sep 2011 16:43:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D6D55A12; Sun, 11 Sep 2011
 16:43:14 -0400 (EDT)
In-Reply-To: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com> (BJ
 Hargrave's message of "Sun, 11 Sep 2011 11:40:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB9F59F4-DCB6-11E0-B762-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181192>

BJ Hargrave <bj@bjhargrave.com> writes:

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 5ae0366..ad6d713 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -232,9 +232,10 @@ static void check_unreachable_object(struct object *obj)
>  				char *buf = read_sha1_file(obj->sha1,
>  						&type, &size);
>  				if (buf) {
> -					if (fwrite(buf, size, 1, f) != 1)
> -						die_errno("Could not write '%s'",
> -							  filename);
> +					if (size > 0)
> +						if (fwrite(buf, size, 1, f) != 1)
> +							die_errno("Could not write '%s'",
> +								  filename);

Funny.

I am sure we fixed a similar breakage elsewhere a few years ago, by
swapping the size and nmemb to the calls (i.e. instead of writing one
block of "size" bytes, you could write "size" blocks of 1-byte) and making
sure fwrite() reports the number of items. IOW

	if (buf && fwrite(buf, 1, size, f) != size)
		die_errno("Could not write '%s'", filename);
