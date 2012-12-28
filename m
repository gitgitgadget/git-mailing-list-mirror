From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/8] wildmatch: support "no FNM_PATHNAME" mode
Date: Fri, 28 Dec 2012 14:15:41 +0700
Message-ID: <CACsJy8C7Y8xLVVhUtt1g234XnHrTbjRCBcY261QEe-y81A1YUw@mail.gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
 <1356163028-29967-5-git-send-email-pclouds@gmail.com> <7vwqw2k833.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 08:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToUBG-00027G-5U
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 08:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2L1HQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 02:16:14 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:42446 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2L1HQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 02:16:12 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so9429929obb.35
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 23:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=otSd8I8QKeq4z4uZDN4T9BdCuL850V02gMtEH/n/TuA=;
        b=AtlGtIQXj5NgMK/F7UEmjt99DqauwGoV4NgKCG/Ih6Dg3Swk5cYfpX/jjQJ8NVh6H7
         wL15k55GadZz3Rgau2uCVWmBEs8qoIJKnazBThu2hiaVV5u3pMLyP0r3NTWBtjOY16oi
         ZTej1IuMn8lluaHDs5Dnzv1YnGa3ViPjb2gNHvGPXja3WH7/1K8OyCXT8Vu9Tjwq/zD9
         AuxEPeC/2eGyQYiSYglkjKssnnCOJuyJL0U+w9P/+mYqliuVPUOm64sOI5SIGSKsBY4n
         sYHVejFWWGCfRRV4Sjzuq0Ya5dpzSgVgH8XFVYmHbX9snB4gup+sOWjnXx4cfxJuCV0l
         eAmQ==
Received: by 10.182.177.72 with SMTP id co8mr26978111obc.53.1356678972085;
 Thu, 27 Dec 2012 23:16:12 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Thu, 27 Dec 2012 23:15:41 -0800 (PST)
In-Reply-To: <7vwqw2k833.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212238>

On Fri, Dec 28, 2012 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>                       if (*++p == '*') {
>>                               const uchar *prev_p = p - 2;
>>                               while (*++p == '*') {}
>> -                             if ((prev_p == text || *prev_p == '/') ||
>> +                             if (!(flags & WM_PATHNAME))
>> +                                     /* without WM_PATHNAME, '*' == '**' */
>> +                                     special = 1;
>> +                             else if ((prev_p == text || *prev_p == '/') ||
>
> Not a new issue in this patch,

No, it's an issue from nd/wildmatch, 40bbee0 (wildmatch: adjust "**"
behavior - 2012-10-15).

> but here, "prev_p" points into the
> pattern string, two bytes before p, which is the byte before the
> "**" that we are looking at (which might be before the beginning of
> the pattern).  "text" is the string we are trying to match that
> pattern against.  How can these two pointers be compared to yield a
> meaningful value?

They can't. I wanted to check whether "**" is at the start of the
pattern (so no preceding '/' needed) and used a wrong pointer to
compare to. Funny there is a test about this and it does not catch it
because prev_p access something before the pattern. Will fix.

>
>>                                   (*p == '\0' || *p == '/' ||
>>                                    (p[0] == '\\' && p[1] == '/'))) {
>
> OK.  "**/", "**" (end of pattern), and "**\/" are handled here.
>
> Do we have to worry about "**[/]" the same way, or a class never
> matches the directory separator, even if it is a singleton class
> that consists of '/' (which is fine by me)?  If so, is "\/" more or
> less like "[/]"?

This is a special case of "**" with FNM_PATHNAME on. With
FNM_PATHNAME, '[]' and '?' cannot match '/' so any patterns with '[/]'
match nothing. I think we don't need to worry about this case.
-- 
Duy
