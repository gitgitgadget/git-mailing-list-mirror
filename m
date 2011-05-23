From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Sun, 22 May 2011 20:18:09 -0700
Message-ID: <7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
 <7vlixyw4cx.fsf@alter.siamese.dyndns.org>
 <BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anthony Foiani <anthony.foiani@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 05:18:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOLf5-0002q6-SQ
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 05:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab1EWDSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 23:18:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1EWDST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 23:18:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CEA85B8F;
	Sun, 22 May 2011 23:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLt5smbvIQcr9wZROuuDvvRR9W0=; b=I2wO5a
	8LCQPiljSeUwzGE0BC2lLL8D/e23cq1HlNk3Xyw9vIJT1uigN2f5DhcMMfPpWuHJ
	mBR7iYrnULyMplxF03JiCyWe+IHWdJJheNrk4vTF8T7711GJjvDV3CnqeZ6nUORN
	9eHW7yoXfpIk2wGMZL0r2lCPal2ujL1FSN+vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYWfgqzrh7rd4UtiTuuuu9h+W/j+NH8W
	T61PYjKCmRUSwOi4MvhwJjisMO0hdJO7AgVQClb2yIX/bhtBheiGrUovzUrKJOBD
	BHT1/iOg6J79Tsx3xG6kCip24tXn7V/3BdynwnsWG192u0pmzcpOKwdnu4yJhfNG
	hB88KPkvlWE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A2C05B8E;
	Sun, 22 May 2011 23:20:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 396565B87; Sun, 22 May 2011
 23:20:18 -0400 (EDT)
In-Reply-To: <BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com> (Anthony
 Foiani's message of "Sun, 22 May 2011 20:35:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 988F12AA-84EB-11E0-A2BF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174221>

Anthony Foiani <anthony.foiani@gmail.com> writes:

> On Sun, May 22, 2011 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Anthony Foiani <anthony.foiani@gmail.com> writes:
>>
>>> I accidentally tried to use "git diff" when I wasn't within a git
>>> repository, only to be confused by getting a usage message with no
>>> particular error output.
>>
>> I do not understand this at all.
>>
>>    $ cd /
>>    $ git diff
>>    usage: git diff [--no-index] <path> <path>
>>
>> What's unclear about it?
>
> It's hard for me to explain right now,...

No, it was only your 'I tried to use "git diff"' that was confusing to me.

With pathspecs or any other options, it is understandable that you were
confused, for example from an output like this:

> $ git diff -b main.c
> usage: git diff [--no-index] <path> <path>

At that point we are committed to no-index codepath, so probably a good
thing to do is to update that confusing usage message a bit better.

It already does change the behaviour when --no-index is not given by the
end user, so perhaps it would be sufficient to change this part:

	if (argc != i + 2)
        	usagef("git diff %s <path> <path>",
                	no_index ? "--no-index" : "[--no-index]");

to something like (caution: I am not typing this in my MUA):

	if (argc != i + 2) {
        	if (no_index)
			warning("Assuming '--no-index'; you are in no repository");
        	usagef("git diff %s <path> <path>",
                	no_index ? "--no-index" : "[--no-index]");
	}

without changing anything else.

That would be just a patch with 1 line removed, 4 lines added, no?
