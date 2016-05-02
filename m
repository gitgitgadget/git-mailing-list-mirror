From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Mon, 02 May 2016 12:33:02 -0700
Message-ID: <xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
	<xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
	<a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
	<xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 02 21:33:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJai-0001D7-PR
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbcEBTdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 15:33:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754654AbcEBTdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 15:33:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E33317616;
	Mon,  2 May 2016 15:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YoboQFT6kju5
	ulvOrGNl8VjigYU=; b=ygQLODThmXpdDDr/7ih8Kuqnyermely4RxZZSnJpqUu/
	QEQw5cbbvGvhtuJrzQO8x4IXHsJQCAUQE+4IqBBmLn6nN69OHqyfgltphIA9U95L
	JzItC0sPdnBZkNoAmqBvBS27X62kCA4LrIPNQaJEifTQora30TVm7bNdS0I58L8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lC2wsA
	iv8NbUrv0rdcMkcVEjQLqDfguFuTHRKtldz2bMBxjpJ+eEwRATK4SsWVPcHOeebJ
	Y/5U10EnJKgwge1p05TsZDjF0EOjerPy19AFtN2soeZc5UkkbNeKYGYJbHrs62mH
	GLeYY5Ekngq1xNqX7GGWBPr8tL4fMbpEDBrz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 051A617615;
	Mon,  2 May 2016 15:33:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6920117614;
	Mon,  2 May 2016 15:33:04 -0400 (EDT)
In-Reply-To: <xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 May 2016 11:16:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B08E31DC-109C-11E6-9B80-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293275>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 29.04.16 23:09, Junio C Hamano wrote:
>>
>>> Well, didn't I do exactly the above much earlier and discarded it
>>> because that breaks the definition of "diff"?  Or is this doing
>>> something differently?
>>
>> Yes, and I try to sneak it in anyway ;-)
>>
>> I spend some time debugging how to get t6038 passed, and need
>> some more time.
>>
>> If 10/10 is a no-go (and it probably should be),
>> does it make sense to keep 1/10..4/10 and discard 5..10 for the mome=
nt ?
>
> Earlier patches in the series certainly felt alright.  I do not
> remember noticing where it went in a strange direction to be honest.

Let's step back a bit and make sure we are on the same page.  I
think this "series" conflates a bit too many things into a single
topic.

 * The comparison between the index and the working tree, i.e. "git
   diff", should compare result of convert_to_git() with what is in
   the index, and the world around it should be made consistent with
   that.  Your separate "git blame" fix to add missing knowledge
   that convert_to_git() would not do s/CRLF/LF/ for a path whose
   index entry already is contaminated with CR falls into this
   category and was a very good thing to do. =20

 * A convert_to_git() and convert_to_working_tree() pair that do not
   roundtrip would (by definition) leave contents in the working
   tree, that, when passed through convert_to_git(), will be
   different from the index, upon completion of "reset --hard".  We
   _should_ fix it so that "git diff" _reports_ differences.
   Currently, lstat(2) based optimization hides this in a racy way
   (when racy Git kicks in to reinspect the index and the working
   tree file actually matches, it finds out that they do not match),
   it is a bug that needs to be fixed, not 10/10 where it tries to
   hide the differences consistently and spreads the bug.  I haven't
   studied 8/10 carefully yet, but it seems to attempt the same.

 * I think the "text=3Dauto eol=3DTHIS" that did not mean "I do not car=
e
   to specify which ones are text files.  Please detect the file
   type, and for those automatically detected, please make sure that
   the contents follwo THIS eol convention." was a bug, and what
   07/10 tries to do is a good thing. =20

By the way, lack of the cover letter of this series made it more
painful to write a reply like this than necessary.  A cover letter
for a trivial 3-patch series might be overkill, but for anything
with substance that spans more than 4-5 patches, a cover letter to
describe the overall direction would really help.

Thanks.
