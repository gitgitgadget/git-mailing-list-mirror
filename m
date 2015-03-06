From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Fri, 06 Mar 2015 11:28:59 -0800
Message-ID: <xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com>
References: <54F89D90.6090505@gmail.com>
	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>
	<xmqq61af100p.fsf@gitster.dls.corp.google.com>
	<54F9E6B6.4070105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 20:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxvr-0003BQ-Nr
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbbCFT3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 14:29:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756673AbbCFT3C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 14:29:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D97053E1F7;
	Fri,  6 Mar 2015 14:29:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9qv3O3/UIm+z+g/7LXgwFcpw19k=; b=WcX/d3
	kf/RoD+jWowlguvOnrrq5SmMDPq6rmKdWqI9v3YbRx8KdFVzpIjfFxbWEPcc+2X5
	NzpAcb3O/6A90cVVFeS+iqUoTOXr8aLNU6K47qbECkXOlxPOWtdgpS0JZYEK/CD7
	Eywq6Srjt72iP0atqe1NKMwgIrH2806FKZfbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdKtfTarp2DDLym0HP1bGO9a+dacxoPX
	zNEpXSXbU4C9+zYzh7UdsNHMwAXbV7gcsq/syPMFH2+iZOrVXuVB/ut+GlREtsRc
	lmzF289n3FZ/jfxqsKp94gI5Eb1DP0N1kr8mgLV0s7ThxBauy8rLuoAqpRAHKSvR
	hTd7ebSJsdU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D146A3E1F6;
	Fri,  6 Mar 2015 14:29:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F0733E1F5;
	Fri,  6 Mar 2015 14:29:01 -0500 (EST)
In-Reply-To: <54F9E6B6.4070105@gmail.com> (karthik nayak's message of "Fri, 06
	Mar 2015 23:11:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AE592B4-C437-11E4-8943-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264955>

karthik nayak <karthik.188@gmail.com> writes:

>> ... I suspect that the caller should supply a pointer to struct
>> object_info, i.e. something along these lines:
>>
>>      struct object_info oi = { NULL };
>>      struct strbuf sb = STRBUF_INIT;
>>      enum object_type type;
>>
>>      ...
>>
>>      oi.typename = &sb;
>>      sha1_object_info_literally(sha1, &oi);
>>      if (!sb.len)
>>          that is an error;
>>      else
>>          use sb.buf as the name;
>>
>>      strbuf_release(&sb);
> I thought I could get the calling function "cat_one_file()" to send
> the address to a struct strbuf. Like this ..
>
> struct strbuf sb = STRBUF_INIT;
> length = sha1_object_info_literally(sha1, &sb);
> if (length < 0)
> die("git cat-file --literally -t %s: failed",
>             obj_name);
> printf("%s\n", sb.buf);
> strbuf_release(&sb);
> return 0;
>
> What do you think? Is this ok?

When I gave you $gmane/264420, I was actually hoping that we do not
have to have "object-info-literally" helper at all, and instead the
caller in cat-file that deals with "-t" option can become something
like this:
	
	struct object_info oi = { NULL };
	struct strbuf typename = STRBUF_INIT;
	unsigned flags = LOOKUP_REPLACE_OBJECT;

        if (doing the --literally stuff)
		flags |= LOOKUP_LITERALLY;

	...

	switch (...) {
	case 't':
        	oi.typename = &typename;
                sha1_object_info_extended(sha1, &oi, flags);
		if (typename.len) {
                	printf("%s\n", typename.buf);
			return 0;
		}
                break;
	...

The change illustrated in $gmane/264420 is probably incomplete and
some calls from the sha1_object_info_extended() after that change
may still need to be tweaked to pay attention to LOOKUP_LITERALLY
bit (e.g. parse_sha1_header() may want to learn not to barf when
seeing an unexpected typename in the header when the caller asks to
look up "literally").
