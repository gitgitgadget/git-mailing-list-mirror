From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Fri, 13 Sep 2013 08:11:22 +0700
Message-ID: <CACsJy8CfVtii-CbMgw3tHUK8P4joDN15XPyfO=OxHJvY-4nTUA@mail.gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com> <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com>
 <alpine.LFD.2.03.1309111224460.20709@syhkavp.arg> <CACsJy8B7WAz4eB88gJCWc3Z0fpSrop8f_Xex1tkmykYuSYUFUQ@mail.gmail.com>
 <alpine.LFD.2.03.1309121214550.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 13 03:12:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKHvR-0005ng-ND
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 03:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab3IMBLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 21:11:54 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33058 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3IMBLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 21:11:53 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so560549obc.30
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pJWFVQdSS6T/+TP9LgAhrzddEJm3pHSeZ7/fZv8WP4s=;
        b=e0gr5FODHjHQ/NW7Qba6rsb/Sz7yYmDp3/5f/rs/MwcHV21n4D4h8cdrGBNu4StgPr
         YIdQY0csNlHcmlc1n7ORSAnCZQ6rbg+TMsBviP9Ed29YFK7INcEN/h22cibh0QJojRiA
         wyLC69ows5UhSirRwwsWD/7Rnzm7IKx3jjSMN9djDu+OLBjzCTK7NBp9n8WUPZHSgyh8
         sWRv7w4jIlGc0f62AQERRw78NHj53zfuiMu9Nf5SvMaYghXZ3CT4oAEZBkmA/10Uhpoq
         RHKSBCltMtJCtfV4qmHRTBr3qgdX5woE3q/bbuk+IVGzVOt+26upjIoKiAEATQ6HtkLH
         nbvA==
X-Received: by 10.182.75.201 with SMTP id e9mr9680514obw.28.1379034712565;
 Thu, 12 Sep 2013 18:11:52 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 12 Sep 2013 18:11:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309121214550.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234717>

On Thu, Sep 12, 2013 at 11:20 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 12 Sep 2013, Duy Nguyen wrote:
>
>> On Wed, Sep 11, 2013 at 11:25 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Wed, 11 Sep 2013, Duy Nguyen wrote:
>> >
>> >> Nico, if you have time you may want to look into this. The result v4
>> >> pack from pack-objects on git.git for me is 35MB (one branch) while
>> >> packv4-create produces 30MB (v2 is 40MB). I don't know why there is
>> >> such a big difference in size. I compared. Ident dict is identical.
>> >> Tree dict is a bit different (some that have same hits are ordered
>> >> differently). Delta chains do not differ much. Many groups of entries
>> >> in the pack are displaced though. I guess I turned a wrong knob or
>> >> something in pack-objects in v4 code..
>> >
>> > Will try to have a closer look.
>>
>> Problem found. I encoded some trees as ref-delta instead of pv4-tree
>> :( Something like this brings the size back to packv4-create output
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index f604fa5..3d9ab0e 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -1490,7 +1490,8 @@ static void check_object(struct object_entry *entry)
>>   * deltify other objects against, in order to avoid
>>   * circular deltas.
>>   */
>> - entry->type = entry->in_pack_type;
>> + if (pack_version < 4)
>> + entry->type = entry->in_pack_type;
>>   entry->delta = base_entry;
>>   entry->delta_size = entry->size;
>>   entry->delta_sibling = base_entry->delta_child;
>
> Hmmm... I've folded this fix into your patch touching this area.

You may want to stricten the condition a bit, to "pack_version < 4 ||
entry->type != OBJ_TREE". I think always not doing it in v4 turns off
the reuse code path for blobs and tags.

> This code is becoming rather subtle and messy though.  We'll have to
> find a way to better abstract things.

Yep. Not sure how that should be done though. Maybe we can revisit it
when pack-objects learns to skip compatibility layer when reading v4
commits and trees..

> Especially since object data
> reuse will work only for blobs and tags with packv4.  Commits and trees
> will need adjustments to their indices.
-- 
Duy
