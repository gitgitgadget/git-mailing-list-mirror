From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] correct blame for files commited with CRLF
Date: Tue, 05 Apr 2016 13:57:26 -0700
Message-ID: <xmqqoa9n22q1.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459884234-13026-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Apr 05 22:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anY2Y-0001Vj-1r
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 22:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031AbcDEU53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 16:57:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884AbcDEU53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 16:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F410C5333D;
	Tue,  5 Apr 2016 16:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7aaWNppcYAy0fTwl2N2b3zG59bk=; b=El7f4r
	Gxwx6hLtDmrc8MRWrBez9MnJg+ak64spcI5+0OCCbMmQH0QzBQW+1+J3G18XW4pQ
	bZQzMywdEQlFXZ3moxrnFBhzgvVRyGUWtesoY0vn9JlqCZ21x5kpArm8Duja9pkg
	AeQ6C5T71voVt+UZF48bfjuz/4y/eE/t5+Kog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nlyw+gigBn4UlvdaCBap3BtomM109p/w
	72qLH8GB7azTs0xIxkbzRIQ+LQv0Ltj1nCP5D5WytHs7Ll6r1x/sknjwpyF+vYEY
	tAAP6lIJgpGiZW0kIrDmiGfp4BFK8vK3qQ2/OcuYAr4sRYCQ9NOl1lrO6uL/PCWY
	LxF9Rl5YuTU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1B3E5333C;
	Tue,  5 Apr 2016 16:57:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53D7D5333B;
	Tue,  5 Apr 2016 16:57:27 -0400 (EDT)
In-Reply-To: <1459884234-13026-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Tue, 5 Apr 2016 21:23:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0121FB56-FB71-11E5-BE09-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290809>

tboegi@web.de writes:

>  This fix is completely independent of the rest of the series,
>  so break out 6/7 from tb/safe-crlf-output.

Sounds sensible.  It is somewhat sad and strange that we need to
rely on what is in the index to show the current working tree state,
but this makes the things more consistent.

Will queue.  Thanks.

> builtin/blame.c               |  1 +
>  t/t8003-blame-corner-cases.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e982fb8..21f42b0 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2307,6 +2307,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	unsigned mode;
>  	struct strbuf msg = STRBUF_INIT;
>  
> +	read_cache();
>  	time(&now);
>  	commit = alloc_commit_node();
>  	commit->object.parsed = 1;
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 6568429..a9b266f 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -212,4 +212,18 @@ test_expect_success 'blame file with CRLF attributes text' '
>  	grep "A U Thor" actual
>  '
>  
> +test_expect_success 'blame file with CRLF core.autocrlf=true' '
> +	git config core.autocrlf false &&
> +	printf "testcase\r\n" >crlfinrepo &&
> +	>.gitattributes &&
> +	git add crlfinrepo &&
> +	git commit -m "add crlfinrepo" &&
> +	git config core.autocrlf true &&
> +	mv crlfinrepo tmp &&
> +	git checkout crlfinrepo &&
> +	rm tmp &&
> +	git blame crlfinrepo >actual &&
> +	grep "A U Thor" actual
> +'
> +
>  test_done
