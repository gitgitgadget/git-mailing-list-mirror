From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] write_file(): introduce an explicit WRITE_FILE_GENTLY request
Date: Tue, 25 Aug 2015 17:08:57 +0700
Message-ID: <CACsJy8A2sUEcaY2JryTHj3hvES-VDJt_eMgogP5WjVA3FiXDsg@mail.gmail.com>
References: <20150824065033.GA4124@sigill.intra.peff.net> <1440436186-7894-1-git-send-email-gitster@pobox.com>
 <1440436186-7894-4-git-send-email-gitster@pobox.com> <xmqqh9no4jhk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 12:09:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBAa-0007Jc-0b
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbbHYKJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 06:09:27 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33373 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbHYKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 06:09:26 -0400
Received: by igfj19 with SMTP id j19so7611522igf.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lru2ha4HXlST2fMvfYwk4t40ksLyEEprm3k7xzEKHz4=;
        b=Sno/V97zJ/MkGhQupmkcIyeBk8sr3Q2pFtYxiaw/sLRXA5+RjkWaSCENcHddqsrpZD
         cqgXAXS6bpa1ImWjTVYMAnlxY5vdQ1rndE8TtSjrM+YCH0SKt+Ru/J0YyemNP7TVjFsG
         q12Xzm3d9GkW4tZNmCloawCCyqp1Mmd0YwknSKVHCY9Vy1x8hgafjiTjCsbrbf9gLDUP
         e5Po+JXnd6uRZZs5FUmh4+WOFl3rEl2PRpblT6fxEPz15qzJrDFrrDwF4rw8vCvXuz9+
         lyWVZ4y3i9q/ueKwuyHfrx8LlaghbjNQ4Q74ro1ksfP2y/CGZnNYAJ2llIT2Q1o0f2OW
         C+HA==
X-Received: by 10.50.108.100 with SMTP id hj4mr1476441igb.65.1440497366342;
 Tue, 25 Aug 2015 03:09:26 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Tue, 25 Aug 2015 03:08:57 -0700 (PDT)
In-Reply-To: <xmqqh9no4jhk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276512>

On Tue, Aug 25, 2015 at 1:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> All callers except for two ask this function to die upon error by
>> passing fatal=1; turn the parameter to a more generic "unsigned flag"
>> bag of bits, introduce an explicit WRITE_FILE_GENTLY bit and change
>> these two callers to pass that bit.
>
> There is a huge iffyness around one of these two oddball callers.
>
>> diff --git a/setup.c b/setup.c
>> index 5f9f07d..718f4e1 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -404,7 +404,7 @@ static void update_linked_gitdir(const char *gitfile, const char *gitdir)
>>
>>       strbuf_addf(&path, "%s/gitfile", gitdir);
>>       if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
>> -             write_file(path.buf, 0, "%s\n", gitfile);
>> +             write_file(path.buf, WRITE_FILE_GENTLY, "%s\n", gitfile);
>>       strbuf_release(&path);
>>  }
>
> This comes from 23af91d1 (prune: strategies for linked checkouts,
> 2014-11-30).  I cannot tell what the justification is to treat a
> failure to write a gitfile as a non-error event.  Just a sloppy
> coding that lets the program go through to its finish, ignoring the
> harm done by possibly corrupting user repository silently?

Failing to write to this file is not a big deal _if_ the file is not
corrupted because of this write operation. But we should not be so
silent about this. If the file content is corrupted and it's old
enough, this checkout may be pruned. I think there's another bug
here... wrong name..
-- 
Duy
