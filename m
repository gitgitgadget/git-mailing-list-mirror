From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Sat, 05 Mar 2016 00:05:38 -0800
Message-ID: <xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
	<56DA896A.3050201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 09:05:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac7Dg-0000XK-FO
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 09:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbcCEIFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2016 03:05:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755992AbcCEIFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2016 03:05:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA2833F4FD;
	Sat,  5 Mar 2016 03:05:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+lfBSD9Gw4ic
	whiAIR1wtId4uQQ=; b=IqtudPYjuujT6iw0GfPfXj1cUhdqfVEUSm+kPstMakc5
	76c+9YDtIXnbdlhklxKC5vPGyuqy7ICiJyIwLXiooampx4s3/EjPxG0Cd1kxgopH
	4/H9Uz1sYGlopFAg4NtdYyb6j1KZ6UooJVE3UJSCdfknI4W563+LCshpEt38XWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I2I/ng
	SiRMAPJjlkbWfYmaDWkVmmZ0VnDePcU3J4vBGXDOqICCcTHOj4hBoB6iYY12xM2q
	AvJXG0n/lrWCoFFcQDpgudu7svNFpdIuY/VCZkVImfJ3V79OG4AlzmVjBh2ItrZl
	yR2fqHYC3Yazz//QeMavhqiGE0vBVOjUwq8eE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E18DB3F4FB;
	Sat,  5 Mar 2016 03:05:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C5BA3F4FA;
	Sat,  5 Mar 2016 03:05:39 -0500 (EST)
In-Reply-To: <56DA896A.3050201@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 5 Mar 2016 08:23:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0CA10F52-E2A9-11E5-900B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288302>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 11.02.16 19:49, Junio C Hamano wrote:
>
>> I did not continue the approach I illustrated because I realized and
>> finally convinced myself that touching ce_compare_data() is a wrong
>> solution--it breaks "diff-files".
>>
>> Imagine if you have contents in the index that wouldn't have been
>> left by a "clean" conversion of what is in the working tree.  You
>> then run "git checkout -f".  Now the contents in the working tree
>> will still not convert back to what is in the index with another
>> "clean" conversion, but it should pass the "Am I safe to proceed"
>> check, namely, it matches what convert_to_worktree() would give.
>>
>> But imagine further what would happen when you add an extra blank
>> line at the end of the file in the working tree (i.e. "echo >>file")
>> and then run "diff-files -p".
>>
>> The illustration patch I gave broke "diff-files" in such a way that
>> before such an addition of an extra blank line, it would have said
>> "No changes".  And if you run "diff-files" after adding that extra
>> blank line, you will see whole bunch of changes, not just the extra
>> blank line at the end.
>>
>> This is sufficient to convince me that the approach is broken.
> []
> Would something like this make sense?
> (The main part is in diff.c, the rest needs some polishing)
>
> commit e494c31fd2f0f8a638ff14d1b8ae3f3a6d56a107
> Author: Torsten B=C3=B6gershausen <tboegi@web.de>
> Date:   Sat Mar 5 07:51:08 2016 +0100
>
>     Text files needs to be normalized before diffing
>   =20
>     Whenever a text file is stored with CRLF in the index, Git change=
s
>     CRLF into LF at the next commit.
>     (text file means the attribute "text" or "crlf" of "eol" is set).

I do not think I can endorse this approach, as I cannot explain why
it could possibly make sense to treat as if CRLF conversion is
somehow special among all the convert_to_git()/convert_to_worktree()
conversions, which your patch does to the diff code.

Comparisons between contents from two tree objects and comparisons
between contents from a tree object and the index must happen
without conversion, and comparisons between contents from the tree
in the HEAD commit and contents from the working tree must be done
in line with the HEAD vs index comparison to serve as a preview of
what would happen after adding the contents taken from the working
tree to the index, which means we should compare what is in the
index (without conversion) and the result of running the whole
convert_to_git() conversion on what is in the working tree.  It
feels fundamentally wrong to apply only CRLF conversion without any
other conversion, whether the direction of the conversion is from
worktree to git or the other way around, when comparing two things.

When the user has CRLF data in the index and the user tell the
attribute system so that the next "add" would result in "fixing" the
indexed lines to be terminated with LF, "diff-files" _should_ show
that correction as a change, I think.
