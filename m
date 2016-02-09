From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/11] test-regex: expose full regcomp() to the command line
Date: Tue, 09 Feb 2016 10:21:28 -0800
Message-ID: <xmqq8u2t4udz.fsf@gitster.mtv.corp.google.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-5-git-send-email-pclouds@gmail.com>
	<CAPig+cQ2yFvM_YeeN+OObo+jZaxtiaLi+URE3USB2v4fUyC9tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCut-0000GU-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113AbcBISVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 13:21:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756803AbcBISVa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 13:21:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42D4E41336;
	Tue,  9 Feb 2016 13:21:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=owaUOjexd4xf
	PEaGaL/pChFuGL4=; b=uyTJj8CB48nO9zOoXWHVC/8vHrkhaSWC1Gzvb5TZJdw5
	DvqdsiGk1c8fxmnrsSzP/i55iebySTRgLzMXzaV9xdDVJPfuJt9EGpfX4l+J2wpx
	OvgSdohAWAFCUZlidfGQ1C+PUlh7Qp4ikhv3lekPDWDTjL9tGfJ7v4qKunkjv8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lxWQPa
	gEtonaiPJPj1MKXfkmEU7ysNHOy4gg1zJiVtUlYi/vInC6xlCkbVdAtXi4f0Td0+
	EjeyPuGUB0hUSwbP56kuWvqZX9SjgRQlllERyG2HARZTxeibLr4cDEbCdKpyDBdf
	qznOg1niJkO+VAuLqCR3NmfI1MiDcHAseVgnA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B54541335;
	Tue,  9 Feb 2016 13:21:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A8C7341334;
	Tue,  9 Feb 2016 13:21:29 -0500 (EST)
In-Reply-To: <CAPig+cQ2yFvM_YeeN+OObo+jZaxtiaLi+URE3USB2v4fUyC9tw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 7 Feb 2016 03:44:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F067EB24-CF59-11E5-AB55-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285847>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Feb 5, 2016 at 9:03 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> diff --git a/test-regex.c b/test-regex.c
>> @@ -21,8 +38,38 @@ static int test_regex_bug(void)
>>  int main(int argc, char **argv)
>>  {
>> +       const char *pat;
>> +       const char *str;
>> +       int flags =3D 0;
>> +       regex_t r;
>> +       regmatch_t m[1];
>> +
>>         if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
>>                 return test_regex_bug();
>> -       else
>> -               die("must be used with --bug");
>> +       else if (argc < 3)
>> +               die("usage: test-regex --bug\n"
>> +                   "       test-regex <pattern> <string> [<options>=
]");
>
> This is just a test program, so it probably isn't that important, but
> die() automatically prepends "fatal: " which means the alignment of
> the second line will be wrong. Perhaps you want to use usage() instea=
d
> which automatically prepends "usage: " (and drop the literal "usage: =
"
> from the above string).

So true.

>> +       argv++;
>> +       pat =3D *argv++;
>> +       str =3D *argv++;
>> +       while (*argv) {
>> +               struct reg_flag *rf;
>> +               for (rf =3D reg_flags; rf->name; rf++)
>> +                       if (!strcmp(*argv, rf->name)) {
>> +                               flags |=3D rf->flag;
>> +                               break;
>> +                       }
>> +               if (!rf->name)
>> +                       die("do not recognize %s", *argv);
>> +               argv++;
>> +       }
>> +       git_setup_gettext();
>> +
>> +       if (regcomp(&r, pat, flags))
>> +               die("failed regcomp() for pattern '%s'", pat);
>> +       if (regexec(&r, str, 1, m, 0))
>> +               return 1;
>> +
>> +       return 0;
>>  }
>
> This version is much easier to read without the "bug" special case
> spread throughout the code. Thanks.
