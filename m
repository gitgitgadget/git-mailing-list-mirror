From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v9 1/9] git-clean: refactor git-clean into two phases
Date: Wed, 15 May 2013 23:07:27 +0800
Message-ID: <CANYiYbF+JLqyB19gHxcC+-ysM=hbMZMve=4JNoiu15B=jaUS9g@mail.gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
	<7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
	<7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
	<CANYiYbF3AC=iHaOkj96yhBSj8caC2SdZDygrxV43+mzAd-wGJA@mail.gmail.com>
	<7vbo8ce14u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 17:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdIj-0005pm-CL
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399Ab3EOPH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:07:29 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:55244 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184Ab3EOPH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:07:28 -0400
Received: by mail-we0-f177.google.com with SMTP id q58so1660669wes.8
        for <git@vger.kernel.org>; Wed, 15 May 2013 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=nhjv23igONmpNFNczKD3fHiYKlk+8kAU+gQpQxhVX/I=;
        b=br1KhnFt7tY+ju4xEe/NQGFlNFvYtSo6hkccP4M1H2gQUAj7/K8vBrIKPwJ5v5FoS9
         30igm0yU8bPw8FnYf6CKklWIlSAt9mpT9MXwTW2NvxNff0qgmYly0uZSt892kufCE162
         IqCE/YIAiJIPv09t6bRZ9P4DtKzrq549xq7w0vOgSiJnq/oGbkn5QYRm4QRLIEIIQZFQ
         aVT046R/YbZyI1HNjqWxaRfItk05LB7m94NNVnVfAqp6uLx3T3wP3+R45ACWKmYxy5Bt
         0/xMoCRAFAF4n4wRiF6nbijrG0He/ciLLT/vt4o0rK7AJXzxpPo//a7EuDtRakfYEVZj
         24OQ==
X-Received: by 10.194.80.170 with SMTP id s10mr4953981wjx.9.1368630447237;
 Wed, 15 May 2013 08:07:27 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Wed, 15 May 2013 08:07:27 -0700 (PDT)
In-Reply-To: <7vbo8ce14u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224412>

2013/5/15 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> 2013/5/15 Junio C Hamano <gitster@pobox.com>:
>>>> @@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>>>                               continue; /* Yup, this one exists unmerged */
>>>>               }
>>>>
>>>> -             /*
>>>> -              * we might have removed this as part of earlier
>>>> -              * recursive directory removal, so lstat() here could
>>>> -              * fail with ENOENT.
>>>> -              */
>>>>               if (lstat(ent->name, &st))
>>>>                       continue;
>>>
>>> I am guessing that the reason why you removed the comment is because
>>> during this phase there is no way we "might have removed".  But if
>>> that is the case, does it still make sense to run lstat() and ignore
>>> errors from the call?
>>>
>>
>> Run lstat() here is necessary, because we need to check whether
>> ent->name points to a file or a directory. If ent points to a directory,
>> only add to del_list when user provides '-x' option to git-clean.
>
> Sorry, but that was not the question; we can see st is used
> immediately below so somebody needs to fill it.
>
> I was pointing out that the "lstat() is expected to fail with ENOENT
> but it is not an error worth reporting" justification the original
> code had to silently ignore an error, because you no longer remove
> anything immediately in this part of the code.  Is "if () continue"
> still valid thing to do here, not "if () die()"?

I'm clear, it could be:

                if (lstat(ent->name, &st))
                        die_errno("Cannot lstat '%s'", ent->name);


-- 
Jiang Xin
