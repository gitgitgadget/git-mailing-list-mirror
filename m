From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] ref-filter: introduce objectname_atom_parser()
Date: Fri, 25 Dec 2015 13:09:46 -0500
Message-ID: <CAPig+cRb2rWX53dkrbEU5+QUf7z69J7X-P-JUsCLuRYZ4ny-Ag@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-12-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSFG86U=+onvJ1aaosmX3k+fzD-431q-hFTnWHpg=pZVw@mail.gmail.com>
	<CAOLa=ZSV9NmAcC+yguacWqcwLDnmBZd-arwzk+WnjtM2J1eC_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 19:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCWp0-0001Sy-Su
	for gcvg-git-2@plane.gmane.org; Fri, 25 Dec 2015 19:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbbLYSJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2015 13:09:48 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35809 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbbLYSJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2015 13:09:47 -0500
Received: by mail-vk0-f53.google.com with SMTP id k1so31587422vkb.2
        for <git@vger.kernel.org>; Fri, 25 Dec 2015 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9t2Ch/c3LwbEhF5s9he26e+EDdPtQYQQA3sLHg0mjDo=;
        b=PVk7rIO0yaxvU4gXRlMNsC933B2AGTZuvjKBCfkWr4bGAa2YciFRH+ytRjLI8zmt/C
         wTkve0R0ztSmge5pEPumgN7BM1bU/IYAUmw0/z3bn8bbe7lu0dA+bkMAuORsFkXI7gBx
         QpUEIOri8Rt3rpy9LQHvhGssoZvuCBSD61cB6MobMScECzeHf6syt8vVTxPtcE8IPbVj
         wlnuk7Wy8GhAUtUMVs5CkMidhX7Pw9T2dM71fSiBJkislM08WTBhhItpeXD0/28vPeAG
         aOtO72xMh+JX6t0ffAzteh835HKWYAMFJzbi1XnUtwQuQp4gE+960oOwGsAXsC6aDCYJ
         pX7g==
X-Received: by 10.31.56.18 with SMTP id f18mr23921022vka.19.1451066986630;
 Fri, 25 Dec 2015 10:09:46 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 25 Dec 2015 10:09:46 -0800 (PST)
In-Reply-To: <CAOLa=ZSV9NmAcC+yguacWqcwLDnmBZd-arwzk+WnjtM2J1eC_Q@mail.gmail.com>
X-Google-Sender-Auth: RKkt6EF5auTOfVGoAA8TaFdbWlc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282989>

On Fri, Dec 25, 2015 at 8:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 11:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +static void objectname_atom_parser(struct used_atom *atom)
>>> +{
>>> +       const char * buf;
>>> +
>>> +       if (match_atom_name(atom->str, "objectname", &buf))
>>> +               atom->u.objectname = O_FULL;
>>> +       if (!buf)
>>> +               return;
>>
>> make_atom_name("objectname") will return true only for "objectname" or
>> "objectname:", and will return false for anything else, such as
>> "objectnamely" or "schmorf". Furthermore, the only way
>> objectname_atom_parser() can be called is when %(objectname) or
>> %(objectname:...) is seen, thus match_atom_name() *must* return true
>> here, which means the above conditional is misleading, suggesting that
>> it could somehow return false.
>>
>> And, if match_atom_name() did return false here, then that indicates a
>> programming error: objectname_atom_parser() somehow got called for
>> something other than %(objectname) or %(objectname:...). This implies
>> that the code should instead be structured like this:
>>
>>     if (!match_atom_name(..., "objectname", &buf)
>>         die("BUG: parsing non-'objectname'")
>>     if (!buf)
>>         atom->u.objectname = O_FULL;
>>     else if (!strcmp(buf, "short"))
>>         atom->u.objectname = O_SHORT;
>>     else
>>         die(_("unrecognized %%(objectname) argument: %s"), buf);
>>
>> However, this can be simplified further by recognizing that, following
>> this patch series, match_atom_name() is *only* called by these new
>> parse functions[1], which means that, as a convenience,
>> match_atom_name() itself could become a void rather than boolean
>> function and die() if the expected atom name is not found. Thus, the
>> code would become:
>>
>>     match_atom_name(...);
>>     if (!buf)
>>         ...
>>     else if (!strcmp(...))
>>         ...
>>     ...
>>
>> By the way, the above commentary isn't specific to this patch and
>> %(objectname), but is in fact also relevant for all of the preceding
>> patches which introduce parse functions calling match_atom_name().
>
> Ah! Thats some good observation, makes sense, match_atom_name()
> is only called after the atom name, so making it return a indication of
> success or failure doesn't make sense.
>
> I think this change would go nicely with the introduction of 'enum atom_type'
> which you mentioned[0] in the previous series.

I'm not sure to which change you refer as going nicely with the 'enum
atom_type'.

The observation above is about misleading logic in this series which
makes the code confusing. At the very least, the present series should
clean up the logic to reflect the first example above.

Changing match_atom_name() from boolean to void, as in the second
example above, is a nice little cleanup, but less important and
needn't be in this series (though it would just be one minor patch at
the end of the series).
