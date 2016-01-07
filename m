From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Thu, 7 Jan 2016 19:55:41 +0530
Message-ID: <CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com> <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 15:26:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHBW4-0003GI-KK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 15:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbcAGO0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 09:26:12 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34056 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbcAGO0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 09:26:11 -0500
Received: by mail-vk0-f51.google.com with SMTP id a123so143539168vkh.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TzhmehSyp/+yG4JxM4Rvc6rCONn/itZrQR985T19Ch8=;
        b=ZXSuJV1DX0yAvpS3QkyZvSAJRcCcwkr4sPPQrmWp8D8Y6o+TzxS0JZA4wQNIUgZY5M
         wjXaN/oKjMYXjtJIXd/inpb+SSVd+TR6zjPLHar9fBl3kbVyWiLwmwQSGRgW/EQl4Gu0
         HkhTOqiwDl+kcaDg4+BXIODmc7t+m6CBb40fbOACpxUVK03vVWSB9zFlZ2I1RuQNnOae
         qEwb2hfCzWx5euBijZsQkp+Xwir691cVS6XpyTljHslA46CWb6GAMXO2L9FxoZLWrARs
         Dccmhsa14zeeqvSbvxnzr9u/dE3118AHIG1CAascJTmjlqQtBJx6mlZ/tXSJ7ToPRI9y
         ZZhg==
X-Received: by 10.31.149.3 with SMTP id x3mr7898729vkd.46.1452176770707; Thu,
 07 Jan 2016 06:26:10 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Thu, 7 Jan 2016 06:25:41 -0800 (PST)
In-Reply-To: <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283493>

On Thu, Jan 7, 2016 at 2:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 5, 2016 at 3:02 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Eric suggested that I make match_atom_name() not return a value [0]. I
>> haven't done that as we use match_atom_name() in [14/15] for matching
>> 'subject' and 'body' in contents_atom_parser() and although Eric
>> suggested I use strcmp() instead, this would not work as we need to
>> check for derefernced 'subject' and 'body' atoms.
>> [0]: http://article.gmane.org/gmane.comp.version-control.git/282701
>
> I don't understand the difficulty. It should be easy to manually skip
> the 'deref' for this one particular case:
>
>     const char *name = atom->name;
>     if (*name == '*')
>         name++;
>
> Which would allow this unnecessarily complicated code from patch 14/15:
>
>     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>         ...
>         return;
>     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>         ...
>         return;
>     } if (!match_atom_name(atom->name, "contents", &buf))
>         die("BUG: parsing non-'contents'");
>
> to be simplified to the more easily understood form suggested during
> review[1] of v2:
>
>     if (!strcmp(name, "subject")) {
>         ...
>         return;
>     } else if (!strcmp(name, "body")) {
>         ...
>         return;
>     } else if (!match_atom_name(name,"contents", &buf))
>         die("BUG: expected 'contents' or 'contents:'");
>
> You could also just use (!strcmp("body") || !strcmp("*body")) rather
> than skipping "*" manually, but the repetition makes that a bit
> noisier and uglier.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/282645

Definitely not a difficulty per se. Just that it seems like something
match_atom_name()
seems to be fit for. As the function name suggests that we're matching
the atom name
and the check for '!buf' indicates that no options are to be included
for that particular atom.

Also after Junio's suggestion[1], I think It looks better now[2]. But
either ways, I'm not
strongly against what you're saying, so my opinion on this matter is
quite flexible.

[1]: http://article.gmane.org/gmane.comp.version-control.git/283404
[2]: http://article.gmane.org/gmane.comp.version-control.git/283449

-- 
Regards,
Karthik Nayak
