From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Wed, 16 Sep 2015 17:09:40 -0400
Message-ID: <CAPig+cTP_Vgtm=D1ESrPMs=r44OpGNUdEBjYMQgnQrtG-WsiaQ@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
	<CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
	<CANoM8SVJr_B83vU43MFmDiL8phRcTqG3=5krk9iquuH3w5dN_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJxa-0000SA-LP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbbIPVJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:09:42 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33822 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbIPVJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:09:41 -0400
Received: by vkhf67 with SMTP id f67so110009163vkh.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EgE2djaNWvY2sPEW9vVic2c6rrT7WjimMP2asxvJhHE=;
        b=QAEZwM/epGUOOgd9csWTNeAgEfvhAH6u14S6t7wC7lpFlxnZ8+ITcfGJCdWMlYL8/0
         b+UoVr599TwIr4KvEYsnbgAkCnjl9161r1vtpFEAQ21R4xHp+NN8Leg8/G/dloJ3y6+O
         v+hDP50j2McHvvJqYxnCGra+Jx3odVVvHz9BwV5QJfzK3gAOKg9Q9fiP8FOpcM3DogoS
         zxpBA8ZxYhJRngzb1LTcFFgr44q9tc6w1mrJAvXLonX+/ddWq/Ooqhz8KuiOluN01/AZ
         Zk/KYLizOk2GWyt4Flp2E9aD/4K+9MePtKpzF02OghC0MV+Ml3EffAYNHk6v8KsoD74r
         EaDQ==
X-Received: by 10.31.151.84 with SMTP id z81mr19649821vkd.14.1442437780291;
 Wed, 16 Sep 2015 14:09:40 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 16 Sep 2015 14:09:40 -0700 (PDT)
In-Reply-To: <CANoM8SVJr_B83vU43MFmDiL8phRcTqG3=5krk9iquuH3w5dN_Q@mail.gmail.com>
X-Google-Sender-Auth: 04L0ToQb5-6Xo4sEHFiSeaZzGz4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278068>

On Mon, Sep 14, 2015 at 1:44 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Sat, Sep 12, 2015 at 11:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>>> +       while (!matched && worktree_list) {
>>> +               if (strcmp("HEAD", symref)) {
>>> +                       strbuf_reset(&path);
>>> +                       strbuf_reset(&sb);
>>> +                       strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
>>> +
>>> +                       if (_parse_ref(path.buf, &sb, NULL)) {
>>> +                               continue;
>>> +                       }
>>> +
>>> +                       if (!strcmp(sb.buf, target))
>>> +                               matched = worktree_list->worktree;
>>
>> The original code in branch.c, which this patch removes, did not need
>> to make a special case of HEAD, so it's not immediately clear why this
>> replacement code does so. This is the sort of issue which argues in
>> favor of mutating the existing code (slowly) over the course of
>> several patches into the final form, rather than having the final form
>> come into existence out of thin air. When the changes are made
>> incrementally, it is easier for reviewers to understand why such
>> modifications are needed, which (hopefully) should lead to fewer
>> questions such as this one.
>
> I reversed the the check here; it is intended to check if the symref
> is _not_ the head, since the head
> ref has already been parsed.  This is used in notes.c to find
> "NOTES_MERGE_REF".

I'm probably being dense, but I still don't understand why the code
now needs a special case for HEAD, whereas the original didn't. But,
my denseness my be indicative of this change not being well-described
(or described at all) by the commit message. Hopefully, when this is
refactored into finer changes, the purpose will become clear.

Thanks.
