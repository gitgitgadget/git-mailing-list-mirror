From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Thu, 20 Feb 2014 10:55:29 +0700
Message-ID: <CACsJy8DB+OP6_vwZKWXjq4YbtiKDg2NE2zRsAuz1ER6oTmyGag@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-3-git-send-email-pclouds@gmail.com> <xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
 <CACsJy8BJ=OKzGDFwWQF_k_Gp9XeNwf7pe7c6_ebduJXN=xeOxw@mail.gmail.com> <xmqqa9dm78n3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 04:56:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGKk2-0003cm-GV
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 04:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbaBTD4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 22:56:01 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:61890 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbaBTD4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 22:56:00 -0500
Received: by mail-qc0-f170.google.com with SMTP id c9so2104338qcz.15
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 19:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bHSbP8gizjdqsmtr92SxmV2t3NxuUra80CfC9X7T5c4=;
        b=hjmK+bXAlU9TxjTSBiLry64kHHkhAgNmMvXDIuSkkYsVqptNjBBpM5tBwGJHNSqnOy
         xCeovl8pFvQD+eTqnX60aS8WfMHcI9Z/51V8PLffFxWgT1jHtk6ma8MSMUrylJjnW1Q/
         UqIqlsuZTAalvy8MBPFvkDNPEldO3I+Q2kyV/6y4evq6jdPO7oqUj0MmrsJY/N79DXE5
         qw9Sg0/3L/W9dywFV1lUu20NaokLKZ/aNTgoUkHhPD83AhDfFETP5vDGmmMTCzyB3OGc
         P0/WgCj+lFwK0DSc/0h4oKSuEuZt8/eLzWKsT7qAw+3mgullSdagcbwd8uPDBbfcCaAP
         vZ8w==
X-Received: by 10.140.40.5 with SMTP id w5mr52373309qgw.65.1392868559771; Wed,
 19 Feb 2014 19:55:59 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 19:55:29 -0800 (PST)
In-Reply-To: <xmqqa9dm78n3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242423>

On Thu, Feb 20, 2014 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>>> -             }
>>>> +             if (old->path && old->name &&
>>>> +                 !file_exists(git_path("%s", old->path)) &&
>>>> +                  file_exists(git_path("logs/%s", old->path)))
>>>> +                     remove_path(git_path("logs/%s", old->path));
>>>
>>> Hmph.  Is this conversion safe?
>>>
>>> This adds three uses of the round-robin path buffer; if a caller of
>>> this function used two or more path buffers obtained from
>>> get_pathname() and expected their contents to remain stable across
>>> the call to this, it will silently break.
>>
>> three round-robin buffers but not all required at the same time, once
>> the first file_exists() returns the first round-robin buffer could be
>> free, and remove_path() calls git_path again, not reusing the result
>> from the second file_exists, so the second buffer is free to go too.
>
> I know these three callers to git_path() will not step on each
> other's toes.  But that is not the question I asked.

OK so your question was if there was a git_path() or mkpath() call
earlier in update_refs_for_switch() and the result was expected to
remain stable till the end of update_refs_for_switch(), then this
conversion could ruin it, correct? I didn't think about that, but I
have checked and the only mkpath() call in this function is not
supposed to last long. If it's about a git_pathname() call outside
update_refs_...() that still expects to be stable, we should fix that
code instead.
-- 
Duy
