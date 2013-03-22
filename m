From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff
 hunk header regex.
Date: Fri, 22 Mar 2013 08:02:03 -0700
Message-ID: <7vehf78olw.fsf@alter.siamese.dyndns.org>
References: <loom.20130322T144107-601@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 16:02:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3UK-0002KL-IK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 16:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3CVPCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 11:02:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993Ab3CVPCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 11:02:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00223BA84;
	Fri, 22 Mar 2013 11:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C5J9HFqB11LLkSRflQblbZvO2t4=; b=UzC2UC
	QrXGiWkb0kNwRsh7oO1FTovScYyzy+C4zrVOTO/B8H6IsO0SHFYHEY3oZe3aNfoS
	xFAp4yJje3pgsoTCvzDXBLMJyuDps9pJA7jQmZ/zhhz7S8HuP/PCpyROgLShFqab
	DI6SeZDiv9ammOFnb4Wr2dNW6lZrKNvPL3UPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j3RpOrH8WZZIkS3ULnouwJ3Oc7neLaw5
	Jy11IgSgi1tCkSGZolYD/LQae9nkXw3VgDYqjylYIfMv2/s3IHJ+ex97Y+cyfq6q
	QMb9C0OtPHrJ8Q13SrmZvWeaRdNCWmuvVzY8lPN3lD8zsV26uVt6pmtlf8lYrKwK
	8uLdkz7Nzrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8EC3BA83;
	Fri, 22 Mar 2013 11:02:05 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 693D2BA82; Fri, 22 Mar 2013
 11:02:05 -0400 (EDT)
In-Reply-To: <loom.20130322T144107-601@post.gmane.org> (Vadim Zeitlin's
 message of "Fri, 22 Mar 2013 13:43:52 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75C14196-9301-11E2-A10F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218811>

Vadim Zeitlin <vz-git@zeitlins.org> writes:

> A C++ method start such as
>
>         void
>         foo::bar()
>
> wasn't recognized by cpp diff driver as it mistakenly included "foo::bar" as a
> label. However the colon in a label can't be followed by another colon, so
> recognize this case specially to correctly detect C++ methods using this style.
>
> Signed-off-by: Vadim Zeitlin <vz-git@zeitlins.org>
> ---
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index ea43a03..9415586 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -125,7 +125,7 @@ PATTERNS("tex",
> "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>          "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
>  PATTERNS("cpp",
>          /* Jump targets or access declarations */
> -        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
> +        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"

Hmm.  Wouldn't "find a word (possibly after indentation), colon and
then either a non-colon or end of line" be sufficient and simpler?
iow, something like...

       "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:]|$)"

>          /* C/++ functions/methods at top level */
>          "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[
> \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
>          /* compound type at top level */
> --
> 1.8.2.135.g7b592fa
