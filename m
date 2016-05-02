From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] trailer: load config to handle core.commentChar
Date: Mon, 02 May 2016 11:13:39 -0700
Message-ID: <xmqqy47stjjg.fsf@gitster.mtv.corp.google.com>
References: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
	<CAPig+cT=Ca+Jd_SN_SM=iOmLnYtAt82dW7ammW4-AKdRReFfPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rafal Klys <rafalklys@wp.pl>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axILs-0006wQ-PC
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbcEBSNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:13:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754913AbcEBSNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:13:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC26216861;
	Mon,  2 May 2016 14:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DxGpllEoSjN54oEs4KA3hIfurks=; b=pqZzxX
	13bKCtakfIiPwyeMX2Son7/orYC+lQY/MVTyZhSHCOkI3G4BXkjFzSuSX2zomhTI
	Dm+1K8Nu9MuSrceOI7nxLgqw+V3Fh1kRGfi4T1FNGysPuzW3zKPI3WM01Ocrngaw
	het7YlS00PhIma3AKxo54/MriyhaK8M7Q495k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZ+0PQ4XKMQqpRJcLt3HEA8mSZi4cc8z
	7HoWUxMYvompKbwCygIsEy0BLtELPBrfr7htDoL5l0ZgqURSVpJwDaCPd+EIPQ1+
	y8FmGZgtK5Ky6HiY/SuMb8YpMrRIu66fyYCfRXgj5QQfQ3kkkUdXNq1MS+50Yscw
	htUk3cpfVzw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E461116860;
	Mon,  2 May 2016 14:13:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DA081685F;
	Mon,  2 May 2016 14:13:41 -0400 (EDT)
In-Reply-To: <CAPig+cT=Ca+Jd_SN_SM=iOmLnYtAt82dW7ammW4-AKdRReFfPA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 Apr 2016 17:12:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 998EC1D2-1091-11E6-93AD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293257>

Eric Sunshine <sunshine@sunshineco.com> writes:

> In fact, this is such a simple fix that the subject suggested above
> may itself be a sufficient commit message; any extra text might just
> be noise since the patch itself contains enough information to
> understand the problem and the fix.

Sounds about right.

>> +       git config core.commentChar x &&
>> +       test_when_finished "git config --unset core.commentChar" &&
>
> The above two lines could be collapsed to:
>
>     test_config core.commentChar x &&

Yes.

> As this new test is effectively a copy of the preceding test, another
> option would be to factor out the common code. For instance:
>
>     test_comment () {
>         cat basic_message >message_with_comments &&
>         sed -e "s/ Z\$/ /" >>message_with_comments <<-EOF &&
>             $1 comment
>         ...
>     }
>
>     test_expect_success 'with message that has comments' '
>         test_comment '#'
>     '
>
>     test_expect_success 'with message that has custom comment char' '
>         test_config core.commentChar x &&
>         test_comment x
>     '
>
> Note that the backslash is dropped from -\EOF so that $1 can be
> interpolated into the here-doc.
>
> Such a re-factoring would be done as a preparatory patch, thus making
> this a two-patch series, however, it's probably not worth it for only
> two tests sharing common code. (Although, the following test is also
> nearly identical...)

This certainly does make the result easier to read through.

>> diff --git a/trailer.c b/trailer.c
>> @@ -483,7 +483,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
>>         const char *trailer_item, *variable_name;
>>
>>         if (!skip_prefix(conf_key, "trailer.", &trailer_item))
>> -               return 0;
>> +               /* for core.commentChar */
>> +               return git_default_config(conf_key, value, cb);
>
> I'm a bit torn about this comment. On the one hand, it does add a bit
> of value since it's not obvious at a glance what config from the
> default set is needed by git-trailer, however, if git-trailer someday
> takes advantage of some additional config from the default set, then
> this comment will likely become outdated.

This is a very good point.

"I wanted the call here for core.commentChar" is better said in the
log message, as that will not stay true forever, as other people
will start depending on being able to access other variables and
generally they would not go back to read this message (to update
it).
