From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/5] notes: Empty notes should be shown by 'git log'
Date: Fri, 07 Nov 2014 10:51:19 -0800
Message-ID: <xmqqr3xeg7yw.fsf@gitster.dls.corp.google.com>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
	<1415351961-31567-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmof3-0008FX-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbaKGSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:53:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752074AbaKGSxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:53:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C04101C034;
	Fri,  7 Nov 2014 13:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a2W7VTkVFm8UtQyDFJsacoLU+l4=; b=tvJL50
	bt848o9Dq1GHkB2VnVVRq4+SCTbx/qIzdzq4voJ6ui3eLgOvutIqzKdHVxdThPv/
	u2UA8hVHZrxALavZhn+ofwd9vKy4kMnuMltzy+Rl8h8Pa+8NyzLNp8j2zxEWxpfY
	+L7mGBoUo/FiOSF9+uyU6YwSCJAAPQTabBI/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ptlE1D2TaO04saiPbSIu3V09k0RAMzNB
	84n8tGmes0CGAFAIoZO/e6qNRlPLx2foZO67+Kzusq1dCqLPUexALV/wOusq7Voi
	Ijw044pEGJfXbv2oYoHqQAHpxqAwrzrWgzLOmiAMczuj1MDQa61r0UfXqn7OHJZx
	1sxtr5DBEew=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5CAB1C033;
	Fri,  7 Nov 2014 13:53:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 065A91BF96;
	Fri,  7 Nov 2014 13:51:20 -0500 (EST)
In-Reply-To: <1415351961-31567-5-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 7 Nov 2014 10:19:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10842928-66AF-11E4-A721-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> If the user has gone through the trouble of explicitly adding an empty
> note, then "git log" should not silently skip it (as if it didn't exist).
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

This makes sense and is in line with the theme of this series.

>  notes.c          |  3 +--
>  t/t3301-notes.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 5fe691d..62bc6e1 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1218,8 +1218,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
>  	if (!sha1)
>  		return;
>  
> -	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
> -			type != OBJ_BLOB) {
> +	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || type != OBJ_BLOB) {
>  		free(msg);
>  		return;
>  	}
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 8280a1a..f5d8193 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1274,4 +1274,16 @@ append -C "$empty_blob"
>  edit
>  EOF
>  
> +test_expect_success 'empty notes are displayed by git log' '
> +	test_commit 17th &&
> +	git log -1 >expect &&
> +	cat >>expect <<\EOF &&
> +
> +Notes:
> +EOF
> +	git notes add -C "$empty_blob" --allow-empty &&
> +	git log -1 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
