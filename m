From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 22/67] entry.c: convert strcpy to xsnprintf
Date: Tue, 15 Sep 2015 14:04:07 -0700
Message-ID: <CAGZ79kZ+YEV61HOgPZ8AcCmFZ5yA-7mLXkwh4p_9Y9BcS-XCAQ@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154012.GV29753@sigill.intra.peff.net>
	<55F86AED.4090500@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 23:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbxOh-0005sj-16
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 23:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbIOVEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 17:04:09 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33686 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbIOVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 17:04:08 -0400
Received: by ykft14 with SMTP id t14so47611150ykf.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GkpXumhIZR0dC/I3FDPhs1uXLQi2HwDzWW0Ob85UwVA=;
        b=jowgRTdhi5uYTXEge3ODF5Ta1RpXPHOKlDorxU8s1ayUJ572HamlcvYN26qa9AywEu
         2fylHPtA31DP37jnzwkFCdKemXRPAXI8ujZ4wLNjhU1/ttyZaq67qflQQd7ZMKea8uap
         iPrOWgPMSTRePoFwpEiVQ/S0YTjQZwyhWj+Z+tAnkVlJjLL539qwt3Hge4Xw/PU1xUJW
         UAKq8M5OjVurcAZ1uZ0fD4y7wRxJE9xzYqun/EvAgTcLB5WAewvgmKaTEz0sSeEN5imd
         koooC9O4ZFgUPQX5hdx/an6gMMdD32SpEmpq0JR6U/5U3T0w25D4yuCa2+kXfNvX/obn
         bHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GkpXumhIZR0dC/I3FDPhs1uXLQi2HwDzWW0Ob85UwVA=;
        b=conxbbvwzvwOiahGptcxTPa2rzW11X0yggCBBfoAQF0d4o0uTp9l5AjjRgscH2Sttm
         mMgaxcqBeBGymqjZN+WjUU5TJjwebkLIUvcNdt7i4LRQovgD4R2Yyre84vR3PRry/780
         +EA8snupHQvcsp8YPssPbmMX+fFddc38xEC/39+1i1NfDLD7GP3JTIUpWFvcfGqdwBcQ
         4zE5zdfYJuNbYHohtzfPYIyaY6xQTarhAsIpXGOfNuNqWn6Lih4jrYs++gSaGjX1JvNO
         dM1O7Wz2KG9S8zBSobSCrkQMmsafh719hVM45NFNVTFLiRtyw1xWsEQOZOyRrpypL2W2
         +xsg==
X-Gm-Message-State: ALoCoQkBwTojD2MuVQ5vOQ96OEdP2iNr2ORrSsuyXkVXCDzgDo5vc02NIOeVJgNNXtEDDsugxKgt
X-Received: by 10.129.16.212 with SMTP id 203mr24912093ywq.142.1442351047625;
 Tue, 15 Sep 2015 14:04:07 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 15 Sep 2015 14:04:07 -0700 (PDT)
In-Reply-To: <55F86AED.4090500@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277984>

On Tue, Sep 15, 2015 at 12:01 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 15/09/15 16:40, Jeff King wrote:
>> This particular conversion is non-obvious, because nobody
>> has passed our function the length of the destination
>> buffer. However, the interface to checkout_entry specifies
>> that the buffer must be at least TEMPORARY_FILENAME_LENGTH
>> bytes long, so we can check that (meaning the existing code
>> was not buggy, but merely worrisome to somebody reading it).
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  entry.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/entry.c b/entry.c
>> index 1eda8e9..582c400 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -96,8 +96,8 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
>>  {
>>       int symlink = (ce->ce_mode & S_IFMT) != S_IFREG;
>>       if (to_tempfile) {
>> -             strcpy(path, symlink
>> -                    ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
>> +             xsnprintf(path, TEMPORARY_FILENAME_LENGTH, "%s",
>> +                       symlink ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
>>               return mkstemp(path);
>>       } else {
>>               return create_file(path, !symlink ? ce->ce_mode : 0666);
>
> Hmm, I was going to suggest strlcpy() again. However, if you expect an overflow to
> occur, then xsnprintf() will at least bring it to your attention!  Checking for overflow
> with strlcpy() is not rocket science either, and I guess we could add xstrlcpy() ... :-D

I mean having a default action "if overflow, then die" suits most of
the cases. It should be
a deliberate decision to not die in case of an overflow. (Why did you allocate
not enough memory in the first place?)

>
> dunno.
>
> ATB,
> Ramsay Jones
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
