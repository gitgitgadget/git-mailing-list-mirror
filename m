From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 09:23:34 -0700
Message-ID: <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
	<xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
	<xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
	<CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzZy-0008Lh-C2
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab3HZQXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:23:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab3HZQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:23:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B43D3A8F9;
	Mon, 26 Aug 2013 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nhWSOut2YtcltOZUQEBRr6goA4=; b=aBk1ne
	gBhaYvBlSA+E8bSCW7cw4nndPqxD2slR5ypBaevBs+f652ia10bNgZJm3H3DgGNs
	eKKcfUgiHpzNl9Y0w/wfQs9fcrao7CBP4mzHfKjA7qy9rRncCyQ0ozrnjZcOdkHP
	ZyE3DDjkFbxrE7YnW9D0dsVc8XrE4P3WkKDXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aJufgj/wBniyl8s96/uqZLiYEX+4NFXe
	gu5zJJmYzdlfSSnskXPSlo4SV2qF/SZxpI2r69WjjViEKvabfQRUhGQaJIAmQIXM
	TLau3n+bH/EIGfb9hQ4VQPPSCKNQ7QbpphLvtE1yGzx+NLhE3OoOw63JNJx/cqFa
	67x9d62eC/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEA53A8F5;
	Mon, 26 Aug 2013 16:23:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDAD63A8E9;
	Mon, 26 Aug 2013 16:23:37 +0000 (UTC)
In-Reply-To: <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
	(Phil Hord's message of "Mon, 26 Aug 2013 07:44:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DCCB5652-0E6B-11E3-B6E1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232999>

Phil Hord <phil.hord@gmail.com> writes:

> On Mon, Aug 26, 2013 at 3:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>
>>>> I think Phil meant that when "git grep" is asked to search within
>>>> "HEAD:some/path", filenames tacked on at the end should be appended
>>>> with a '/' separator instead of the usual ':' (e.g.,
>>>> "HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").
>>>
>>> Ah, OK.
>>>
>>> I am not sure if we have a proper hint in the revision parser
>>> machinery, but it may not be too hard to teach rev-cmdline interface
>>> to keep that kind of information (i.e. "This tree object name is a
>>> result of parsing '<tree-ish>:path' syntax").
>>
>> Actually, having thought about this a bit more, I am no longer sure
>> if this is even a good idea to begin with.
>>
>> An output line that begins with HEAD:some/path:inner/path.c from
>> "git grep" is an answer to this question: find the given pattern in
>> a tree-ish specified with "HEAD:some/path".
>>
>> On the other hand, HEAD:some/path/inner/path.c is an answer to a
>> different question: find the pattern in a tree-ish specified with
>> "HEAD".  The question may optionally be further qualified with "but
>> limit the search to some/path".  Both the question and its answer
>> are more intuitive than the former one.
>
> I disagree.  The man page says that git grep lists the filenames of
> matching files.

But you need to realize that the manual page gives a white lie in
order to stay short enough to be readable.  It does give filenames
when reading from the working tree, the index or a top-level tree
object.  When given arbitrary tree object that is not top-level, it
does give filenames relative to the given tree object, which is the
answer HEAD:some/path:inner/path.c to the question "where in the
tree HEAD:some/path do we have hits?".

>> If the user asked the question of the former form, i.e.
>>
>>     $ git grep -e pattern HEAD:some/path
>>
>> there may be a reason why the user wanted to ask it in that
>> (somewhat strange) way.  I am not 100% sure if it is a good idea to
>> give an answer to a question different from what the user asked by
>> internally rewriting the question to
>>
>>     $ git grep -e pattern HEAD -- some/path
>
> We are not rewriting the question at all.

That statement is trapped in a narrow "implementor" mind. I know you
are not rewriting the question in your implementation, but what do
the end users see? It gives an answer to a question different from
they asked; the observed behaviour is as if the question was
rewritten before the machinery went to work.

If your justification were "above says 'there may be a readon why
the user wanted to ask it in that way', i.e. 'find in this tree
object HEAD:some/path and report where hits appear', but the reason
can only be from laziness and/or broken script and the user always
wants the answer from within the top-level tree-ish", then that
argument may make some sense. You need to justify why it is OK to
lose information in the answer by rewriting the colon that separates
the question ("in this tree object") and the answer ("at this path
relative to the tree object given").

Whether you rewrite the input or the output is not important; you
are trying to give an answer to a different question, which is what
I find questionable.
