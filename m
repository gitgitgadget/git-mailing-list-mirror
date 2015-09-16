From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Wed, 16 Sep 2015 17:36:14 -0400
Message-ID: <CANoM8SUTOgqOsPxO1NYgjPbwSkC=odeRKfbMtds65CZitSqxsA@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-3-git-send-email-rappazzo@gmail.com> <CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
 <CANoM8SVJr_B83vU43MFmDiL8phRcTqG3=5krk9iquuH3w5dN_Q@mail.gmail.com> <CAPig+cTP_Vgtm=D1ESrPMs=r44OpGNUdEBjYMQgnQrtG-WsiaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKNf-0007IW-DB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbbIPVgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:36:35 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33463 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbbIPVge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:36:34 -0400
Received: by vkgd64 with SMTP id d64so110476351vkg.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JjyEHLDITIntGvicacoG7nvBXDN3Jo5cYWlGBq1IVsY=;
        b=I8/DLk8VBqwmbSxuVs9R6CfXK0h2UPeTHXMjOsmsbIv8U20NyHCon1WTfKLROyaLgq
         XaX4j8Pk9tWgoEGFZZglog9AnyxsEIf5/Y6P38czYGk96NMIQ2RfzPhJSaq+cD9GJEio
         /v/ZFx3jC1HEkjD1ZdoiuSXhuTstFOaTBvN3Mc23PrMN4IRxmHDsU21IFOgB4nzkz/v5
         vAIF74fpAIFS2XNC42j7LL2qR7WbXkxnsLKGebjNUquNI9T5vberV1EycAx2k3qBUAJ1
         XCg+IKYSAzI70aSSuRccateyzanbEWZIPV7Y9Zv8pPxtxvep8sha2mTS/2W+U45TvNdi
         o37g==
X-Received: by 10.31.2.193 with SMTP id 184mr1912887vkc.126.1442439393491;
 Wed, 16 Sep 2015 14:36:33 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Wed, 16 Sep 2015 14:36:14 -0700 (PDT)
In-Reply-To: <CAPig+cTP_Vgtm=D1ESrPMs=r44OpGNUdEBjYMQgnQrtG-WsiaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278071>

On Wed, Sep 16, 2015 at 5:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Sep 14, 2015 at 1:44 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>> On Sat, Sep 12, 2015 at 11:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>>>> +       while (!matched && worktree_list) {
>>>> +               if (strcmp("HEAD", symref)) {
>>>> +                       strbuf_reset(&path);
>>>> +                       strbuf_reset(&sb);
>>>> +                       strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
>>>> +
>>>> +                       if (_parse_ref(path.buf, &sb, NULL)) {
>>>> +                               continue;
>>>> +                       }
>>>> +
>>>> +                       if (!strcmp(sb.buf, target))
>>>> +                               matched = worktree_list->worktree;
>>>
>>> The original code in branch.c, which this patch removes, did not need
>>> to make a special case of HEAD, so it's not immediately clear why this
>>> replacement code does so. This is the sort of issue which argues in
>>> favor of mutating the existing code (slowly) over the course of
>>> several patches into the final form, rather than having the final form
>>> come into existence out of thin air. When the changes are made
>>> incrementally, it is easier for reviewers to understand why such
>>> modifications are needed, which (hopefully) should lead to fewer
>>> questions such as this one.
>>
>> I reversed the the check here; it is intended to check if the symref
>> is _not_ the head, since the head
>> ref has already been parsed.  This is used in notes.c to find
>> "NOTES_MERGE_REF".
>
> I'm probably being dense, but I still don't understand why the code
> now needs a special case for HEAD, whereas the original didn't. But,
> my denseness my be indicative of this change not being well-described
> (or described at all) by the commit message. Hopefully, when this is
> refactored into finer changes, the purpose will become clear.
>
> Thanks.

The special case for HEAD is because the HEAD is already included in
the worktree struct.  This block is intended to save from re-parsing.
If you think the code would be easier to read, the HEAD check could be
removed, and the ref will just be parsed always.
