Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9B620189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbcFVSdN (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:33:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35928 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcFVSdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:33:12 -0400
Received: by mail-io0-f195.google.com with SMTP id s63so8613944ioi.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 11:33:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NfIMNA/v847kM44+FRGLgOfHPDuVFRU+qPDo6F4hi3c=;
        b=U4m6RkTKH/eCWh4BASoyIM42qaWV74Rep0wXBEPMBrodbtinEGAMFJ40oX2imqKGSu
         7XphT4grvUz6wJFVi6PqAHjXqcUM3OVB+7iSH0FTP3eTpWKHD70MSADiGwftTGzGqxp3
         vHsDZlRsIciSEIj1YyGSNklxiR9Ddh7iqcr9duUCtTe9IPUdBJTeKbI8iVaMBXWKtwDB
         N4nxbQxz9083IRK4EMO7XqkYkzhJYveL/DXkyu76vliyWj2yMXbpodszcfBKTYU5qfSr
         f+CePQtWDn4RcH0oPuiN+k4UcJPDf6TiWq/ddZKC/A3sROA+f7XWR16NfTRoYPC4jDwm
         itbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NfIMNA/v847kM44+FRGLgOfHPDuVFRU+qPDo6F4hi3c=;
        b=GR4k1qj8Ai6HVHo3eF8hhDgRMaGAYRZyucEpxj3EBcSRd5Gvh2pbh8XEmS17FA43ub
         4oYaWCqpS8LQZzAhii+805uAaAAEb/n5hJzf22X1aYs46tYCy/SzGwajlA377xxm54/e
         1Y3rsonfArzjisHJzyIASk42dNYofkTkZKuzJTn3ZkUlJg9OTJ5iiPEU/mzUMNKGbaDg
         vnD7FoGMIyVGAvS5Lao9UA/WeJzGn9NoaCxJwxPBXrtALFnc4rUeoewNNraBkQFRDA8d
         8VGBHIWJEpekL25hq3hHcQwPw0sxXYpjdv1z5qhbfjaTdtYiAb5N3QbG2PV0enioXtmr
         hKLA==
X-Gm-Message-State: ALyK8tLFi5QSta9ge3/Tb75VH2ZElQhbxc1jVgDadjIB0eblN/eBrnOuh2ysQ9FysqCALaFz0O5krjxMXN7qQg==
X-Received: by 10.107.22.131 with SMTP id 125mr41871431iow.128.1466620391698;
 Wed, 22 Jun 2016 11:33:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 11:32:42 -0700 (PDT)
In-Reply-To: <xmqqlh1xm7c5.fsf@gitster.mtv.corp.google.com>
References: <20160621211412.28752-1-charles@hashpling.org> <20160621211412.28752-2-charles@hashpling.org>
 <xmqqinx2nonl.fsf@gitster.mtv.corp.google.com> <CACsJy8C9Dh_Owr3UFJnCtvXserG4V-e1ws8ZY52ME1yr+fefOw@mail.gmail.com>
 <xmqqlh1xm7c5.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 22 Jun 2016 20:32:42 +0200
Message-ID: <CACsJy8Acb+Hx1R66hcHQ7gNQ6TmKoUzC7Ar2PpSPkQeKM1EY8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> So I wonder if a better change would be more like
>>>
>>>         for (...) {
>>>                 if (!S_ISREG(ce->ce_mode))
>>>                         continue; /* not a regular file */
>>>                 if (!ce_path_match(ce, pathspec, NULL)
>>>                         continue; /* uninteresting */
>>> +               if (cached && ce_intent_to_add(ce))
>>> +                       continue; /* path not yet in the index */
>>>
>>>                 if (cached || ...)
>>>                         UNCHANGED FROM THE ORIGINAL
>>>
>>> perhaps?
>>
>> I did wonder a bit about these cases. But, can i-t-a really be
>> combined with CE_VALID or CE_SKIP_WORKTREE? CE_SKIP_... is
>> automatically set and should not cover i-t-a entries imo (I didn't
>> check the implementation). CE_VALID is about real entries, yes you
>> could do "git update-index --assume-unchanged <ita-path>" but it does
>> not feel right to me.
>
> Yeah but we know people are stupid^W^Wdo unexpected things ;-)
>
>> If cached is false and ce_ita() is true and either CE_VALID or
>> CE_SKIP_WORKTREE is set, we would continue to grep an _empty_ SHA-1.
>> But I think we should grep_file() instead, at least for CE_VALID.
>
> Yes, that is the breakage I noticed in the patch under discussion
> and that I wanted to fix in the "I wonder if a better change would
> be..." version.

Heh.. I did guess that. Since neither solution is complete, I'm in
favor of Charles's and assume that i-t-a forces to ignore CE_SKIP and
CE_SKIP_WORKTREE. I could wait for people to come back complaining,
then we know there are real users in very obscure cases and will fix
it then.
-- 
Duy
