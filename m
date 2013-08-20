From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all
 requested bytes
Date: Tue, 20 Aug 2013 17:16:22 +0200
Message-ID: <CALWbr2yaQaCte6+Y3GEa8Hxyhq6GPS64aTNzkGo8pdpcd9ZVUg@mail.gmail.com>
References: <521333AE.1090506@kdbg.org>
	<xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnfX-0004GM-PE
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3HTPQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 11:16:23 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43466 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3HTPQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:16:23 -0400
Received: by mail-qa0-f46.google.com with SMTP id bq6so2549399qab.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ofblBoA1IXE55WLhC5YVdz7Mk2IT9EB+MtudqhAcYZY=;
        b=IlwHyQ789vNfsv9uJ4rdYqwsHQ/2DjdONipJ9EHHbT8o27CPBUW6onoCsQ+oFUCNKc
         Hl9Ihuhk+Ikl8aZC8/D6qPvl3QzmBk2gD6Dt+nbEhwLgiIDc9hQvUnZ0i9/qhrAocVF3
         A2cQw5QjNDthIBPAns0YGILO6O9+0oHYrGb3zhPufxtq6Gn1Tjz2XKOAMzrJ38zowu5O
         O9Rl5gd4SfNVR/nQ2cw5m+zKoBFWgBLs9VlSELCCEJzU52blYyj58EaiEWcuPLzb2jQL
         4g73hH0fe4g+e3nTK4jZAwiWjk1Ir0lT4dLBQbQfJE8FxniP2u2PuSJn3R7vsZZ47grc
         +/mQ==
X-Received: by 10.224.121.3 with SMTP id f3mr4694218qar.47.1377011782425; Tue,
 20 Aug 2013 08:16:22 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Tue, 20 Aug 2013 08:16:22 -0700 (PDT)
In-Reply-To: <xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232612>

On Tue, Aug 20, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> The deflate loop in bulk-checkin::stream_to_pack expects to get all bytes
>> from a file that it requests to read in a single function call. But it
>> used xread(), which does not give that guarantee. Replace it by
>> read_in_full().
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  The size is limited to sizeof(ibuf) == 16384 bytes, so that there
>>  should not be a problem with the unpatched code on any OS in practice.
>>  Nevertheless, this change seems reasonable from a code hygiene POV.
>>
>>  bulk-checkin.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>> index 6b0b6d4..118c625 100644
>> --- a/bulk-checkin.c
>> +++ b/bulk-checkin.c
>> @@ -114,7 +114,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
>>
>>               if (size && !s.avail_in) {
>>                       ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
>> -                     if (xread(fd, ibuf, rsize) != rsize)
>> +                     if (read_in_full(fd, ibuf, rsize) != rsize)
>
> This is the kind of thing i was wondering and worried about with the
> other "clipped xread/xwrite" patch.  The original of this caller is
> obviously wrong.  Thanks for spotting and fixing.
>
> I wonder if there are more like this broken caller or xread and/or
> xwrite.

I was actually wondering when it's better to use xread() over
read_in_full() ? Considering that we don't know if xread() will read
the whole buffer or not, would it not be better to always use
read_in_full() ? I guess there is a drawback to this, but I'm not
exactly sure what it is.
