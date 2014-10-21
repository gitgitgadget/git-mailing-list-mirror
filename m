From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix match highlighting for combined patterns with context lines
Date: Tue, 21 Oct 2014 12:23:27 -0700
Message-ID: <xmqqh9yxz0pc.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 21:23:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf22-0008NE-VI
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbaJUTXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:23:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932382AbaJUTXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:23:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 509B7161FD;
	Tue, 21 Oct 2014 15:23:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E3I1SaOA7H2zFUTgNa4ihR5Oc10=; b=ThHltu
	2gpP8kgw+RRbSucVzL1Jjj3WWWceQg+cB8EXy6QvHkKUICeFXXdjqgYOLNUdcLmi
	gY47v/cFJ4hNNHkS+rN8r7w7OlQ9HGVnatFDAkGGbtRtWZ/Upk065/bhWsMr58Nt
	qLl+/w6Jb7owBGkOIMfc9usXrxnQLmqruPH/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHTEGXwQKt8Ng20wcCAXAzX+IQn7qRNJ
	PT9+/Gmk35uVpeEdsurfDO8pBagp2kVsca7HDesiL2cTXZDWliGZDNbUgnmDcsL1
	Qu55WcO+X07c4l5Tsy7tg/Dv1WfN77N/IA5pJU1aYpOHIpeJUFwfHbe8lvfG9mYz
	YNr22hYwCvA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 470ED161FB;
	Tue, 21 Oct 2014 15:23:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99571161F9;
	Tue, 21 Oct 2014 15:23:28 -0400 (EDT)
In-Reply-To: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	(Zoltan Klinger's message of "Tue, 21 Oct 2014 16:56:03 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC6F156E-5957-11E4-893B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> When git grep is run with combined patterns such as '-e p1 --and -e p2'
> and surrounding context lines are requested, the output contains
> incorrectly highlighted matches.
>
> Consider the following output (highlighted matches are surrounded by '*'
> characters):
>     $ cat testfile
>     foo a
>     foo b
>     foo bar
>     baz bar foo
>     bar x
>     bar y
>     $ git grep -n -C2 -e foo --and -e bar testfile
>     testfile-1-*foo* a
>     testfile-2-*foo* b
>     testfile:3:*foo* *bar*
>     testfile:4:baz *bar* *foo*
>     testfile-5-*bar* x
>     testfile-6-*bar* y
>
> Lines 1, 2, 5 and 6 do not match the combined patterns, they only
> contain incorrectly highlighted 'false positives'.
>
> Modify the show_line() function in grep.c to highlight matches only on
> lines that match the combined pattern. Do not highlight matches on lines
> that provide only context or contain only the function name of the match.
>
> The output of the same command after the change:
>     $ git grep -n -C2 -e foo --and -e bar testfile
>     testfile-1-foo a
>     testfile-2-foo b
>     testfile:3:*foo* *bar*
>     testfile:4:baz *bar* *foo*
>     testfile-5-bar x
>     testfile-6-bar y

If your goal is to stop colouring words on context and other kinds
of lines, do you still need the "while (next_match(...))" loop for
them?  Can't you make the resulting code clearer by restructuring
the inside of the whole "if (opt->color)" block further, something
along the lines of...

	if (sign != ':') {
		regmatch_t match; ...
		enum grep_context ctx = GREP_CONTEXT_BODY;
                ...
        	while (next_match(...)) {
                	... the "word-by-word" loop ...
		}
	} else {
        	switch (sign) {
		case '-':
                       	line_color = opt->color_context;
                        break;
		case ':':
                       	line_color = opt->color_function;
                        break;
		}
                output_color(opt, bol, ..., line_color);
	}

Hmm?
