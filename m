From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Fri, 26 Jun 2015 15:42:46 +0800
Message-ID: <CACRoPnQgy2C__912pVx+Xn2YTgMgfV8ukLtbd8f5uvk82EjnAw@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-7-git-send-email-pyokagan@gmail.com>
	<334feea4cee88d06a10a7363956d2bfe@www.dscho.org>
	<CACRoPnQAGt_mLbG-EtJ+qTpD2OvNgi-MZfU=NoKCoSmhCOnBEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 09:42:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8OHl-0001iA-3N
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 09:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbFZHmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 03:42:49 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33973 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFZHms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 03:42:48 -0400
Received: by lbnk3 with SMTP id k3so59434965lbn.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XVev6ar+zsmjQtLZqtaqbmZRYJbw+HvAKTXJl7KcH0U=;
        b=DXkNINqzUEPDOH7Kqqrb+hSQdgsUp9IxkdbiFC4NSvEroInnN/br6VKQR7v5JOEsJ6
         p9TSLfu0HJgAlixGEeLxlUdW3Eq43PGptO3k4kSC7dYQOvopaNs7zKHAo6cbjXtv8AsD
         22i7MmoHaTNtXe/G/TSF4ne7WK3edtwuuVs8iFBIP7CurnlnaX0uF0DW8OavHzGqvURW
         YhQbF2fkWz3DaOljPfAWsWZlnF4TitekVkvktf416kUCxDUVA3wOPrwbVO2zQ++pHkP9
         JB6XCQUVz3+82yDFbMhPSl7ymLMUPQlqxvTJv7oiGZOWUr39AqeIvBq14xIRjueZxlfL
         ZQcA==
X-Received: by 10.152.87.13 with SMTP id t13mr306688laz.66.1435304566575; Fri,
 26 Jun 2015 00:42:46 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 26 Jun 2015 00:42:46 -0700 (PDT)
In-Reply-To: <CACRoPnQAGt_mLbG-EtJ+qTpD2OvNgi-MZfU=NoKCoSmhCOnBEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272764>

On Thu, Jun 25, 2015 at 9:40 PM, Paul Tan <pyokagan@gmail.com> wrote:
> On Wed, Jun 24, 2015 at 11:10 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>> +     else if (l1.len && l2.len && l3.len && is_email(paths->items->string))
>>> +             ret = PATCH_FORMAT_MBOX;
>>
>> Maybe we can do better than this by folding the `is_email() function into this here function, reusing the same strbuf to read the lines and keeping track of the email header lines we saw... I would really like to avoid opening the same file twice just to figure out whether it is in email format.
>
> Okay, how about every time we call a strbuf_getline(), we save the
> line to a string_list as well? Like string_list_getline_crlf() below:
> [...]

Hmm, on second thought, I don't think it's worth the code complexity.
While I agree it's desirable to not open the file twice, I don't think
detecting the patch format is so IO intensive that it needs to be
optimized to that extent.

Instead, we should probably just modify is_email() to take a FILE*,
and then fseek(fp, 0L, SEEK_SET) to the beginning.

I think the logic of is_email() is complex and so it should not be
folded into the detect_patch_format() function, especially since we
may add detection of other patch formats in the future, and may need
more complex heuristics.

Regards,
Paul
