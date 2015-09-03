From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Thu, 3 Sep 2015 21:31:04 +0530
Message-ID: <CAOLa=ZT=VEHWokfdBdRPsNj8VgBkyvV7GdacPaRgnMZOQ-G4qg@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWxN-0005k7-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272AbbICQBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:01:36 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36615 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771AbbICQBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:01:34 -0400
Received: by obqa2 with SMTP id a2so36237399obq.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pCmV1/j4wYFNyZjoYgv9tCvVnxkOg8i+LZk9RLv6eUc=;
        b=URDFcqPvTdaVQqjzB1HXi7Nwm9GgJ6bH4F0weArmYxJRQ3qaaUIeteb6OBCvpHgukx
         JaH96FoxyI4uRvWVilk7zTlB2LTgWlKaLCAcO2SZ2NE6aTNk/vpx8rR9WKhBczNarqqw
         nDFzxcZHhds5+vVSd5ULpdjNqqnAtY4P5vIgSwxXQKUyn+Myi6o61oIXIqL/wTTdgqX8
         wdxZ5lMi6uAsGTsanvT6ta/Ny9cABlPcOgaJt/wco6L+/ttj7pJ+8ZzE0sUTnoGZPtsk
         95etC8ZnWkViGGIA8bsr5kdXi+eMlh5fFqyJx4lglcEsBbcoIHMciKefQKIJLuBiGme/
         BW4w==
X-Received: by 10.182.81.98 with SMTP id z2mr26375562obx.70.1441296093961;
 Thu, 03 Sep 2015 09:01:33 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 09:01:04 -0700 (PDT)
In-Reply-To: <CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277215>

On Thu, Sep 3, 2015 at 7:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:..) and %(end).
>
> Spell this either %(align:) or %(align:...) with three dots, not two.
> I, personally, think %(align:) is sufficient.
>

Will change.

>> It is followed by `:<width>,<position>`, where the `<position>` is
>> either left, right or middle and `<width>` is the size of the area
>> into which the content will be placed. If the content between
>> %(align:) and %(end) is more than the width then no alignment is
>> performed. e.g. to align a refname atom to the middle with a total
>> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>>
>> We have an `at_end` function for each element of the stack which is to
>> be called when the `end` atom is encountered. Using this we implement
>> the aling_handler() for the `align` atom, this aligns the final strbuf
>> by calling `strbuf_utf8_align()` from utf8.c.
>>
>> Ensure that quote formatting is performed on the whole of
>> %(align)...%(end) rather than individual atoms inside.  We skip quote
>
> Add colon: %(align:)
>

Okay.

>> formatting for individual atoms when the current stack element is
>> handling an %(align) atom and perform quote formatting at the end when
>
> %(align:)
>

will do.

>> we encounter the %(end) atom.
>>
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index e49d578..cac3128 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,6 +127,15 @@ color::
>>         Change output color.  Followed by `:<colorname>`, where names
>>         are described in `color.branch.*`.
>>
>> +align::
>> +       Left-, middle-, or right-align the content between %(align:..)
>
> %(align:)
>

noted.

>> +       and %(end). Followed by `:<width>,<position>`, where the
>> +       `<position>` is either left, right or middle and `<width>` is
>> +       the total length of the content with alignment. If the
>> +       contents length is more than the width then no alignment is
>> +       performed. If used with '--quote' everything in between
>> +       %(align:..)  and %(end) is quoted.
>
> %(align:)
> Also drop the extra space before "and": s/\s+and/ and/
>

Noted, thanks for the review.

-- 
Regards,
Karthik Nayak
