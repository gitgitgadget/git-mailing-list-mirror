From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/5] t3301: Verify that 'git notes' removes empty notes by default
Date: Fri, 07 Nov 2014 09:48:00 -0800
Message-ID: <xmqq61eqhpgv.fsf@gitster.dls.corp.google.com>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
	<1415351961-31567-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 18:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmndq-0000wk-8n
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 18:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaKGRsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 12:48:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480AbaKGRsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 12:48:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 791DB1AFBA;
	Fri,  7 Nov 2014 12:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eGzfQE2pLLNwy+tdB5qvg8+JD7Q=; b=p+SUJC
	OzVcnCZmlKPKz2VMicXVdP37K54wZhU0+tt7jkpQP3I5tUHYjQJ94y/jP992svfD
	h6iu4JXnU9OcdgAwyLPz1qsjTyogcAl/nad01ELyAJGNfv+X0SYr24VTgghiS4qT
	Y2alZR4mCgMJUFSaoN4qqYM4NqtlMBincm6PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NX9GQlfquNlmW3gdSZkOwisvrrxecaAu
	xac68MO+6ixG5mVHnBkw4GGZS8PAxoOVeY70i/l4vbrBT1IjOFqA4dsSKlIpjOqq
	PkuPqStGVhGF/gAZ+B5jtFH8z53poz4bg3MkjmQl88m5ol5NNRvxzix998HESmR3
	G9tueNKADC0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F2201AFB9;
	Fri,  7 Nov 2014 12:48:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB9B51AFB6;
	Fri,  7 Nov 2014 12:48:01 -0500 (EST)
In-Reply-To: <1415351961-31567-3-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 7 Nov 2014 10:19:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3823D590-66A6-11E4-A0E4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Add test cases documenting the current behavior when trying to
> add/append/edit empty notes. This is in preparation for adding
> --allow-empty; to allow empty notes to be stored.
>
> Improved-by: Eric Sunshine <sunshine@sunshineco.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  t/t3301-notes.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index cfd67ff..33f0558 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1239,4 +1239,31 @@ test_expect_success 'git notes get-ref (--ref)' '
>  	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
>  '
>  
> +test_expect_success 'setup testing of empty notes' '
> +	git config --unset core.notesRef &&

Use "test_unconfig" instead?

If the previous test failed (or a different topic that touches this
same script is merged to change what the previous test leaves), this
configuration variable may not be set, and "config --unset" may
fail.

> +	test_commit 16th &&
> +	empty_blob=$(git hash-object -w /dev/null)
> +'
> +
> +while read cmd
> +do
> +	test_expect_success "'git notes $cmd' removes empty note" "
> +		test_might_fail git notes remove HEAD &&
> +		MSG= git notes $cmd &&
> +		test_must_fail git notes list HEAD
> +	"
> +done <<\EOF
> +add
> +add -F /dev/null
> +add -m ""
> +add -c "$empty_blob"
> +add -C "$empty_blob"
> +append
> +append -F /dev/null
> +append -m ""
> +append -c "$empty_blob"
> +append -C "$empty_blob"
> +edit
> +EOF
> +
>  test_done
