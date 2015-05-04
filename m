From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Sun, 3 May 2015 22:55:40 -0400
Message-ID: <CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com>
References: <55463094.9040204@gmail.com>
	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com>
	<xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 04:55:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp6Xq-0001Ol-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 04:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbEDCzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 22:55:42 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36040 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbEDCzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 22:55:41 -0400
Received: by igblo3 with SMTP id lo3so74080863igb.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XWTBRzxX/gpsxVlOiz+W0r4uxdVpJ1ggWovftbz3uEg=;
        b=q+ObNkyYy1i5PUW+iXjTvb49fSMp4AYGV8XEUff/3A0xhH0ddf169YRYSq4i4LWowy
         0GvKd3wPnsW4Ty8SG5Vmrn+15R0L4aOErYEY5G9/XVODnqsFV40jcG0EDAKsRZQ9SB8V
         2TRURIVEkYwPF8kS7d16OEauHOY4BiJttHy7L4ilAT3PQfuEmP00Z5phtWnWkAAMfB8E
         VAHXNbv1D2CEg0eT6sNOnO3JMRNJ6o/4vNVfhAPSwFXvmjNR2YGehIe6JItstrzUJ4z1
         yeOvUP8T2EgCNRrlbQS+h69i5z/DGKxjPtBWJd3/iMMh/5lPN/ebQvFxgddJRG41XBww
         OkUw==
X-Received: by 10.50.66.230 with SMTP id i6mr10755421igt.22.1430708140607;
 Sun, 03 May 2015 19:55:40 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 19:55:40 -0700 (PDT)
In-Reply-To: <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 9XpLL0WnbTTR3zrb6-EHB9X8djA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268303>

On Sun, May 3, 2015 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmmmm... you do not seem to pass your own test.
>>
>> expecting success:
>>         echo $bogus_type >expect &&
>>         git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>>         test_cmp expect actual
>>
>> --- expect      2015-05-04 00:09:24.327335512 +0000
>> +++ actual      2015-05-04 00:09:24.335335473 +0000
>> @@ -1 +1 @@
>> -abcdefghijklmnopqrstuvwxyz1234679
>> +abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
>> not ok 86 - Type of broken object is correct when type is large
>
> Perhaps it would have a better chance of being correct with this
> squashed in.

Interestingly, neither test passes on Mac OS X even with this fixup.
In fact, the git-hash-object invocation which computes/retrieves
'bogus_sha1' with the extra long bogus type crashes with SIGABRT in
write_sha1_file_prepare(). Still investigating.

> -- >8 --
> [PATCH] fixup! sha1_file: support reading from a loose object of unknown type
>
> ---
>  sha1_file.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index f65bf90..e010e7c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1568,7 +1568,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>                                         unsigned long mapsize, void *buffer,
>                                         unsigned long bufsiz, struct strbuf *header)
>  {
> -       unsigned char *cp;
>         int status;
>
>         status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
> @@ -1579,7 +1578,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>         if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
>                 return 0;
>
> -       strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
>         do {
>                 status = git_inflate(stream, 0);
>                 strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
> --
> 2.4.0-282-g4432dd4
