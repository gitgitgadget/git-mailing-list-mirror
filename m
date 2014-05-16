From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] config: be strict on core.commentChar
Date: Fri, 16 May 2014 10:36:15 -0700
Message-ID: <xmqqsio9aank.fsf@gitster.dls.corp.google.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
	<1400248283-303-1-git-send-email-pclouds@gmail.com>
	<20140516162508.GA12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:27:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMrL-0007jw-2h
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317AbaEPS1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 14:27:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57085 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbaEPS1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 14:27:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9758F19E58;
	Fri, 16 May 2014 14:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1NPhfuW0QdPy
	9kzM+U7KefjRBvY=; b=ZLLxQ7rJPRwBzU9SdnDBU5HglclkZpBR3m6cin84EPob
	TwIEz669Qy5y865/IvbALZUBfjBYepCmAopfFeWxuET+Kg9/mwQj17Msqj/s6uJE
	nrfYVguEDt+CYJKCTi1AYYAOCj8F9mNNeCJCp02NuwqHLi0VSZ+fhcaoUJjsYXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iOCZT4
	bBAY+H5QsWDlCSP9iPo1p9Tcd+UJOSa266QKdpjRWdERXvjmVew4vcV9YDqyodra
	R8Bz6JrOmMPR5RwwFSSAHDQjsfFk2ikWkx2stG1ieGsKFtLgkNnBc99UUhcmL3bJ
	n5/h8HWPXojgMd4JCsKtXAJFlLPrw4Z3+Thqc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DD5019E57;
	Fri, 16 May 2014 14:27:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B7611794C;
	Fri, 16 May 2014 13:36:17 -0400 (EDT)
In-Reply-To: <20140516162508.GA12314@google.com> (Jonathan Nieder's message of
	"Fri, 16 May 2014 09:25:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 95C34D12-DD20-11E3-B017-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249405>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --- a/config.c
>> +++ b/config.c
>> @@ -826,8 +826,12 @@ static int git_default_core_config(const char *=
var, const char *value)
>>  	if (!strcmp(var, "core.commentchar")) {
>>  		const char *comment;
>>  		int ret =3D git_config_string(&comment, var, value);
>> -		if (!ret)
>> -			comment_line_char =3D comment[0];
>> +		if (!ret) {
>> +			if (comment[0] && !comment[1])
>> +				comment_line_char =3D comment[0];
>> +			else
>> +				return error("core.commentChar should only be one character");
>> +		}
>
> Perhaps, to decrease indentation a little:
>
> 		if (ret)
> 			return ret;
> 		if (comment[0] && !comment[1])
> 			comment_line_char =3D comment[0];
> 		else
> 			return error(...);
> 		return 0;
>
> [...]
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -1348,12 +1348,6 @@ test_expect_success "status (core.commentchar=
 with submodule summary)" '
>>  	test_i18ncmp expect output
>>  '
>> =20
>> -test_expect_success "status (core.commentchar with two chars with s=
ubmodule summary)" '
>> -	test_config core.commentchar ";;" &&
>> -	git -c status.displayCommentPrefix=3Dtrue status >output &&
>> -	test_i18ncmp expect output
>
> Could keep the test to avoid regressions:
>
> 	test_config core.commentchar ";;" &&
> 	test_must_fail git -c status.displayCommentPrefix=3Dtrue status

All good points, including your other review message.
