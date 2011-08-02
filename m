From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] fast-import: don't fail on omitted committer name
Date: Tue, 02 Aug 2011 09:53:44 -0700
Message-ID: <7voc07g3fr.fsf@alter.siamese.dyndns.org>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
 <1311831844-13123-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 18:53:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoIE5-00038S-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 18:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab1HBQxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 12:53:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab1HBQxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 12:53:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB78D4D8D;
	Tue,  2 Aug 2011 12:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2tBzdDbN02xWv/I7wYB2KzN7BOw=; b=RLGl4a
	sRgmMLPdYgZYh+Ga7SdI21X+xb1gVhnGuzJXiIh3pYt0+dJ+1QcRpNk509X4Dkpj
	Uy1pW/0T85Zo+H8uvx45aWkg6nJ2bdCBRTH5tUhW8EHVbuQC6LcmNZsjjBL5Fwtx
	ZyEXfiUjNVXXqPGHK1/q7Skf+j2YJrtpWCL7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HaHddySWeJhIWeJ4J2GxzBg91nx9G58m
	kD2f8oL1pRx6nqD50PeQrNFYUafP/uu0IfLJIjfEB+zhSFyDhpnw7XEntZl0CE61
	7esVwQPuuaS2Hg0INfHrMUK/hY3vvNkr1XBo6ivJB4g3nmVuIXVYebGT+ZQmgWda
	gAhORC/v6tY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C38AF4D8C;
	Tue,  2 Aug 2011 12:53:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49C834D8B; Tue,  2 Aug 2011
 12:53:46 -0400 (EDT)
In-Reply-To: <1311831844-13123-3-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Thu, 28 Jul 2011 11:44:01 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCC30604-BD27-11E0-9FFE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178482>

Dmitry Ivankov <divanorama@gmail.com> writes:

> fast-import format declares 'committer_name SP' to be optional. But SP
> between empty or not name and a email is obligatory and checked by

Sorry, cannot parse this.

> git-fsck, so fast-import must prepend the SP if the name is omitted.
> Currently it doesn't.
>
> Name cannot contain LT or GT and ident always comes after SP in
> fast-import. So reuse that SP as if a valid 'SP <email>' ident was passed.
>
> This fixes a ident parsing bug for a well-formed fast-import input.
> Though the parsing is still loose and can accept a ill-formed input.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
>  fast-import.c          |    4 ++++
>  t/t9300-fast-import.sh |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 9e8d186..3194f4e 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1972,6 +1972,10 @@ static char *parse_ident(const char *buf)
>  	size_t name_len;
>  	char *ident;
>  
> +	/* ensure there is a space delimiter even if there is no name */
> +	if (*buf == '<')
> +		--buf;
> +
>  	gt = strrchr(buf, '>');
>  	if (!gt)
>  		die("Missing > in ident string: %s", buf);
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index a659dd4..09ef6ba 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -352,7 +352,7 @@ data <<COMMIT
>  empty commit
>  COMMIT
>  INPUT_END
> -test_expect_failure 'B: accept and fixup committer with no name' '
> +test_expect_success 'B: accept and fixup committer with no name' '
>  	git fast-import <input &&
>  	out=$(git fsck) &&
>  	echo "$out" &&
