From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Tue, 28 Apr 2015 00:08:02 -0700
Message-ID: <xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
	<CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Quentin Neill <quentin.neill@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymzff-0004n4-JV
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbD1HLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:11:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753163AbbD1HLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:11:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B88004423C;
	Tue, 28 Apr 2015 03:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NkspLzaxN2PXxGdFIV53ZvdqGPY=; b=uiG6o8
	mXkXg8r88xVxXa/dTjz3PwRbrB5TE2s0ZsD3PkIkR28UWKzb78KnWE89M99GDCtl
	UlKP3AUD5w3l80d7a9pwi4ePSslUFCSfMcXKM2VVzyBhK+sp0uOuT7fWZ5lRdzb1
	V2ArVH67TTjABtucicfYAJdUR5XxlTa5/bNyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hDQmhHm0EAe9xJtVoB5iVZUcxRN7l9P4
	OsTegUVLPG1LlrCEOBsINHs5EYZH/ru9b/sRZgnelryK3pXAncFPqSuyKbDHRDZl
	Ric66DL2Ud+6E9HI2IBseWPtEBuwzEqauN5cxGWTwsg+LPm7v0umr9QuFqtzzNP+
	fKsHnRMEWJs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B13344423B;
	Tue, 28 Apr 2015 03:08:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 324EA4423A;
	Tue, 28 Apr 2015 03:08:04 -0400 (EDT)
In-Reply-To: <CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 27 Apr 2015 15:23:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 504E16CA-ED75-11E4-826B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267906>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Right. Rather than having a separate global 'show_email' variable and
> consulting that variable in parallel with OUTPUT_SHOW_EMAIL throughout
> the code, instead set the OUTPUT_SHOW_EMAIL bit in git_blame_config().
> To do this, take advantage of the "callback data" argument of
> git_config(), which will arrive in git_blame_config() as its 'void
> *cb' argument. So, for instance, something like this:
>
>     static int git_blame_config(var, value, void *cb)
>     {
>         ...
>         if (!strcmp(var, "blame.showemail")) {
>             if (git_config_bool(var, value)) {
>                 int *output_options = cb;
>                *output_options |= OUTPUT_SHOW_EMAIL;
>             }

Don't forget to clear the bit when the bool is set to false, too.

>             return 0;
>         }
>         ...
>     }
>
>     int cmd_blame(...)
>     {
>         ...
>         git_config(git_blame_config, &output_options);
>         ...
>         parse_options(...);
>         ...
>     }
