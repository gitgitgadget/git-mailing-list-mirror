From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Tue, 10 Feb 2015 14:06:43 -0800
Message-ID: <xmqqoap1v2to.fsf@gitster.dls.corp.google.com>
References: <20150207131112.394.30858.chriscool@tuxfamily.org>
	<xmqq386hcw33.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLIxH-0008JG-5h
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbbBJWGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:06:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754153AbbBJWGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:06:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D91A37BCD;
	Tue, 10 Feb 2015 17:06:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Asmd3cRq/ND4FQIePsrFjiSTSIk=; b=nLJPJT
	1UgYFF5jB1EQ3cGw77iFgVaDy5r/osf6CdShcFSBfJtNE6v6cV7VZVR4pjgByk/X
	Yq4bZFrIEojOfMMq/RI527l1DmNly65xv+j813wTMUsRoPd1yls00AoSrYaxaiX0
	SgLH60VJkVXZ+j3kM36FoZcOt7rahfPr7ROII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fweeJ84+eOs/irJ3Y4Ne3d04d6gX6n4v
	671uahKe7tN3XUidzhRbuLfQxc895DpbiNq2G+qrgFXbI8dBveMCVjmtDSLZ+3dw
	HS1GIdYKrxa8Wkd+U9CSwnXzUFJ7JmTQ6BifeqcgZdSt7pPjABorCxjjuhbYv+i5
	HqIjI2nn0xs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7444337BCC;
	Tue, 10 Feb 2015 17:06:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E755237BCA;
	Tue, 10 Feb 2015 17:06:44 -0500 (EST)
In-Reply-To: <CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
	(Christian Couder's message of "Sat, 7 Feb 2015 23:19:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19C2A976-B171-11E4-845D-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263650>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 7, 2015 at 9:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Another problem I have with "filter out during the output phase"
>> comes from the semantics/correctness in the resulting code, and I
>> suspect that it would need to be done a lot earlier, before you
>> allow the logic such as "if I have X, do this, but if there is no X,
>> do this other thing".  If you have an X that is empty in the input,
>> trimming that before such logic kicks in and trimming that in the
>> final output phase would give different results, and I think the
>> latter would give a less intuitive result.
>
> I think it is much better in the output phase because it is very
> natural for some projects to have a template message with empty
> trailers like this:

That is exactly my point.  With empty trailers in the input, "Add
this iff there is no existing one" will be made useless.

I am *not* saying that we must not have a filter at the output
phrase.  If anything, it would allow people to be more sloppy and
hide the problem under the rug.  Your code may have a bug or design
problem that adds an empty one somewhere even when the user told you
that she does not want an empty one in the result.  The user may be
sloppy and say "Add this key-value" unconditionally, instead of
having to do "What is the value I want to add?  Oh, it is not empty,
so I'll ask the trailer machiner to add this key-value there".

I am saying that not filtering the input and whatever intermediate
result you produce [*1*] will make the end result much less useful.

[Footnote]

*1* Filtering intermediate result of course can be done by making
sure you do not add an empty one in the first place.
