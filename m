From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 05/10] ref-filter: introduce color_atom_parser()
Date: Mon, 14 Dec 2015 00:16:41 +0530
Message-ID: <CAOLa=ZQhFXUYvYjJjWDzN6z+HDiXrhJqRbd3CWKTGmDtXn3oJw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRXgLqmUf1ZK2QnHbHM6-1Ya=iTx6Jq9YdnkO8aOsq+tQ@mail.gmail.com>
 <CAOLa=ZQY3PMtfemVAsbHydtguQG9pc2uVTiJ6Qh+jLf6mY4dFw@mail.gmail.com> <CAPig+cSC8fP1KGM1wCXzcfj2QHgvoUUjfBncRH0jKLv1EnYKCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 19:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Bfx-0007QG-IF
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 19:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbLMSrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 13:47:12 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34165 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbLMSrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 13:47:12 -0500
Received: by vkgj66 with SMTP id j66so46033759vkg.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bB4Xzuh9wx3u+30ixoLUCpcyC9XS9oAwS5sfyzj2TpM=;
        b=bULq0bv+FxzRnbW+nKxky40OPnypKUEypkUOF5ep60k/cptaZwSG199J3XEHkQbn3q
         MLE9uKzHelNIBVlaS7n7YKfOLQl/DjLToM5sc3MOz5Q0JAi+JMb/TSzEJ4zGow/BkMbC
         j5NR8y4ZWt4kF+yJJbYlMapKnTUvdxBwBp3I6VjVK4LFVFgWps7Q9sZen8scWVFbRyj3
         N0npazFcyg1HsQQLCi5SPWMjxRFTRBa/FWFuTd71sRnI/LPcfvP/wmTzX1l5nuq+Cxyq
         xJSWPEtd+sqlBcvGFsipYeKla9n255rdxTo9APNwgRNje7HFgfO50u1NCApxPx9MDyre
         KTqg==
X-Received: by 10.31.155.23 with SMTP id d23mr19362948vke.146.1450032431034;
 Sun, 13 Dec 2015 10:47:11 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 10:46:41 -0800 (PST)
In-Reply-To: <CAPig+cSC8fP1KGM1wCXzcfj2QHgvoUUjfBncRH0jKLv1EnYKCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282340>

On Sun, Dec 13, 2015 at 11:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Dec 3, 2015 at 8:35 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Wed, Dec 2, 2015 at 4:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> @@ -833,11 +846,10 @@ static void populate_value(struct ref_array_item *ref)
>>>>                         refname = branch_get_push(branch, NULL);
>>>>                         if (!refname)
>>>>                                 continue;
>>>> -               } else if (match_atom_name(name, "color", &valp)) {
>>>> +               } else if (starts_with(name, "color")) {
>>>
>>> Hmm, so this will also match "colorize". Is that desirable?
>>
>> Well the error checking is done when we parse the atom in color_atom_parser()
>> so here we don't need to worry about something like this.
>
> I'm not sure that I understand your response. Let's say that, in the
> future, someone adds a new atom named "colorize" (which may or may not
> have its own parser in the valid_atom[] table). color_atom_parser()
> will never see that atom, thus error checking in color_atom_parser()
> is not relevant to this case. What is relevant is that the original
> code:
>
>     } if (match_atom_name(name, "color", &valp)) {
>
> only matched %(color) or %(color:whatever). It did not match
> %(colorize). However, the new code:
>
>     } else if (starts_with(name, "color")) {
>
> is far looser and will match %(colorize) and %(color) and
> %(color:whatever) and %(coloranything), which is potentially
> undesirable. It's true that the person adding %(colorize) could be
> careful and ensure that the if/else chain checks %(colorize) first:
>
>     } else if (!strcmp(name, "colorize") {
>         ...
>     } else if (starts_with(name, "color")) {
>         ...
>     } else ...
>
> but that places a certain extra burden on that person. Alternately,
> you can tighten the matching so that it is as strict as the original:
>
>     } else if (!strcmp(name, "color") || starts_with(name, "color:")) {
>         ...
>     } else ...
>
> Or perhaps upgrade match_atom_name() to make the 'val' argument
> optional, in which case you might be able to do something like this:
>
>     } else if (match_atom_name(name, "color", NULL) {
>
> (However, if you introduce an 'enum atom_type' as suggested in my
> response to the cover letter, then this problem goes away because
> you'd be switching on the enum value, which is determinate, rather
> than on a partial string, which may be ambiguous, as illustrated.)

Ah, Thanks for putting it out. I understand, I'll work on the enum atom_type
now. that should take care of this :)

-- 
Regards,
Karthik Nayak
