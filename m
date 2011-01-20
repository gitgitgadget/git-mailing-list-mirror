From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correctly report corrupted objects
Date: Thu, 20 Jan 2011 13:05:03 -0800
Message-ID: <7vsjwnqoao.fsf@alter.siamese.dyndns.org>
References: <20110120201220.GD12418@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg1h4-00013v-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab1ATVFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 16:05:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1ATVFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jan 2011 16:05:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36E063B22;
	Thu, 20 Jan 2011 16:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VzH8SMwhdgdb
	AkjX7RzTUYehQAE=; b=guEoA4+dV1wwEm+0/XWCueY7BSu8QQkL5UG/z3p2+Gso
	winh3p3auj5QfgB/OUTy3rUhqAUNw3f8JaTdfWyVz+MOV8XcTS1WWb2uDFECou4J
	MnEpbUvE+KSAf/fxB4vvuPfNZoQjYoeWs8quJFkfli590N6UXgjZt4A8eMIVfxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rT1tb+
	lwobZZcd/N0SYPuwO/4kO84BbiwZHS7QEB1Xw0IphGypuF8D7vhDR9bL9H2PU42w
	FFbgUmqUQ3YWwYLykbtXyOJ4SVqNb+r+JZG0h+86p/iMBkOqAdngk/3JCSEtJKIW
	5RsVTMU+LbaumOucpsw3kEwVTDYRf12vvJPqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 039F23B21;
	Thu, 20 Jan 2011 16:05:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC3BD3B1F; Thu, 20 Jan 2011
 16:05:52 -0500 (EST)
In-Reply-To: <20110120201220.GD12418@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Thu\, 20 Jan 2011 21\:12\:20
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13330408-24D9-11E0-A387-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165337>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> The errno check added in commit 3ba7a06 "A loose object is not corrup=
t
> if it cannot be read due to EMFILE" only checked for whether errno is
> not ENOENT and thus incorrectly treated "no error" as an error
> condition.
>
> Because of that, it never reached the code path that would report tha=
t
> the object is corrupted and instead caused funny errors like:
>
>   fatal: failed to read object 333c4768ce595793fdab1ef3a036413e2a8838=
53: Success
>
> So we have to extend the check to cover the case in which the object
> file was successfully read, but its contents are corrupted.

Hmm, what is the exact code path that read_object() callchain fails to =
set
errno when it returns a NULL?  It is unclear from the above description=
=2E
Is there a funny object replacement involved?

> Reported-by: Will Palmer <wmpalmer@gmail.com>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
>  sha1_file.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 1cafdfa..d86a8db 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2141,7 +2141,7 @@ void *read_sha1_file_repl(const unsigned char *=
sha1,
>  		return data;
>  	}
> =20
> -	if (errno !=3D ENOENT)
> +	if (errno && errno !=3D ENOENT)
>  		die_errno("failed to read object %s", sha1_to_hex(sha1));
> =20
>  	/* die if we replaced an object with one that does not exist */
> --=20
> 1.7.4.rc2.18.gb20e9
