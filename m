From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v3 4/7] notes copy --stdin: split lines with
 string_list_split()
Date: Sun, 28 Feb 2016 08:47:22 +0100
Message-ID: <56D2A60A.4000306@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de> <56D28207.6080600@moritzneeb.de>
 <CAPig+cT2GQ7mr0i649JRkJA7xGzXLEmy0RD31u537==sU1mtqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 08:47:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZw4g-0001eg-8v
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 08:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcB1HrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 02:47:25 -0500
Received: from moritzneeb.de ([78.47.1.106]:38027 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbcB1HrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 02:47:25 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id D692F1C02F;
	Sun, 28 Feb 2016 08:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456645643;
	bh=cArkiETHcHLlopwPLTjOq+5wclVpWPFUlNe5jrOrETw=;
	h=Subject:References:Cc:To:From:Date:In-Reply-To:From;
	b=XL2Wc33UXUHwaAL5uiKJQArxbMF7CqE+WXnyf7AALV0PBpnHpH1W40jcBdrPwqh6J
	 nIMpMbhipvRH/ntglIelzKMYL4qZzB962q8W3aEijBSUkKrbmG1ke6r2to4xsInR5H
	 pBZhP3Dw6cS7oY0tGMbAgrt8o/rGa3kgk/tMT+9k=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cT2GQ7mr0i649JRkJA7xGzXLEmy0RD31u537==sU1mtqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287758>

On 02/28/2016 07:56 AM, Eric Sunshine wrote:
> On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> This patch changes, how the lines are split, when reading them from
>> stdin to copy the notes. The advantage of string_list_split() over
>> strbuf_split() is that it removes the terminator, making trimming
>> of the left part unneccesary.
> 
> Here's an alternate commit message:
> 
>     strbuf_split() has the unfortunate behavior of leaving the
>     separator character on the end of the split components, thus
>     placing the burden of manually removing the separator on the
>     caller. It's also heavyweight in that each split component is a
>     full-on strbuf. We need neither feature of strbuf_split() so
>     let's use string_list_split() instead since it removes the
>     separator character and returns an array of simple NUL-terminated
>     strings.
> 
>> The strbuf is now rtrimmed before splitting. This is still required
>> to remove potential CRs. In the next step this will then be done
>> implicitly by strbuf_readline(). Thus, this is a preparatory refactoring,
>> towards a trim-free codepath.
> 
> I would actually swap patches 4 and 5 so that strbuf_getline() is done
> first (without removing any of the rtrim's) and string_list_split()
> second. That way, you don't have to add that extra rtrim in one patch
> and immediately remove it in the next. And, as a bonus, you can drop
> the above paragraph altogether.

Yeah, I also was thinking about that, should've pointed that out.
I was just following your "guiding" in v2 [1], that's why I did it this way,
because I thought it is somehow expected to be a prepraratory change.

Ok, when switching 4 and 5, I could call it something like "post cleanup/refactoring"
instead.

[1] http://article.gmane.org/gmane.comp.version-control.git/286868

> 
> The patch itself looks okay.
> 
>> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
>> ---
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> @@ -292,18 +292,18 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>>
>>         while (strbuf_getline_lf(&buf, stdin) != EOF) {
>>                 unsigned char from_obj[20], to_obj[20];
>> -               struct strbuf **split;
>> +               struct string_list split = STRING_LIST_INIT_DUP;
>>                 int err;
>>
>> -               split = strbuf_split(&buf, ' ');
>> -               if (!split[0] || !split[1])
>> +               strbuf_rtrim(&buf);
>> +               string_list_split(&split, buf.buf, ' ', -1);
>> +
>> +               if (split.nr != 2)
>>                         die(_("Malformed input line: '%s'."), buf.buf);
>> -               strbuf_rtrim(split[0]);
>> -               strbuf_rtrim(split[1]);
>> -               if (get_sha1(split[0]->buf, from_obj))
>> -                       die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
>> -               if (get_sha1(split[1]->buf, to_obj))
>> -                       die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
>> +               if (get_sha1(split.items[0].string, from_obj))
>> +                       die(_("Failed to resolve '%s' as a valid ref."), split.items[0].string);
>> +               if (get_sha1(split.items[1].string, to_obj))
>> +                       die(_("Failed to resolve '%s' as a valid ref."), split.items[1].string);
>>
>>                 if (rewrite_cmd)
>>                         err = copy_note_for_rewrite(c, from_obj, to_obj);
>> @@ -313,11 +313,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>>
>>                 if (err) {
>>                         error(_("Failed to copy notes from '%s' to '%s'"),
>> -                             split[0]->buf, split[1]->buf);
>> +                             split.items[0].string, split.items[1].string);
>>                         ret = 1;
>>                 }
>>
>> -               strbuf_list_free(split);
>> +               string_list_clear(&split, 0);
>>         }
>>
>>         if (!rewrite_cmd) {
>> --
>> 2.4.3
