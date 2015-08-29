From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Sat, 29 Aug 2015 06:00:10 +0200
Message-ID: <CAP8UFD2Vm0ObZXfH_D-AgHS3eOrL-9W6jqcAMqsZLWA4ArL=3g@mail.gmail.com>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	<xmqqegip3k5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 06:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVXJU-0003zp-1t
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 06:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbbH2EAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 00:00:13 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35339 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbH2EAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 00:00:11 -0400
Received: by igph8 with SMTP id h8so24504204igp.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fk9B6jyA85Y1ODEOyA9CM99T9kBy3QU0SOJBne2WOfY=;
        b=EHaquMJ/Kak5AOpGiFq/GXYPVU0ZsCf54i7cBvQooWf2pJqpfHius/hCJtzmLZL3rb
         DwzKCqobKj/f43Qc297fMiR5QM4A7ljedC3dalVC3cEjdke0UN482Bf7ojVDfy1vnPP8
         H6oC2exBaor3V52uFKlfeDd3rBUPGWsj1S8/UchKYydvovGLA+U2Uk8WF3cqxykPPTno
         oaEZb93ADbym3jJQjJsgvwMoYwkRjBUgxI37tqT31J09a4SCmFxAHXHwtjlJSHe1grPR
         hTa51/gBBd4qZ8xp7qNbx6sIkxFhpIwy10e+K81yrZzYohLQxSDXMsv/CTUw7YwLdwHZ
         2LPw==
X-Received: by 10.50.80.14 with SMTP id n14mr5525712igx.30.1440820810790; Fri,
 28 Aug 2015 21:00:10 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Fri, 28 Aug 2015 21:00:10 -0700 (PDT)
In-Reply-To: <xmqqegip3k5y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276764>

On Wed, Aug 26, 2015 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> We currently ignore the first line passed to `git interpret-trailers`,
>> when looking for the beginning of the trailers.
>>
>> Unfortunately this does not work well when a commit is created with a
>> line break in the title, using for example the following command:
>>
>> git commit -m 'place of
>> code: change we made'
>>
>> In this special case, it is best to look at the first line and if it
>> does not contain only spaces, consider that the second line is not a
>> trailer.
>> ---
>
> Missing sign-off,

Ok, will add it.

[...]

> I think the analysis behind the first patch is correct.  It stops
> the backward scan of the main loop to reach there by realizing that
> the first line, which must be the first line of the patch title
> paragraph, can never be a trailer.
>
> To extend that correct realization to cover the case where the title
> paragraph has more than one line, the right thing to do is to scan
> forward from the beginning to find the first paragraph break, which
> must be the end of the title paragraph, and exclude the whole thing,
> wouldn't it?
>
> That is, I am wondering why the patch is not more like this (there
> may be off-by-one, but just to illustrate the approach; I didn't
> even compile test this one so...)?
>
> Puzzled...
>
>  static int find_trailer_start(struct strbuf **lines, int count)
>  {
> -       int start, only_spaces = 1;
> +       int start, end_of_title, only_spaces = 1;
> +
> +       /* The first paragraph is the title and cannot be trailer */
> +       for (start = 0; start < count; start++)
> +               if (!lines[start]->len)
> +                       break; /* paragraph break */
> +       end_of_title = start;
>
>         /*
>          * Get the start of the trailers by looking starting from the end
>          * for a line with only spaces before lines with one separator.
> -        * The first line must not be analyzed as the others as it
> -        * should be either the message title or a blank line.
>          */
> -       for (start = count - 1; start >= 1; start--) {
> +       for (start = count - 1; start >= end_of_title; start--) {
>                 if (lines[start]->buf[0] == comment_line_char)
>                         continue;
>                 if (contains_only_spaces(lines[start]->buf)) {

Yeah, we can do that. It will be clearer.

Thanks,
Christian.
