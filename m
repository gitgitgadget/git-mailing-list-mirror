From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 04:04:00 -0400
Message-ID: <CAPig+cT=uUp5T1W1-CBrx4ZMsTSdpoghg57affU3JZ3Uvq20Pw@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
	<1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
	<CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
	<CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
	<CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 10:04:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLaR-0004kJ-Qy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 10:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbbHIIED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 04:04:03 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34768 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858AbbHIIEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 04:04:01 -0400
Received: by ykdt205 with SMTP id t205so38159946ykd.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xfGupvb2ML9VWrleHLbRF3lZrdOfzX3REAMnzxCQ6Hg=;
        b=i64ADR8AkIWmg7o/sRGlHaL8sES0QARZ8VsaMAwzLFrcdwFjtiKakL20Dvzo3MqXBD
         0miHxbcbrKRBL0xN5jMuklftlXrfX74JRLPGpmame11k4hz4IWNG/7gBbNd/8vP/U2WW
         ZmwSJ8N+2J1n/X6GmLzlJHM9JIwYMmL/ABtUU3Q0bGcZHJjR9EgttODkGJAK6c/Ov8lH
         fiaW+gerRkxDwgukkyHpAOvDYJvSwJMb9miTIFV68+Ig9NRiBvlDtGrfTdlo5I28ozWm
         +jj55HOusXFdu4yLVXZWVWX5/4x3ojY+vck3GrTT4daqw20/+Rp3IZe4LrtYkHiev25i
         SrQA==
X-Received: by 10.13.221.14 with SMTP id g14mr1309968ywe.48.1439107440791;
 Sun, 09 Aug 2015 01:04:00 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 01:04:00 -0700 (PDT)
In-Reply-To: <CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com>
X-Google-Sender-Auth: a0XJPIL5sakOrxX7KZr0MqYQAh8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275530>

On Sun, Aug 9, 2015 at 2:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 9, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 8, 2015 at 2:35 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Fri, Aug 7, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>> +               else if (align->align_type == ALIGN_MIDDLE) {
>>>>> +                       int right = (align->align_value - buf_len)/2;
>>>>> +                       strbuf_addf(final, "%*s%-*s", align->align_value - right + len,
>>>>> +                                   value->buf, right, "");
>>>>
>>>> An aesthetic aside: When (align_value - buf_len) is an odd number,
>>>> this implementation favors placing more whitespace to the left of the
>>>> string, and less to the right. In practice, this often tends to look a
>>>> bit more awkward than the inverse of placing more whitespace to the
>>>> right, and less to the left (but that again is subjective).
>>>
>>> I know that, maybe we could add an additional padding to even out the value
>>> given?
>>
>> I don't understand your question. I was merely suggesting (purely
>> subjectively), for the "odd length" case, putting the extra space
>> after the centered text rather than before it. For instance:
>>
>>     int left = (align->align_value - buf_len) / 2;
>>     strbuf_addf(final, "%*s%-*s", left, "",
>>         align->align_value - left + len, value->buf);
>>
>> or any similar variation which would give the same result.
>
> I get this could be done, what I was asking was, Consider given a alignment
> width of 25 would be better to make that 26 so that we have even padding on
> both sides. But I don't like the adding of manipulating user given data.

I thought you might be asking that, but wasn't certain. I do agree
with your conclusion that second-guessing the user is a bad idea, and
that you should give the user exactly what was requested.

>> That raises another question. Why are 'struct ref_formatting_state',
>> 'struct align', 'struct atom_value', etc. defined in ref-filter.h at
>> all? Aren't those private implementation details of ref-filter.c, or
>> do you expect other code to be using them?
>
> I guess struct ref_formatting_state and struct align could be moved to
> ref-filter.c. About struct atom_value its referenced by ref_array_item()
> so any reader reading about this, would find it easier if atom_value()
> is at the same place.

Do you expect callers ever to be manipulating or otherwise accessing
the atom_value of ref_array_item? If callers have no business mucking
with atom_value, then one option would be to simply forward declare
atom_value in the header:

    struct atom_value;

    struct ref_array_item {
        ...
        struct atom_value *value;
        ...
    };

which makes atom_value opaque to clients of ref-filter. The actual
declaration of atom_value would then be moved to ref-filter.c, thus
kept private.
