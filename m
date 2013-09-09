From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 2/2] Add new @ shortcut for HEAD
Date: Sun, 8 Sep 2013 21:09:49 -0500
Message-ID: <CAMP44s1-+i30CuTH5uRpu4Qi_hWhHmygc2-quYkTrrBV+4hZXQ@mail.gmail.com>
References: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
	<1378103670-3394-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opsprq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 04:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqvL-0004XA-8P
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 04:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3IICJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 22:09:51 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:54874 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab3IICJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 22:09:50 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so4556502lbd.12
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gfOCJ+n9vwvo2Qp63i+IqgplMS+HEJuWOW1TnGyA9UQ=;
        b=IALkdDbQw7ydZ4H2vENBikyRw3M7wVlAJdVX3AJIV6fglg1XSrtW4901jwtA0s7nbd
         ta35Nei26ojsNfW0sekLiTlvANuvomPgSfyraHif9HVHO5IzhO13ftsfs8UEme554/zC
         jKVTVIxCcd3Yw2rCu+f8wcSkYCCHr6W044zV3Yxwb9Oz/R1XKVozQn8M9CUNWCZzcjXO
         /iluq5OZzugKPI8vOxuKg3okxbEZnqvmvi/wtSPSwbCoYQd3WQv7YtzrIA9BC3MeLmQr
         Dmks9lobAJwszswLjjvXo9KX5GwqpVn/J/PeM1TsYXCa9f7mvdyauNn/0W+12MAB7l+r
         e1mg==
X-Received: by 10.152.9.37 with SMTP id w5mr4495870laa.23.1378692589474; Sun,
 08 Sep 2013 19:09:49 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 19:09:49 -0700 (PDT)
In-Reply-To: <xmqqd2opsprq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234303>

On Tue, Sep 3, 2013 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 93197b9..b8ece6e 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -1004,6 +1004,26 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>>       return st;
>>  }
>>
>> +/* parse @something syntax, when 'something' is not {.*} */
>> +static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
>> +{
>> +     const char *next;
>> +
>> +     if (len || name[1] == '{')
>> +             return -1;
>> +
>> +     /* make sure it's a single @, or @@{.*}, not @foo */
>> +     next = strchr(name + len + 1, '@');
>> +     if (!next)
>> +             next = name + namelen;
>> +     if (next != name + 1)
>> +             return -1;
>> +
>> +     strbuf_reset(buf);
>> +     strbuf_add(buf, "HEAD", 4);
>> +     return 1;
>> +}
>
> Hmph, is the above sufficient?  I added a case that mimics Stefano's
> original regression report (which is handled) and another that uses
> doubled "@" for the same purpose of introducing a "funny" hierarchy,
> and it appears that "checkout -b" chokes on it.

This fixes it:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1014,6 +1014,8 @@ static int interpret_empty_at(const char *name,
int namelen, int len, struct str

        /* make sure it's a single @, or @@{.*}, not @foo */
        next = strchr(name + len + 1, '@');
+       if (next && next[1] != '{')
+               return -1;
        if (!next)
                next = name + namelen;
        if (next != name + 1)

-- 
Felipe Contreras
