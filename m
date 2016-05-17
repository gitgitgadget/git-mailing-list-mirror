From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 13:25:58 -0700
Message-ID: <xmqqposkv3c9.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
	<xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ-xf167LiO+zY+B8BTYd-9h7u=dgpL=4tsEJDPgwq8CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 22:26:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2lZL-0006Bx-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 22:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbcEQU0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 16:26:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119AbcEQU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 16:26:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2981E1D04C;
	Tue, 17 May 2016 16:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fjybWtAzGxOEGTfmMA2enIhaiYI=; b=m5OfZa
	kI7m5z0k2vIoj6IkW4dprDASb50yR4AoNa6ue/VHQj+GK/bon1e73FgFG5uP6jr4
	ojifLUb2TdJN2JnWAH0cu4WJAfKkD76ASJhlINWdUCV/fpatoashLfz49JtlQ5xa
	pRa0X/PTuLqTVdTbD6kjanH70CjJBKHiOpPsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFI5RrcXE9j4ikj08UZxtadvDX62D1zy
	9mBQJ6e4zyeAq2ZhIPkCpdYDhAQ4Pat1ytrVIQ6L51pwIi3idlKTyp8W5iy3rsvX
	Jrajbq6vF5pJd772eFnW36DR05Wk52h2oLY0KIwOF8rqLXSaNWdLudIUmXtdxeVW
	/JJeLNvdF64=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 077771D04A;
	Tue, 17 May 2016 16:26:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DD741D049;
	Tue, 17 May 2016 16:25:59 -0400 (EDT)
In-Reply-To: <CAGZ79kZ-xf167LiO+zY+B8BTYd-9h7u=dgpL=4tsEJDPgwq8CA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 17 May 2016 12:23:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9192A614-1C6D-11E6-AA18-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294910>

Stefan Beller <sbeller@google.com> writes:

> On Mon, May 16, 2016 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> When matching (i.e. the match_attrs() function), you would instead
>> do
>>
>>         path = xmemdupz(name, namelen);
>>         git_check_attr(path, item->attr_check);
>>
>> to grab values for only attributes that matter to you, instead of
>> calling git_all_attrs() [*2*].
>>
>> After git_check_attr() returns, item->attr_check.check[0].attr would
>> be git_attr("VAR1") and item->attr_check.check[0].value would be
>> whatever setting the path has for the VAR1 attribute.  You can use
>> your match_mode logic to compare it with the values .attr_match
>> expects.
>>
>> You do not necessarily have to have the same number of elements in
>> .attr_match and .attr_check.check by the way.  .attr_match might say
>>
>>         VAR1=VAL2 !VAR1 -VAR1
>>
>> which may be always false if these are ANDed together, but in order
>> to evaluate it, you need only one git_attr_check_elem for VAR1.
>

The key phrase in the message you are reacting to is "not
necessarily".  It is not a crime to ask for the same attribute twice
in a git_attr_check structure.

    $ git check-attr text text text -- path

would stuff three instances of "text" in there and ask them for
"path".  The simple in-code callers that uses git_attr_check_initl()
do rely on the order of the attributes it placed in attr_check
structure (see e.g. how ll_merge() uses check[0].value and
check[1].value to see the driver name and marker size), and that is
perfectly kosher.  Existing code is your friend.

The mention of the possibility is purely as a hint useful for a
possible enhancement in the far future.  If we ever want to support
something like this:

	":(attr-expression (VAR1=VAL1 | VAR1=VAL2) & VAR2)"

you can remember that you can put VAR1 and VAR2 in attr_check to
grab values for VAR1 and VAR2 (even though VAR1 is mentioned twice
in the expression), and use them in the evaluation you will perform.

> So for the matching we would need to get the order right, i.e.
>
>     const char *inspect_name = git_attr_name(item.attr_match[i].attr);
>     for (j=0; j <  p.attr_check.check_nr; j++) {
>         const char *cur_name = git_attr_name(p.attr_check.check[j].attr);
>         if (!strcmp(inspect_name, cur_name))
>             break;

You do not strcmp() when you have attributes.  They are interned so
that you can compare their addresses.  That makes it somewhat
cheaper.

Once you start "expression over random attributes", you'd need to
map attr => value somehow.  The format attr_check structure gives
you, i.e. a list of <attr, value>, is aimed at compactness than
random hashmap-like access.  If the caller wants a hashmap-like
access for performance purposes, the caller does that itself.

Existing users do not need a hashmap-like access, because they know
at which index in attr_check they placed request for what attribute.
An array that can be indexed with a small integer is exactly what
they want.

> This doesn't look cheap to me? Am I holding it wrong again?

By the way, I do not think during the entire discussion on this
topic, you have never been in a situation to deserve the "holding it
wrong" label (which implies "a ware is broken, but somehow the end
user is blamed for using it incorrectly").  When you were wrong, you
were simply wrong.
