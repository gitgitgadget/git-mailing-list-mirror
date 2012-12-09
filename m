From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: Fix wrapping lines of wraplen
Date: Sun, 09 Dec 2012 01:36:28 -0800
Message-ID: <7v8v97efdv.fsf@alter.siamese.dyndns.org>
References: <1354993767-7455-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jan H. Schoenherr" <schnhrr@cs.tu-berlin.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 10:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThdMZ-0005r2-0C
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795Ab2LIJge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 04:36:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932779Ab2LIJgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 04:36:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E1982F5;
	Sun,  9 Dec 2012 04:36:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PCwTN3Rdlc/jb+qlVDpJEboLtWc=; b=V/FXME
	KTVTyodyopD5+JOWiZ1i2yMz6X4/ULY742RWhqFvxERtSRAn7WXURTy4HKUWUgIu
	Rmoo4TmyenDwUeFZgZZRC4YxgBd+4hgI3JdJyxcmmnkDkglUYFIu6Brx0t0ntUwS
	TQhusPreoFwr/Nqil/ZMHIAT7M4vsd7sF4L9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yI/1NDguXYoNVD4gM+i0pb2alf/Te5so
	CDhtGYAsDQwvd+UyS9lNzJQwZvYaBtOSFV3sBjFSB2P/V5m+0AmO0t8wSiJINr+3
	5vje8IXjZf2nWwcHRjc7GQiH1QHKbFIhNpgpe/h0cS38HDkB57DPk8WFDCGTdOEh
	lpBNO6MPuuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B136982F3;
	Sun,  9 Dec 2012 04:36:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03C2682EE; Sun,  9 Dec 2012
 04:36:29 -0500 (EST)
In-Reply-To: <1354993767-7455-1-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Sat, 8 Dec 2012 20:09:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E93164AE-41E3-11E2-9B13-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211230>

Steffen Prohaska <prohaska@zib.de> writes:

> A recent commit [1] fixed a off-by-one wrapping error.  As
> a side-effect, add_wrapped_shortlog_msg() needs to be changed to always
> append a newline.

Could you clarify "As a side effect" a bit more?  Do you mean
something like this?

    Earlier strbuf_add_wrapped_text() ended its output with a
    newline only when the end of the text exactly fitted in wrap
    length, due to the off-by-one error fixed with 14e1a4e (utf8:
    fix off-by-one wrapping of text, 2012-10-18). There was a hack
    in add_wrapped_shortlog_msg() function to compensate for this
    bug.

    With the bug fixed, the function never ends its output with a
    newline, and the caller needs to unconditionally add one.


>
> [1] 14e1a4e1ff70aff36db3f5d2a8b806efd0134d50 utf8: fix off-by-one
>     wrapping of text
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  builtin/shortlog.c  |  3 +--
>  t/t4201-shortlog.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index b316cf3..db5b57d 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -307,8 +307,7 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
>  				     const struct shortlog *log)
>  {
>  	int col = strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
> -	if (col != log->wrap)
> -		strbuf_addch(sb, '\n');
> +	strbuf_addch(sb, '\n');
>  }
>  
>  void shortlog_output(struct shortlog *log)
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 6872ba1..02ac978 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -120,6 +120,30 @@ test_expect_success 'shortlog from non-git directory' '
>  	test_cmp expect out
>  '
>  
> +test_expect_success 'shortlog should add newline when input line matches wraplen' '
> +	cat >expect <<\EOF &&
> +A U Thor (2):
> +      bbbbbbbbbbbbbbbbbb: bbbbbbbb bbb bbbb bbbbbbb bb bbbb bbb bbbbb bbbbbb
> +      aaaaaaaaaaaaaaaaaaaaaa: aaaaaa aaaaaaaaaa aaaa aaaaaaaa aa aaaa aa aaa
> +
> +EOF
> +	git shortlog -w >out <<\EOF &&
> +commit 0000000000000000000000000000000000000001
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:14:13 2005 -0700
> +
> +    aaaaaaaaaaaaaaaaaaaaaa: aaaaaa aaaaaaaaaa aaaa aaaaaaaa aa aaaa aa aaa
> +    
> +commit 0000000000000000000000000000000000000002
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:14:13 2005 -0700
> +
> +    bbbbbbbbbbbbbbbbbb: bbbbbbbb bbb bbbb bbbbbbb bb bbbb bbb bbbbb bbbbbb
> +    
> +EOF
> +	test_cmp expect out
> +'
> +
>  iconvfromutf8toiso88591() {
>  	printf "%s" "$*" | iconv -f UTF-8 -t ISO8859-1
>  }
