From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 13 Dec 2015 01:15:02 -0500
Message-ID: <CAPig+cRtKezyzkBpTmc3sgrkk3zDXX3ZnmkW57rf=AVZNaCrvA@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-9-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
	<CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 07:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7zwi-0001Ck-Un
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 07:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbbLMGPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 01:15:05 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34938 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbLMGPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 01:15:04 -0500
Received: by vkha189 with SMTP id a189so137609806vkh.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 22:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=z/l/I9dOokSeMNxgqQeVQQuIqbX1RS5ff536AHLWrzQ=;
        b=VNUfmHeMs9C5JXZEPtAd2KoM+elDyUPlphNTYVZa9M0mpC3YISD3aQY4rXop/Nlsgu
         Nojfd2bblPxhk7vPFR8COkMkkChLrQ7/Njsvlsqtyj0PSq1si7aOBZM8XjrJpU2TyeNw
         oAGxMgJMjFfxQc5+rNUGiFTACUMheNVfrKLwrtWhnRIKTOxdZc/5aZQXSWElvdYqrWaC
         wKcJU5VEh4equ263agHDgcrKOUENcuw6Zisz+ovs0caSdGHN7H5vaz7gK9nsd9QBJBXZ
         5m2HJJa2xyaH+ErMTKJNzRo9L2538pGIOeLKnjuRjGudFb3KeiCUVPAMm62Woa09aLB+
         O1WQ==
X-Received: by 10.31.182.129 with SMTP id g123mr20369170vkf.45.1449987302887;
 Sat, 12 Dec 2015 22:15:02 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 22:15:02 -0800 (PST)
In-Reply-To: <CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
X-Google-Sender-Auth: VFMhIzmZNg2R1XqgcooIAK0qX3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282323>

On Sun, Dec 13, 2015 at 1:02 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +               if (!num_ours && !num_theirs)
>>> +                       *s = "";
>>> +               else if (!num_ours)
>>> +                       *s = xstrfmt("[behind %d]", num_theirs);
>>> +               else if (!num_theirs)
>>> +                       *s = xstrfmt("[ahead %d]", num_ours);
>>> +               else
>>> +                       *s = xstrfmt("[ahead %d, behind %d]",
>>> +                                    num_ours, num_theirs);
>>
>> Tangent: These xstrfmt()'d strings are getting leaked, right? Is that
>> something that we need to worry about (if, for instance, a repository
>> contains a lot of tracking refs)? Should there be a NEEDSWORK comment
>> here regarding the issue?
>
> This is sort of a problem with most of the values in ref-filter, we dynamically
> allocate memory and do not free it, since the program exits soon after and
> we leave it to the Operating System to do the garbage collection.

I'm not worried about memory dynamically allocated for the used_atom[]
array being leaked (and cleaned up automatically at program exit), but
rather about memory being leaked for each processed reference, which
might become substantial for a project with a lot of references.

> Not sure if we'd want to work on this though.

It's likely outside the scope of the current patch series anyhow, and
probably not something that needs to be tackled right away (or perhaps
ever), which is why a NEEDSWORK comment might be appropriate, as a
reminder that the situation could be improved.
